From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/43] perf metricgroup: Use strsep()
Date: Mon,  1 Jul 2019 23:26:02 -0300
Message-ID: <20190702022616.1259-30-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour intended, trivial optimization done by avoiding
looking for spaces in 'g' right after setting it to "No_group".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f2siadtp3hb5o0l1w7bvd8bk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a0cf3cd95ced..90cd84e2a503 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -308,10 +308,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				struct mep *me;
 				char *s;
 
+				g = skip_spaces(g);
 				if (*g == 0)
 					g = "No_group";
-				while (isspace(*g))
-					g++;
 				if (filter && !strstr(g, filter))
 					continue;
 				if (raw)
-- 
2.20.1
