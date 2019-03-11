From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v1 01/10] perf, tools, list: Filter metrics too
Date: Mon, 11 Mar 2019 13:24:37 -0700
Message-ID: <20190311202446.10210-2-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When a filter is specified on the command line, filter the metrics too.

Before:

% perf list foo
List of pre-defined events (to be used in -e):

Metric Groups:

DSB:
  DSB_Coverage
       [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
... more metrics ...

After:

% perf list foo

List of pre-defined events (to be used in -e):

Metric Groups:

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c9f98d00c0e9..a8394b4f1167 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -119,7 +119,7 @@ int cmd_list(int argc, const char **argv)
 						details_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, NULL, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag);
 			free(s);
 		}
 	}
-- 
2.20.1
