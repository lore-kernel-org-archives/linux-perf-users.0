From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/83] perf tests: Set evlist of test__backward_ring_buffer() to !overwrite
Date: Fri, 17 Nov 2017 17:15:29 -0300
Message-ID: <20171117201601.24110-52-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbdKQUTO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:14 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Wang Nan <wangnan0@huawei.com>

Setting overwrite in perf_evlist__mmap() is meaningless because the
event in this evlist is already have 'overwrite' postfix and goes to
backward ring buffer automatically. Pass 'false' to perf_evlist__mmap()
to make it similar to others.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20171113013809.212417-3-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/backward-ring-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 71b9a0b613d2..43a8c6ac4070 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -59,7 +59,7 @@ static int do_test(struct perf_evlist *evlist, int mmap_pages,
 	int err;
 	char sbuf[STRERR_BUFSIZE];
 
-	err = perf_evlist__mmap(evlist, mmap_pages, true);
+	err = perf_evlist__mmap(evlist, mmap_pages, false);
 	if (err < 0) {
 		pr_debug("perf_evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-- 
2.13.6
