From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/30] perf ui browser: Fix ui popup argv browser for many entries
Date: Mon, 11 Mar 2019 23:02:03 -0300
Message-ID: <20190312020204.22092-30-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix the argv ui browser code to correctly display more entries than fit
on the screen without crashing. The problem was some type confusion with
pointer types in the ->seek function. Do the argv arithmetic correctly
with char ** pointers. Also add some asserts to find overruns and limit
the display function correctly.

Then finally remove a workaround for this in the res sample browser.

Committer testing:

1) Resize the x terminal to have just some 5 lines

2) Use 'perf report --samples 1' to activate the sample browser options
   in the menu

3) Press ENTER, this will cause the crash:

  # perf report --samples 1
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5a514a]
  /lib64/libc.so.6(+0x385bf)[0x7f27281b55bf]
  /lib64/libc.so.6(+0x161a67)[0x7f27282dea67]
  /lib64/libslang.so.2(SLsmg_write_wrapped_string+0x82)[0x7f272874a0b2]
  perf(ui_browser__argv_refresh+0x77)[0x5939a7]
  perf[0x5924cc]
  perf(ui_browser__run+0x39)[0x593449]
  perf(ui__popup_menu+0x83)[0x5a5263]
  perf[0x59f421]
  perf(perf_evlist__tui_browse_hists+0x3a0)[0x5a3780]
  perf(cmd_report+0x2746)[0x447136]
  perf[0x4a95fe]
  perf(main+0x61c)[0x42dc6c]
  /lib64/libc.so.6(__libc_start_main+0xf2)[0x7f27281a1412]
  perf(_start+0x2d)[0x42de9d]
  #

After applying this patch no crash takes place in such situation.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-12-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 884ef2a92c15..c0dd73176d42 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -36,9 +36,6 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
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
