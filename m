Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD77283FDC;
	Sat, 12 Sep 2026 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190307; cv=none; b=PGWvS79ggXdRs6ULHBfh6HfbfnjUB8wpa2h6Ynmdlv2BwpllFW2BweL1F25OzoVHD8IQ9PATtFrvIevGLEEULPUCUwgKH0YGdTjFgriSww+CzXxteLiF5Sv/TeaTxyn7g3bgnfaqkag977KD4VwWcADyzsLkh65M2hBwAQg1Mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190307; c=relaxed/simple;
	bh=tE+UjwX16KPWLNxoxAUpqG2bUz+IBihT0iOPdKSq96s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3xYKA0rl6LM6dtXqaQsxE/C06koGhmhUSqKAuKIZJwRjZYKCbfI76M217f4SUUbgl8u4QUps797mPpLw5iUcvTln7WVDe3qFRZFhVDIk0Oa/BtGis1epiuLOCsPdBkfNiXcbLtYXYvCjCaNPRF7EKZdxi6HvqQjAHP/6TS2ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WkSPzCyk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WkSPzCyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ob
	reumAzFSG539bhkjy3mbnHi82EjpxhT2ed+BhSJ8w=; b=WkSPzCyk9D2glOolYF
	N3s6z9wybsgKCxWFf7qml8UQdjm+5z5MKpf3IwqFueJjw4IMg82kHPIi1dSv4YUH
	JjOYiz1BosE8qlRR6CbO8urPP8+zeV+uT3C1rjPKYYs/Uhd8LNf7qLLYwwk2RXvE
	qCrscQ7yqCkAhgRn4jzd75IaA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbzl74KRqe7rRAA--.56883S2;
	Sat, 12 Sep 2026 13:17:48 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v2] perf thread_map: Deduplicate numerically equivalent PID and TID strings
Date: Sat, 12 Sep 2026 14:17:47 +0900
Message-ID: <20260912051747.2215776-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912031112.1814574-2-sh_def@163.com>
References: <20260912031112.1814574-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbzl74KRqe7rRAA--.56883S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFWUtry7WFW5XrWUWFy3urg_yoWxXFyxpr
	WFka4ftws7AF4xZw12qa1vgFy5Wr1FgF47KryIka4rAw1xCw4fXFWIka4UJr17AFWkZ3WD
	Jrn8Wrn5KrWDJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRiF4tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwh4bemqk4H4yyAAA3X

thread_map__new_by_pid_str() and thread_map__new_by_tid_str() attempt
to deduplicate adjacent PIDs/TIDs using prev_pid and prev_tid.
However, prev_pid and prev_tid were never updated inside the loop,
making the check "if (pid == prev_pid)" dead code.

Furthermore, even if prev_pid/prev_tid were updated, strlist sorts
lexicographically (e.g. "010", "011", "10"), which means identical
numeric values with different string representations (e.g. leading
zeros) are not adjacent in the list and would never be deduplicated.

Before this fix, the new tests fail at the first duplicate TID case:

  $ perf test -v 35
  35: Thread map                                                      :
  --- start ---
  test child forked, pid 363297
  FAILED tests/thread-map.c:63 wrong nr for duplicate TIDs
    (nr=3, expected 1)
  test child finished with -1
  ---- end ----
  Thread map: FAILED!

Replace the ineffective prev_pid/prev_tid check with an intlist seen-set.
This ensures that any numeric duplicate PID or TID is properly
recognized and skipped, regardless of string formatting or order.

Add tests for numerically equivalent PID and TID strings.

After this fix:

  $ perf test -v 35
  35: Thread map                                                      :
  --- start ---
  test child forked, pid 363650
  test child finished with 0
  ---- end ----
  Thread map: Ok

Fixes: b52956c961be ("perf tools: Allow multiple threads or processes in record, stat, top")
Signed-off-by: Hui Su <sh_def@163.com>
---
Differences in v2:
 - Explicitly include <stdio.h> in tools/perf/tests/thread-map.c for snprintf.
 - Link to v1: https://lore.kernel.org/r/20260912031112.1814574-2-sh_def@163.com/

 tools/perf/tests/thread-map.c | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/thread_map.c  | 28 ++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 877868107455..690ccae17c31 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
@@ -56,6 +57,39 @@ static int test__thread_map(struct test_suite *test __maybe_unused, int subtest
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&map->refcnt) == 1);
 	perf_thread_map__put(map);
