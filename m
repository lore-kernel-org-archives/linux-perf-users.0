Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8A28C2A3
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297056; cv=none; b=osoymW9/kA92HY86jyLHmraRbNiZm5xAJRVHAEuCKCrZgC4AyxSEs03hfE646XtVeQKf/HSMJctIJddP7Yro1FrPTzC/3Z+Ltu5QSLCWfm1tgH/4A3sOiG0KwiUlAjYqsu6auYorPvSKXNQtKWTLUPpcr29EqPQvsQ5Ec1NvxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297056; c=relaxed/simple;
	bh=7Xc8Cd/vtq6U2bdRHl/0imVR2eO7Er4gK6Oz07RG5rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwxJ/YCgm1d49IKYTbzf//EWHzEZkIiC2+J2Vx3Gtum2e1whr6YM63ZaiYmb9dpF8cyEiCPDoua0bUcWyyT3r6mAmGS95pFysan1DlOw42UiSIciAVQxWWnhjBHzoW4x/+22Um6aVSp7Ug95HKdLFR2ZOF/j42nWnintGx0vJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D16E1D34;
	Mon, 30 Jun 2025 08:23:59 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EB533F6A8;
	Mon, 30 Jun 2025 08:24:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 30 Jun 2025 16:23:35 +0100
Subject: [PATCH v2 03/13] perf arm_spe: Correct memory level for remote
 access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-3-2e1afab313b9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751297044; l=1089;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7Xc8Cd/vtq6U2bdRHl/0imVR2eO7Er4gK6Oz07RG5rU=;
 b=BDH47d1EZaTLMC+m/Grh5uKFz+V4wUYBeCXutVmYXGrQ0fH6Eu3DSjRCfQzhWB6adI66TGoHF
 2D1oOpTLdvwD+QMWWYpHQ77AcyhOwlqZW9R9S/yveO0KxiKDlbuOPxQ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For remote accesses, the data source packet does not contain information
about the memory level. To avoid misinformation, set the memory level to
NA (Not Available).

Fixes: 4e6430cbb1a9 ("perf arm-spe: Use SPE data source for neoverse cores")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index fdef6f743cf3c76b1dcdd57f5a2c297642fdd21a..182e2c604ea49790a2f5341304ef1cd8217ea6a3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -670,8 +670,8 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	 * socket
 	 */
 	case ARM_SPE_COMMON_DS_REMOTE:
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
 		break;

-- 
2.34.1

