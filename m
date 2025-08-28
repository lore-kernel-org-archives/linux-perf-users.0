Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564EB1FBC94;
	Thu, 28 Aug 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344968; cv=none; b=otQbHz44mKlqUoNc0PzuJzb48XUzWlkmjWWAOA8sCdy0dLhvcL+S6APRWxNQIe8LaOHlg1nVyHZWkOdneub3EZQ5S/ZjbYltyoQkRcBT83OMUHPuq4xspqYWrPWlde+0FOuEfkhMj24OfwybFP/62t7Gx1MnbBpGQ+AiYmS3e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344968; c=relaxed/simple;
	bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtjwiyzCTQbjoMJDAbyYtvaNt0LEtUlb/pIyARa4blWFTU72YGCKXFBmpDG51U/vNH0azUNtendc8pFEsAJhCRZ4eV9GrHF0S+2L2Hs2orxt3esHngSw7MpSiPD4hTvhwNBxeKbzCnJyY6hJUcj/9ies+3JfmnBCnAP1Jlo8AXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfGox03J; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfGox03J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344963; x=1787880963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
  b=QfGox03JCmHItRBH8+72J+hhVvDYVJtelz805dTIuDMyxwXjRDvYb3up
   sTnPLbaWyMI5xXuwKn5+HLpRrD9+mWcuu1MrNP53gm7qZW+d1klDzW3Qx
   n9SEGamoSbD8+yUrQJ82fuYyiuzyR4S/YJ4GCcBt0/RtJuGFwdd5sStJq
   JjnigPE20BZOFmtviIRkXzG3CW9rM6A35MJ1puB5B4Rrg85eufpgy0WLP
   ISKY1UeBGJGskitmHaVyZnyggcPx6rQN2RyYy6J8WcF+n1lgrI9WrpW/s
   ijzaLYsgMElot21FPv3gta6j8Qc1RrdZRudT5VsjXeui6znopMNJd6DRx
   g==;
X-CSE-ConnectionGUID: lpW8QGmRTrGpuH0BTwerXQ==
X-CSE-MsgGUID: NeKmj6kMSHeK1ninnwBH+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240836"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:36:02 -0700
X-CSE-ConnectionGUID: X/S29BblTo6q4AMI74T85g==
X-CSE-MsgGUID: pBkmIVeZTDulsDtJjCtEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372485"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:36:00 -0700
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
Subject: [Patch v7 03/12] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Thu, 28 Aug 2025 09:34:26 +0800
Message-Id: <20250828013435.1528459-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
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

