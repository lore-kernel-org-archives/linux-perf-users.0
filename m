From: Arun Sharma <asharma@fb.com>
Subject: [PATCH] perf, x86: Disable sanity check
Date: Wed, 18 Apr 2012 16:24:09 -0700
Message-ID: <1334791449-402-1-git-send-email-asharma@fb.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail005.snc4.facebook.com ([66.220.144.139]:43763 "EHLO
	intmgw001.snc4.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751456Ab2DRXY3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Apr 2012 19:24:29 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arun Sharma <asharma@fb.com>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

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
 arch/x86/kernel/cpu/perf_event.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 07f46ba..87d9abd 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1596,9 +1596,6 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
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
