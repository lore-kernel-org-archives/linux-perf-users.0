From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/9] perf top: Fix annoying fallback message on older kernels
Date: Tue,  6 Mar 2018 14:23:36 -0300
Message-ID: <20180306172343.16546-3-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <Kan.liang@intel.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <Kan.liang@intel.com>

On older (e.g. v4.4) kernels, an annoying fallback message can be
observed in 'perf top':

	┌─Warning:──────────────────────┐
	│fall back to non-overwrite mode│
	│                               │
	│                               │
	│Press any key...               │
	└───────────────────────────────┘

The 'perf top' utility has been changed to overwrite mode since commit
ebebbf082357 ("perf top: Switch default mode to overwrite mode").

For older kernels which don't have overwrite mode support, 'perf top'
will fall back to non-overwrite mode and print out the fallback message
using ui__warning(), which needs user's input to close.

The fallback message is not critical for end users. Turning it to debug
message which is printed when running with -vv.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: http://lkml.kernel.org/r/1519669030-176549-1-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b7c823ba8374..35ac016fcb98 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -991,7 +991,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 	evlist__for_each_entry(evlist, counter)
 		counter->attr.write_backward = false;
 	opts->overwrite = false;
-	ui__warning("fall back to non-overwrite mode\n");
+	pr_debug2("fall back to non-overwrite mode\n");
 	return 1;
 }
 
-- 
2.14.3
