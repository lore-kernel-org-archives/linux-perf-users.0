From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3]: perf/x86: store user space frame-pointer value on a
 sample
Date: Thu, 24 May 2018 17:11:54 +0300
Message-ID: <311d4a34-f81b-5535-3385-01427ac73b41@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Store user space frame-pointer value (BP register) into Perf trace 
on a sample for a process so the value becomes available when 
unwinding call stacks for functions gaining event samples.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- adjusted comment regarding saved registers on system call after 
  recent KPTI improvements

Changes in v2:
- lifted restriction on frame pointer architecture so it's value is provided
  as for i386 as for x86_64 processes

MAINTAINERS file lacks references to appropriate folks for reviewing 
  changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
  update the file as well in this respect.
---
 arch/x86/kernel/perf_regs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..f54348a72add 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -151,17 +151,19 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user_copy->sp = user_regs->sp;
 	regs_user_copy->cs = user_regs->cs;
 	regs_user_copy->ss = user_regs->ss;
-
 	/*
-	 * Most system calls don't save these registers, don't report them.
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time;
 	 */
+	regs_user_copy->bp = user_regs->bp;
+
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
 	regs_user_copy->r15 = -1;
-
 	/*
 	 * For this to be at all useful, we need a reasonable guess for
 	 * the ABI.  Be careful: we're in NMI context, and we're
