Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158328C2B1
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297077; cv=none; b=pbb5YXoF+ygBk9g5xMU9d5Mu4obhqqvxG7a3XWOh0TSHtm9G7NaDiw9gxDmhl12yxphshxAUBvGSg/Yp8wOpzCp1sCYj9zQ4eTTga7T8GyAqpGI43Ykd/Rn1bGuOUHSc09XZwG/O+HJTJ2TChRtKb7QzRC7h+THh2Ual/Hlap1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297077; c=relaxed/simple;
	bh=SSENaL9QPQy/OwQbeJf4NlxCmJRyfqxIKzm2IN2ukF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az1iVfidbDo3B47TuyBMCJvMky+uBCNW3dl1DenFrwY4vvYe8489JAaFCtDTceiJo8/A7JMn2gIJhwrKuLs5qWRZ4/QiOiEG1m6hMWLwwLrBNF1/rObpZnRnExRKE710khwB+7NuoJvPTo3+trDwTJbeE7juK9CorRwinavJAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E8FE1516;
	Mon, 30 Jun 2025 08:24:20 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B383F6A8;
	Mon, 30 Jun 2025 08:24:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 30 Jun 2025 16:23:43 +0100
Subject: [PATCH v2 11/13] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-11-2e1afab313b9@arm.com>
References: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
In-Reply-To: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751297044; l=1957;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SSENaL9QPQy/OwQbeJf4NlxCmJRyfqxIKzm2IN2ukF0=;
 b=EZipj/LL0o/8GPMbqI4Pnrqhg6pBpATY8/R81PyVLDw2BPyn8mWApkYc63cNxNzZwjKJ+Npgg
 2I1nOdKtAFVAYHsLDF4gOi+JpfE5k1aPR8J91ONP5kW6oBMNEvsVhJ1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Handle "CPU=-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
function. As a result, the function is more general and will be invoked
by a sequential change.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3715afbe1e4713b5eebb00afbcb3eaa56ff1c49c..5b6699f192e5e58bab6b0d8e2e8df80fdf404a36 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -324,6 +324,19 @@ static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
 	if (!spe->metadata)
 		return NULL;
 
+	/* CPU ID is -1 for per-thread mode */
+	if (cpu < 0) {
+		/*
+		 * On the heterogeneous system, due to CPU ID is -1,
+		 * cannot confirm the meta data.
+		 */
+		if (!spe->is_homogeneous)
+			return NULL;
+
+		/* In homogeneous system, simply use CPU0's metadata */
+		return spe->metadata[0];
+	}
+
 	for (i = 0; i < spe->metadata_nr_cpu; i++)
 		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
 			return spe->metadata[i];
@@ -926,22 +939,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 		cpuid = perf_env__cpuid(spe->session->evlist->env);
 		midr = strtol(cpuid, NULL, 16);
 	} else {
-		/* CPU ID is -1 for per-thread mode */
-		if (speq->cpu < 0) {
-			/*
-			 * On the heterogeneous system, due to CPU ID is -1,
-			 * cannot confirm the data source packet is supported.
-			 */
-			if (!spe->is_homogeneous)
-				return false;
-
-			/* In homogeneous system, simply use CPU0's metadata */
-			if (spe->metadata)
-				metadata = spe->metadata[0];
-		} else {
-			metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
-		}
-
+		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
 		if (!metadata)
 			return false;
 

-- 
2.34.1

