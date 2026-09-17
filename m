Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10D381B07;
	Thu, 17 Sep 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610417; cv=none; b=aU7FBOMHbwk8mXf4p8/YcAcgTqzJfuqDc65Iq32skArUblijO1Kd+0C6W7wjnEeXHcYQ/BC7tT5SdgNGucepkV2nEJbNRlmuwLBJtc8fDKzf+M3wSnvVazchax2rJqlo5ELtEwDV0+cQQwZk3CIi8ZIQhMVAW57Ot7wu3AUi/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610417; c=relaxed/simple;
	bh=Oy0Pa1sWWsF5ORHK2YFdzqrCvtx701+9jyV7tLSnSPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDUggK7mZp30cnF3WGttrEt7kkMAPqgPrVb4Z/ZMW2uzXTR2X8NjeWccaGj5oCzZBuq/R0ZyVdfHULRliPIit/R0sKWjZJmwKaHOH8gQiC5MELXUXYLUX0PtoD7OumqjP/kN9wFbC3VktLA7p0uOULwKnUHW7qmFxmwlq268r9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpU5Pmi0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpU5Pmi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610416; x=1821146416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oy0Pa1sWWsF5ORHK2YFdzqrCvtx701+9jyV7tLSnSPc=;
  b=jpU5Pmi0hK98P1BNPyMgFiTVTiheqrl/nIBLzFKJrPIeaif/3TmC+/Cn
   j9Bdfbec1ncXtgcjXKl3gcO+Q2BpKf0H01uKsYwzYxL1NDFHolUsAbOLk
   ThR9JTl63l+A2BcWMg/8J2lMz+WaY3L7nzBLa9v6f0Jr9hRou3qVmZX6D
   W7T8ozyWZnJkzCyylu0m/k0bwXCHf+7AFtdeIrbJv3pNl/ycUjHXlfb2t
   yf0ZlvK2HTj/zT+qMUglgd6m5ECZHrcCR2k6ZTMcAiLeaM46eStJgpNFB
   oeyKFFoosYh8+N8DdouqlWzK5ejSMLmr9adEkGcmy4DjOTDTh4VxwSkof
   g==;
X-CSE-ConnectionGUID: Q0jUIAynTb+EOP2FnP24DQ==
X-CSE-MsgGUID: JjGJQh3uRYuURm5YskwKOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498622"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498622"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:15 -0700
X-CSE-ConnectionGUID: FK1unsE3RcudFjQvlARgtA==
X-CSE-MsgGUID: CXzZuRNST32VatwrqKqmpw==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:00:06 -0700
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
Subject: [PATCH 09/12] perf/x86/intel: Constrain PantherCove UOPS_DISPATCHED events
Date: Thu, 17 Sep 2026 09:52:31 +0800
Message-Id: <20260917015234.981153-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the latest PantherCove event definitions, the following events are
only supported on PMCs 0-3:
- UOPS_DISPATCHED.INT_EU_ALL (0x1b2)
- UOPS_DISPATCHED.ALU (0x2b2)

Add explicit event constraints for these two events so scheduling does
not place them on unsupported counters.

Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e6efd2a2ada6..9462862bf72a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -506,6 +506,8 @@ static struct event_constraint intel_pnc_event_constraints[] = {
 	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
 
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01b2, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02b2, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0847, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0446, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0846, 0xf),
-- 
2.34.1

