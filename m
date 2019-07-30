From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 006/107] perf trace: Order -e syscalls table
Date: Mon, 29 Jul 2019 23:54:29 -0300
Message-ID: <20190730025610.22603-7-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The ev_qualifier is an array with the syscall ids passed via -e on the
command line, sort it as we'll search it when setting up the
BPF_MAP_TYPE_PROG_ARRAY.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c8hprylp3ai6e0z9burn2r3s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bfd739a321d1..9bd5ecd6a8dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1528,6 +1528,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
+static int intcmp(const void *a, const void *b)
+{
+	const int *one = a, *another = b;
+
+	return *one - *another;
+}
+
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
@@ -1591,6 +1598,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 	}
 
 	trace->ev_qualifier_ids.nr = nr_used;
+	qsort(trace->ev_qualifier_ids.entries, nr_used, sizeof(int), intcmp);
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
-- 
2.21.0
