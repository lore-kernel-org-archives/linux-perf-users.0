From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/17] perf ui browser: Allow specifying message to show when no samples are available to display
Date: Tue, 20 Aug 2019 16:27:30 -0300
Message-ID: <20190820192733.19180-15-acme@kernel.org>
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

The 'perf top' tool will use that to avoid having a initial blank screen
while collecting the minimum number of samples to sort and display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ciceg8cy4442he3t0jzo3f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 2 ++
 tools/perf/ui/browser.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index d227d74b28f8..c797a853d3a0 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -347,6 +347,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
 			  browser->rows - row, width, ' ');
 
+	if (browser->nr_entries == 0 && browser->no_samples_msg)
+		__ui__info_window(NULL, browser->no_samples_msg, NULL);
 	return 0;
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index dc1444136658..3678eb88f119 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -23,6 +23,7 @@ struct ui_browser {
 	void	      *priv;
 	const char    *title;
 	char	      *helpline;
+	const char    *no_samples_msg;
 	void 	      (*refresh_dimensions)(struct ui_browser *browser);
 	unsigned int  (*refresh)(struct ui_browser *browser);
 	void	      (*write)(struct ui_browser *browser, void *entry, int row);
-- 
2.21.0
