From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/24] perf: Remove duplicated workqueue.h include from perf_event.h
Date: Mon, 21 Jan 2019 20:56:50 -0300
Message-ID: <20190121235706.20005-9-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

It is already included a little bit higher up in that file.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190117072504.14428-1-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cec02dc63b51..f8ec36197718 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
 #include <linux/atomic.h>
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
-#include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <asm/local.h>
 
-- 
2.20.1
