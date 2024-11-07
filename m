Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DC212171;
	Thu,  7 Nov 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984003; cv=none; b=AT5vgSV+8ra0DgUMZ58qlL/kpECPzhmXKBmYEDdEO0/GW0PorBGznT9bt/oMJy7HrnKWCkEJoQGa92j7/lXWlqDFiPgWNFYuqhqUh61ZOXKrr3L9vgMNFpEPrHrU1Pn7zGVEcdkHI4cuXZ7pO0Xx2DZ8Znzkzl3GiC+iLMjRCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984003; c=relaxed/simple;
	bh=w//oz49RFW0FGN6kIjlGyOVQ8mNTqSaIM/vtfz2beh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNSpUqrDvw4UmlcUi6LTx/D3Ca6zxYSym2hEwagjXJIEj4/ksoapxzIYD9GlRhqcwQKOKZOsWP7B1kjJ5thhfO9bir/RPhLqDMzjMP8tXy8G/lPHkj4q16n5rtD+bAiZqoGfab0QUPM+Z8gizAuwo7EJljTzKDCgGhbeK3ek7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A5BB497;
	Thu,  7 Nov 2024 04:53:51 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 594383F66E;
	Thu,  7 Nov 2024 04:53:19 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 2/3] perf cpumap: Add more tests for CPU map merging
Date: Thu,  7 Nov 2024 12:53:07 +0000
Message-Id: <20241107125308.41226-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125308.41226-1-leo.yan@arm.com>
References: <20241107125308.41226-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional tests for CPU map merging to cover more cases.

These tests include different types of arguments, such as when one CPU
map is a subset of another, as well as cases with or without overlap
between the two maps.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/cpumap.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7f189d57232f..f8187a801b8e 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -156,21 +156,45 @@ static int test__cpu_map_print(struct test_suite *test __maybe_unused, int subte
 	return 0;
 }
 
-static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const char *expected)
 {
-	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
-	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
+	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
+	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
 	char buf[100];
 
 	perf_cpu_map__merge(&a, b);
-	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == 5);
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == nr);
 	cpu_map__snprint(a, buf, sizeof(buf));
-	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(a);
 	return 0;
 }
 
+static int test__cpu_map_merge(struct test_suite *test __maybe_unused,
+			       int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = __test__cpu_map_merge("4,2,1", "4,5,7", 5, "1-2,4-5,7");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_merge("1-8", "6-9", 9, "1-9");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_merge("1-8,12-20", "6-9,15", 18, "1-9,12-20");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_merge("4,2,1", "1", 3, "1-2,4");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_merge("1", "4,2,1", 3, "1-2,4");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_merge("1", "1", 1, "1");
+	return ret;
+}
+
 static int __test__cpu_map_intersect(const char *lhs, const char *rhs, int nr, const char *expected)
 {
 	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
-- 
2.34.1

