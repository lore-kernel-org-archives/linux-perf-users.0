Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7727FD7A;
	Fri, 16 May 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420168; cv=none; b=TvIyDFMAS7cJUPDreg6ot/+UrkIqn68uC6Bs6BnigBfgATNuIy4SXYOQK7GzFwkLfH52oCdgdhz4WBD2wWisYXtU1d2kceD65jSw5zgDQKdgfV530tzGrfwvwS950GDDzeu7TRhuBVL1W85acwtXu7XxUxwndxiazJVvYeqz1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420168; c=relaxed/simple;
	bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbkEOY/FjbK7vFWp/mU1Sd2PlB+PjL/Wm501sfaDTYNXuH9iBKyavBnk2+3VU9N/BzjcMayzrvQasmcqSTDWD43h/xRz3OHkBoUPnkVH+7jE9IWpUGyIHdh+0q1QZ09Ue3rgOUkzHWOk2iCI+9uHYYMBEj0lis5DGEa7O+0GJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1BcsYkf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1BcsYkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420167; x=1778956167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
  b=W1BcsYkfkbaZcbacrC0tdtgBmw/6YQxzlwbakcZHzP+qwJinLRj+2Iis
   seL8MMdZR7KEaAgCmYM6A2PnLgaqui2YqfrZOvqj4GvJCeNZq8zV71Kts
   rX01Wc3JYTjUNNo3wOKL76TnNzP3HQflnr4/3GDi4gg0F81G/rkjtL1ar
   bYYmKj4UaCfgKwMciJiAsw9DM60G5j2Lkk2aLWy4JnFqzlgrTxQzyN+OT
   qTJdCfqStfbeA0E4331oy+EDL8zKiOFolbXVDr+BxO6ijQbikCQWoQXwM
   8LaPYU2BhvNDRDy+d45w6m5WbrhLnx6rHqEy7hAMRsRGPQwnVfDGBVISu
   Q==;
X-CSE-ConnectionGUID: Vm17cjiERj2wEMAfcp7Qlw==
X-CSE-MsgGUID: Er5nQ4VLSjmX7jqW3+K8Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328858"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:23 -0700
X-CSE-ConnectionGUID: w4qC/1qGTh+TTYBtZ0KYHg==
X-CSE-MsgGUID: iTIbMbSZQxu8WApuVIO/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802614"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:23 -0700
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
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH V3 09/16] perf/apple_m1: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:46 -0700
Message-Id: <20250516182853.2610284-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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

