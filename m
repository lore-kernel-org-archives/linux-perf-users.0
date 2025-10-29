Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8F32861D;
	Wed, 29 Oct 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733471; cv=none; b=qO5Xpq0RAKq9Y9Ndw38AMw83GmPIbKuCV3mGxoujrJCn9Hb/XoJwvhaIPj64pLIX2FTliHZw8wx0NHds0Sjp5liofzM+lGukLiBxG7aFhxeGB5cqj+Lbv83L5F4oAqk9ncimwFepr/w40cOTugydvg95T7INN6pZnIOoNBmQq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733471; c=relaxed/simple;
	bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbuexBnCNkOCDvg6kwWJ9upfQ3RHUSumMW29SBOPLY/0Y2m7QBBJItRXFVRpH1oSf0yRQ67U5gXegl5GdHO9u+beK1ng3Y2vSrAa2HPXOyJvX/81ZYaQe5Ka4ei6QQXG3Kja8f+wFaqYMDHhXdbOcryhA9tqMudnL1mKRs/HJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFHIYmX+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFHIYmX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733470; x=1793269470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
  b=aFHIYmX+nQdqSg6ycx9E9i0l5tqGyCRdPfgd6zXwyco5M1R0YjVxbOQl
   j5bqgEp043mSHuwD7pQSG2aghWyO4opeZ8URKSw3LSYwQ9v+Hb+yX6drK
   CZdJp8u1EpB92H2FHQEOb8mih4ErMBwg+hgUTZpgbeCkpeEkdPSLpCx6H
   AwaFIc1CDpBo+cSHFekzYA78+QMCiAUfiuvFC2m6iZtOSr2Y4+cn2gm1b
   U85GQ6Ngra1n8eySlwtixHd3DdLmT2ypkcsdsKAU9v5X0R7hKoJQRbxZQ
   hjzKxrnS+GjsQyu2Ocd27rZahvRGkpbqHH2kdXOvPPkjCfzThdcWU6xMp
   Q==;
X-CSE-ConnectionGUID: ftPVeLjbRBeVE12udlk4fg==
X-CSE-MsgGUID: IFfYSycOTSin2lXHUqqaQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63885953"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63885953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:24:29 -0700
X-CSE-ConnectionGUID: dNskTaukR1uHkFMLYsLlzw==
X-CSE-MsgGUID: X8Pph07YTDmIAOGg7wIpqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963352"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:26 -0700
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
Subject: [Patch v9 03/12] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Wed, 29 Oct 2025 18:21:27 +0800
Message-Id: <20251029102136.61364-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use x86_pmu_drain_pebs static call to replace calling x86_pmu.drain_pebs
function pointer.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..46a000eb0bb3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3269,7 +3269,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		last_period = event->hw.last_period;
 
-- 
2.34.1

