Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F3280A2F;
	Tue, 20 May 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765038; cv=none; b=sj9DgrpbRzrLX8GX5QhVWnPHDzDKjkdtHfXHhzbeq4MmF6YmNV15DG5RjkhsvQfXNa8ARV8yktuKUjB1h/ZD+pGPbomfV0fe1JvUUxuMxyCYx4gprtoOlNEQkJNj5W6sLtahTj+aHiNhfFZ6gihs9e2XF3OqF0zLQqm+X6c8wZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765038; c=relaxed/simple;
	bh=s+EyXjLUXo0M2dfj157AL5fvrY36sWvSBJ2tuImTWtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORTGwKDnHq3EVr1tBz/QBSrC7FwsKxCwPIwguZkVK82DXgU0Xvx5PXH2gVShtfjelK4xD/C04jcG5GmOPciYDyR9bRm19jiVeQCwIyxhzQy37kzyuO8PcHFWHaZegHh6eh6olV2BD29GiXHZgwzSPWdhxEQCQVbKPF1du8ou4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwxZKh8d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwxZKh8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765037; x=1779301037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+EyXjLUXo0M2dfj157AL5fvrY36sWvSBJ2tuImTWtk=;
  b=MwxZKh8d3G7ErN+6/M3E3jiGw7sPfqh3yFadzyT3Cmnod98cL/Y5UJOu
   Bv0FCEwqWSEVg2AJWHjD5ruPuV2tvreNSScZ7E9OlpBUl1PmEWxg3EEza
   n8bSvZGdfJbD3OZ4BZfS/vFHL/ng0sLnn/Gz0/uE2t+bb59zsGphh86OQ
   bTN4F1JxnO6ks/eIRIQU4H0FSfxd8xmQYwM79trOKuHNyUrTYwnyW2wLL
   MsrBTb6sIVHdXiiZpQWmWs0YG+gBPhy0CfgtVWCrl4wWJ6imrokrkM8U8
   ZIUfqQ2xMNrCHHSniNxpuQtl3a2326eu4S0ewZKueMPBKpaQOYVjkKTqy
   Q==;
X-CSE-ConnectionGUID: u3yNZ/BERO2/BbHSm+uYRA==
X-CSE-MsgGUID: NSPj8zWLTTOEK/S7qSWKqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847988"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847988"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: tt0fVSeZQYu+1VmXOJztCQ==
X-CSE-MsgGUID: DwqYvJaXTXKgUclat/S2VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514710"
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4 06/16] powerpc/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:34 -0700
Message-Id: <20250520181644.2673067-7-kan.liang@linux.intel.com>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/perf/core-book3s.c  | 6 ++----
 arch/powerpc/perf/core-fsl-emb.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42ff4d167acc..8b0081441f85 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2344,12 +2344,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
 			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (perf_event_overflow(event, &data, regs))
-			power_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	} else if (period) {
 		/* Account for interrupt in case of invalid SIAR */
-		if (perf_event_account_interrupt(event))
-			power_pmu_stop(event, 0);
+		perf_event_account_interrupt(event);
 	}
 }
 
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index d2ffcc7021c5..7120ab20cbfe 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -635,8 +635,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			fsl_emb_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 }
 
-- 
2.38.1

