From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/20] perf report/top: Allow pressing hotkeys in the options popup menu
Date: Mon,  6 Jan 2020 13:07:02 -0300
Message-ID: <20200106160705.10899-18-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the users presses ENTER in the main 'perf report/top' screen a
popup menu is presented, in it some hotkeys are suggested as
alternatives to using the menu, or for additional features.

At that point the user may try those hotkeys, so allow for that by
recording the key used and exiting, the caller then can check for that
possibility and process the hotkey.

I.e. try pressing ENTER, and then 'k' to exit and zoom into the kernel
map, using ESC then zooms out, etc.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ujfq3fw44kf6qrtfajl5dcsp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c44b508f9e06..8776b1cb29b7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2995,12 +2995,13 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
-		int choice = 0;
+		int choice;
 		int socked_id = -1;
 
-		nr_options = 0;
-
-		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
+		key = 0; // reset key
+do_hotkey:		 // key came straight from options ui__popup_menu()
+		choice = nr_options = 0;
+		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3279,10 +3280,13 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 		do {
 			struct popup_action *act;
 
-			choice = ui__popup_menu(nr_options, options, NULL);
-			if (choice == -1 || choice >= nr_options)
+			choice = ui__popup_menu(nr_options, options, &key);
+			if (choice == -1)
 				break;
 
+			if (choice == nr_options)
+				goto do_hotkey;
+
 			act = &actions[choice];
 			key = act->fn(browser, act);
 		} while (key == 1);
-- 
2.21.1
