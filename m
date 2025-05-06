Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E322857E1;
	Tue,  6 May 2025 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550097; cv=none; b=HzBt6KVuJme/CRQDiq7gUdGji/ALvyAcVlvzjpeqbHOiR8ugdQZNt/TAFh4znkfN4bMhNc9fhipQaKSCAonEXXEORD9tUKFkdAk2qb5udVpqxGWICG/cGmmJqSa5QOJsWAKR5Ucjqvz6U81hhchKyCsviJOrugdSpHZ7A+/U1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550097; c=relaxed/simple;
	bh=HSdv283f+P99zUV0yE0dYL7wNhVhUAdWxElvJ/afTp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naENiVNXaSx231N8zRD+plswm0ES6w3aBSJ/FQ60kSmW6j+FMtmnuk5vficfxkBOWTwxc13qCKB0+rOXTqXtFSHO4jvbblnmtg/JHYbQSzguyxi6GVGtWr1vFdzlguYdsCBnasUv5p13zE3oKoZSsUf3a8uyFaqzcYbxecKIOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h77u3Pxu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h77u3Pxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550096; x=1778086096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSdv283f+P99zUV0yE0dYL7wNhVhUAdWxElvJ/afTp0=;
  b=h77u3Pxu01OldGYcOoWXtwseVIjmPawE5YXqvw0iI4+S3SgzOxcFTW1Z
   YIcPo2aDoyPT0rSAzYlkOwVndiAG0yCg/88z5w5PGRu93zFmOa5+l6Thf
   2kjCyoW7xOD5/zMI1F1w06W8tOkTMNxn6zXH8saUWBPffhSBt+uavKkQR
   YD4Df0ibf+3SgwuAub9qeevX2BIzf0Oa1qrn2nZWP0IZhULtsmtzdNgyJ
   iktql4wZymCb9DJcmIA4/xSnGIPLPnbIqcSc6yij5rH3Fl51ybUgNK6Ph
   ilIddNty8fXcVDooIALgci9lCY9SFX6xZSvqbb4D4sNzcuYXyc5ZGogyl
   A==;
X-CSE-ConnectionGUID: 4xQGsFnnTqOhInleiPpwCw==
X-CSE-MsgGUID: bbChFpHsRwizp82+an2lNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595274"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:16 -0700
X-CSE-ConnectionGUID: kYvKpvcdQwaiD2Yl5RvFXQ==
X-CSE-MsgGUID: pDpv7dLlQWSnDJilYdxbwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674866"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:15 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH 06/15] s390/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:31 -0700
Message-Id: <20250506164740.1317237-7-kan.liang@linux.intel.com>
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 --
 arch/s390/kernel/perf_cpum_sf.c | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index e657fad7e376..6a262e198e35 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
-	if (overflow)
-		event->pmu->stop(event, 0);
 
 	perf_event_update_userpage(event);
 	return overflow;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index ad22799d8a7d..91469401f2c9 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
 	overflow = 0;
 	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
-	if (perf_event_overflow(event, &data, &regs)) {
-		overflow = 1;
-		event->pmu->stop(event, 0);
-	}
+	overflow = perf_event_overflow(event, &data, &regs);
 	perf_event_update_userpage(event);
 out:
 	return overflow;
-- 
2.38.1

