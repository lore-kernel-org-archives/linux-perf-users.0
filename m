Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2891AB6EF;
	Thu,  3 Oct 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981619; cv=none; b=SWJ2RpbSO76p78gkkGJ+BuM/VEKByfzZ4NbqUr9VMqyqFcsHvXuUuvksx/8BPPXmSadkVW9G4GFrUKDol2sAD2lSEtWVwG537+CfegJcTOQiaVqZx3VPwzeRYhPHzVHgA1SKMJHCGYKTODB00qBFC5sm5f1b/oHwajuntnR9Byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981619; c=relaxed/simple;
	bh=fPKQP1jFze7BRm9mPDY4X0fnIw4wuUgFrVWd5pUD9i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOeTpompeFI05LlibhxWxR9rWUEnBZ8isPRLAico0jYdcaiwOJSjjtUg4xnWqY8DJ8JKOuNGDsRSFaDdEYGzkCY7BxS0YalJmrt1REa/89GG2gaLIwiApEClOycP+Q51u8xKflAUATQfRaGyACxt4mP5ZSvo4ZRh+c6LiRxqMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1786497;
	Thu,  3 Oct 2024 11:54:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D91F3F640;
	Thu,  3 Oct 2024 11:53:35 -0700 (PDT)
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
Subject: [PATCH v3 1/7] perf arm-spe: Rename arm_spe__synth_data_source_generic()
Date: Thu,  3 Oct 2024 19:53:16 +0100
Message-Id: <20241003185322.192357-2-leo.yan@arm.com>
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

The arm_spe__synth_data_source_generic() function is invoked when the
tool detects that CPUs do not support data source packets and falls back
to synthesizing only the memory level.

Rename it to arm_spe__synth_memory_level() for better reflecting its
purpose.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 13fd2c8afebd..34e147e8a963 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -496,8 +496,8 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	}
 }
 
-static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
-					       union perf_mem_data_src *data_src)
+static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
+					union perf_mem_data_src *data_src)
 {
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L3;
@@ -534,7 +534,7 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	if (is_neoverse)
 		arm_spe__synth_data_source_neoverse(record, &data_src);
 	else
-		arm_spe__synth_data_source_generic(record, &data_src);
+		arm_spe__synth_memory_level(record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;
-- 
2.34.1

