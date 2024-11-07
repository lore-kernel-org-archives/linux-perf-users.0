Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18B217904;
	Thu,  7 Nov 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984005; cv=none; b=iMFcP8oV84ebOHDc6bo5wx+wpEhaRo+soONOpBlUIgw/L3Sq2K21Djpvp9TxSfdeIOP0FTv4TC4nJQG44DeNJ449+PEtVA8H7nscThQYHgAaTSuExV1Le3nGTUmfmisg6mxvFBs0EUe6avuuVWB5PgbdtVUjS/hh3i86tA+STxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984005; c=relaxed/simple;
	bh=03KkwZiPQBOVnf4NMbcHta8rWedhXrG6c2Fui05BMnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNObJPFbo070QshNTH0oOJ9ZzMBchPWLYL0WGulUvhUAOWa3jBmGBIV62kAUnZ+KxSBlT1D0ElzjGJ+DlmuLCR2Y/pAZs6SGe3TfDaTOEMR+NrrAQn+Hkack/PoB0Etd3UUiGE06zc1zGZdRC7geK60puQo+ZRgw6dzErIqpIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8381063;
	Thu,  7 Nov 2024 04:53:53 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 619973F66E;
	Thu,  7 Nov 2024 04:53:21 -0800 (PST)
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
Subject: [PATCH v2 3/3] perf cpumap: Add checking for reference counter
Date: Thu,  7 Nov 2024 12:53:08 +0000
Message-Id: <20241107125308.41226-4-leo.yan@arm.com>
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

For the CPU map merging test, add an extra check for the reference
counter before releasing the last CPU map.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/cpumap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f8187a801b8e..5ed7ff072ea3 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -167,6 +167,15 @@ static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const
 	cpu_map__snprint(a, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
 	perf_cpu_map__put(b);
+
+	/*
+	 * If 'b' is a superset of 'a', 'a' points to the same map with the
+	 * map 'b'. In this case, the owner 'b' has released the resource above
+	 * but 'a' still keeps the ownership, the reference counter should be 1.
+	 */
+	TEST_ASSERT_VAL("unexpected refcnt: bad result",
+			refcount_read(perf_cpu_map__refcnt(a)) == 1);
+
 	perf_cpu_map__put(a);
 	return 0;
 }
-- 
2.34.1

