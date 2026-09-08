Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AA3AE1B1;
	Tue,  8 Sep 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854298; cv=none; b=gzGFRxiDagN6PlQ+mtE8kN/vIZE9Bb/iq2snDXFdag4fee959cRUOk1vSHqZKg/zTXME0D7uBThMCBda6r2ynXtd5Ym6f6vPnNXVQ9P7Mj036/DmGAkEpRT4VewuuBCImlvLyjMSkRons10JP2vAeMNdCKFJuKoaqMKzOktGd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854298; c=relaxed/simple;
	bh=ZYptAyBu6KFFO7ApF0ix66fm88V2Y3sp/RqwAC6MXEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzfIAh/lhIbefCoEIAG4bRvWHJneYwUqRnHJMBoetZfRb/gcDOTqexBzViq2HE4egBJZ/nDyTYGn3ZCxexN/Fpd1jr/7/b5cL6lutdWQrLWAuLutAxtSA5ZkcuQ4lrmXVR0qAg8jguDQQCMD2wN+RZEoaScSlSJWXviS/+1qirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlTgIwTF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlTgIwTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788854296; x=1820390296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZYptAyBu6KFFO7ApF0ix66fm88V2Y3sp/RqwAC6MXEA=;
  b=PlTgIwTF7d00RWk0CeMFcwDcFn1FCxKcC2/xVF+wew0VWrrg9qJnaFPx
   8N8+WUkdYJY8cK1tEOYTdo/YgD5RdzF5uXvC++W8O7cqohd8yP4ywQKgS
   ilJcbQ4Mpt0AND3xG3jats6eiyKEqoDvyg+oGWXflsGnCll57TjBYBzDS
   lGx7rKzZw2fRk7o+yI7WIiyPJYBZQ6JW1809+0jfdcFL+psSKPAABMj7P
   k2qHr7EBEHIMJL2OtSh99s6QAvmkrJMi9+vxXZxkfmMgPC5GhqSLfaRv7
   tJ3R3yishlGK4GoDEjxbyrLsivoWL/Yquo5pGALFVUQaPk3Gpm51aQR7z
   g==;
X-CSE-ConnectionGUID: EXVEwtc7SCi9J7DcR7zWkw==
X-CSE-MsgGUID: EveBE7M5QPC7SEoYnfcp8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91758447"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91758447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 00:58:16 -0700
X-CSE-ConnectionGUID: ZjLgEWb+TYCLa7tCCTrwjQ==
X-CSE-MsgGUID: z8i8DElBT/y6R2cxTsku/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="266576245"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 08 Sep 2026 00:58:11 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 2/2] perf/x86: Disable precise sampling for PERF_SAMPLE_STACK_USER
Date: Tue,  8 Sep 2026 15:51:02 +0800
Message-Id: <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
to user space when the PMI exits. Since the skid from the PEBS/IBS sample
and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
can diverge from the user stack at PMI return. That mismatch breaks DWARF
unwinding.

Precise sampling provides no benefit in this case, so disable PEBS/IBS
precise sampling and allow only PMI-based sampling when
PERF_SAMPLE_STACK_USER is requested.

Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/ibs.c    |  3 +++
 arch/x86/events/core.c       |  3 +++
 arch/x86/events/perf_event.h | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3531f9c23b8c..c67b659d64e2 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -327,6 +327,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	if (!x86_pmu_allow_sample_user_stack(event, true))
+		return -EINVAL;
+
 	/* handle exclude_{user,kernel} in the IRQ handler */
 	if (event->attr.exclude_host || event->attr.exclude_guest ||
 	    event->attr.exclude_idle)
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..ceb5038d7565 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -594,6 +594,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 		/* There's no sense in having PEBS for non sampling events: */
 		if (!is_sampling_event(event))
 			return -EINVAL;
+
+		if (!x86_pmu_allow_sample_user_stack(event, false))
+			return -EINVAL;
 	}
 	/*
 	 * check that PEBS LBR correction does not conflict with
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 71ed5b2acea2..9fbcf2bcef51 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1274,6 +1274,25 @@ static inline bool is_counter_pair(struct hw_perf_event *hwc)
 	return hwc->flags & PERF_X86_EVENT_PAIR;
 }
 
+static inline bool
+x86_pmu_allow_sample_user_stack(struct perf_event *event, bool ibs)
+{
+	if (!(event->attr.sample_type & PERF_SAMPLE_STACK_USER))
+		return true;
+
+	/*
+	 * PERF_SAMPLE_STACK_USER needs to return the user stack and
+	 * user registers to user space when the PMI exits. Since the skid
+	 * from the PEBS/IBS sample and PMI delivery, the PEBS/IBS register
+	 * snapshot (especially IP/SP/BP) can diverge from the user stack
+	 * at PMI return. That mismatch breaks DWARF unwinding.
+	 *
+	 * Therefore, disable precise sampling for PERF_SAMPLE_STACK_USER
+	 * and permit only PMI-based sampling for this case.
+	 */
+	return !(event->attr.precise_ip || ibs);
+}
+
 static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 					  u64 enable_mask)
 {
-- 
2.34.1

