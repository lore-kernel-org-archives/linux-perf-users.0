From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/15] perf annotate TUI: Fix --show-total-period
Date: Fri, 28 Jul 2017 17:00:15 -0300
Message-ID: <20170728200021.11389-10-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

We were showing the number of samples, not the total period, fix it.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 0c4a5bcea460 ("perf annotate: Display total number of samples with --show-total-period")
Link: http://lkml.kernel.org/r/1500500223-16753-1-git-send-email-treeze.taeung@gmail.com
[ extracted from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 680fff70f7a0..c382b1d8af42 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -152,7 +152,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 						current_entry);
 			if (annotate_browser__opts.show_total_period) {
 				ui_browser__printf(browser, "%6" PRIu64 " ",
-						   bdl->samples[i].he.nr_samples);
+						   bdl->samples[i].he.period);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
 						   bdl->samples[i].percent);
-- 
2.9.4
