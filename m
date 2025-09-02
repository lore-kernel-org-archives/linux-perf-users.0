Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88E2E06C9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Sep 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795480; cv=none; b=GlD1Ccdy1UfpO1hPCu3+KFvQgHPgyxKHEjHHJH7l+KdMiiFEXZ7dnB8vWm9CdcDb6mSwjS47qCBMajgv9WgN4s1w4h2O+Vm06SYx3VMrY7TYGYKdRksZh7ZhSdfXvaIy5yf6/MlXY/dxwsvvBMV6Tt9XnQbbIXvNebix8lj7IR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795480; c=relaxed/simple;
	bh=Dp5RxvITKAgpeWdpYQjM3UcGbHucAWJaIoeebHX6J3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VdjXW8H3QBdCKtCeq3CIBfQAIf05PMHUWYFEqrAjHQmo5Z7W2EjCd8TG+vNsDVl6jC0b8CeoakpjyZO7Wiuz2EAdM1c96SYHXxfE6UqA2VH+NIW85Ywgdf4eXUSG0E4PzZaT2zUBxquUKa5RX4divauxZtOmPYO2Q5YCSjYe0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Odnl67m8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Odnl67m8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756795479; x=1788331479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dp5RxvITKAgpeWdpYQjM3UcGbHucAWJaIoeebHX6J3k=;
  b=Odnl67m8AcYON3+xAfVmfHvdvhvr9bXjYvUlnZQX3Nxkn7HnTQ+X+D2L
   nfzOA+r4ffLzTMDTkX4OZeT5t+HF16kcYFEdv1FCfWR7DpnrBiXOFXKJP
   SVNrERvSPJCozRyc4L/7YKODgliz46hZ8hNEji5sPT0LL3TN6mTxY8s2R
   Dd8/sbHX0kWTtpWEYjPWJ33c0Ev5JT9uHRzavludea1wQCPsliw+6oaot
   kX709EtLoP+ZpFHkO/1l913OaBdnQeAATg5wfa8fpqqQ44jXTXmdGN99t
   iNf/+TylRRVi66pGLXa4veaPVjPGGZu8cEqfd9mqAWwrrr7MFCHhOmvMO
   w==;
X-CSE-ConnectionGUID: Zg/UDY7JSnOd2fp0o+/MSQ==
X-CSE-MsgGUID: DjmUqvadT2mQhShIPKE0ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59117990"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59117990"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:44:38 -0700
X-CSE-ConnectionGUID: AIPHCmNgSTGgMFLlcPO5Hw==
X-CSE-MsgGUID: TtYVgb6OSkCwdOPucjC+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171637143"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Sep 2025 23:44:36 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	jolsa@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH]  perf tools: Fix regcomp() error detection in SDT probes
Date: Tue,  2 Sep 2025 12:13:06 +0530
Message-Id: <20250902064306.4047749-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regcomp() function returns 0 on success and a non-zero error code
on failure, not negative values. The current code incorrectly checks
for ret < 0, which would miss positive error codes returned by regcomp().

Fix the error checking in sdt_init_op_regex() and arch_sdt_arg_parse_op()
to properly check for non-zero return values using ret != 0, ensuring
all regcomp() failures are correctly detected and handled.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/perf/arch/x86/util/perf_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 12fd93f04802..1e9967a98889 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -156,7 +156,7 @@ static int sdt_init_op_regex(void)
 		return 0;
 
 	ret = regcomp(&sdt_op_regex, SDT_OP_REGEX, REG_EXTENDED);
-	if (ret < 0) {
+	if (ret != 0) {
 		pr_debug4("Regex compilation error.\n");
 		return ret;
 	}
@@ -215,7 +215,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	char prefix[3] = {0};
 
 	ret = sdt_init_op_regex();
-	if (ret < 0)
+	if (ret != 0)
 		return ret;
 
 	/*
-- 
2.34.1

