From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/44] perf bpf: Add bpf__setup_output_event() strerror() counterpart
Date: Thu,  9 Aug 2018 11:58:15 -0300
Message-ID: <20180809145822.21391-38-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That is just bpf__strerror_setup_stdout() renamed to the more general
"setup_output_event" method, keep the existing stdout() as a wrapper.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nwnveo428qn0b48axj50vkc7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c |  4 ++--
 tools/perf/util/bpf-loader.h | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 95a27bb6f1a1..80dead642719 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1791,8 +1791,8 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size)
 	return 0;
 }
 
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			       int err, char *buf, size_t size)
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				     int err, char *buf, size_t size)
 {
 	bpf__strerror_head(err, buf, size);
 	bpf__strerror_end(buf, size);
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 6be0eec043c6..8eca75145ac2 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -83,9 +83,7 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
 int bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err,
-			       char *buf, size_t size);
-
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
 
@@ -200,11 +198,16 @@ bpf__strerror_apply_obj_config(int err __maybe_unused,
 }
 
 static inline int
-bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			   int err __maybe_unused, char *buf,
-			   size_t size)
+bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				 int err __maybe_unused, char *buf, size_t size)
 {
 	return __bpf_strerror(buf, size);
 }
+
 #endif
+
+static inline int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err, char *buf, size_t size)
+{
+	return bpf__strerror_setup_output_event(evlist, err, buf, size);
+}
 #endif
-- 
2.14.4
