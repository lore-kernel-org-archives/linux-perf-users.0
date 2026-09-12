Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065442F7F07;
	Sat, 12 Sep 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182705; cv=none; b=Q2nC8ArL8U16irx1Mw2kCmNmaTsSSMaYaZi35Zlc0Ow4cET0CjSexfxX9wZjPyPPFWEFcipZwm21vXZAJX6pMsnu1eXm0LkzDQMeX5nJi/vF7E3EgXhi6HWML4HQQe9O6jrk1A2CuL5leCFi2tUBjwJrYEEetuprxVfBvGglvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182705; c=relaxed/simple;
	bh=Go5Hg7knIGDuijHH0qtGw0fQymnbvE7x4jbQmt+ICJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJCqUpXXKovqqP/nVVGPGHTxDFLDasJpMqCcUxHfsHpnIA0ZzcwQ5dsfrqnKP7vFZK6Jee84RytwQJ/dR58vQkxynXefU8Zyz9a9CZw1/+gyEt5snm3QsBfDwFIcFl6YwRbo6dCfHY/lG48Hph+WkTSFcf/KRquJ3tG7Oc582kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oXD9eBZz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oXD9eBZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=G6
	i46xAMMvlxSlwuhrN58VLqhWgxVA3qRAQZ2supRts=; b=oXD9eBZzmCrZ2vDq0Z
	lzplAiLVF03rhjx8WlbMszvJ4LdVBRHEMzWAd7mMZ+iG+XsuZ2qMdPGuo4IDhvLn
	LAPLPkf0y/3Frw5BSMAY8asOFenixFXyLrgxQJJKdhiePUACkpL2Wa9VJOVgKUI9
	3JSDIpepAeBoRqpApYMiMGAsk=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3X8fQwqRqv+m_AA--.45437S2;
	Sat, 12 Sep 2026 11:11:12 +0800 (CST)
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
Subject: [PATCH] perf evsel: Restrict incremental open error unwind
Date: Sat, 12 Sep 2026 12:11:10 +0900
Message-ID: <20260912031112.1814574-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X8fQwqRqv+m_AA--.45437S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrW8WrWxuw4Utw17uF18Grg_yoW7KryrpF
	WkCrWftrZ8Gr1avw1fJa17WFWagayfWr9rGr9akr4rZr4Iqr1kXrWIqa45tF1UZ3yvv3y2
	yF15KrWDCrWfAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ5r7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRCoCGqkwtCvfQAA3-

evsel__open_cpu(), evsel__tool_pmu_open() and
evsel__hwmon_pmu_open() support opening a subrange of a CPU map, bounded
by [start_cpu_map_idx, end_cpu_map_idx).

Their error paths, however, unwind using "while (--idx >= 0)" all the way
back to CPU index 0 regardless of start_cpu_map_idx. If lower CPU indices
were opened by an earlier invocation, a later incremental open failure
therefore closes those existing file descriptors and overwrites their
slots with -1.

Before this fix, running the new incremental open test demonstrates this
corruption:

  $ perf test -v "Tool PMU"
   12: Tool PMU:
   12.1: Tool PMU                                                      : Ok
   12.2: Tool PMU leader                                               : Ok
   12.3: Incremental open error unwind boundary:
     FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=-1, expected 4
  FAILED!

Stop the unwind at start_cpu_map_idx so that only file descriptors
opened by the current invocation are rolled back.

After this fix:

  $ perf test -v "Tool PMU"
   12: Tool PMU:
   12.1: Tool PMU                                                      : Ok
   12.2: Tool PMU leader                                               : Ok
   12.3: Incremental open error unwind boundary                        : Ok

Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/perf/tests/tool_pmu.c | 79 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c     |  2 +-
 tools/perf/util/hwmon_pmu.c |  2 +-
 tools/perf/util/tool_pmu.c  |  2 +-
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index c6c5ebf0e935..667160f9e2cd 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -1,8 +1,16 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <internal/xyarray.h>
+#include "cpumap.h"
 #include "debug.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "parse-events.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "tool_pmu.h"
 
 static int do_test(enum tool_pmu_event ev, bool with_pmu)
@@ -100,9 +108,80 @@ static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
 	return TEST_OK;
 }
 
+static int test__tool_pmu_incremental_open_unwind(struct test_suite *test __maybe_unused,
+						  int subtest __maybe_unused)
+{
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *threads = NULL;
+	struct evsel *evsel;
+	int ret = TEST_FAIL, fd0 = -1;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, "tool/user_time/", &err)) {
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
+		return TEST_FAIL;
+	}
+	parse_events_error__exit(&err);
+
+	evsel = evlist__first(evlist);
+	cpus = perf_cpu_map__new("0,1");
+	threads = thread_map__new_by_tid(getpid());
+	if (!cpus || !threads)
+		goto out;
+
+	/* Step 1: Open CPU index 0 successfully */
+	if (evsel__open_per_cpu_and_thread(evsel, cpus, 0, threads) < 0) {
+		pr_debug("Failed to open CPU index 0\n");
+		goto out;
+	}
+
+	fd0 = (*(int *)xyarray__entry(evsel->core.fd, 0, 0));
+	if (fd0 < 0 || fcntl(fd0, F_GETFD) < 0) {
+		pr_debug("CPU index 0 FD is invalid (%d)\n", fd0);
+		goto out;
+	}
+
+	/* Step 2: Intentionally trigger failure on CPU index 1 */
+	evsel->core.attr.sample_period = 1; /* Not supported for tool PMU -> -EINVAL */
+	if (evsel__open_per_cpu_and_thread(evsel, cpus, 1, threads) >= 0) {
+		pr_debug("Unexpected success opening CPU index 1 with sample_period=1\n");
+		goto out;
+	}
+
+	/*
+	 * Step 3: Check that CPU index 0's FD was NOT destroyed by CPU index 1's unwind.
+	 */
+	if ((*(int *)xyarray__entry(evsel->core.fd, 0, 0)) != fd0) {
+		pr_debug("FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=%d, expected %d\n",
+			 (*(int *)xyarray__entry(evsel->core.fd, 0, 0)), fd0);
+		goto out;
+	}
+
+	if (fcntl(fd0, F_GETFD) < 0) {
+		pr_debug("FAILED: CPU 0 FD %d was closed by error unwind! errno=%d (%s)\n",
+			 fd0, errno, strerror(errno));
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	evsel__close(evsel);
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
+	evlist__put(evlist);
+	return ret;
+}
+
 static struct test_case tests__tool_pmu[] = {
 	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
 	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
+	TEST_CASE("Incremental open error unwind boundary", tool_pmu_incremental_open_unwind),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..eb429087ebfe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3127,7 +3127,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	errno = old_errno;
 out:
 	if (err)
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index ed544dca70c3..96aeb379e169 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -803,7 +803,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	close(dir);
 	return err;
 }
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 5c30854b4644..d2f7591747d9 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -349,7 +349,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	errno = old_errno;
 	return err;
 }
-- 
2.55.0

