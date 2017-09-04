From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/13] perf annotate browser: Help for cycling thru hottest instructions with TAB/shift+TAB
Date: Mon,  4 Sep 2017 11:00:44 -0300
Message-ID: <20170904140044.22912-14-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The popup help accessed via 'h' wasn't mentioning about TAB and
shift-TAB, just about 'H', which goes to the hottest line, while the
former two are the hotkeys for actually cycling thru the hottest lines.

Reported-by: Flavio Bruno Leitner <fbl@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-5ppym6odizfj1ifa4t7neiku@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ba0aee576a2b..786fecaf578e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -829,7 +829,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"q/ESC/CTRL+C  Exit\n\n"
 		"ENTER         Go to target\n"
 		"ESC           Exit\n"
-		"H             Cycle thru hottest instructions\n"
+		"H             Go to hottest instruction\n"
+		"TAB/shift+TAB Cycle thru hottest instructions\n"
 		"j             Toggle showing jump to target arrows\n"
 		"J             Toggle showing number of jump sources on targets\n"
 		"n             Search next string\n"
-- 
2.13.5
