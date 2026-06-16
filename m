Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3163CD8B9;
	Tue, 16 Jun 2026 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585559; cv=none; b=Y3A+UergQPS98aMS5Y3NDyfsN4AGyAol4I3qlGCguRzSFB6d9MhmuVmBv4fImp9JpuZaDbEJmV45JIz+Y3z9/ICUhgYsxiaPvpw4wmwwakx6/3dPdZo3uJvWY+1SpCq3bXlwH59TOLA0LOdlQvyuafxz79k4JMDxbSVD6/4oJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585559; c=relaxed/simple;
	bh=TgcV4h+TDwdSYWgyL6ihk3QjrMclAphRz9ZqbKtA7G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXrDij7Eq0bEu8eFSuV3qyvWr/Hm113ak7DUByxFFVRnBrI7ZK3JkO1R3OpfCaqBLvKMUu0l9xxaKU0wSzmA80Unfa8J+LC0ZxdJTvzjRBo7sUnZdyyLo4+YtnfppUQ5wOChw1KTX8N5fo5Zv24xz2gHektBsYpwU4hTq+hkH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcovCP5J; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcovCP5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585558; x=1813121558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TgcV4h+TDwdSYWgyL6ihk3QjrMclAphRz9ZqbKtA7G0=;
  b=mcovCP5J1q2ywjjyBUb+ChGs6j3PcQbbyjJTO2PKN7IULj50UD+ezSSj
   qHX1HDEDquLT5bJnLeZi0jWFWcoCGOV2Tq1zOF+qamxVrKYNXci2fp6Gh
   DQ85j3Ia01qDI3Hksgy7x8ZmnY837E/Qc5j2ono9pDkc9lyQFOMKN4UAH
   GkFiOScwylndmQsF54Vr7M9KBMkmygnoRHw0Z+kTPBexo3jMTIUvoN1Kn
   +vtfSsHn3smgPDhIfdF5rXqYLnS1bXNil32/IYbPPPOqxBssEJpUtkxPy
   bmFN+AqB9jQVOf2bzf5fpQ0cs6pBDy/sJTQXSFIsh/MQfUxNOPX0AQvX7
   g==;
X-CSE-ConnectionGUID: Ru5RFJdhReCjjMnSKAaAXQ==
X-CSE-MsgGUID: bNHT5NhbSaWrZ3WF6/RthQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445401"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445401"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:38 -0700
X-CSE-ConnectionGUID: 7Idsm93GRtar7FQ+ox9oTw==
X-CSE-MsgGUID: 8ILmNeOfQ0eTbPcctutsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726319"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:33 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 3/8] perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
Date: Tue, 16 Jun 2026 12:46:49 +0800
Message-Id: <20260616044654.3468742-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_lbr_filter() currently assumes arch-LBR provides hardware
branch-type decoding and skips software decoding on that path.

However, arch-LBR may not always expose branch-type information. In
that case, treating entries as hardware-decoded can misclassify sampled
branches (for example, defaulting to JCC), which breaks branch-type
filtering results.

Fix this by using software branch-type decoding when hardware
branch-type decoding is unavailable (that is, when x86_lbr_type is not
enabled). This keeps branch classification and filtering behavior
correct across arch-LBR configurations.

Since x86_lbr_type is only set to true when arch-LBR is supported,
it's unnecessary to check if the CPU has the arch-LBR feature.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..e2657f791e50 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		 * Doesn't support OTHER_BRANCH decoding for now.
 		 * OTHER_BRANCH branch type still rely on software decoding.
 		 */
-		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+		if (static_branch_likely(&x86_lbr_type) &&
 		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
-- 
2.34.1

