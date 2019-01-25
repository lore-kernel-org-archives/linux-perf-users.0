From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/29] perf bpf: Convert pid_map() to bpf_map()
Date: Sat, 26 Jan 2019 00:18:39 +0100
Message-ID: <20190125231843.2895-26-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

First user, pid_t as the type, lets see how this goes with the BTF
routines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-56eplvf86r69wt3p35nh805z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 0482028c1d11..5df7ed9d9020 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -34,13 +34,7 @@ struct bpf_map SEC("maps") name = {				\
  *	  For the current need, 'perf trace --filter-pids', 64 should
  *	  be good enough, but this surely needs to be revisited.
  */
-#define pid_map(name, value_type)		\
-struct bpf_map SEC("maps") name = {		\
-	.type	     = BPF_MAP_TYPE_HASH,	\
-	.key_size    = sizeof(pid_t),		\
-	.value_size  = sizeof(value_type),	\
-	.max_entries = 64,			\
-}
+#define pid_map(name, value_type) bpf_map(name, HASH, pid_t, value_type, 64)
 
 static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
 static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
-- 
2.20.1
