Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097A2857C7;
	Tue,  6 May 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550097; cv=none; b=fNuXHYRrVdm6Q4MNJAv+xDbompr5POpDH/i8aCGtJ8wiNiYM5IJIUCdIBcHnTVnVHREM8+YUa2L+ZaH3qHusw/8qQENZ11eZC4/60TrVKr7AxSAdrXOWqFF3HPhOUK2LrmsISC1CiEoD3I6DFQWwAx0jBFKJ9ccZ9YEPKnw8SoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550097; c=relaxed/simple;
	bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9+DY2ubAOqGyWe68MibtuRsFFpot1g5oHGF+UO34ct5lescciw/LQp5umAocMF9taigWAn2Zc0VxlOotnZu2vYsu8RE0MeiPzO0dDzxZeUhooFvoyeX5lDxMVvp8Gf2t/4chdhXrJMWpU0YtC0gT9lbFD550YAjN/xfaQw7iuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F92iWebO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F92iWebO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550096; x=1778086096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
  b=F92iWebO7rrJbzGcROVb3GydGYdOhlyYFBqhffqsKZh4zfgxc6FbpAQS
   48WlSH7N7z5WdBhwPCIlTm3szkwVw4jDfUK9WPMzIMpScyBuZkhbRaYPI
   RgEAJcGiaVUtORCyae1k/bdAQMqoMUmfQuwrhzjY1NqXe24Gn4juzFNaQ
   0SPOzEVwnxvjguJL9EstEaAh92AJsGCL4DVNtRE++wub8BUwj1vfpPH2r
   qBoMey0WPSgDTiC3x36VGh9HQqxfPw9ZCZYArPWwozotQlkJ88TdnL+fD
   pmq2XxgKxu+GjsZICXgbOJmee0ukZyud014y/DUgt6R6kS+9/IzVpKVlI
   g==;
X-CSE-ConnectionGUID: OfBLrJyRQQa29d0wUg9ctQ==
X-CSE-MsgGUID: 1F60uAGaRJOBIoPmcW6kEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595251"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595251"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:15 -0700
X-CSE-ConnectionGUID: nwc2n/8oSXqz7NO9qurilw==
X-CSE-MsgGUID: 4oBJitNqSK6h5o/ebWw9hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674855"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [RFC PATCH 04/15] perf/x86/zhaoxin: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:29 -0700
Message-Id: <20250506164740.1317237-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250506164740.1317237-1-kan.liang@linux.intel.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0cf9a5e..49a5944fac63 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -397,8 +397,7 @@ static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
-- 
2.38.1

