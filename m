Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC615575F;
	Sat, 14 Sep 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351777; cv=none; b=L2eRJBonNJEzmXZX0jWAlk4Uh6h43WXhKCLcdG+xEepRTmfvm6mP5x+RxZ/kaPPe+OhMSkHNQqyU3ZiFYOB0wViulHotlbJY867MhTKo6Xk1Ew9X/nKv5XFZMejSvEhDChljLyIys28JCXGN05KUkZAzqFxR/r3ThezLHnorOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351777; c=relaxed/simple;
	bh=/X1eIoXTgs28/tCarZ6WVyEGCBHdsLYnDDJJxdZeuAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KS6ClxoLWjKWqTOAMxvG8+nEcINWKcjUekhDDtFr/mnuB+Oa9WhMcYl123/q+H/Pnw3QPgyzBVUTC1b+SqPEF11H1AThLCLwtOJaJdF7jrrRJRjMk80hIpPbbe9bULX9UhFm/AzC9T9+zUraKtVT5wcJ5pKSwuS6mJ8AXasFFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEA4C11FB;
	Sat, 14 Sep 2024 15:10:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A38B33F66E;
	Sat, 14 Sep 2024 15:09:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 7/7] perf arm-spe: Add Cortex CPUs to common data source encoding list
Date: Sat, 14 Sep 2024 23:09:01 +0100
Message-Id: <20240914220901.756177-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914220901.756177-1-leo.yan@arm.com>
References: <20240914220901.756177-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Cortex-A720, Cortex-A725, Cortex-X1C, Cortex-X3 and Cortex-X925 into
the common data source encoding list. For everyone of these CPUs, it
technical reference manual defines the data source packet as the common
encoding format.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 07bec88a3c7d..b64a5f3949f5 100644
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

