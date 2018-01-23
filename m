From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/43] perf bpf: Remove misplaced __maybe_unused attribute
Date: Tue, 23 Jan 2018 10:12:46 -0300
Message-ID: <20180123131251.28197-39-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The bpf__setup_stdout() function uses that evlist argument, remove the
misleading __maybe_unused attribute.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7vbhhzbd33nvdm7l35gdfryt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index ab2598af91eb..af7ad814b2c3 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1533,7 +1533,7 @@ int bpf__apply_obj_config(void)
 			(strcmp("__bpf_stdout__", 	\
 				bpf_map__name(pos)) == 0))
 
-int bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
+int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
-- 
2.14.3
