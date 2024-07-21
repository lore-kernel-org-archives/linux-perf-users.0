Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00279161900;
	Sun, 21 Jul 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593300; cv=none; b=JromPAhRPbs+wUlxWa1u8pKhRyc69i125mqEy5S0zC76XfB/6w+uKkYJBpqoGSwGGYGq5B8yn+QK8c+XSQxVbb2U/ozIcEa9/jwZe/UDxZs+97U5E0WiSYSN/bxlxRAoYXY7lW+0gMSFwPAbIDfhupjn5/nBl5Rvw0EscVDqLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593300; c=relaxed/simple;
	bh=iTgW/iDhJ+Do4gUgnQRruD3d4y2Wnifor113FBLks2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrFIPu5moXBLGd2s/nbFOpSz3E+5HJUBirHngJ31rdWUAPhL1Rsodhed9OLpd87YWRDsVF5rbuGlfybHSYrnsKSDcEfQ5KtzJcFBiQ7s+XRJJad6Tgh2HB/jYDMq4g7+GyCah8MVsrLm0TytnIBvOwlmD9TfN7eCiCs+UBIkx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E481007;
	Sun, 21 Jul 2024 13:21:58 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3099C3F73F;
	Sun, 21 Jul 2024 13:21:30 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
Date: Sun, 21 Jul 2024 21:21:08 +0100
Message-Id: <20240721202113.380750-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721202113.380750-1-leo.yan@arm.com>
References: <20240721202113.380750-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than iterating the whole PMU list for finding the associated PMU
device for an evsel, this commit optimizes to directly use evsel's 'pmu'
pointer for accessing PMU device.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 986166bc7c78..798cd5a2ebc4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1199,7 +1199,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 
 bool evsel__is_aux_event(const struct evsel *evsel)
 {
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel->pmu;
 
 	return pmu && pmu->auxtrace;
 }
-- 
2.34.1

