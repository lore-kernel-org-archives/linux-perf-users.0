From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/75] perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
Date: Thu,  6 Dec 2018 18:25:01 -0300
Message-ID: <20181206212602.20474-15-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wen Yang <yellowriver2010@hotmail.com>, zhong.weidong@zte.com.cn, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).  This
makes it more readable and also fix this warning detected by
err_cast.cocci:

  tools/perf/util/bpf-loader.c:1606:11-18: WARNING: ERR_CAST can be used with op

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/20181127090610.28488-1-wen.yang99@zte.com.cn
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f9ae1a993806..9a280647d829 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1603,7 +1603,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return ERR_PTR(PTR_ERR(op));
+				return ERR_CAST(op);
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
-- 
2.19.2
