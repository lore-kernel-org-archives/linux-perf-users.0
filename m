Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D32E7F07;
	Thu, 21 Aug 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748766; cv=none; b=jL4XcOENNSEm5DV44uPwBffv+fLJiKVyPpsd96mU+w0vN38RQVMeKHvzmVA2xxILe4xOqdmwv86WNgu8XSEH2Bx+IpnhOF42/ExYZZcBj2hi9Xe0vX+ASLaKhIWBF/clDS4rj04sJ8H826BMVoINhx8qlzuZqwXxbNf0C3ZdnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748766; c=relaxed/simple;
	bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heb4T6evFptrRxIYQqPZl2aaLo7F1wfeoRQ5PsAEMq2EWWe1srbEk3gP/DHrciGBIjKbClHTYLSOfv3wEdb0Eb7kK7BNDxQHweBk+I42EyHEX+PRJt8riF/giUq0S3TAwd8KJ6ldQPQFbqWphOvnd3H4MkiLV2IQIuL2hdwDnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3Z+R+li; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3Z+R+li"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748765; x=1787284765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZglxdEiMhwZbOJ7YeIwThviIiLv7/83iyeKDAIzrU7s=;
  b=N3Z+R+ligi9GhzAjFDOCZ31YMP9XhyVT2Y5MN9jvWsQBlvJGMeAVfiUK
   lqdLgFFkU1uMAepY8tDa8yHZmApgD8Up9bjCZtzVI/S/IaRDP7a9cvUzs
   Hu2jmRxwdvjX5LXqhp2fltGzz9bweK7oQJ4qx2TuXYJcTyF16sH0Uwqbd
   N59g8Cp3H3mqh0Z1JUpa8J4jWjGE8JPBds1z1T3FpY+zeftEFmCjtx1JM
   i1n09unikxijAmrBr0XcMoKx6TCnJ0zwEU88gYKL4UhA2sqNZK0Kfy3Vg
   4VJuD+DNdszE6oxk5jqpm6ATA+PDgRyjEVFLcq6XrwSNAbDa0DChrKZjx
   Q==;
X-CSE-ConnectionGUID: qkzwDknBS8Ktq+smiemwUA==
X-CSE-MsgGUID: DVIT80G6TSWU4JbNcGYkjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68731948"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68731948"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:25 -0700
X-CSE-ConnectionGUID: JcB/WuObT26Nf9uecTX2/A==
X-CSE-MsgGUID: fNS//ilGQkesM9lgRqIQSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168713001"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:21 -0700
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
Subject: [Patch v6 01/10] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Thu, 21 Aug 2025 11:57:56 +0800
Message-Id: <20250821035805.159494-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
References: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
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