+
+	/* test numeric deduplication of TIDs */
+	map = thread_map__new_by_tid_str("123,0123,00123");
+	TEST_ASSERT_VAL("failed to alloc map", map);
+	TEST_ASSERT_VAL("wrong nr for duplicate TIDs", map->nr == 1);
+	TEST_ASSERT_VAL("wrong pid", perf_thread_map__pid(map, 0) == 123);
+	perf_thread_map__put(map);
+
+	/* test non-adjacent numeric duplicates (strlist lexicographic: 010, 011, 10) */
+	map = thread_map__new_by_tid_str("010,011,10");
+	TEST_ASSERT_VAL("failed to alloc map", map);
+	TEST_ASSERT_VAL("wrong nr for non-adjacent duplicate TIDs", map->nr == 2);
+	perf_thread_map__put(map);
+
+	/* test numeric deduplication of PIDs */
+	{
+		struct perf_thread_map *base, *dup;
+		char pid_str[64];
+
+		base = thread_map__new_by_pid(getpid());
+		TEST_ASSERT_VAL("failed to alloc baseline map", base);
+
+		snprintf(pid_str, sizeof(pid_str), "%d,0%d", getpid(), getpid());
+
+		dup = thread_map__new_str(pid_str, NULL, false);
+		TEST_ASSERT_VAL("failed to alloc duplicate pid map", dup);
+		TEST_ASSERT_VAL("wrong nr for duplicate PIDs",
+				dup->nr == base->nr);
+
+		perf_thread_map__put(dup);
+		perf_thread_map__put(base);
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 48c70f149e92..7b59b3f7f2e4 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include "string2.h"
 #include "strlist.h"
+#include "intlist.h"
 #include <string.h>
 #include <api/fs/fs.h>
 #include <linux/string.h>
@@ -163,12 +164,13 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 	int items, total_tasks = 0;
 	struct dirent **namelist = NULL;
 	int i, j = 0;
-	pid_t pid, prev_pid = INT_MAX;
+	pid_t pid;
 	struct str_node *pos;
 	struct strlist *slist = strlist__new(pid_str, NULL);
+	struct intlist *seen = intlist__new(NULL);
 
-	if (!slist)
-		return NULL;
+	if (!slist || !seen)
+		goto out;
 
 	strlist__for_each_entry(pos, slist) {
 		pid = strtol(pos->s, NULL, 10);
@@ -176,9 +178,12 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 		if (pid == INT_MIN || pid == INT_MAX)
 			goto out_free_threads;
 
-		if (pid == prev_pid)
+		if (intlist__has_entry(seen, (unsigned long)pid))
 			continue;
 
+		if (intlist__add(seen, (unsigned long)pid))
+			goto out_free_threads;
+
 		sprintf(name, "/proc/%d/task", pid);
 		items = scandir(name, &namelist, filter, NULL);
 		if (items <= 0)
@@ -200,6 +205,7 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 	}
 
 out:
+	intlist__delete(seen);
 	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
@@ -219,17 +225,19 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 {
 	struct perf_thread_map *threads = NULL, *nt;
 	int ntasks = 0;
-	pid_t tid, prev_tid = INT_MAX;
+	pid_t tid;
 	struct str_node *pos;
 	struct strlist *slist;
+	struct intlist *seen;
 
 	/* perf-stat expects threads to be generated even if tid not given */
 	if (!tid_str)
 		return perf_thread_map__new_dummy();
 
 	slist = strlist__new(tid_str, NULL);
-	if (!slist)
-		return NULL;
+	seen = intlist__new(NULL);
+	if (!slist || !seen)
+		goto out;
 
 	strlist__for_each_entry(pos, slist) {
 		tid = strtol(pos->s, NULL, 10);
@@ -237,9 +245,12 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		if (tid == INT_MIN || tid == INT_MAX)
 			goto out_free_threads;
 
-		if (tid == prev_tid)
+		if (intlist__has_entry(seen, (unsigned long)tid))
 			continue;
 
+		if (intlist__add(seen, (unsigned long)tid))
+			goto out_free_threads;
+
 		ntasks++;
 		nt = perf_thread_map__realloc(threads, ntasks);
 
@@ -251,6 +262,7 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		threads->nr = ntasks;
 	}
 out:
+	intlist__delete(seen);
 	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
-- 
2.55.0

