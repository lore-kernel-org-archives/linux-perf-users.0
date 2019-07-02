From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/43] perf tools: Increase MAX_NR_CPUS and MAX_CACHES
Date: Mon,  1 Jul 2019 23:25:37 -0300
Message-ID: <20190702022616.1259-5-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kyle Meyer <kyle.meyer@hpe.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

Attempting to profile 1024 or more CPUs with perf causes two errors:

  perf record -a
  [ perf record: Woken up X times to write data ]
  way too many cpu caches..
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  Error: failed to set  cpu bitmap
  Requested CPU 1024 too large. Consider raising MAX_NR_CPUS

  Increasing MAX_NR_CPUS from 1024 to 2048 and redefining MAX_CACHES as
  MAX_NR_CPUS * 4 returns normal functionality to perf:

  perf record -a
  [ perf record: Woken up X times to write data ]
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  ...

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.h        | 2 +-
 tools/perf/util/header.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 711e009381ec..74d0124d38f3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
 }
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			1024
+#define MAX_NR_CPUS			2048
 #endif
 
 extern const char *input_name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 06ddb6618ef3..abc9c2145efe 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,7 +1121,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES 2000
+#define MAX_CACHES (MAX_NR_CPUS * 4)
 
 static int write_cache(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
-- 
2.20.1
