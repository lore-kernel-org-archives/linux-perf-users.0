From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/31] libperf: Add missing event.h file to install rule
Date: Fri, 20 Sep 2019 11:25:14 -0300
Message-ID: <20190920142542.12047-4-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that this development header is properly installed and can be found
by tools linking with libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index a67efb8d9d39..e325c0503dc6 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -146,6 +146,7 @@ install_headers:
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.21.0
