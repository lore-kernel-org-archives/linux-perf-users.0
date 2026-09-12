Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BB3382F7;
	Sat, 12 Sep 2026 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182704; cv=none; b=OppG9ue2loK4CFteer5Rks/Xj9TuzoIFvVO2vS2uLwW/N4Fpj86CqlPavIjDBjDMRQFKWSI8IKRpyWL8ZeE3fqgEbOZ72a34rw3Sf1reVnBUvX16kqx9hZTUQ9r5p1y9eSksXTTzpT6a1YXUDPPbEtq2RmXPF5VmgWazgTL+SVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182704; c=relaxed/simple;
	bh=QP2Bh3wvnXI7DGWMnsTcr06iy+Q5cC8F8FJJDngQuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDReiWmHy23N2KRNFtUsnEH31+fTa/N+Gj1SQMhdcsoHPwagM/bZCIZYL1DwIvlqHiic1lpJ9lWOR0TbFUqJdZejJVcuxUGqqCDH+BsujzyL+wHYJop1i3e7chB61R/JcNizrd1WSiaIvy2ibHbt9qBP5XSfCJksIqD9tiz3Pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XYZuiMHg; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XYZuiMHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hk
	lj20Q2apiklmmodSRLnuqLHqwmHtrbK6+oE8l2TYM=; b=XYZuiMHgeq53VOb1GE
	4X96DyWzw80CtiZwFkZOmmDzW3/sWKtCGqL6RJqR6Ec0F9ftPBg53N/aX30UzsGK
	haInIw0VtieBlNBnYSWI2BXhaxDxzX8RK/6NATRovoHCVh2pZDS+5arpVYmsxCV+
	nUIcwo+pF0GHjTIEd2kClXdSw=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXcvnQwqRqHqgZPw--.18025S2;
	Sat, 12 Sep 2026 11:11:13 +0800 (CST)
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
Subject: [PATCH] perf thread_map: Deduplicate numerically equivalent PID and TID strings
Date: Sat, 12 Sep 2026 12:11:11 +0900
Message-ID: <20260912031112.1814574-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXcvnQwqRqHqgZPw--.18025S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFWUtry7WFW5XrWUWFy3urg_yoW7KFW3pr
	WFka4ftws7AF48Zw12qa1kKFy5Gr1FgF47KrySkayrAw1xCw4fXFWIka4UJr17AFW8Z3WD
	Jrn8Wrn5KrWDJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUj1vxUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6RGoCGqkwtEBngAA3a

thread_map__new_by_pid_str() and thread_map__new_by_tid_str() attempt
to deduplicate adjacent PIDs/TIDs using prev_pid and prev_tid.
However, prev_pid and prev_tid were never updated inside the loop,
making the check "if (pid == prev_pid)" dead code.

Furthermore, even if prev_pid/prev_tid were updated, strlist sorts
lexicographically (e.g. "010", "011", "10"), which means identical
numeric values with different string representations (e.g. leading
zeros) are not adjacent in the list and would never be deduplicated.

Before this fix, running duplicate TID and PID tests fails:

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
 tools/perf/tests/thread-map.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/thread_map.c  | 28 ++++++++++++++++++++--------
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 877868107455..0299c8fd0a6a 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -56,6 +56,39 @@ static int test__thread_map(struct test_suite *test __maybe_unused, int subtest
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

