Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CD280321;
	Tue, 20 May 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765039; cv=none; b=pmGawKMzdSet4uAVFZ/uh6ufKbgpCJzbjF520Ot7hvvjG4/SXHjW8nGM5sqj1qkokslgYwQAsvv+cVOtlJbO19knmgg3SFIds2iB06B1Vi14cYYd8G8YLMgIXKQBeItlZYe59stKUbK+x0ydk/oPWTm2dwAISKccEDjp3Uuw9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765039; c=relaxed/simple;
	bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVn8MrfVD5NdrBYelNQLqkmYw0hiF9vgoVp4c8xbctW9F76P0oGo4Negk5oNHGKn/u+NM9+Q+61m7Uwu6d0NBbI5ejNRTwc0hYB7JytTVJ2I60xPJeK7LGisC9jgYZGboOs7cSZmlsJRGqIR/vfVVVo9FMm4CnO/MsWVnkc7IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcwPwv3F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcwPwv3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765037; x=1779301037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
  b=dcwPwv3FTyrsvlfRDu22nR37+QFAl0LHfKE0+Pp/cqE7Zn6F/2lQdELW
   BfnqKvANvFVE7OPHXGCNADWLPkaYYQBtnY1mKKf1X41O6KpPcxsrfdfg/
   gv14+WRcqYnx+N/LzUV2P+ddkk6WMGxfRCxqjMP8xT9NfqoJZCfDVtL+b
   DJgQZ8Ta01nOKkRAz9RY/JIcAXOh/UL0WttrIaToVoiaYyC6LBqT3yQHK
   hNBoUKYNROTOsF11wE2PP0cLX6aJamNC7YbD9DydqcXgUNN82C0yMi/oj
   61ezFK0E2BRXdbOlKkGRQ2bEzTaCfGnb46xU2iuU8fuC/1+IvxXz47xin
   Q==;
X-CSE-ConnectionGUID: u5b/bcGxTi2bTUHhjRZTMA==
X-CSE-MsgGUID: NWiLMpAhTM61Wd+jpdVRVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847979"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: 0XHfJ6W6QsKLF5JG49WOEA==
X-CSE-MsgGUID: f1vZVfHxS2GsiJjfNH3gKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514709"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
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
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH V4 05/16] perf/x86/zhaoxin: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:33 -0700
Message-Id: <20250520181644.2673067-6-kan.liang@linux.intel.com>
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

