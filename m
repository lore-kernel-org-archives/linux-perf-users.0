From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/17] perf top: Show info message while collecting samples
Date: Tue, 20 Aug 2019 16:27:31 -0300
Message-ID: <20190820192733.19180-16-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Give visual cue about what is happening while initially collecting the
minimal set of samples to collect/sort/display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xcui60p1v6ozijfam2o89ya8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b195b1ba625b..30547fdb0787 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2894,6 +2894,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	if (symbol_conf.col_width_list_str)
 		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
 
+	if (!is_report_browser(hbt))
+		browser->b.no_samples_msg = "Collecting samples...";
+
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
-- 
2.21.0
