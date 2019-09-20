From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/31] perf hist: Add missing 'struct branch_stack' forward declaration
Date: Fri, 20 Sep 2019 11:25:29 -0300
Message-ID: <20190920142542.12047-19-acme@kernel.org>
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

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-srzphk0ehptfn3zqmpkgsi65@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 34803e33dc80..6a186b668303 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -15,6 +15,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct branch_stack;
 struct block_info;
 struct symbol;
 struct ui_progress;
-- 
2.21.0
