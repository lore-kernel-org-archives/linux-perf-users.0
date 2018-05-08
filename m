From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Date: Tue, 8 May 2018 18:21:36 +0300
Message-ID: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
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
 arch/x86/kernel/perf_regs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..8d68658eff7f 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	 * Most system calls don't save these registers, don't report them.
 	 */
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
+	/*
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time;
+	 */
+	regs_user_copy->bp = user_regs->bp;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
