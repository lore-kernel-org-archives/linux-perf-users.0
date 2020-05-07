From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH v2 01/23] perf expr: unlimited escaped characters in a symbol
Date: Thu,  7 May 2020 07:07:57 -0700
Message-ID: <20200507140819.126960-2-irogers@google.com>
References: <20200507140819.126960-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Current expression allows 2 escaped '-,=' characters. However, some
metrics require more, for example Haswell DRAM_BW_Use.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 74b9b59b1aa5..73db6a9ef97e 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -86,7 +86,7 @@ number		[0-9]+
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@?]+
-symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
+symbol		({spec}|{sym})+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
-- 
2.26.2.526.g744177e7f7-goog
