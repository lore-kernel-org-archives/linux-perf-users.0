Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949814;
	b=WC2SghllebnSJRyQ2mJ/Ibpz+JxAZy7iz9ZqCqZAJTVoaFkPAM4xiUR5LjwW+bGxl4mz
	 FBjUzBddnLWk04l7vv/39C1A8dtfEQSfVkihJcsIOQAwr9lZkbuiThFZlHiwMuSq+EBSm
	 QITryqzdvsPgvitArd3teIMC60QpCWE168ZvGnfKs/m+PegP5sCL83RuT2crWvjT0ECrO
	 4BTf8Z+Z8NQ0vc5Qnm0jNE/h5s5Uw42HvSkg0I3IQvpOrrQZVW2r4OrqSbZvXry0XUGrW
	 Rmp3WbdN6UTReLVxk8GvxyAbj9JaHCX62wpk8mklOSya4wy47+RKT2l5LmJ/H2PzlKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949814;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x8Yz07kSluvwAHy3cIT05lp9fxH/Ngxpo6xMev2wtuo=;
	b=YNd1mxZrJ9Kveysml+JOODm95rxjRc1EQnmzqdLOZ7HU2qCXzBoHQatGqQTz67NsWXQz
	 /UxZtM6/2SVlnj39oc43OXec2E7Cd7BIlE6AvFFDXEd/G4bRx0NrtTaRYOhCQN6BfFFUh
	 tbxVcO8VWgyNkJNNxUgwO2cFXADqrXbNWOtgVSNEkGpzIR6nWeJ47nOvGYixfYcstSifs
	 2AyjapYl1efNgiVIws7ykoNGW/tI7aV50SB1+vPdX0AZ1bYdDamCSZWRMu8aqeLV5cFMQ
	 VoxFpvDIpZMebXZgDf+B2gAB0gpNTg2UOL4q6JhXxLwdje6o8u8QAl9a6xuLk3XzjfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aIMkWAsp;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87EF606A32D;
	Fri,  6 Nov 2026 07:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87EF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aIMkWAsp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793949814; x=1825485814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zp4vqpYBIpUjKiyvnTG4hu8LVUrMb+IWLGdUWghYpag=;
  b=aIMkWAspkK00D3nUKWFmJVE+P78X7wZIM9Dw4ruIeZLaQhIo+slqqJi8
   DKOE32ps/DSowIOJNrvEM+l78fclOa3OAjw12S+Sbu20RXyrzDu0It9qg
   itBhYTBWwXlWcmGTrWAOAbhFRp44p7WWzpj/SzLpPPjoNU6myNz1kcN5h
   2hlJKnCq19DZYctx3mHJZoA2d/BZG+sioBSWN6/ioUrFh1OpCDwRKhJZC
   JPYIEXB2LbarUd0SK3GvGvrbz5pBccegvspR1p208+jhPaQVL8X8R6ywO
   cWj3DvwCbtacsrtMCMvNR0IflmwgPje/BIQNQxlWRb5EIG+1c+2tmmUqM
   w==;
X-CSE-ConnectionGUID: DXvHfQSoRb6MVzuFXhTDhg==
X-CSE-MsgGUID: uzVmpJPiRpaIq+cyYtarkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2773397"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2773397"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:23:33 -0800
X-CSE-ConnectionGUID: ToaV5sdvTMiZ8HqIyzy3kg==
X-CSE-MsgGUID: r0NX1qRWTQSTHMNYkFB/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7548899"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:23:28 -0800
Message-ID: <90d0b16a-af97-477d-bca6-eb4c7886b492@linux.intel.com>
Date: Fri, 6 Nov 2026 15:23:26 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 00/20] perf/x86: Fix multiple LBR sampling issues
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sashiko reported an issue on the patch 15/20 "perf/x86/intel: Refresh LBR
stack for non-PEBS LBR events when needed",
https://lore.kernel.org/all/sashiko-outbox-200872@kernel.org/.

It looks a new version is needed to fix the issue. Thanks.

