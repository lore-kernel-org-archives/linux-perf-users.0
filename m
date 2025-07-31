Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6622D23AD
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968435; cv=none; b=N9IweU6JjpGlBmGqmDRVZXgF9qoeV32RbWTuwuRSKizneKZTndXCn5Shw7rvjDx8M8WuZRxrJTlHKEMBMG7lIWP9dY9B14yRFFbFJhtb4Vbwc/Zy53i+VKizCpXxrhPOx9ep87ImeoXRv2X7DZzLsvitBIp4gINxv8bbTfVsXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968435; c=relaxed/simple;
	bh=3MVcE/vT4//ABa1xAaLkjoUylPoHOkskTwy+aQM+NKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5fy89vn3i5oPXYkH/bwCnkGBDhskTB9CnC8bxUWrvysebL4NiWhthVK7O3uvD9aQlDZwmuAD5uSI+NooAwgKLvwVGrxHBhYyrgxvMGqy5qYYAvma6dD63Z13V7abxQtqwuTsaJe58HocuiLhDze+VTBSAirLIfZfi7re/p5H/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18AE1D13;
	Thu, 31 Jul 2025 06:27:05 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCBAD3F66E;
	Thu, 31 Jul 2025 06:27:11 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:39 +0100
Subject: [PATCH v4 04/15] perf arm_spe: Correct memory level for remote
 access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-4-58e5677a412b@arm.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=1089;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3MVcE/vT4//ABa1xAaLkjoUylPoHOkskTwy+aQM+NKw=;
 b=KnglJv7V1QHvZsENMJ6hN83WvPKgbX7gC7Az9laS+tl1lqO4aVpu8v1tpkFw6QfT+WcnYlRaJ
 BegLQJCdKzSA4AdMvjWVXmQvbJLTsNVVUuLUZFRLh6YBy9ocTeg5QOg
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
index 8ecf7142dcd8705c13c27e0cbacd69647dc4fd22..3086dad92965af3981b1065f2892a3e67df7b616 100644
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

