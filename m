From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/28] perf ui: No need to set ui_browser to 1 twice
Date: Wed, 14 Aug 2019 15:40:51 -0300
Message-ID: <20190814184051.3125-29-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to do it only when fallbacking from GTK to the TUI.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dda0acxqef1k72n9z4myjbjt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 44fe824e96cd..3bc7c9a6fae9 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -89,9 +89,9 @@ void setup_browser(bool fallback_to_pager)
 		printf("GTK browser requested but could not find %s\n",
 		       PERF_GTK_DSO);
 		sleep(1);
+		use_browser = 1;
 		/* fall through */
 	case 1:
-		use_browser = 1;
 		if (ui__init() == 0)
 			break;
 		/* fall through */
-- 
2.21.0
