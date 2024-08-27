Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4EE1D27AF;
	Tue, 27 Aug 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777517; cv=none; b=DIq+dHHQgulaDl2JoWxjbJw+KHmQu06iN6vUQ61I1LiZuIwWzaNWER4Gkkb8URYLWiYC+gvumqgKyjX8tlPDeiKjZm2KFyc39Fwr3RrzTCZVo+r2dnGbjYFgtj38SAf9DOzNw6+Ob0fQ52mNnIdchbjlRjTRcOQUL5gLljAvY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777517; c=relaxed/simple;
	bh=EVFi51hL3nruh/Q8y2VF0oMGKq0Fnt+ysBQKmRsEj8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKXLoNOw15Q69AqayhSlbDSe8qmSRvXqT0n/Xf5fdQ2EQS5/x15j7NLtkwkBSi6KCSR9YZjOtmEeT6dRJwZiN0MYvWugpeE8/ZYJO7B2gL04Lp1IItQM3xWLGcZMxHNiofEnsiaap5EwEVLem9HxUW3NPD1+nB3Zuv+dr1i3V5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C5011FB;
	Tue, 27 Aug 2024 09:52:22 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2963A3F66E;
	Tue, 27 Aug 2024 09:51:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Besar Wicaksono <bwicaksono@nvidia.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 6/7] perf arm-spe: Add Neoverse-V2 to common data source encoding list
Date: Tue, 27 Aug 2024 17:51:24 +0100
Message-Id: <20240827165125.3311306-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827165125.3311306-1-leo.yan@arm.com>
References: <20240827165125.3311306-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Besar Wicaksono <bwicaksono@nvidia.com>

Add Neoverse-V2 MIDR to the common data source encoding range list.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index f7bc39043a23..b97837f71bfc 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -431,6 +431,7 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	{},
 };
 
-- 
2.34.1

