From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/6] perf report: Make -F more strict like -s
Date: Thu,  5 Dec 2019 16:32:20 -0300
Message-ID: <20191205193224.24629-3-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Currently -F allows branch-mode / mem-mode fields with -F even
when perf report is not running in that mode. Don't allow that.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 106d795574ba..9fcba2872130 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2959,6 +2959,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__MEMORY)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
@@ -2968,6 +2971,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__BRANCH)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
-- 
2.21.0