On 11/6/2026 12:32 PM, Dapeng Mi wrote:
> This patch series fixes several x86 LBR sampling issues discovered during
> review and debugging. Most of them are related to BPF LBR snapshotting
> support.
>
> The series originally targeted the BPF stack out-of-bounds access issue,
> but additional problems were found during debugging and code review,
> including:
> - PMU and LBR being re-enabled unconditionally at BPF snapshotting exit,
>   even when they had already been disabled before BPF snapshotting on both
>   AMD and Intel.
> - LBR not being fully frozen in the PMI handler on Intel, which allows
>   branches in the PMI path to pollute the BPF LBR snapshot.
> - BPF snapshotting overwriting the cached LBR stack of PEBS LBR events on
>   Intel.
> - PEBS LBR events overwriting the LBR stack of non-PEBS LBR events on
>   Intel when both overflow in the same PMI.
> - LBR counter events reporting zero counters on Intel when multiple
>   LBR counter events overflow in the same PMI.
>
>
> Patch layout:
> - Patch 01: Add a sanity check to ensure the LBR stack does not exceed
>   MAX_LBR_ENTRIES.
> - Patch 02: Validate that hardware LBR data has actually been stored in
>   the XSAVE area before parsing it.
> - Patch 03-04: Fix the potential LBR stack out-of-bounds access issue on
>   AMD and Intel separately.
> - Patch 05-08: Fix the incorrect PMU and LBR re-enabling issue
>   in perf_snapshot_branch_stack() for AMD and Intel separately.
> - Patch 09: Freeze LBR throughout the PMI processing period and ensure
>   all LBR events observe a consistent LBR stack in the PMI handler.
> - Patch 10: Add counted bounds tracking for perf_branch_stack{}.
> - Patch 11-12: Add a dedicated LBR stack for BPF LBR snapshotting to avoid
>   overwriting the default LBR stack of other LBR events.
> - Patch 13: Ensure perf_snapshot_branch_stack() snapshots the live
>   hardware LBR data instead of the cached PEBS LBR stack.
> - Patch 14: Refresh LBR stack in PMI only when LBR users are active for
>   AMD.
> - Patch 15: Prevent PEBS LBR data from overwriting non-PEBS LBR data when
>   both overflow in the same PMI.
> - Patch 16: Remove dead lbr_pebs_users and relative code.
> - Patch 17-18: Ensure LBR counters are not dropped when multiple LBR
>   counter events overflow in the same PMI.
> - Patch 19: Clamp the parsed PEBS LBR stack depth to x86_pmu.lbr_nr to
>   avoid LBR stack out-of-bounds access.
> - Patch 20: Fix the shared LBR stack depth truncation issue.
>
>
> Changes in v6:
> - Patch 01: Move LBR stack depth validation into common
>   init_hw_perf_events(). (Peter)
> - Patch 10: New patch, add __counted_by() tracking for flexible array
>   entries[] of perf_branch_stack{}. (Peter)
> - Patch 14: Refresh LBR stack only when LBR users are active for AMD.
>   (Peter)
> - Patch 15: Refactor code to ensure no duplicated LBR stack reading.
>   (Peter)
> - Patch 16: New patch, remove dead lbr_pebs_users.
>
> Changes in v5:
> - Patch 02: Clear xsave->header.xfeatures before calling the xsaves
>   instructuion to read LBR states.
> - Patch 05-18: New patches to fix newly discovered issues described above.
>
> Changes in v4:
> - Patch 01: Disable LBR if parsed x86_pmu.lbr_nr exceeds
>   MAX_LBR_ENTRIES (Sashiko).
> - Patch 05: New patch, which always snapshots live hardware LBR stack
>   for BPF path (Sashiko).
>
> Changes in v3:
> - Patch 01: A new patch to ensure x86_pmu.lbr_nr not to exclude
>   MAX_LBR_ENTRIES (Internal Sashiko).
> - Patch 03: Clean cached LBR stack when reseting hardware LBR registers,
>   which prevents stale LBR stack leakage.
> - Patch 04: Don't reset cached LBR stack if all LBR events are PEBS
>   events. This ensures PEBS captured LBR stack isn't cleared (Sashiko).
>
> Changes in v2:
> - Include a fix for Intel LBR.
> - Add Tested-by from Dapeng to the Intel fix.
>   https://lore.kernel.org/all/eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com/
>
> History:
> v5: https://lore.kernel.org/all/20261029043914.1395147-1-dapeng1.mi@linux.intel.com/
> v4: https://lore.kernel.org/all/20261021050711.4043703-1-dapeng1.mi@linux.intel.com/
> v3: https://lore.kernel.org/all/20261019070836.2972403-1-dapeng1.mi@linux.intel.com/
> v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
> v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/
>
> Dapeng Mi (19):
>   perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
>   perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
>   perf/x86/intel/lbr: Limit branch snapshots to valid entries
>   perf/x86: Add lbr_enabled to track LBR state
>   perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
>   perf/x86/intel: Add helper to enable PMU without LBR
>   perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
>   perf/x86/intel: Keep LBR frozen throughout PMI handling
>   perf: Add counted-bounds tracking for perf_branch_stack
>   perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
>   perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
>   perf/x86/intel: Always snapshot live hardware LBR state for BPF
>   perf/x86/amd: Refresh LBR stack in PMI only when LBR users are active
>   perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
>   perf/x86/intel: Remove dead lbr_pebs_users
>   perf/x86/intel: Clear raw LBR counters in the LBR stack
>   perf/x86/intel: Refill LBR stack for LBR counter events in PMI handler
>   perf/x86/intel: Pass LBR stack size into store_lbr()
>   perf/core: Don't overwrite shared LBR stack depth
>
> Sandipan Das (1):
>   perf/x86/amd/lbr: Limit branch snapshots to valid entries
>
>  arch/powerpc/perf/core-book3s.c |  43 +++++---
>  arch/x86/events/amd/brs.c       |   7 +-
>  arch/x86/events/amd/core.c      |  21 ++--
>  arch/x86/events/amd/lbr.c       |  48 +++++----
>  arch/x86/events/core.c          |   8 +-
>  arch/x86/events/intel/core.c    | 130 ++++++++++++++++++++----
>  arch/x86/events/intel/ds.c      |  20 ++--
>  arch/x86/events/intel/lbr.c     | 170 +++++++++++++++++++-------------
>  arch/x86/events/perf_event.h    |  45 +++++++--
>  drivers/perf/arm_brbe.c         |   5 +
>  include/linux/perf_event.h      |  15 ++-
>  kernel/events/core.c            |   8 +-
>  12 files changed, 365 insertions(+), 155 deletions(-)
>
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
