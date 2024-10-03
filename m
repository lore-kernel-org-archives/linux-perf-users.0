Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07C1AB6DE;
	Thu,  3 Oct 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981630; cv=none; b=JAjUv8WclFzbma6n1GIW5hzvArUffWx89cDe3P4ZqkF2zLV1PhG2Q24q+u71m0q6k3Nywouz9rUWaOAP4C6cWBAVa70NUNeU5YufqUQxMzXu9dTR+JMerE4ckdUujs4MpAFU23hblI08ghBaUxhXamKioZtOipoWbYkr5JV5Sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981630; c=relaxed/simple;
	bh=7kEFo8Kklmc9Fw0lsHNelbnmeo3pWe6BVgToP4WKWDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jl3gY3lsUVy3rTdEUCPU3c6GDpx3F0gStS9Y/ZpNP/i1mlYpfYjQj5GUY+UrlsMWRJxcCEpiFLgK6nGQfmj1/leR5irj3tMxmeDTyCDVndgDovP6DxVaa5FDkEm6Vl3SOkXyB+Zyppo9NXDKtxe3AGzOnz919HJ8kmtnzyk95bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16E4D497;
	Thu,  3 Oct 2024 11:54:18 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B63B3F640;
	Thu,  3 Oct 2024 11:53:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 6/7] perf arm-spe: Add Neoverse-V2 to common data source encoding list
Date: Thu,  3 Oct 2024 19:53:21 +0100
Message-Id: <20241003185322.192357-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
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
index 485f60c32309..5c34a9ae3862 100644
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

