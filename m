Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC53E9F7B;
	Mon, 24 Aug 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560562; cv=none; b=RmrNyQPcnUPZQfh2dLzZdF9CrIwvE2a660uuQUD0smXHoCU+P/p/426Nb47jWN6UCD7z/dTtN8i03eelVhJPKDaopRvIpOTTZARzCah2Xz2DuF6WubBozGrJDm7ibZWcZHKfCSm2fE0liwDyvwA1FAJjk0z37QUs2VHEvTOtAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560562; c=relaxed/simple;
	bh=rxX2NegBPTl2R7nXU0/jNO259TRYQTcFBmOEJ4sUR+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcMsfgpstw71AWC3lfhBb5yvZ6K0HmGCoNukO0XvmNmzFa5FqI9kPy0T59JTWNpUft3H7QgrrPRWHQMFnB8TOL/W+Vnpqx42EB0NoFX79PHAXp4ICQuJSDsVM8b3VvNWG/BPqtr27c7pN06BfqZ7RYaaKslf76DAFKczttKJLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1cbPiuu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1cbPiuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560561; x=1819096561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxX2NegBPTl2R7nXU0/jNO259TRYQTcFBmOEJ4sUR+o=;
  b=k1cbPiuu2zIQsLS5r7yuOx+rjE+VzQri4Twfgh1jYXVlZP6TIS9v2IPb
   seugemhfFn6AdaIyb3FURmruDIotXcta7DX5ziwphP0bHgOfpwPkjjRIw
   R7M+ze8bENm2ZLYjyNX0bFwQw9Qgg9c2dZS5IhVJws+e7KI4X+0ax4N+v
   6VTFAJzQ81lRkaBggFpn3rMp7WYYHzyV5c3bIbFPNzYl/JM6aSvh67epi
   XGzSKdSxZiD5DnruLPvCW1nIzVe3l7rRTz/tp5Y5JorY+TZK8flSrUhaI
   Ld0leubW8iDvFw/hqWVQsdjpf0eluaAYlYu4SvPYdYlOgwSgET2o+24mf
   w==;
X-CSE-ConnectionGUID: kroGwk7SSPCbeyRF17CtKg==
X-CSE-MsgGUID: 5XTyWBlwR32Nj6Ihyna0fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598933"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:36:00 -0700
X-CSE-ConnectionGUID: SU1ue3LCRUK0D4T1XG301A==
X-CSE-MsgGUID: gH6w5UzESUenEeDywTwYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326744"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:55 -0700
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
Subject: [RESEND Patch v10 21/23] perf/x86/intel: Advertise PERF_PMU_CAP_SIMD_REGS capability
Date: Mon, 24 Aug 2026 16:27:29 +0800
Message-Id: <20260824082731.1013973-22-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set PERF_PMU_CAP_SIMD_REGS once XSAVES-backed extended state beyond XMM
is available for sampling, e.g. YMM, ZMM, OPMASK, eGPRs, or SSP.

Keep backward compatibility unchanged. When only XMM sampling is
available, continue to expose only PERF_PMU_CAP_EXTENDED_REGS. Expose
PERF_PMU_CAP_SIMD_REGS only when additional SIMD/predicate register state
is supported.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 82525f9665a0..54a38c058a95 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6204,7 +6204,27 @@ static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
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
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_CET_USER, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
+
 	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+	if (x86_pmu.ext_regs_mask > XFEATURE_MASK_SSE)
+		dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
-- 
2.34.1

