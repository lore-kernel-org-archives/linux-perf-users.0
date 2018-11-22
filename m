From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/28] perf bpf: Add defines for map insertion/lookup
Date: Thu, 22 Nov 2018 00:35:47 -0300
Message-ID: <20181122033611.15890-5-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Starting with a helper for a basic pid_map(), a hash using a pid as a
key.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-gdwvq53wltvq6b3g5tdmh0cw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 52b6d87fe822..04ecd425a237 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,6 +18,17 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+#define pid_map(name, value_type)		\
+struct bpf_map SEC("maps") name = {		\
+	.type	     = BPF_MAP_TYPE_HASH,	\
+	.key_size    = sizeof(pid_t),		\
+	.value_size  = sizeof(value_type),	\
+	.max_entries = 512,			\
+}
+
+static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
+static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
-- 
2.14.5
