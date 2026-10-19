Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4C48BD5B;
	Mon, 19 Oct 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394211; cv=none; b=XsSl7XyZo4Jgw970T4kS6xxlMcV24xcgilPRuOQQejvKhha8YLx2WLuJ0sc2W+I3ic1El3hfsom3oglFTdfVcKowrManc1QVLiD5WlS0bb/8oEun9dnzi8//I35pI9t4WAZ3YPXIrugPGkyvYa8GShLNmgvH9lTviCXbysz+urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394211; c=relaxed/simple;
	bh=g5kpkYSI7dAeqTnAtItc0u8TzNNQBPoRQvSOM0cqfic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MswHyc9LQv+I1l77I6iKSQgh7tiJZ8CQx6ojxtp2HbEUgMoBaF509hDiR6pdqU7NmLZXTu65yb7N24EVc0m028RkIetHeV4sZX4ZPghhK+eyGqxVrYbVPtsw5Pz4Q6zTJXKbLNs4+3cxDoFb9vfyzIxj6nwlHxOKR0o9K1qE9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tgbzran+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tgbzran+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394210; x=1823930210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5kpkYSI7dAeqTnAtItc0u8TzNNQBPoRQvSOM0cqfic=;
  b=Tgbzran+UtF5Hpo8YVFmoJhp7ngC7Wo8V04g4FW89buBRXfG+O1Ea7s/
   vA1mrfavu1D4eQGZP90KWaws5mPDeZ2xzuWdSIkl/aIVX2H9uscYPHVjk
   kO2rWbEca0d/wplOugGTtAvCRD6vIhZ9O/XiBkKkNK77eYXTuFElIdH7n
   ImiVZyx7E5QMwOvBFAYOvdWKdFEOIguAPUuLvtrb+epwntcB9jyu/iXM6
   dfXE3FPQ0XotOwiluuQIy+5qpjaAeJ3BC/Cqi7LE7Lb8KdO8opXOQtrfO
   LDkkhy2U1b0mqtZXR4zLkJ9hMoREzfNsamjQY04Z9cC38Is1Httbg20N3
   Q==;
X-CSE-ConnectionGUID: PSc0u2WbS3mYx03gDfV/tQ==
X-CSE-MsgGUID: WiTWPz7UR+WCL+okIiv2Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1085720"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1085720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:16:50 -0700
X-CSE-ConnectionGUID: SvangAdqQ5G062l8cwyEoQ==
X-CSE-MsgGUID: rcbBnhVfTU6LbC7EO6hp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2807242"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2026 00:16:45 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 3/4] perf/x86/intel/lbr: Reset the cached LBR stack in intel_pmu_lbr_reset()
Date: Mon, 19 Oct 2026 15:08:35 +0800
Message-Id: <20261019070836.2972403-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset the cached LBR stack in addition to the hardware LBR register file
when intel_pmu_lbr_reset() is called. This prevents stale LBR data from
being reused after a context switch or similar transition.

Also adjust intel_pmu_arch_lbr_read_xsave() to update the cached LBR
stack only when new hardware LBR data is present, avoiding overwrite of
stale data with previously captured values.

Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..249db12e927e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	cpuc->lbr_stack.nr = 0;
+
 	if (!x86_pmu.lbr_nr)
 		return;
 
@@ -1012,7 +1014,8 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 	}
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
+		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
 
 void intel_pmu_lbr_read(void)
-- 
2.34.1

