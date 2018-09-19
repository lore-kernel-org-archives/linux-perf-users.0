From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/13] tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header
Date: Wed, 19 Sep 2018 11:25:29 -0300
Message-ID: <20180919142537.29985-6-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ding Xiang <dingxiang@cmss.chinamobile.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

Add PTR_ERR_OR_ZERO, so that tools can use it, just like the kernel.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 7a8b61ad44cb..094649667bae 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
 
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
 #endif /* _LINUX_ERR_H */
-- 
2.14.4
