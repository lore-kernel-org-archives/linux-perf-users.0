Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03487285412;
	Tue, 20 May 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765042; cv=none; b=u4zKEGCPG4ARj1vRlB4RHJkcCXwXGwvwiKRKB69B/YUZ1JQQrDvqJ9I9Z3JIaHrSF5zjUvaTz7WmR/VnbAmiglFj0r4DG0CDZyB72CrFuNF8bXePpkFSkEkyrt4ErCW9WZyYJ9ydqVfiiZHAACkj69nyoyr+c0cM73d0S9fr08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765042; c=relaxed/simple;
	bh=rrfPQWQxUpl+1TbJT7SuB/unJ120m8U+rV6GjI5dzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdYn2gsPdIgS3+VAnBG6iHIJGN3Taz1+eOns4qOxXKvmmJzbEvphoSIydH06PbxRXazb5iN4+fXn2man/K5L3rmrIbWvYyQZ2m16HIhSRKRZ9Roc2jmhVPxfaqb1rKVGKPIdI4U2iVbN9sVHlTNoDHpKanfkhrcE/DqXzErEa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH35E+Zt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH35E+Zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765041; x=1779301041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrfPQWQxUpl+1TbJT7SuB/unJ120m8U+rV6GjI5dzKk=;
  b=ZH35E+Zt23/1HV2TA6TpierBNxActOiuaH4u+zK4/BH4yqSFVpHHRagr
   Ufbi2znWpWd+Ix4s+9IIoTU7e2aCWj1WbyL8wZXb8dDdeJwxufMy5iv8B
   98v1e++6VWAIvEwylljMxzEjznABnZIHgtWmB5VSXC5ysPfvD5VP38EoM
   iYXRYH+PD/211dew7ZaGuxQZwa3osNMu3mAaixtOYLLLG2dIh4Bg6fzdc
   eAiSlQNmhtZ1ebkZe0eN6T3NpmiJRGebDeEkIlgzgLC/YG/y4ARvsTLeX
   0452BxLirUKv24rEFztE02Ypq2ZVFQFsvxjS8u04Ue0XuTv/7O2Kr/RbJ
   Q==;
X-CSE-ConnectionGUID: olNzmwJPTj6N5vzuvz1d/Q==
X-CSE-MsgGUID: WxBKMJsVTTW7QWigf35iGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848034"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848034"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: HPiXoGeHQsGm9bdl/h2sWw==
X-CSE-MsgGUID: 32SONy88R0i1xY+3Fd5/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514720"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:13 -0700
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
	Guo Ren <guoren@kernel.org>,
	Mao Han <han_mao@c-sky.com>,
	Guo Ren <ren_guo@c-sky.com>,
	linux-csky@vger.kernel.org
Subject: [PATCH V4 12/16] csky/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:40 -0700
Message-Id: <20250520181644.2673067-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
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

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f18420ce64..e0a36acd265b 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1139,8 +1139,7 @@ static irqreturn_t csky_pmu_handle_irq(int irq_num, void *dev)
 		perf_sample_data_init(&data, 0, hwc->last_period);
 		csky_pmu_event_set_period(event);
 
-		if (perf_event_overflow(event, &data, regs))
-			csky_pmu_stop_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	csky_pmu_enable(&csky_pmu.pmu);
-- 
2.38.1

