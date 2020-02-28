From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/15] perf annotate: Align struct annotate_args
Date: Fri, 28 Feb 2020 11:00:13 -0300
Message-ID: <20200228140014.1236-15-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Align fields of struct annotate_args.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f11031a40290..c816e5840166 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,13 +1143,13 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 }
 
 struct annotate_args {
-	struct arch		*arch;
-	struct map_symbol	 ms;
-	struct evsel	*evsel;
+	struct arch		  *arch;
+	struct map_symbol	  ms;
+	struct evsel		  *evsel;
 	struct annotation_options *options;
-	s64			 offset;
-	char			*line;
-	int			 line_nr;
+	s64			  offset;
+	char			  *line;
+	int			  line_nr;
 };
 
 static void annotation_line__init(struct annotation_line *al,
-- 
2.21.1
