Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF428A1CD;
	Wed, 14 May 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235695; cv=none; b=JgL423EMPGrLiAtNBSfsiPAWvVQ8cZYqRIU0lxktoL1MMMkQLTUTDMUEy7zi/Zc3h8qjLt2YVHx+4A8ZE8pBNVdJnAPt58MeL4I+3MnDpY7H7cgONnJqZeKt+2zWP6T/NU/ZQJOGY3g05LCH5o1zgIGsXjj+tD9o+gd6jEQnHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235695; c=relaxed/simple;
	bh=ZWv03XD/Q1kgk/HFJzz+qCMhdC25MzBMQsMSIBLWzs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY+Ri9I6INunPrJVcLQ8wNEmcpzZANn8usxlEYk51XIVzf2QjmiXEHhDqGETVqNoqB749wysOGsH/J2iP6bJeFmRNgjXDj/v8x24xP1VnsxHrCzhZ7Su5Abr7MvVwIsmjMsTJXXhT3A5H+/wCbMXK8p4+5Oq9qJhEham1No88Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixl1aWjY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixl1aWjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235693; x=1778771693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWv03XD/Q1kgk/HFJzz+qCMhdC25MzBMQsMSIBLWzs0=;
  b=ixl1aWjYh9wCzgA6TI4NzHCZIK78ZANauQz/beLEV52ODNx8rnfBRndC
   bDfuCevJHYfYtRvHNQqI2eK8y5yxTMBbDI4XoAf3AdTEErVSBSC0Kb9uc
   23V0dJMq3zDo+kuSbqg2RiwdOjqL9vcf6VzQ8C7O6bqNCibqLRljE0Tt/
   EEQ92992UsOa4+lzMx3YuORgsFFJ6FdvrKv3MYcFd2DXvkHiOXXwFsQ8R
   f/TmJXvts822ILaXZVYoNheNx+2ItnNKaDSm+Niv4XqwxeoYWlRoxKkW8
   xyaQrNZfJphnSfK/qwXXaqCxxcD2yNobmAdjL1EGBLygh7qVo2Gh7wWKA
   A==;
X-CSE-ConnectionGUID: dZpSFbBASKWyCrRuLWS3aw==
X-CSE-MsgGUID: R8I+6cTSSkyttApBR8kqRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072807"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072807"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:48 -0700
X-CSE-ConnectionGUID: awuxL/G3Q2eVgn4/8N2g5Q==
X-CSE-MsgGUID: 3KgVMnuPQqyDjnFdQTxxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939179"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:48 -0700
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
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH V2 14/15] xtensa/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:14:00 -0700
Message-Id: <20250514151401.2547932-15-kan.liang@linux.intel.com>
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

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---

Changes since V1:
- Add Reviewed-by from Max

 arch/xtensa/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index 183618090d05..223f1d452310 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -388,8 +388,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id)
 			struct pt_regs *regs = get_irq_regs();
 
 			perf_sample_data_init(&data, 0, last_period);
-			if (perf_event_overflow(event, &data, regs))
-				xtensa_pmu_stop(event, 0);
+			perf_event_overflow(event, &data, regs);
 		}
 
 		rc = IRQ_HANDLED;
-- 
2.38.1

