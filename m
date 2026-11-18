Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972283;
	b=bKxJKxFne83p1PM41D8rKGeprBuNp2uE5eOCYHR8XIrwiWzxm+pGViGQ4i6APf0jjvRW
	 VM6uy6757ykJOyBBACXjEph3BBkvKkzXhQb1C44SmaCvbCcssHpGPZ9/I89zT3BPhzjGM
	 nMWUH8Us4KA4iWGxTcFOpAydSSPtsoui9eeT2Y+zmXSj3J1+OrMftb0hI3vrPLPsnqNAN
	 kC8K+MvhB8p2B2o8uHMvFIOr8jrHmS74tlkyUk2qOklaL8X7TkUHokxCYf+CXMzOIQPP9
	 ccb9gdDL4+VRZ2jeWZBQ1ipDb4ff4UNBGWFSFXCNi50ONX2ONrcE1Zl9VBXIB+xmV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972283;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rAUAXOcU6+Prm2JvcPZ/ODIqquGi1OM+kWs7VyD5IU4=;
	b=zoS0vPjHNQ0n3zYmoHfljzOwCoFXMN1iabm3hewHwcoCmagICriXTlhPjBsDtlHXPipD
	 DnhYiCC9yoxHZYQps972JB+IktEhA77to8MB37qr17oP90trENp7rQHl90wv1dH3/8db7
	 cjAYAcqz4MHW7gkQAEBZTkLzX7jlQXbMWkR0dch8+q+6/eUVeono2x7q6cEw9cMQWp5R/
	 AF5KGia8cyGHOnu8lUg/P02WNgWhDgY7JWXTz4paQKulgwpqw0ygkYlhKRWGVC+UJZe4e
	 mMyMDN6DS/GIj0+MMZq/lq4iH1FHpJz6bS16Ht1vN2xdv5CZGPa9OreOEPwmfJ9rm2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BeGMoYC5;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA33606A8A6;
	Wed, 18 Nov 2026 03:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA33606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BeGMoYC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972283; x=1826508283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YDl84zl28gaxmAiCJSGxYZF0/CVDkgZbO5ihfBzmIeU=;
  b=BeGMoYC5h8IBOk9bv02aqWVJaTiN8h3t9R0WhHZKzby6dL8mcpPgeoay
   KcyrzurQEv4gCTWQ5lwwVq0qqZ+AYs/rBl6V+BeqAEPxbB+AEgOEgaTPI
   ia8bRw88qwUViTEsVKVE3ZHW3RONc+0YkyFzBD4NcSiH3t1SdDgomWtSf
   OZ84q76OvaF/u26ROgY1hm85sX4yNtXNST7dA5+O3O0gX77tfzviBtskD
   bNddMh1yC4a0yvjNFohjEPgkUJpknVQ9wiRoWHFh6HSeR1A18Y4Ethidg
   LmvnKeZ+GtRIsRshXtzTPc5z5caR3n8KtVegxvT6U5940andGeUp3IklZ
   A==;
X-CSE-ConnectionGUID: puarUi9/TU6Sp1gInu7BOg==
X-CSE-MsgGUID: B6jm7IopQTOisNsBA+wU0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630100"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3630100"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:43 -0800
X-CSE-ConnectionGUID: xyBkXW03Q+qVes2AKU7vTw==
X-CSE-MsgGUID: SPAPZzuFSxOHmbxEkLOJXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894448"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:38 -0800
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
Subject: [Patch v7 24/24] perf/x86/intel: Fix incorrect PERF_METRICS overflow bit clearing
Date: Wed, 18 Nov 2026 11:14:53 +0800
Message-Id: <20261118031453.1353625-25-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow status bit for PERF_METRICS is cleared incorrectly in
handle_pmi_common(). The code clears the raw bit index value instead of
the corresponding BIT_ULL(...) mask, which leaves the overflow flag in
an incorrect state.

Define GLOBAL_STATUS_PERF_METRICS_OVF as the proper bit mask and use it
when clearing the PERF_METRICS overflow bit in handle_pmi_common().

Fixes: a5f5e1238f4f ("perf/x86/intel: Don't clear perf metrics overflow bit unconditionally")
Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 4 ++--
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b4632b791e26..d7284eb73227 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3972,7 +3972,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 */
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
-			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
 	}
 
 	/*
@@ -3987,7 +3987,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
-			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
 	}
 
 	/*
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5c92d43bbef8..63e1d1bcd01a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -452,6 +452,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
 #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
+#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
-- 
2.34.1

