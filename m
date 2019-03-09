From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v5 15/15] perf tools ui: Fix ui popup browser for many entries
Date: Fri,  8 Mar 2019 21:56:28 -0800
Message-ID: <20190309055628.21617-16-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix the argv ui browser code to correctly display more entries
than fit on the screen without crashing. The problem was some type
confusion with pointer types in the ->seek function. Do
the argv arithmetic correctly with char ** pointers. Also
add some asserts to find overruns and limit the display function
correctly.

Then finally remove a workaround for this in the res sample
browser.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browser.c             | 10 +++++++---
 tools/perf/ui/browsers/res_sample.c |  3 ---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 4f75561424ed..4ad37d8c7d6a 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -611,14 +611,16 @@ void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence)
 		browser->top = browser->entries;
 		break;
 	case SEEK_CUR:
-		browser->top = browser->top + browser->top_idx + offset;
+		browser->top = (char **)browser->top + offset;
 		break;
 	case SEEK_END:
-		browser->top = browser->top + browser->nr_entries - 1 + offset;
+		browser->top = (char **)browser->entries + browser->nr_entries - 1 + offset;
 		break;
 	default:
 		return;
 	}
+	assert((char **)browser->top < (char **)browser->entries + browser->nr_entries);
+	assert((char **)browser->top >= (char **)browser->entries);
 }
 
 unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
@@ -630,7 +632,9 @@ unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
 		browser->top = browser->entries;
 
 	pos = (char **)browser->top;
-	while (idx < browser->nr_entries) {
+	while (idx < browser->nr_entries &&
+	       row < (unsigned)SLtt_Screen_Rows - 1) {
+		assert(pos < (char **)browser->entries + browser->nr_entries);
 		if (!browser->filter || !browser->filter(browser, *pos)) {
 			ui_browser__gotorc(browser, row, 0);
 			browser->write(browser, pos, row);
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index c2a8536904bc..8befd8e984ab 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -37,9 +37,6 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 	struct res_sample *r;
 	char extra_format[256];
 
-	/* For now since ui__popup_menu doesn't like lists that don't fit */
-	num_res = max(min(SLtt_Screen_Rows - 4, num_res), 0);
-
 	names = calloc(num_res, sizeof(char *));
 	if (!names)
 		return -1;
-- 
2.20.1
