From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/13] perf ui browser: Fixup cleaning unused lines at the bottom
Date: Mon,  9 Apr 2018 16:34:28 -0300
Message-ID: <20180409193437.14199-5-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that we can have extra title lines we should use ui_browser->rows
and not ->height when drawing lines, as well as adding
ui_browser->extra_title_lines to browser->y when cleaning unused lines
at the bottom, otherwise we end up clobbering with spaces the last line
just shown by ui_browser->refresh() routine.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ef9ff6017e3c ("perf ui browser: Move the extra title lines from the hists browser")
Link: https://lkml.kernel.org/n/tip-dfcpokt1pm5ixm8n9pxwtstz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index d7bb2591838e..4f75561424ed 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -343,8 +343,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	else
 		width += 1;
 
-	SLsmg_fill_region(browser->y + row, browser->x,
-			  browser->height - row, width, ' ');
+	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
+			  browser->rows - row, width, ' ');
 
 	return 0;
 }
-- 
2.14.3
