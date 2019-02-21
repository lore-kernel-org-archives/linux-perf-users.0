From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/17] perf bpf: Add bpf_map dumper
Date: Wed, 20 Feb 2019 22:25:42 -0300
Message-ID: <20190221012549.4069-11-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point I'll suggest moving this to libbpf, for now I'll
experiment with ways to dump BPF maps set by events in 'perf trace',
starting with a very basic dumper for the current very limited needs
of the augmented_raw_syscalls code: dumping booleans.

Having functions that apply to the map keys and values and do table
lookup in things like syscall id to string tables should come next.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lz14w0esqyt1333aon05jpwc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build     |  1 +
 tools/perf/util/bpf_map.c | 72 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf_map.h | 22 ++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 tools/perf/util/bpf_map.c
 create mode 100644 tools/perf/util/bpf_map.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3008d49fa587..8dd3102301ea 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -115,6 +115,7 @@ perf-y += branch.o
 perf-y += mem2node.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
+perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
new file mode 100644
index 000000000000..eb853ca67cf4
--- /dev/null
+++ b/tools/perf/util/bpf_map.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "util/bpf_map.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static bool bpf_map_def__is_per_cpu(const struct bpf_map_def *def)
+{
+	return def->type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	       def->type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
+}
+
+static void *bpf_map_def__alloc_value(const struct bpf_map_def *def)
+{
+	if (bpf_map_def__is_per_cpu(def))
+		return malloc(round_up(def->value_size, 8) * sysconf(_SC_NPROCESSORS_CONF));
+
+	return malloc(def->value_size);
+}
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
+{
+	const struct bpf_map_def *def = bpf_map__def(map);
+	void *prev_key = NULL, *key, *value;
+	int fd = bpf_map__fd(map), err;
+	int printed = 0;
+
+	if (fd < 0)
+		return fd;
+
+	if (IS_ERR(def))
+		return PTR_ERR(def);
+
+	err = -ENOMEM;
+	key = malloc(def->key_size);
+	if (key == NULL)
+		goto out;
+
+	value = bpf_map_def__alloc_value(def);
+	if (value == NULL)
+		goto out_free_key;
+
+	while ((err = bpf_map_get_next_key(fd, prev_key, key) == 0)) {
+		int intkey = *(int *)key;
+
+		if (!bpf_map_lookup_elem(fd, key, value)) {
+			bool boolval = *(bool *)value;
+			if (boolval)
+				printed += fprintf(fp, "[%d] = %d,\n", intkey, boolval);
+		} else {
+			printed += fprintf(fp, "[%d] = ERROR,\n", intkey);
+		}
+
+		prev_key = key;
+	}
+
+	if (err == ENOENT)
+		err = printed;
+
+	free(value);
+out_free_key:
+	free(key);
+out:
+	return err;
+}
diff --git a/tools/perf/util/bpf_map.h b/tools/perf/util/bpf_map.h
new file mode 100644
index 000000000000..d6abd5e47af8
--- /dev/null
+++ b/tools/perf/util/bpf_map.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#ifndef __PERF_BPF_MAP_H
+#define __PERF_BPF_MAP_H 1
+
+#include <stdio.h>
+#include <linux/compiler.h>
+struct bpf_map;
+
+#ifdef HAVE_LIBBPF_SUPPORT
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp);
+
+#else
+
+static inline int bpf_map__fprintf(struct bpf_map *map __maybe_unused, FILE *fp __maybe_unused)
+{
+	return 0;
+}
+
+#endif // HAVE_LIBBPF_SUPPORT
+
+#endif // __PERF_BPF_MAP_H
-- 
2.19.1
