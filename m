Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334830748D;
	Wed, 25 Jun 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813708; cv=none; b=OS59aTmd+nWBpXQcllkTQxMLgAQ0oTwBVz0AG70mOAQddxl/FHsDSs4+FrSY5SJBm3/nlj5JJ1ICW1Ya/esumXdmVZ1p1Ejh3f4IABd4IktEYP/wEQdzsyTvgxoLrN20/YUj2u8UPklLTgc+NFkcJqSDtHDNc36pC1TiDVjeF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813708; c=relaxed/simple;
	bh=g38j/4XIxhvMU4YULtA2oALcpzRtTtzUsypbIXm1jnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMS7ZSvib5W1bP6Tc/xKHa/NuaTSY0ZEnfZnA7oHFzn6z99SS9DsMBGbJT5VB8Afy88mLXx1S/9xGwmWmtYqlxjUQWkpJiwER32JbQSqYC4kVJIWbCTAUHPZqphRUh79i1ITW431RW+lo/Uoygbr8V8zYBIQKkJ+kjYShT/FaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVjLfvLo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVjLfvLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750813707; x=1782349707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g38j/4XIxhvMU4YULtA2oALcpzRtTtzUsypbIXm1jnY=;
  b=gVjLfvLo4TUKc8+eNNu+y9NmxxNXufETaLD13ukh2mlFkKN3sQzD18ka
   wNuU5KDedeIjEKzYI4+uz6eT76Md59nE8/2KuRXag13oHj8yyp5ky3Mm7
   cKMDb5RLLlvWlVk90zHslmrgQo/SfvjFTH+5sm/uTtcegRSyqERcsNNxA
   7fXGm+Wo0cnJKEkxC0t7SfO8zTNLuhUde0rd6ANcFdq6wTFTaMOFnxI5t
   IdF0UCgFUNqmYW1PX2DwSJxfdYDsv41G4Qad6uFDBGQ6ht+L1maqTq/oa
   sZ3xKrDhMT+3Fu/NGtPXoxYEHP3Fo3RVhGx8pWKWN43GeY51Wj8PShRtf
   A==;
X-CSE-ConnectionGUID: 4qMMDlf4SeOE64VhrGxf7g==
X-CSE-MsgGUID: 2v9oBnJgR9S/LD/ZPV2jSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53003633"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="53003633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 18:08:27 -0700
X-CSE-ConnectionGUID: l2DpKkGLQ3qLb8Cvp7iUiw==
X-CSE-MsgGUID: exIVeGLpTDy61zdnj6gJ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156470218"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa003.jf.intel.com with ESMTP; 24 Jun 2025 18:08:23 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH 1/2] perf/x86/intel/cstate: Remove PC3 support from LunarLake
Date: Wed, 25 Jun 2025 09:08:21 +0800
Message-ID: <20250625010822.250826-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LunarLake doesn't support Package C3. Remove the PC3 residency counter
support from LunarLake.

Fixes: 26579860fbd5 ("perf/x86/intel/cstate: Add Lunarlake support")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ec753e39b007..6f5286a99e0c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -70,7 +70,7 @@
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL,LNL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
@@ -522,7 +522,6 @@ static const struct cstate_model lnl_cstates __initconst = {
 				  BIT(PERF_CSTATE_CORE_C7_RES),
 
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
-				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
-- 
2.43.0

