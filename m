Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7D3803CB;
	Fri, 15 May 2026 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825836; cv=none; b=GcNbLBuV/fhDEQw/GRr3ndxC1p3RmLan758soQmkBFfsxPvCoKPJ3hm+/PCwWcPFu6EgnaQZEATccbFjGFxT++ijjXRgk0yI62EXKCHFIVML9RCd577xiWsArRZCMB8CJ0ywrtYcJq87DtvalrV3RE8TVUFE6NRn9oF3ozJNBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825836; c=relaxed/simple;
	bh=814Xmi8CwxH/iVFJhfAQgbbXv0ErzpiDU9LXkDfN+Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/OW6x/0n6qVv8dzR4sMZJSBJ9NOOjciXFatKJeDMOku6LFfivV1hiIsowvwo4I78oRyTeflkZKDzjffVnX/3EYtVT5lw6EZ39UcTnYxzqm7OxyhQ/XRTGQTSZJeemO0UIAcK5c0lsMh+0CkKGnAdzmIGjzO1Dq7rPtqmlKhOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/OflkUg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/OflkUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825836; x=1810361836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=814Xmi8CwxH/iVFJhfAQgbbXv0ErzpiDU9LXkDfN+Sw=;
  b=g/OflkUgLklQITpihxHL0aKNWNy5iOA3a9842wkvBflvf/p4O7m/f3Gq
   LaAcp0f0Cm7/YADuanNjBK1jd4wXFh6Ry9HfA4T4Jpvc55+D9fEdAK2hd
   R1Ukg1fWDXkAHhNFmOfh1jLjZjIBrkzxFKhxCmGBMw3Pi7L4PV9byi2+V
   5RD0YnapOmeh2FDEfcLKzYAi1gxYFp329zvycoI/1fooEHh210spZ7JCc
   SZUjC/c+1tLHHm53eIlRfPgmu8mBz0t4OrOCqwfDDE0673GF3nm/Lc0rR
   Knpp/tCvhGiNre/ZtlolBmWWZ0dxhuWHWRBr4AtmFx4flo+ZNdMBNCbBd
   g==;
X-CSE-ConnectionGUID: q6xWZXprSiejiI3+imX5OQ==
X-CSE-MsgGUID: zAmgUbXDQYufo8xT9n5+eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635962"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635962"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:16 -0700
X-CSE-ConnectionGUID: ZCGXSObSQ0yyjuHiRQxhaA==
X-CSE-MsgGUID: r8jjv5fhRaiasTz9gDNK9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968496"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:17:12 -0700
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
Subject: [PATCH 10/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for SRF
Date: Fri, 15 May 2026 14:11:42 +0800
Message-Id: <20260515061143.338553-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update perf hard-coded event constraints and cache_extra_regs[] for
Sierra Forest according to the latest SRF perfmon events (V1.17).

SRF has same uarch (crestmont) as MTL E-core and shares same perf
events, so directly apply the crestmont perf events.

SRF perfmon events:
https://github.com/intel/perfmon/blob/main/SRF/events/sierraforest_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 587167dbb98f..e1c6fb127f10 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8101,8 +8101,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_ATOM_CRESTMONT:
 	case INTEL_ATOM_CRESTMONT_X:
-		intel_pmu_init_grt(NULL);
-		x86_pmu.extra_regs = intel_cmt_extra_regs;
+		intel_pmu_init_cmt(NULL);
 		intel_pmu_pebs_data_source_cmt();
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
-- 
2.34.1

