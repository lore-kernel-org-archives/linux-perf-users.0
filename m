From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/17] perf hists browser: Clarify top/report browser help
Date: Fri, 20 Apr 2018 11:32:21 -0300
Message-ID: <20180420143227.16030-12-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clarify in the browser help that ESC in tui mode may go back to the
previous screen instead of just exiting (was not clear to me)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0eec06c105c6..e5f247247daa 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2714,7 +2714,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"h/?/F1        Show this window\n"				\
 	"UP/DOWN/PGUP\n"						\
 	"PGDN/SPACE    Navigate\n"					\
-	"q/ESC/CTRL+C  Exit browser\n\n"				\
+	"q/ESC/CTRL+C  Exit browser or go back to previous screen\n\n"	\
 	"For multiple event sessions:\n\n"				\
 	"TAB/UNTAB     Switch events\n\n"				\
 	"For symbolic views (--sort has sym):\n\n"			\
-- 
2.14.3
