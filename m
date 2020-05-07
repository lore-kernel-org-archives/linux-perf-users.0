From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH v2 07/23] perf expr: debug lex if debugging yacc
Date: Thu,  7 May 2020 07:08:03 -0700
Message-ID: <20200507140819.126960-8-irogers@google.com>
References: <20200507140819.126960-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Only effects parser debugging (disabled by default). Enables displaying
'--accepting rule at line .. ("...").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index aa631e37ad1e..8b4ce704a68d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -45,6 +45,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 
 #ifdef PARSER_DEBUG
 	expr_debug = 1;
+	expr_set_debug(1, scanner);
 #endif
 
 	ret = expr_parse(val, ctx, scanner);
-- 
2.26.2.526.g744177e7f7-goog
