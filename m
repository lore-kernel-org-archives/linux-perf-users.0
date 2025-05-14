Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20428689C;
	Wed, 14 May 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235690; cv=none; b=UNmWTmCzuht3Veixx1Mv3PaAXLNyRPbC0cND7YZrpeN3cM8ACLktGYoxU2cg12aPKdDOudpLpk2ODLtBBoQa81fDeeTqO0qJjrue+koVd1VmbhHW9ZsFOoeDtBq9APm0ybl7nHoMl+fVX/tGMmm+RBgqe8GNqKovHZuS19bU4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235690; c=relaxed/simple;
	bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leICoVuFKNNz66Fqy1A/+qvLhXOyVpDSi13+cqLvz0c9GyrnX4gsvz4puFlcK7hokYYmhfVQyp/mo0AkRtjn0zbbLH0uLomuikCaMxA833jeT7I9YPRIfUqNut1FXOFHlFJr12cyE9cjNHZvIQgDuFju/Wb/o16dH+kJZFp2EY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAhDzjbJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAhDzjbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235689; x=1778771689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
  b=IAhDzjbJlfsKjjqTPw4QRvxLpUzo1x+8WHhQXQBUNis7ZIkwKAEl44CB
   x/NLR0JpDNga+UTVn+6qTDV95MsofGQY8rN9IwLe2Wsl9rNdbRwRlPKt+
   LsiTXtdGTI3MXokg2E60FMFegd+kJgX7MKfCBGqj00JTUndvzp3f0CuEL
   VvGfuRFGXBdcLPziI5Wsg1okl18qkMuQXcUGNSKLIyLnJ0HbdWpL51jOx
   +h2i2bSS7LarD3mqi0tPOkVsAopa5oCiacjJdou3Br69gN63UbddIRo+B
   k3dWadmpamq9BqPGLrDubwQCTGbgOxq/r+XKsjQRtAssRvGoLdSf3fRp2
   w==;
X-CSE-ConnectionGUID: qYIT3d0zTTGYBKQI8zJajQ==
X-CSE-MsgGUID: xrSx1r5eTxqjXAWCd3Pzqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072758"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072758"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:46 -0700
X-CSE-ConnectionGUID: b9U4YqtdR0+x9gn5tnQ9/Q==
X-CSE-MsgGUID: BgFcYL/QQCa57Xepg6UOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939171"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:45 -0700
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
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH V2 08/15] perf/apple_m1: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:54 -0700
Message-Id: <20250514151401.2547932-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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
Cc: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dc..81b6f1a62349 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -474,8 +474,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			m1_pmu_disable_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	cpu_pmu->start(cpu_pmu);
-- 
2.38.1

