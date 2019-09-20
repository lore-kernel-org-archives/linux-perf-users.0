From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/31] perf memswap: Adopt 'struct u64_swap' from evsel.h
Date: Fri, 20 Sep 2019 11:25:34 -0300
Message-ID: <20190920142542.12047-24-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is not used in evsel.h and is a memory swap struct, so fits better
in memswap.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wvzxu7a5l3m868ywwphrnnqo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h   | 5 -----
 tools/perf/util/memswap.h | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68321d10eb2d..74df298acb31 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -179,11 +179,6 @@ struct evsel {
 	} side_band;
 };
 
-union u64_swap {
-	u64 val64;
-	u32 val32[2];
-};
-
 struct perf_missing_features {
 	bool sample_id_all;
 	bool exclude_guest;
diff --git a/tools/perf/util/memswap.h b/tools/perf/util/memswap.h
index 1e29ff903ca9..2c38e8c2d548 100644
--- a/tools/perf/util/memswap.h
+++ b/tools/perf/util/memswap.h
@@ -2,6 +2,13 @@
 #ifndef PERF_MEMSWAP_H_
 #define PERF_MEMSWAP_H_
 
+#include <linux/types.h>
+
+union u64_swap {
+	u64 val64;
+	u32 val32[2];
+};
+
 void mem_bswap_64(void *src, int byte_size);
 void mem_bswap_32(void *src, int byte_size);
 
-- 
2.21.0
