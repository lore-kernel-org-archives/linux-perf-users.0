From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/6] perf report/top TUI: Replace pr_err() with ui__error()
Date: Thu,  5 Dec 2019 16:32:19 -0300
Message-ID: <20191205193224.24629-2-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

pr_err() in TUI mode does not print anyting on the screen and just
quits.

Replace such pr_err() with ui__error().

Before:

  $ perf report -s +
  $

After:

  $ perf report -s +

    ┌─Error:────────────────┐
    │Invalid --sort key: `+'│
    │                       │
    │Press any key...       │
    └───────────────────────┘

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 345b5ccc90f6..106d795574ba 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2681,12 +2681,12 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
-					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
+					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
 				else
-					pr_err("Invalid --sort key: `%s'", tok);
+					ui__error("Invalid --sort key: `%s'", tok);
 				break;
 			} else if (ret == -ESRCH) {
-				pr_err("Unknown --sort key: `%s'", tok);
+				ui__error("Unknown --sort key: `%s'", tok);
 				break;
 			}
 		}
@@ -2743,7 +2743,7 @@ static int setup_sort_order(struct evlist *evlist)
 		return 0;
 
 	if (sort_order[1] == '\0') {
-		pr_err("Invalid --sort key: `+'");
+		ui__error("Invalid --sort key: `+'");
 		return -EINVAL;
 	}
 
@@ -3034,7 +3034,7 @@ static int __setup_output_field(void)
 		strp++;
 
 	if (!strlen(strp)) {
-		pr_err("Invalid --fields key: `+'");
+		ui__error("Invalid --fields key: `+'");
 		goto out;
 	}
 
-- 
2.21.0
