Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C32853FC;
	Tue, 20 May 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765042; cv=none; b=bouIAQdTl5655/rLh6KIxWE6sAuS/HocQ9effgQMoJ2DeJIsq9GQa5iw/IGgIVEKiGltoTj9UBuL2KzvqNJOfJgbdFAo8wYl0fi+A4ivqX9ycb5fFptWYibLQOth1ivgCxexae+vO9p5xdxShivmMF96F1NLYD4weH9KbiQi9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765042; c=relaxed/simple;
	bh=s3ZgcZ6BKTnLp+A1PAb6rpm8YoZDgBt/nxZwAaxXJ7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoHVItpZv0WaKdJX+5BSOXGlxAFAtj/PbTKRzoAnONAPNW12TLWNq1fCoPLafadvqL3CbHOPYxKzDynP0xJkzXLP3cjUJOvFdN7ZDIJrPRGkkpheSk/f02twXQsgxBom2FJvPBnC5Z/fJ2FF6pgsYHvoc7gVORe/i6h245Kvknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4bEg5AQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4bEg5AQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765041; x=1779301041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3ZgcZ6BKTnLp+A1PAb6rpm8YoZDgBt/nxZwAaxXJ7E=;
  b=U4bEg5AQgSU2XGBQ6e6JLyRbzM2S4A6nBX8c0g+3ru39H2LSNncu+sEl
   JzhkoG61GypAFiQsSLcpRWJd2kZTym5Wj6zqWYCpeymkFp98ufO27Agvh
   VblHSr9AdnZjMWMEi7BrO9lZvIYjSyHMN5huTPQEzNEtJ1CBgzW1J130m
   oYnAja/am+5KHokMHONryulUFRWyIm84GKV0K6TGIKQ3Fp92Uy1MEswwa
   kdjHoRrA3CjDM9LniBxVfcY48yocq7uyMQYeEpI+IcVd0FomfVJU0ZobR
   +nxgFMDP4TjAqA0S9ehvABvqn9poo5Ci6Xz7K1C52P9rb9kXURWiz+YvC
   w==;
X-CSE-ConnectionGUID: MTXTFa7GQaSaGjWiEKMrhA==
X-CSE-MsgGUID: jIVcGFOPQ1WU/ZQBh3unFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848024"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848024"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: zgxjsAdARFahbTEB79tOeA==
X-CSE-MsgGUID: uyVaAjEwQi6E30TJqOU05A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514719"
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
	Vineet Gupta <vgupta@kernel.org>,
	Vineet Gupta <vgupta@ikernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH V4 11/16] arc/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:39 -0700
Message-Id: <20250520181644.2673067-12-kan.liang@linux.intel.com>
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

Acked-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Vineet Gupta <vgupta@ikernel.org>
Cc: linux-snps-arc@lists.infradead.org
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

