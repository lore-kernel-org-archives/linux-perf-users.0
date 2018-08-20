From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/21] perf tools: Make decompress_to_file() function static
Date: Mon, 20 Aug 2018 13:15:49 -0300
Message-ID: <20180820161602.6830-9-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 tools/perf/util/dso.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8ee1faa5726f..9f4b72d8f50f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -239,7 +239,7 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-bool decompress_to_file(const char *ext, const char *filename, int output_fd)
+static bool decompress_to_file(const char *ext, const char *filename, int output_fd)
 {
 	unsigned i;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ef69de2e69ea..e1adadd1fe1e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -252,7 +252,6 @@ int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type t
 				   char *root_dir, char *filename, size_t size);
 bool is_supported_compression(const char *ext);
 bool is_kernel_module(const char *pathname, int cpumode);
-bool decompress_to_file(const char *ext, const char *filename, int output_fd);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
-- 
2.14.4
