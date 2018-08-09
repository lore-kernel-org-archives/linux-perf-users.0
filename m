From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/44] perf bpf: Make bpf__for_each_stdout_map() generic
Date: Thu,  9 Aug 2018 11:58:13 -0300
Message-ID: <20180809145822.21391-36-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By passing a 'name' arg, that will eventually be used to setup more
"bpf-output" events, e.g. to create a event where to create raw_syscalls
like events that in addition to the syscall arguments will also copy the
pointer contents being passed from/to userspace.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-talrnxps9p3qozk3aeh91fgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 3d02ae38ec56..e864a7e0ff12 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1529,12 +1529,15 @@ int bpf__apply_obj_config(void)
 	bpf_object__for_each_safe(obj, objtmp)	\
 		bpf_map__for_each(pos, obj)
 
-#define bpf__for_each_stdout_map(pos, obj, objtmp)	\
+#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
 	bpf__for_each_map(pos, obj, objtmp) 		\
 		if (bpf_map__name(pos) && 		\
-			(strcmp("__bpf_stdout__", 	\
+			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
+#define bpf__for_each_stdout_map(pos, obj, objtmp) \
+	 bpf__for_each_map_named(pos, obj, objtmp, "__bpf_stdout__")
+
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
-- 
2.14.4
