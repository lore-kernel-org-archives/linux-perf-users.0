Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807026ED29;
	Thu, 23 Oct 2025 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259461; cv=none; b=RteHT0QX2J7BSPZJkCGxHbf/EVlSGrMlS3AFNV/f4UrVFOHchUvdOkEtttbWEuTRWi/6E0KBSlTv8wMx+fkdEQSltiyuIcmznKJekfZz/c8A587DECZyJgwVhmezCnkhj7f+32QNRmOPnD0uBXg4V8b0AgwBpxjeCcNvTTxfsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259461; c=relaxed/simple;
	bh=vTZI1I1+aVm4OJCS6IGIdXNJd01XGd3A7+EqPa7aWYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKaBrMbCY6X/GgKF00zy8loPH7a6VJLNDS0D1QKjASTdKSaJDR+dLkwmiiKeOSj8cp0yP7Gp+uO8oLI6df3FqEEs12D2xGCv2Lo/LmEWQi1ZLhn+PcVtkHHpJ41ywftN3DHmQgRU1iW6im3SdO2YOa3rfIWryZpfVWC36XEKpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqQesAot; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqQesAot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761259460; x=1792795460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTZI1I1+aVm4OJCS6IGIdXNJd01XGd3A7+EqPa7aWYA=;
  b=fqQesAot83eFGgr9E9UlSsEIqHeT+5+taZXrshSnmd16tp5Meb4DbDSf
   S6ir212mbAMJlK1iDo+y/siFesruuUsWHJE96pchQuxaglbAAyjc5hCIk
   2CKd+bJQvpmhc6hqYa5leYzpKQYytYGpoK+rDenNGMj6GYxSEemZtrgX8
   C56Peo8mAXS3L4C5X5McNGSjTFAzjwz+6ssCG9dw5UmLFdEqa/u0Eyd4l
   yHkR/Q/s9D2UBjxfCap/ad+0B/p8CB4pQTvg1VjvBnqsN9Ip/rKqON3qv
   jgu/aYTSYbfWvB4Urvq0kyOTAeLByidoaZJKGaCR+lI4gqy3e+xP1Wur9
   A==;
X-CSE-ConnectionGUID: AOr7cy4AQwiS1lYH0xxh4w==
X-CSE-MsgGUID: zxHvDXXYSPKAwIzNqtQ+1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63333507"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63333507"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:19 -0700
X-CSE-ConnectionGUID: GYPkEpWFSjKkd1azwesSJg==
X-CSE-MsgGUID: rvXpa0ApSb2oC7KvTXc0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183885477"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:18 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>
Subject: [PATCH RESEND 1/3] perf/x86/intel/cstate: Add Clearwater Forest support
Date: Thu, 23 Oct 2025 15:37:51 -0700
Message-ID: <20251023223754.1743928-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023223754.1743928-1-zide.chen@intel.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearwater Forest is based on the Darkmont Atom microarchitecture.
From the perspective of C-state residency profiling, it supports the
same residency counters as Sierra Forest: CC1/CC6, PC2/PC6, and MC6.

Please note that the C1E residency counter can only be read via PMT,
not MSR. Therefore, tools relying on the perf_event framework cannot
access the C1E residency.

Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ec753e39b007..a5f2e0be2337 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -628,6 +628,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&srf_cstates),
 
 	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
 	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),
-- 
2.51.1

