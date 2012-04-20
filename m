From: Arun Sharma <asharma@fb.com>
Subject: [PATCH 1/3] perf, x86: Allow multiple stacks
Date: Fri, 20 Apr 2012 12:35:25 -0700
Message-ID: <1334950527-5050-2-git-send-email-asharma@fb.com>
References: <1334950527-5050-1-git-send-email-asharma@fb.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334950527-5050-1-git-send-email-asharma@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arun Sharma <asharma@fb.com>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Without this patch, applications with two different stack
regions (eg: native stack vs JIT stack) get truncated
callchains even when RBP chaining is present. GDB shows proper
stack traces and the frame pointer chaining is intact.

This patch disables the (fp < RSP) check, hoping that other checks
in the code save the day for us. In our limited testing, this
didn't seem to break anything.

In the long term, we could potentially have userspace advise
the kernel on the range of valid stack addresses, so we don't
spend a lot of time unwinding from bogus addresses.

Signed-off-by: Arun Sharma <asharma@fb.com>
Cc: Ingo Molnar <mingo@elte.hu>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Namhyung Kim <namhyung.kim@lge.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 arch/x86/kernel/cpu/perf_event.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index bb8e034..9f98636 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1785,9 +1785,6 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry *entry)
 		if (bytes != sizeof(frame))
 			break;
 
-		if (fp < compat_ptr(regs->sp))
-			break;
-
 		perf_callchain_store(entry, frame.return_address);
 		fp = compat_ptr(frame.next_frame);
 	}
@@ -1831,9 +1828,6 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 		if (bytes != sizeof(frame))
 			break;
 
-		if ((unsigned long)fp < regs->sp)
-			break;
-
 		perf_callchain_store(entry, frame.return_address);
 		fp = frame.next_frame;
 	}
-- 
1.7.8.4
