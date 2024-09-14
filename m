Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E814A635;
	Sat, 14 Sep 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351775; cv=none; b=hlTeRofmN2Kesu+krEZh3WIj1wQ/nvJwLPHNrQD6StE0n8QANGDxqY3my6u0FCYFHm4KmiIyq7MN8fJMqh69XGndFQ4wRwP1ofY8CO3aC29cHfIxhQl91edfKIQPuMBGwZ6Y8ODrb4QIZwgBP8TVwili9jXwlXHySSeRGkkrEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351775; c=relaxed/simple;
	bh=VkOUDlVxYwrPSOrg/medc2fCns6IwYe1oVW8xKV6Gfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXnA/aln6CGargmqzTMCPwryPZTCECdgMFH8wePzNtawLhBckiH6UUsAOiLrJ8B0LQjRCSylvBPW8ZXmOEwt9qKW3SEnFQV0t33z04sESmAiRDuDB0by6VLlAavLQxRAVZN+ndt+/hkS45xJ7//QcCMJFZkO8Dxe7Ca8V3qq1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDEFC1691;
	Sat, 14 Sep 2024 15:10:02 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92A803F66E;
	Sat, 14 Sep 2024 15:09:31 -0700 (PDT)
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
Subject: [PATCH v2 6/7] perf arm-spe: Add Neoverse-V2 to common data source encoding list
Date: Sat, 14 Sep 2024 23:09:00 +0100
Message-Id: <20240914220901.756177-7-leo.yan@arm.com>
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

From: Besar Wicaksono <bwicaksono@nvidia.com>

Add Neoverse-V2 MIDR to the common data source encoding range list.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index cb0d40b7e3fa..07bec88a3c7d 100644
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

