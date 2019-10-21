From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/core: Fix tracking of auxiliary trace buffer allocation
Date: Mon, 21 Oct 2019 10:33:54 +0200
Message-ID: <20191021083354.67868-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, songliubraving@fb.com, hechaol@fb.com, acme@kernel.org, mingo@redhat.com, peterz@infradead.org
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

commit d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")
breaks auxiliary trace buffer tracking.

I run command 'perf record -e rbd000' to record samples and saving
them in the **auxiliary** trace buffer. The value of 'locked_vm' becomes
negative after all trace buffers have been allocated and released:

During allocation the values increase
[52.250027] perf_mmap user->locked_vm:0x87 pinned_vm:0x0 ret:0
[52.250115] perf_mmap user->locked_vm:0x107 pinned_vm:0x0 ret:0
[52.250251] perf_mmap user->locked_vm:0x188 pinned_vm:0x0 ret:0
[52.250326] perf_mmap user->locked_vm:0x208 pinned_vm:0x0 ret:0
[52.250441] perf_mmap user->locked_vm:0x289 pinned_vm:0x0 ret:0
[52.250498] perf_mmap user->locked_vm:0x309 pinned_vm:0x0 ret:0
[52.250613] perf_mmap user->locked_vm:0x38a pinned_vm:0x0 ret:0
[52.250715] perf_mmap user->locked_vm:0x408 pinned_vm:0x2 ret:0
[52.250834] perf_mmap user->locked_vm:0x408 pinned_vm:0x83 ret:0
[52.250915] perf_mmap user->locked_vm:0x408 pinned_vm:0x103 ret:0
[52.251061] perf_mmap user->locked_vm:0x408 pinned_vm:0x184 ret:0
[52.251146] perf_mmap user->locked_vm:0x408 pinned_vm:0x204 ret:0
[52.251299] perf_mmap user->locked_vm:0x408 pinned_vm:0x285 ret:0
[52.251383] perf_mmap user->locked_vm:0x408 pinned_vm:0x305 ret:0
[52.251544] perf_mmap user->locked_vm:0x408 pinned_vm:0x386 ret:0
[52.251634] perf_mmap user->locked_vm:0x408 pinned_vm:0x406 ret:0
[52.253018] perf_mmap user->locked_vm:0x408 pinned_vm:0x487 ret:0
[52.253197] perf_mmap user->locked_vm:0x408 pinned_vm:0x508 ret:0
[52.253374] perf_mmap user->locked_vm:0x408 pinned_vm:0x589 ret:0
[52.253550] perf_mmap user->locked_vm:0x408 pinned_vm:0x60a ret:0
[52.253726] perf_mmap user->locked_vm:0x408 pinned_vm:0x68b ret:0
[52.253903] perf_mmap user->locked_vm:0x408 pinned_vm:0x70c ret:0
[52.254084] perf_mmap user->locked_vm:0x408 pinned_vm:0x78d ret:0
[52.254263] perf_mmap user->locked_vm:0x408 pinned_vm:0x80e ret:0

The value of user->locked_vm increases to a limit then the memory
is tracked by pinned_vm.

During deallocation the size is subtracted from pinned_vm until
it hits a limit. Then a larger value is subtracted from locked_vm
leading to a large number (because of type unsigned):
[64.267797] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x78d
[64.267826] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x70c
[64.267848] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x68b
[64.267869] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x60a
[64.267891] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x589
[64.267911] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x508
[64.267933] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x487
[64.267952] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x406
[64.268883] perf_mmap_close mmap_user->locked_vm:0x307 pinned_vm:0x406
[64.269117] perf_mmap_close mmap_user->locked_vm:0x206 pinned_vm:0x406
[64.269433] perf_mmap_close mmap_user->locked_vm:0x105 pinned_vm:0x406
[64.269536] perf_mmap_close mmap_user->locked_vm:0x4 pinned_vm:0x404
[64.269797] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff84 pinned_vm:0x303
[64.270105] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff04 pinned_vm:0x202
[64.270374] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe84 pinned_vm:0x101
[64.270628] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe04 pinned_vm:0x0

This value sticks for the user until system is rebooted, causing
follow-on system calls using locked_vm resource limit to fail.

Note: There is no issue using the normal trace buffer.

In fact the issue is in perf_mmap_close(). During allocation auxiliary
trace buffer memory is either traced as 'extra' and added to 'pinned_vm'
or trace as 'user_extra' and added to 'locked_vm'. This applies for
normal trace buffers and auxiliary trace buffer.

However in function perf_mmap_close() all auxiliary trace buffer is
subtraced from 'locked_vm' and never from 'pinned_vm'. This breaks the
ballance.

Fixes: d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 kernel/events/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0bfddbd..90ba23043af0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5607,8 +5607,12 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		if (!rb->aux_mmap_locked)
+			atomic_long_sub(rb->aux_nr_pages,
+					&mmap_user->locked_vm);
+		else
+			atomic64_sub(rb->aux_mmap_locked,
+				     &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-- 
2.21.0
