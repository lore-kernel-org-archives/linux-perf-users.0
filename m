Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40D146A83;
	Wed, 25 Sep 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294037; cv=none; b=BuHlfOJTrF5jbDolfpQmHOCtOgbBpzpGRmWzZ4zX2r33I071IOVINMW0VcdFo2B4QeEBdhaojTVGJg7KRo8Emgg0NA4CjJmRhMJUtkk7IYBXsCownnj8hvE4XxYEWMosQ4RWCLM3PeusnPyOmgNdHEObb06gVcv7Aqdqw90NU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294037; c=relaxed/simple;
	bh=1kP3y9v4x9gt4KRH/ael6EWdQPP4TyqLqmnTHACQqRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFATn+tMTVJlrLRvACkvlTJxnXmEqNM9UaGD7g4+ciqH7mqBgdplmwKOl0J/s+O0c+5PEQ+5IrAXLA+ZVrIU9bQCnz4dlz+hlJNpp/LWVf8mxQjOXrH+qAyg9FLrBper5wpKovC2N5JpM5ECq+npzKGkOvwUh/dr3Rn03jq1Tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961BC1576;
	Wed, 25 Sep 2024 12:54:23 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D2F63F64C;
	Wed, 25 Sep 2024 12:53:52 -0700 (PDT)
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
Subject: [PATCH v1 1/5] libperf cpumap: Correct reference count for perf_cpu_map__merge()
Date: Wed, 25 Sep 2024 20:53:21 +0100
Message-Id: <20240925195325.426533-2-leo.yan@arm.com>
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

The perf_cpu_map__merge() function has two arguments, 'orig' and 'other',
and it returns results for three different cases:

  Case 1: 'other' is a subset of 'orig'.
  Case 2: 'orig' is a subset of 'other'.
  Case 3: 'orig' and 'other' are not subsets of each other.

The result combinations are:

  +--------+-------------+-----------+-----------+
  | Cases  | Result      | orig      | other     |
  +--------+-------------+-----------+-----------+
  | Case1  | orig        | No change | No change |
  +--------+-------------+-----------+-----------+
  | Case2  | other       | No change | refcnt++  |
  +--------+-------------+-----------+-----------+
  | Case3  | New CPU map | refcnt--  | No change |
  +--------+-------------+-----------+-----------+

Both Case 1 and Case 3 have a risk of releasing maps unexpectedly. This
is because the reference counter operations are not consistent crossing
different cases and leads to difficulty for callers handling them.

For Case 1, because 'other' is a subset of 'orig', 'orig' is returned as
the merging result, but its refcnt is not incremented. This can lead to
the map being released repeatedly:

  struct perf_cpu_map *a = perf_cpu_map__new("1,2");
  struct perf_cpu_map *b = perf_cpu_map__new("2");

  /* 'm' and 'a' point to the same CPU map */
  struct perf_cpu_map *m = perf_cpu_map__merge(a, b);

  ...

  perf_cpu_map__put(m); -> Release the map
  perf_cpu_map__put(b);
  perf_cpu_map__put(a); -> Release the same merged again

For Case 3, it is possible that the CPU map pointed to by 'orig' can be
released twice: within the function and outside of it.

  struct perf_cpu_map *a = perf_cpu_map__new("1,2");
  struct perf_cpu_map *b = perf_cpu_map__new("3");

  struct perf_cpu_map *m = perf_cpu_map__merge(a, b);
                             `> 'm' is new allocated map. But 'a' has
			        been released in the function.
  ...

  perf_cpu_map__put(m);
  perf_cpu_map__put(b);
  perf_cpu_map__put(a); -> Release the 'a' map again

This commit increases the reference counter if a passed map is returned.
For the case of a newly allocated map, it does not change the reference
counter for passed maps.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/cpumap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index cae799ad44e1..3f80eade8b1c 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -438,9 +438,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 /*
  * Merge two cpumaps
  *
- * orig either gets freed and replaced with a new map, or reused
- * with no reference count change (similar to "realloc")
- * other has its reference count increased.
+ * Return a new map, or reused with its reference count increased.
  */
 
 struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
@@ -452,11 +450,9 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	struct perf_cpu_map *merged;
 
 	if (perf_cpu_map__is_subset(orig, other))
-		return orig;
-	if (perf_cpu_map__is_subset(other, orig)) {
-		perf_cpu_map__put(orig);
+		return perf_cpu_map__get(orig);
+	if (perf_cpu_map__is_subset(other, orig))
 		return perf_cpu_map__get(other);
-	}
 
 	tmp_len = __perf_cpu_map__nr(orig) + __perf_cpu_map__nr(other);
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
@@ -483,7 +479,6 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
 	free(tmp_cpus);
-	perf_cpu_map__put(orig);
 	return merged;
 }
 
-- 
2.34.1

