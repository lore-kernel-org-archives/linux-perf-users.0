From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/23] perf symbols: Convert symbol__is_idle() to use strlist
Date: Fri, 14 Feb 2020 16:10:37 -0300
Message-ID: <20200214191057.26266-4-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Use the more optimized strlist implementation to do the idle function
lookup.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210163147.25358-1-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f3120c4f47ad..1077013d8ce2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
 		NULL
 	};
 	int i;
+	static struct strlist *idle_symbols_list;
 
-	for (i = 0; idle_symbols[i]; i++) {
-		if (!strcmp(idle_symbols[i], name))
-			return true;
-	}
+	if (idle_symbols_list)
+		return strlist__has_entry(idle_symbols_list, name);
 
-	return false;
+	idle_symbols_list = strlist__new(NULL, NULL);
+
+	for (i = 0; idle_symbols[i]; i++)
+		strlist__add(idle_symbols_list, idle_symbols[i]);
+
+	return strlist__has_entry(idle_symbols_list, name);
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
-- 
2.21.1
