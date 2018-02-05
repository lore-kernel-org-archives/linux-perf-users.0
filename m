From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/10] tools headers: Synchronize uapi/linux/sched.h
Date: Mon,  5 Feb 2018 16:56:14 -0300
Message-ID: <20180205195620.9010-5-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Juri Lelli <juri.lelli@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the tools copy updated with the changes in 34be39305a77
("sched/deadline: Implement "runtime overrun signal" support"), that
cause no effect on the tools, will be used when we start copying the
sched_attr struct argument to the sched_get/setattr syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Juri Lelli <juri.lelli@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8rododhs87x8hv9k83qcdtne@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 30a9e51bbb1e..22627f80063e 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -49,5 +49,10 @@
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
+#define SCHED_FLAG_DL_OVERRUN		0x04
+
+#define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
+			 SCHED_FLAG_RECLAIM		| \
+			 SCHED_FLAG_DL_OVERRUN)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.14.3
