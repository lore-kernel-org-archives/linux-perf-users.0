From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/75] tools include: Adopt ERR_CAST() from the kernel err.h header
Date: Thu,  6 Dec 2018 18:25:00 -0300
Message-ID: <20181206212602.20474-14-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Howells <dhowells@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Wen Yang <yellowriver2010@hotmail.com>, zhong.weidong@zte.com.cn
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add ERR_CAST(), so that tools can use it, just like the kernel.

This addresses coccinelle checks that are being performed to tools/ in
addition to kernel sources, so lets add this to cover that and to get
tools code closer to kernel coding standards.

This originally was introduced in the kernel headers in this cset:

  d1bc8e954452 ("Add an ERR_CAST() function to complement ERR_PTR and co.")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/n/tip-tlt97p066zyhzqhl5jt86og7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 094649667bae..2f5a12b88a86 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -59,4 +59,17 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 	else
 		return 0;
 }
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * __must_check ERR_CAST(__force const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
 #endif /* _LINUX_ERR_H */
-- 
2.19.2
