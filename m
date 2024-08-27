Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5101D2F65;
	Tue, 27 Aug 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777520; cv=none; b=CAlwaq6jVNqnr8PUSWCC1LfL2Ewv7/T5rix0sHMu5Hpv4gikh3ZW/5xTUW2qmkmUDR4VnnX25gE0uQfOaTs10gpzO2IKleHUAhCLqTX/uT1yszEZWtLxPhxwb2ppyo2wTY/rnce/DUc0l3e8UHpxCjHII0UCWPeZACZnNAmhosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777520; c=relaxed/simple;
	bh=bpaAe/Fi8aLjM0znkFdqV0i50kIrhpPVlk3I8KLM470=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOyYUqEnCsD2B/VpWYOUjDxoK7o9zcpS6B1a7PMmr+HzxBOqalaYQw6RVIyPrkr+ORAgtCTVZRj35tgq78c+pYeIBja+88AsohGe0Ljcx4rd5bzWsuCO5ZSTApy3GwnvVYHgWO0nu4f9YR+tPJAjDvVKqJqrj0Od/NzqG7ToasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE2711FB;
	Tue, 27 Aug 2024 09:52:24 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 942343F66E;
	Tue, 27 Aug 2024 09:51:56 -0700 (PDT)
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
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 7/7] perf arm-spe: Add Cortex CPUs to common data source encoding list
Date: Tue, 27 Aug 2024 17:51:25 +0100
Message-Id: <20240827165125.3311306-8-leo.yan@arm.com>
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

Add Cortex-A720, Cortex-A725, Cortex-X1C, Cortex-X3 and Cortex-X925 into
the common data source encoding list. As ever CPU's technical reference
manual defines the data source packet as the common encoding format.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index b97837f71bfc..422950db9566 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -428,6 +428,11 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 }
 
 static const struct midr_range common_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-- 
2.34.1

