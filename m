From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 53/83] perf tests: Set evlist of test__basic_mmap() to !overwrite
Date: Fri, 17 Nov 2017 17:15:31 -0300
Message-ID: <20171117201601.24110-54-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758955AbdKQUTQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:16 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Wang Nan <wangnan0@huawei.com>

In this test, a large ring buffer is required so all events can feed
into, so overwrite or not is meaningless.

Change to !overwrite so following commits can remove this argument.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20171113013809.212417-5-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 5a8bf318f8a7..91f10d6d9ae2 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -94,7 +94,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		expected_nr_events[i] = 1 + rand() % 127;
 	}
 
-	if (perf_evlist__mmap(evlist, 128, true) < 0) {
+	if (perf_evlist__mmap(evlist, 128, false) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
-- 
2.13.6
