From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/73] perf jevents: Remove unused variable
Date: Fri, 17 May 2019 16:35:58 -0300
Message-ID: <20190517193611.4974-61-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, John Garry <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>, wanghaibin.wang@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

Address gcc warning:

  pmu-events/jevents.c: In function ‘save_arch_std_events’:
  pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
    struct stat *sb = data;
                 ^~

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: wanghaibin.wang@huawei.com
Link: http://lkml.kernel.org/r/1557919169-23972-1-git-send-email-yuzenghui@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index daaea5003d4a..58f77fd0f59f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -415,7 +415,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *metric_name, char *metric_group)
 {
 	struct event_struct *es;
-	struct stat *sb = data;
 
 	es = malloc(sizeof(*es));
 	if (!es)
-- 
2.20.1
