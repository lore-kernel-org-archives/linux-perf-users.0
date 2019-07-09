From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/25] perf metricgroup: Add missing list_del_init() when flushing egroups list
Date: Tue,  9 Jul 2019 15:31:17 -0300
Message-ID: <20190709183126.30257-17-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that at the end each of the entries have its list node struct cleared
and the egroup list head ends emptied.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dxzj1ah350fy9ec0xbhb15b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0d8c840f88c0..416a9015405e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -492,6 +492,7 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 		for (i = 0; i < eg->idnum; i++)
 			zfree(&eg->ids[i]);
 		zfree(&eg->ids);
+		list_del_init(&eg->nd);
 		free(eg);
 	}
 }
-- 
2.21.0
