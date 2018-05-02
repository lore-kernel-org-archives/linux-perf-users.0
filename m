From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/52] perf ui stdio: Use map_groups__fprintf()
Date: Wed,  2 May 2018 12:19:16 -0300
Message-ID: <20180502151942.20542-27-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of the variant that allows asking for just a specific map_type,
because that map_type split will go away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-eya0jvmu26qvro0nxxd49xia@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 6832fcb2e6ff..c1eb476da91b 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -819,8 +819,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		}
 
 		if (h->ms.map == NULL && verbose > 1) {
-			__map_groups__fprintf_maps(h->thread->mg,
-						   MAP__FUNCTION, fp);
+			map_groups__fprintf(h->thread->mg, fp);
 			fprintf(fp, "%.10s end\n", graph_dotted_line);
 		}
 	}
-- 
2.14.3
