Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873137C904;
	Mon,  6 Jul 2026 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303381; cv=none; b=S0WRtnngc1KoTtoaRH0FYOyUEmDrYAETY9i9xwgTOS34+WJEKdGpayHvyFKbFOHuO+miOI2lK8qTe62xqqhKegUv7s2iDelgs+Muw/baOBnnvEj0AnnW5Qvnqzkhut02ykKQjRJvf5u8RGlGxTfEgh6yWprP+HGuiSQ67NZDeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303381; c=relaxed/simple;
	bh=I5WjZalBTU9TuJT0NpzICdnPOJ1JweKWSSeW0gtCheM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ojgumd12SeSCvW7iP1smUjWBM8b9ZrxT4KSHJmDxUmB0cBk57+PPJxxNiOAI/kK+z+5rHhuTena+pWsxWthdL9+h885nOJr1hzChiX27q4CHiw1n5VComnn0/46jQkz6IPgVAOojdtLhKLnhbayy5y0n3izb2gtJ+9ewCDauom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klKIZNxA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klKIZNxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303381; x=1814839381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5WjZalBTU9TuJT0NpzICdnPOJ1JweKWSSeW0gtCheM=;
  b=klKIZNxAHr/66W5n56yOcY2OCKO6o9qFs7gIJmU1WUOiadqOOrYIrGh/
   OqD7fL7B0IwcI9GvabqfC6RCB99PUkKpvsDJ7NKKb1Pz3m+FpgFDzaYwW
   6xlwIw3Zi0pirNGmt0PDVKjUt+7OGdNWnfi+eG/JJAKQH8yqZ6XpQAwl+
   X4ndEATyBRaKc4nkRqtKWM3jQ3ALepX/Z0iHaqgNQSGvcL/eh89+Ecm3a
   ACcGtyn0fDNNszxz4KAlVWT9/uzjrcIL0WzkB0OkcapL/SQ40iqkJTqlB
   0i3uAlmfOaD3A8cXnE+rc7bfdFiarLH6U+IOmUQD198LfkKkmWNyut+23
   g==;
X-CSE-ConnectionGUID: 2vurQXflT0+MqNF+60KSmg==
X-CSE-MsgGUID: VtqinB6eThmLAAtAdGkBlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911792"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911792"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:03:00 -0700
X-CSE-ConnectionGUID: juH4AujwS+WJSOrj3j/1Dg==
X-CSE-MsgGUID: qEz/by8WRjy/tYfi38b/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191507"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:55 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v9 22/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
Date: Mon,  6 Jul 2026 09:54:37 +0800
Message-Id: <20260706015439.3040804-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the PERF_PMU_CAP_SIMD_REGS capability when XSAVES support is
available for extended registers (YMM, ZMM, OPMASK, eGPRs, or SSP).

To simplify the validation logic and maintain consistency, enable
PERF_PMU_CAP_SIMD_REGS capability only when both XSAVES and
architectural PEBS are supported. In environments where PEBS is
unavailable (such as a guest), enable the capability if XSAVES
supports extended register states beyond basic XMM.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 15962a3457ee..56997731dc83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6303,14 +6303,37 @@ static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 	 */
 	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 
+	if (boot_cpu_has(X86_FEATURE_AVX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_YMM;
+	if (boot_cpu_has(X86_FEATURE_APX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_APX;
+	if (boot_cpu_has(X86_FEATURE_AVX512F)) {
+		if (cpu_has_xfeatures(XFEATURE_MASK_OPMASK, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_OPMASK;
+		if (cpu_has_xfeatures(XFEATURE_MASK_ZMM_Hi256, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_ZMM_Hi256;
+		if (cpu_has_xfeatures(XFEATURE_MASK_Hi16_ZMM, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_Hi16_ZMM;
+	}
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
+
 	/* PEBS supported case */
-	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
-	    (x86_pmu.intel_cap.pebs_format >= 4 && x86_pmu.intel_cap.pebs_baseline))
+	if (x86_pmu.intel_cap.pebs_format >= 4 && x86_pmu.intel_cap.pebs_baseline)
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+	if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_EXT)) {
+		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS |
+					  PERF_PMU_CAP_SIMD_REGS;
+	}
 
 	/* PEBS unsupported case (e.g., guest) */
-	if (!x86_pmu.intel_cap.pebs_format)
+	if (!x86_pmu.intel_cap.pebs_format) {
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+		if (x86_pmu.ext_regs_mask > XFEATURE_MASK_SSE)
+			dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
+	}
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
-- 
2.34.1

