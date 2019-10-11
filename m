From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/69] perf trace: Allow associating scnprintf routines with well known arg names
Date: Fri, 11 Oct 2019 17:05:19 -0300
Message-ID: <20191011200559.7156-30-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance 'msr' appears in several tracepoints, so we can associate
it with a single scnprintf() routine auto-generated from kernel headers,
as will be done in followup patches.

Start with an empty array of associations.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ptht6s5fez82lykuwq1eyb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8303d83cb93c..d52972ca6123 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1479,6 +1479,27 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
+static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+};
+
+static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
+{
+       const struct syscall_arg_fmt *fmt = fmtp;
+       return strcmp(name, fmt->name);
+}
+
+static struct syscall_arg_fmt *
+__syscall_arg_fmt__find_by_name(struct syscall_arg_fmt *fmts, const int nmemb, const char *name)
+{
+       return bsearch(name, fmts, nmemb, sizeof(struct syscall_arg_fmt), syscall_arg_fmt__cmp);
+}
+
+static struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
+{
+       const int nmemb = ARRAY_SIZE(syscall_arg_fmts__by_name);
+       return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
 {
@@ -1518,6 +1539,11 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+               } else {
+			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
+
+			if (fmt)
+				arg->scnprintf = fmt->scnprintf;
 		}
 	}
 
-- 
2.21.0
