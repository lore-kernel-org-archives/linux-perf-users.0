From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf record is broken on kernel 5.4.0.rc3
Date: Fri, 18 Oct 2019 10:40:36 +0200
Message-ID: <318faccf-a5fb-50f3-2635-6037b4670eb6@linux.ibm.com>
References: <b1678611-bafd-36db-b91c-aad87943489f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b1678611-bafd-36db-b91c-aad87943489f@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Hechao Li <hechaol@fb.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org


I ran into a eBPF program load error, system call bpf() returned -EPERM.
It turned out that
  bpf_prog_load()
    bpf_prog_charge_memlock()
     __bpf_prog_charge() operated on a strange value of user->locked_vm:
                         user->locked_vm:0xfffffffffffffe04
                         when accounting for 1 page.

I bisected this strange value to
commit d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

I added printk at end of function perf_mmap() to show allocation
and at end of function perf_mmap_close() to display memory release.
Then I run command 'perf record -e rbd000' to record samples and saving
them in the auxiliary trace buffer.

Here is the output, copied from the dmesg buffer:

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

This happens on a s390 (where I can proof it), but I am sure this
affects other plattforms too as above commit changes common code.

If you send me a fix, I can verify it.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
