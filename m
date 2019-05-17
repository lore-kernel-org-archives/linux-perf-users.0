From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/73] perf parse-regs: Add generic support for arch__intr/user_reg_mask()
Date: Fri, 17 May 2019 16:36:03 -0300
Message-ID: <20190517193611.4974-66-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There may be different register mask for use with intr or user on some
platforms, e.g. Icelake.

Add weak functions arch__intr_reg_mask() and arch__user_reg_mask() to
return intr and user register mask respectively.

Check mask before printing or comparing the register name.

Generic code always return PERF_REGS_MASK. No functional change.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557865174-56264-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-regs-options.c | 13 ++++++++++---
 tools/perf/util/perf_regs.c          | 10 ++++++++++
 tools/perf/util/perf_regs.h          |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index b21617f2bec1..08581e276225 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	const struct sample_reg *r;
 	char *s, *os = NULL, *p;
 	int ret = -1;
+	uint64_t mask;
 
 	if (unset)
 		return 0;
@@ -22,6 +23,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
+	if (intr)
+		mask = arch__intr_reg_mask();
+	else
+		mask = arch__user_reg_mask();
+
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
 		/* because str is read-only */
@@ -37,14 +43,15 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
 				for (r = sample_reg_masks; r->name; r++) {
-					fprintf(stderr, "%s ", r->name);
+					if (r->mask & mask)
+						fprintf(stderr, "%s ", r->name);
 				}
 				fputc('\n', stderr);
 				/* just printing available regs */
 				return -1;
 			}
 			for (r = sample_reg_masks; r->name; r++) {
-				if (!strcasecmp(s, r->name))
+				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
 			}
 			if (!r->name) {
@@ -65,7 +72,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 
 	/* default to all possible regs */
 	if (*mode == 0)
-		*mode = PERF_REGS_MASK;
+		*mode = mask;
 error:
 	free(os);
 	return ret;
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 2acfcc527cac..2774cec1f15f 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 	return SDT_ARG_SKIP;
 }
 
+uint64_t __weak arch__intr_reg_mask(void)
+{
+	return PERF_REGS_MASK;
+}
+
+uint64_t __weak arch__user_reg_mask(void)
+{
+	return PERF_REGS_MASK;
+}
+
 #ifdef HAVE_PERF_REGS_SUPPORT
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 1a15a4bfc28d..cb9c246c8962 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -23,6 +23,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
+uint64_t arch__intr_reg_mask(void);
+uint64_t arch__user_reg_mask(void);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
-- 
2.20.1
