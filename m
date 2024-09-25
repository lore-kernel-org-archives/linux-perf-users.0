Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8E165F1C;
	Wed, 25 Sep 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294044; cv=none; b=EBlqtGiKtg23AePM5ngqO+xn/nAj4dtc1gfh413R94Bj0zAiTbS/P1B4Zv/n4xgXVNNBNOnqurEY4ENoNlrhxgQ3oOirwQWgzuUKFT1lT+R0GkY6vHz1BuiFTyNauwaMk57J2BwNcM7z+8UdJODTRzN8kqkmyA/yvCTZlf5w8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294044; c=relaxed/simple;
	bh=XYqMdQ221ClMLf6vRpxFS9OZ5NIjBc81FRZpkGdMeHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9NsVw+MoJkEp6KWhLcLWcnKukfbV/o8FlhQ32DG/gqDzafS9XRYWx3yfPGaXkqAq8zKpgnPhFM0FFRnXEmvtieBpcxiIHWI3b8RpvZmo5xfMtSiv0qv8FWomaXIMWDC0OaODHVRWAj6LBx1mfgQzChxYBHXBrA/krGh+IcwtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BABDA1576;
	Wed, 25 Sep 2024 12:54:31 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 826353F64C;
	Wed, 25 Sep 2024 12:54:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 5/5] perf cpumap: Add checking for reference counter
Date: Wed, 25 Sep 2024 20:53:25 +0100
Message-Id: <20240925195325.426533-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925195325.426533-1-leo.yan@arm.com>
References: <20240925195325.426533-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the CPU map merging and intersection cases, add an extra check for
the reference counter before releasing the last CPU map.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/cpumap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index d5b6c450f5c9..0bcf603a0ccf 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -168,6 +168,16 @@ static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
 	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
+
+	/*
+	 * If 'b' is a superset of 'a', 'c' points to the same map with the
+	 * map 'b'. In this case, the two owners 'b' and 'c' both point to the
+	 * same map. The owner 'b' has released the resource above but 'c'
+	 * still keeps the ownership, so the reference counter should be 1.
+	 */
+	TEST_ASSERT_VAL("unexpected refcnt: bad result",
+			refcount_read(perf_cpu_map__refcnt(c)) == 1);
+
 	perf_cpu_map__put(c);
 	return 0;
 }
@@ -208,6 +218,16 @@ static int __test__cpu_map_intersect(const char *lhs, const char *rhs, int nr, c
 	TEST_ASSERT_VAL("failed to intersect map: bad result", !strcmp(buf, expected));
 	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
+
+	/*
+	 * If 'b' is a subset of 'a', 'c' points to the same map with the
+	 * map 'b'. In this case, the two owners 'b' and 'c' both point to the
+	 * same map. The owner 'b' has released the resource above but 'c'
+	 * still keeps the ownership, so the reference counter should be 1.
+	 */
+	TEST_ASSERT_VAL("unexpected refcnt: bad result",
+			refcount_read(perf_cpu_map__refcnt(c)) == 1);
+
 	perf_cpu_map__put(c);
 	return 0;
 }
-- 
2.34.1

