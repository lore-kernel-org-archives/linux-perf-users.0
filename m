Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326472874FB;
	Tue,  6 May 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550104; cv=none; b=tOCcpb1VGpmwMnQvKAmmMZv7lIFtUabZrYEnAAu6DAg0SxHiDbFYs4RkPAn2gJlka2ms4BeLikRSXfO+u7LHclPtXDkS99fTkQYE/6m7SSmf3HF/a1VVCDs2x9Ek83ZN/vZoTbDehzvA8S5T3Gt493Q3qHefqByOwuiMQ7b+kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550104; c=relaxed/simple;
	bh=B8QsEFV1XiWjwO1syGoIhQQIyeZx4cI+2rXT69sma5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FonG6X2h21iSNy9WRZur78HBH+a1p0UGfkH7q1xhlomtJ4E93+IIa+JqkB33kfrS4jvsPzVuzLiKImnc+CFBjdCTeTIr+hehNAKWhw9/klT2Cwt2paafgcPN85QvBr8KBGfvOG6mywEQJJH8E1qwrUUKHO5LXOfslXcOMRXP0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd0sSzbL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd0sSzbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550102; x=1778086102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B8QsEFV1XiWjwO1syGoIhQQIyeZx4cI+2rXT69sma5A=;
  b=Bd0sSzbLP6rnjuC8HkxCyoSTnh20gj/uiD3hwk8POVWm36Gc5oDsL/c5
   0EcZyWr5PQQgIBCGFN1dAQPa/3iwCgVMCFvNKP3HsGNSSCXqo25i8SMDa
   bmdRgDfmPXH7ZOEz4vytSEXIJOqgeePJRAseDHNyGJmBFeGjGj0xfuy/7
   FHd1YFkVnCvoio6GrSYx0KRDVVG4YVQF3E9nFnrM45G10AJinWVGUMi61
   gVdGiR+p9ZJUOk4LwxvW8zRNoV6lWockUhzYpBmAEJa2mC8WGheo2oJ5D
   VVHuELnyC23toEdgJgoL6CJ6bU0/YqIa/JNGvNFduocSsTJRSObpMzamY
   g==;
X-CSE-ConnectionGUID: MAqiBhLvT6uzHNhdP207Rw==
X-CSE-MsgGUID: EbkXbxFhRe+5nGPE1f0yYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595332"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:22 -0700
X-CSE-ConnectionGUID: ON9dzfoMQ3q3ixbCJ6PDkg==
X-CSE-MsgGUID: WiO49QYWQWayAOM/A83GCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674896"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:21 -0700
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
	"David S . Miller" <davem@davemloft.net>
Subject: [RFC PATCH 13/15] sparc/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:38 -0700
Message-Id: <20250506164740.1317237-14-kan.liang@linux.intel.com>
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
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index f02a283a8e8f..cae4d33002a5 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1668,8 +1668,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		if (!sparc_perf_event_set_period(event, hwc, idx))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			sparc_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	finish_clock = sched_clock();
-- 
2.38.1

