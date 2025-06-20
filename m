Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BA227E93;
	Fri, 20 Jun 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404552; cv=none; b=BDdHa/e1S7/si85ajuY2b5gQK5J65MBil4MOGlIA6KAwnQ/JfmRCPmuBC9/6uMFvNbVFBJT78+zmYlLoy/tbQV4C231URHkP3VcQzYPaJpXKpvC8tn+2p1rFHfP3qIh91qywmnpAhVnSkmTpNL/hBMLVw2IcY0UDFi4QRIOuWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404552; c=relaxed/simple;
	bh=rYWAsQ6FYNS1vD2Z/GSRKI5X/qjhR6LVzd3FnuP33/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3rWkpW/TTcFSfz2754d6e//AlFNfeJFo8j6QygUCYbP/5Tpltxl3n181/f8bDA8gOnkrGeWhFBST/aANbPOUYJAoLS73cMLfOhdbnDxB1o4PuZDR6+JZq5h2TjcwxkScc0XTUjQAWd4whGjZJHIi0/WcSjVMdFUvNzenCJqw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXx5F/SO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXx5F/SO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404550; x=1781940550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYWAsQ6FYNS1vD2Z/GSRKI5X/qjhR6LVzd3FnuP33/0=;
  b=IXx5F/SOUekv+SaVyJ9s0HIt9wo+KVbQ4TGgoYTr/RJJj6tgaEsPl081
   erZm+zD2j8pLF2YlxKtgYmsfhsJmxugBJgt02+SSGLNUYAAUqNxvp9iat
   dOwe0vMib/u5ONSkeSJGKEySVdzuKLYmkZNFLTcjGE64/uAjUQkYK060L
   UgaZ2UWQobqqJaeXzrLEhaYl3GGg2tg388QmqPftlUkbSqH+WyKI/Rtlb
   eArU44U8TgHl9zgnXPo0Ls4AkwqzVKnrFBsGx4zBVHfZN7zFAc+NAqVlO
   wUcz9DNj5qBpWyXG7DQ8WgzgaRGsIrDhUeY/fJ9acXz85gTAe+OF8LZbo
   g==;
X-CSE-ConnectionGUID: awFt9wmjSLusI4dJWSt6RQ==
X-CSE-MsgGUID: 2DhBANo0QuiTmBJZNBFMpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887714"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:10 -0700
X-CSE-ConnectionGUID: 5tBn3PiGQnWY7ite5pHZ8A==
X-CSE-MsgGUID: aKSlF50LQOKqJBrO7T4HlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156650942"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:07 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 01/13] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Fri, 20 Jun 2025 10:38:57 +0000
Message-ID: <20250620103909.1586595-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
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
index 741b229f0718..fb6e5c2251a2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3272,7 +3272,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		last_period = event->hw.last_period;
 
-- 
2.43.0

