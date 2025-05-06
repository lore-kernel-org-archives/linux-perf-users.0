Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E10286D6B;
	Tue,  6 May 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550102; cv=none; b=DoZ5Zs/41KwSyiN0QvZc5jrtLPRB554A1FTqoyllQq7hLsrCxER6ZMb2jDXNYKSCrIpjWcJSxIBVBnqHwgFNBQJ3kMDzgGGhBB1WU95zKqkfOhcK6NVRLrI0eiVprN2LZeE2JSX0srF+tZfRdqGkY01sy+PIh51fGS+KdNh8uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550102; c=relaxed/simple;
	bh=V6nXz/yCtJ1VxaLqKn5i3FS20UppU9XH8lr/vOeoYWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVybmS2bv7l5eBA6cjYIHPreqtmPd++3BCfmklo7v4KeqbCkzUbE6xYpLedIwnS5O6IEeF8np3owY9sY4V78DHVrkydj6UIMjNFJno69W2ER3hYTjXKYMPSqkr9vdZVkbaZmaG2G+Z4datq5aI+EJs1xQfRhJ7py/Lwhmr0tVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDU+yITE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDU+yITE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550101; x=1778086101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6nXz/yCtJ1VxaLqKn5i3FS20UppU9XH8lr/vOeoYWM=;
  b=QDU+yITEnpa+XiGj7SahE+Ipa5CgmppSFPEhB4CsLox1aas9ZxMD0b85
   wX3Z7ImbrIBnITAQnc1lI+rXaf4ID92wRYoLxcT9sdmPD95rC3UoLVZsN
   2Npk+SNXF+NQCrdbiBmatcZzRgzcvEny5fpPXEBx7TEl+tp8rqQX6VCjQ
   KRJ+IUHUPRUIad/7i3dvQVl1SM/kZ9058seu20n/l9o7GAdvO6TUARmS0
   errf/qBXoygJejtwDoFqT9rsubHRBGB0ax/3fQQMJUQxUQVEOoqRCH55p
   9ZxIRvm5WjYoODtqTdHrydYHck3mdlUQj6vGKHSrmy93rfmxY7Rol1Czl
   w==;
X-CSE-ConnectionGUID: vs5TI4J6T5O5VoWxZt1/1g==
X-CSE-MsgGUID: dU67HPt/SqOfJ78+AhQQ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595315"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595315"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:20 -0700
X-CSE-ConnectionGUID: 17+2+htoRuGk3kDJ2su+dA==
X-CSE-MsgGUID: uJn8WK7cQ/KRfwKa1IlySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674890"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:20 -0700
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
	Mao Han <han_mao@c-sky.com>,
	Guo Ren <ren_guo@c-sky.com>
Subject: [RFC PATCH 11/15] csky/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:36 -0700
Message-Id: <20250506164740.1317237-12-kan.liang@linux.intel.com>
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
Cc: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <ren_guo@c-sky.com>
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

