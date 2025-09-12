Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A47315D5A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691790; cv=none; b=d9gH0QoS6fxZweHQi25xcQmJrjUUVDNqlfRk/PWI/QirIPrSfjdqIFCtQsZDOpgr5wQ2mYJopaS4bGdMCb3Cl9E9/2wRzhRTj8AJpjs68t668P/b4Rz4lP6+6LJiVtUjK5xs7jjsSA3lyyHJ/9D0OfeEqVeX9a6G7E4j5J/g6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691790; c=relaxed/simple;
	bh=1kKucE6e8wSangp0jm3cWYqA6xJQBIZEXjnOHyytAM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAF1+egljedHlezuo/aiMao6F4jlRpDdJvaiYeMHb6I533StlwxX/+UeCZ+eD2NJ6CxavuYM68oG47QdIaWArLn4twPt8EueKYkrNe/2QV+i5EQbt8sF73GL8y0pPyEwJO6DhsXxFtQxWyHHtKAQpAW+m0/1Ezjcu9SF5pBUUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CF71515;
	Fri, 12 Sep 2025 08:43:00 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A50943F694;
	Fri, 12 Sep 2025 08:43:06 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:17 +0100
Subject: [PATCH v5 12/14] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-12-0800880da0a7@arm.com>
References: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
In-Reply-To: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=2238;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1kKucE6e8wSangp0jm3cWYqA6xJQBIZEXjnOHyytAM4=;
 b=heCRUuQYA+SJZUUJraZiBi+RVFteohKeqMxWdGbf7q0QAMdXuNLV+HBMdiK3GotMTIF6uPqCh
 pzkA0wmJ4BKAIsV0WpcXpiwxu0X355HpwBo2Gumicm2MYrr0wQUbUzZ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Handle "CPU=-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
function. As a result, the function is more general and will be invoked
by a sequential change.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index c5fd62534e0362dd69c69f6e836cef6f67b0d060..58f80b5c0ab969448c962adb31abde5067cf4be3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -315,15 +315,28 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
 	return 0;
 }
 
-static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
+static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, int cpu)
 {
 	u64 i;
 
 	if (!spe->metadata)
 		return NULL;
 
+	/* CPU ID is -1 for per-thread mode */
+	if (cpu < 0) {
+		/*
+		 * On the heterogeneous system, due to CPU ID is -1,
+		 * cannot confirm the data source packet is supported.
+		 */
+		if (!spe->is_homogeneous)
+			return NULL;
+
+		/* In homogeneous system, simply use CPU0's metadata */
+		return spe->metadata[0];
+	}
+
 	for (i = 0; i < spe->metadata_nr_cpu; i++)
-		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
+		if (spe->metadata[i][ARM_SPE_CPU] == (u64)cpu)
 			return spe->metadata[i];
 
 	return NULL;
@@ -915,22 +928,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 		cpuid = perf_env__cpuid(perf_session__env(spe->session));
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

