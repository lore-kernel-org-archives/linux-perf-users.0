From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/17] perf hists browser: Rename perf_evsel_browser_title to a more descriptive name
Date: Tue,  3 Apr 2018 23:21:51 -0300
Message-ID: <20180404022158.12190-11-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rename it to hists_browser__scnprintf_title() to better reflect that it
provides a scnprintf-like function operating on a hists_browser
instance.

This paves the way to have a non-hists_browser specific function to
scnprintf format a title with per evsel information to use in other
tools or UIs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-sntpyzxsnme9jvuz2qntwoh2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8b4e82548f8e..2ac66011354f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -32,8 +32,7 @@
 
 extern void hist_browser__init_hpp(void);
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				    char *bf, size_t size);
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size);
 static void hist_browser__update_nr_entries(struct hist_browser *hb);
 
 static struct rb_node *hists__filter_entries(struct rb_node *nd,
@@ -2183,7 +2182,7 @@ perf_evsel_browser__new(struct perf_evsel *evsel,
 	if (browser) {
 		browser->hbt   = hbt;
 		browser->env   = env;
-		browser->title = perf_evsel_browser_title;
+		browser->title = hists_browser__scnprintf_title;
 	}
 	return browser;
 }
@@ -2209,8 +2208,7 @@ static inline bool is_report_browser(void *timer)
 	return timer == NULL;
 }
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				char *bf, size_t size)
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
 {
 	struct hist_browser_timer *hbt = browser->hbt;
 	struct hists *hists = browser->hists;
-- 
2.14.3
