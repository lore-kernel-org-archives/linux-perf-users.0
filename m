From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/19] perf tools: Add perf_data_file__write function
Date: Fri,  3 Nov 2017 10:54:55 -0300
Message-ID: <20171103135503.4921-12-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756458AbdKCN4Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Nov 2017 09:56:16 -0400
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Adding perf_data_file__write function to provide single file write
operation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-c3f9p4xzykr845ktqcek6p4t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 8 +++++++-
 tools/perf/util/data.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 07ef56a4123c..f80a23d031d6 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -144,10 +144,16 @@ void perf_data__close(struct perf_data *data)
 	close(data->file.fd);
 }
 
+ssize_t perf_data_file__write(struct perf_data_file *file,
+			      void *buf, size_t size)
+{
+	return writen(file->fd, buf, size);
+}
+
 ssize_t perf_data__write(struct perf_data *data,
 			      void *buf, size_t size)
 {
-	return writen(data->file.fd, buf, size);
+	return perf_data_file__write(&data->file, buf, size);
 }
 
 int perf_data__switch(struct perf_data *data,
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 1797bed3aa4b..000c43bbb7ac 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -50,6 +50,8 @@ int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
 ssize_t perf_data__write(struct perf_data *data,
 			      void *buf, size_t size);
+ssize_t perf_data_file__write(struct perf_data_file *file,
+			      void *buf, size_t size);
 /*
  * If at_exit is set, only rename current perf.data to
  * perf.data.<postfix>, continue write on original data.
-- 
2.13.6
