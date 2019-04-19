From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] perf tools: Check maps for bpf programs
Date: Fri, 19 Apr 2019 09:30:26 -0300
Message-ID: <20190419123029.11328-5-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

As reported by Jiri Olsa in:

  "[BUG] perf: intel_pt won't display kernel function"
  https://lore.kernel.org/lkml/20190403143738.GB32001@krava

Recent changes to support PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT
broke --kallsyms option. This is because it broke test __map__is_kmodule.

This patch fixes this by adding check for bpf program, so that these maps
are not mistaken as kernel modules.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/20190416160127.30203-8-jolsa@kernel.org
Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 16 ++++++++++++++++
 tools/perf/util/map.h |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e32628cd20a7..28d484ef74ae 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -261,6 +261,22 @@ bool __map__is_extra_kernel_map(const struct map *map)
 	return kmap && kmap->name[0];
 }
 
+bool __map__is_bpf_prog(const struct map *map)
+{
+	const char *name;
+
+	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = map->dso->short_name;
+	return name && (strstr(name, "bpf_prog_") == name);
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0e20749f2c55..dc93787c74f0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
+bool __map__is_bpf_prog(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
-	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
+	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
+	       !__map__is_bpf_prog(map);
 }
 
 bool map__has_symbols(const struct map *map);
-- 
2.20.1
