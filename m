Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789DE20C00A
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716255; cv=none; b=ql5gUZ2vgBbJzxvyyaEMI1/IBfGeAJJkHHFOmHtT5HFwAI5KaXKC23On37TnzMKe3P5djLMmNuhyF0aXdiR/IwP5PPVXTmMDTRba45UBjy5XhmnJz2LD6rZ0q03hISNZM+OdA7xF3O9wv0ALxIter7S3BqkVHiNuow/gSeWEh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716255; c=relaxed/simple;
	bh=6Wqhms50dYo+mpC/2gnjNhYq7LooLhisZkEyDlyLBSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p4RhbzsJOS+usfD0lIG9hEQalPKu8pbccxZDvSzKJn5EgTL05mtMuqMjtwsJioY8r6mGdjsT3vD60HFnV86+RJeenx2ZKsp1H+cdJKe+HaZE1BIHQ/yUJP7grx7ouiXuyn+06QyX3PNDeobFLL4FwGtnhGjacVXbyBvwXR6t0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D34881595;
	Fri, 17 Oct 2025 08:50:44 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4D73F66E;
	Fri, 17 Oct 2025 08:50:51 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 16:50:43 +0100
Subject: [PATCH] perf arm_spe: Add CPU variants supporting common data
 source packet
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_arm_spe_update_midr_list-v1-1-9de407550354@arm.com>
X-B4-Tracking: v=1; b=H4sIANJl8mgC/x3MUQqDMAwA0KtIvldoi27gVcYItYlbQF1JVATx7
 iv7fD/vBGMVNuibE5R3MfkuFeHWQP6k5c1OqBqij13w4eEK64hJZ7TCuBVKK+MspDiJrW64d23
 OMWVPBPUoyqMc///5uq4fIa8rF28AAAA=
X-Change-ID: 20251017-perf_arm_spe_update_midr_list-b654cc2ac0dd
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
 Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760716251; l=2176;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=6Wqhms50dYo+mpC/2gnjNhYq7LooLhisZkEyDlyLBSo=;
 b=NPVrX0ce/W+YK8PqJr32Ok0ttL+esGUjb+brOzCBnglsKQQAk1a0GOqCQ8l1EJODXLLiFGwrF
 pVNbdFrK5/XD6oxv6Eu5gSiPU4IPxqxuQS8vN6ayViCtHVHyK2HWPhH
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add the following CPU variants to the list for data source decoding:

  - Cortex-A715 [1]
  - Cortex-A78C [2]
  - Cortex-X1 [3]
  - Cortex-X4 [4]
  - Neoverse V3 [5]

[1] https://developer.arm.com/documentation/101590/0103/Statistical-Profiling-Extension-Support/Statistical-Profiling-Extension-data-source-packet
[2] https://developer.arm.com/documentation/102226/0002/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
[3] https://developer.arm.com/documentation/101433/0102/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
[4] https://developer.arm.com/documentation/102484/0003/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet
[5] https://developer.arm.com/documentation/107734/0002/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f507718caadc091714c40bcee073c1d60..47e86699fe3378e44df4dd04a0aab8aa832142cc 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -570,15 +570,20 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 }
 
 static const struct midr_range common_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 	{},
 };
 

---
base-commit: f3b601f900902ab80902c44f820a8985384ac021
change-id: 20251017-perf_arm_spe_update_midr_list-b654cc2ac0dd

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

