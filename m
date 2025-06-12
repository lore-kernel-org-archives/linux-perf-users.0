Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D025393B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739140; cv=none; b=nkFvc+gOKOw/kIqmhd2I7DCXGOh1zbzJtzJgevQtMFQGFNEaXM9yt37E8HV1B4iGY0f/ERDtzq0mBf7LiTC1gI7cvxuwPejXuv9iHk7WWTh1U+nvsZR5PYZiLcJ7a3kt2uznD9pPKDuJ/G/1UXtbUbu5fH2DPML3yemU+OLSamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739140; c=relaxed/simple;
	bh=RCSOse9Pu2+OucWA9/70UyyrUntWE6Yl8cOFOcayAe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zzx8siYgqeWgeqM65TBHsJfAFqRB85WOYcatQpYwdoGdz177KjgHe8vwCh5Mx1dNdTqwcmXEcW8Ostw4nhy8P/0/1n+CjwEs2iMi1wAXWYCVQ4uR7x/N6T0yPHDOCBa+3TIjEWwxIpHt8Tr8ovfkObmGwFDvMeMjrMSvRrJl0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAXtrVTa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAXtrVTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749739139; x=1781275139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RCSOse9Pu2+OucWA9/70UyyrUntWE6Yl8cOFOcayAe0=;
  b=FAXtrVTaeMF1bOyf0M+eZRw9jkBH/PzK8Z/QQhCOGUaf2qewBdDeXlUj
   b92zpt9TcE38Iofd+ZRPjUgvEvZAXZuPXOnUA/kG12CGB9MIsxpwxWlqG
   i9aOwR9TjgeJ8Aia5ek9uAbfMcxB02uCwRCqB39JK371peYmC9JAYyp6R
   scOz1U/MIpQIlk1bgaqpii3O8S6OShSu4nd9S3MmpsAc/4q6kfSQL2jNe
   7pBco3RLpswdm4MAYPK5VLDscrTkRsbXllVKgN8DCo2HCA81EfJAPpxAF
   ebhVW2lhOzGfqOTm6kiDlGugwB7iCmpiXIupH1Xgl7pOrpxn3gzFpujCb
   w==;
X-CSE-ConnectionGUID: 5iHHphr2RQeGYkj/U/rL8g==
X-CSE-MsgGUID: JTpGNp+AS6SHn3HUyEi+vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51636602"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51636602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:38:58 -0700
X-CSE-ConnectionGUID: xctw5ESkRcKMeD1by0kgkQ==
X-CSE-MsgGUID: Ec92IqxGSjuSVETPsPi/lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152447213"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jun 2025 07:38:57 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH] perf/x86/intel: Fix crashing bug in icl_update_topdown_event
Date: Thu, 12 Jun 2025 07:38:18 -0700
Message-Id: <20250612143818.2889040-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf_fuzzer found a hard-lock crash on a RaptorLake
machine.

Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
CPU: 23 UID: 0 PID: 0 Comm: swapper/23
Tainted: [W]=WARN
Hardware name: Dell Inc. Precision 9660/0VJ762
RIP: 0010:native_read_pmc+0x7/0x40
Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
RSP: 000:fffb03100273de8 EFLAGS: 00010046
....
Call Trace:
  <TASK>
  icl_update_topdown_event+0x165/0x190
  ? ktime_get+0x38/0xd0
  intel_pmu_read_event+0xf9/0x210
  __perf_event_read+0xf9/0x210

The CPUs 16-23 are e-core CPUs that don't support perf metrics feature.
The icl_update_topdown_event() should not be invoked.

It's an regression of the commit f9bdf1f95339 ("perf/x86/intel: Avoid
disable PMU if !cpuc->enabled in sample read"). The is_topdown_event()
is mistakenly used to replace the is_topdown_count() to check if the
topdown functions for the perf metrics feature should be invoked.
The is_topdown_event() only checks the event encoding. It's possible
that the same encoding 0x0400 is created on an e-core CPU (although
there is no valid event with such encoding on e-core).
The is_topdown_count() checks the PERF_X86_EVENT_TOPDOWN flag. Only
when the topdown events require the perf metrics magic, the flag is set.

It should be a typo when merging the intel_pmu_auto_reload_read() and
intel_pmu_read_topdown_event() in the commit.

Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c60b6f199f51..38886cd7aa65 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
 		 */
-		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+		if (is_topdown_count(event) && !is_pebs_counter_event_group(event))
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();
-- 
2.38.1

