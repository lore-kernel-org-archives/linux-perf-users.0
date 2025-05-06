Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93A286D5A;
	Tue,  6 May 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550102; cv=none; b=VDr8xWq25vavXl7c8JarQHxg6qxZWwszO/rfeb9jKoNWTxjTkvOyuUPTQp25r1gqFV2zPzz4sCPjyLFpt+Z6SXZlSBm6fzG7WkI9Pa8PdnZjLmbMlZV/6ukNCvytEp2/Sb43Sks9/fV+iv0mJYNK/jhdN5LfiX4jPTfiM4Y8p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550102; c=relaxed/simple;
	bh=0mKYVrYQyC2W8elMimVQZxsUfveK3GJxU+vrnQYmQLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJxMb0TY8pTL2I5HggZMRlr2U/PdJ5gHrfn6lZL97Tl3IKdhe5HaSpmnVPkRhfbkBGturvMdBxKU386iOmX4Ie2tQwRRXVCbBXcFFb5LLjfZ1kgLcj90qrpjTnnC+IjzX/j6myCBTDFxWtwfq0f4mtrejY8UjTePa6n/lNN6GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtQYD7KW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtQYD7KW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550100; x=1778086100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mKYVrYQyC2W8elMimVQZxsUfveK3GJxU+vrnQYmQLQ=;
  b=JtQYD7KW7cavEt9sU/Vwzcbf2KDGXGV9iuEfAw4UFxzUPrA39tlAeTd1
   cpOeJfHUCkwOSeCiwLEAoY0QWlujN5CCx84BIZHorTGqpZSvWdXJP99Ys
   ZDvdmiTmITIKWPRpkTDaG1FH+Lsx5qcxgUq64Lt6qlZcbyeDBpbZGVuA7
   1EVAxuRNs7+QKa4S7l2aCFIuukPHFGk0TVcPiMZY/8xGuAt0mcQxEDa52
   WrzYrzMyJHyOQGN+nXXHNo/HO7V3XJBttD/DERgaH6VvuhI9AwRJV1XLf
   rIW5XpC/d4ce6hWPafssC8K5DLbJoUTQGTn3HbaYWUcYJyzCjYTdmlOoj
   Q==;
X-CSE-ConnectionGUID: 49i1oNL1QHGFkIfEkx3Ymw==
X-CSE-MsgGUID: ic/Cy9WXRGqq/WxpI9WDHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595307"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595307"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:20 -0700
X-CSE-ConnectionGUID: ZCUbzolUTCacK7kXTNKhsw==
X-CSE-MsgGUID: OzRrGi+rRiGr5rEoFMTNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674885"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:18 -0700
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
	Vineet Gupta <vgupta@ikernel.org>
Subject: [RFC PATCH 10/15] arc/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:35 -0700
Message-Id: <20250506164740.1317237-11-kan.liang@linux.intel.com>
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
Cc: Vineet Gupta <vgupta@ikernel.org>
---
 arch/arc/kernel/perf_event.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 6e5a651cd75c..ed6d4f0cd621 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -599,10 +599,8 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 
 		arc_perf_event_update(event, &event->hw, event->hw.idx);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (arc_pmu_event_set_period(event)) {
-			if (perf_event_overflow(event, &data, regs))
-				arc_pmu_stop(event, 0);
-		}
+		if (arc_pmu_event_set_period(event))
+			perf_event_overflow(event, &data, regs);
 
 		active_ints &= ~BIT(idx);
 	} while (active_ints);
-- 
2.38.1

