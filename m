Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C72224D6;
	Thu, 30 Apr 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509051; cv=none; b=OaawdtGP7g6o0spXVtB+sCwoEBQQl+KNmns5SoSA9ViXIU2Ncs/1UsaLXT9/44SE8v4TM7rGukRROfqaBkGSNSrHk4HMF8JVSW+6czww7zpHRSWsxDJliqY/l0aFqXud6yj8B5IX+YE8gRmT9hkD47I0TnK7IlILChtKHtccCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509051; c=relaxed/simple;
	bh=3mf9kvSPXBbLW1PAKSwdr8Zcy59whm7qzw8bmy9nH88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kxqoFnGguiv2YV+Kkt14XFSdiyo+k6XAafMsRIoTZxEp00EAfDMAj66pQQgtgDAOz8tTgCio9Ad/e9rnfwfgD+rQ/su4DWmIXoEAPV+XaKRuMMkizmQfPdrU6lVkhyYz9ypK/LK8f2DDfwNJ1woi9KRjrC6ilJg+M64cffxUfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdnNOzbh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdnNOzbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509050; x=1809045050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3mf9kvSPXBbLW1PAKSwdr8Zcy59whm7qzw8bmy9nH88=;
  b=QdnNOzbhzf6UhkgJOdhP8VZatzyEhxofSkX38Dk7eiGmCxQHdFDQznaJ
   hFFK8IGkOCtJNW+d5NjbbiaeBgOZ/7kOvX5tIbadpnZED1pv6M07l/ITK
   8wr0saFzIt4NOt8eZHkTaGWb8NbO7MNLTt7hxlORGt61F8Sfz1JrvF554
   S2QHTXk6lWVCoOgnNPNhwZE1Vh/tBIK16iekxReCp8H0fbuNYtq/+wshr
   MeAoo2pCkPMnqrACnEROg921uicPtUBWEtyDqCOP5KfJ/rtBCWC3bZKgo
   7lARG3InB6w6mRjEGtSJSjN3iJ8WBpWA88GdiO8C8MV3OGW1ShjQF+2gZ
   w==;
X-CSE-ConnectionGUID: 8kyzrJ2gQbOsVpMNae/n8Q==
X-CSE-MsgGUID: UQPLIlTBTty6E8YjD+GCaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95873635"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="95873635"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:30:49 -0700
X-CSE-ConnectionGUID: BQHWhjV8Q+yXvaYU6Wgjuw==
X-CSE-MsgGUID: XGZyjYKtT5yQsJqYHmKsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234455195"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2026 17:30:46 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 0/5] perf/x86/intel: Fix bugs of auto counter reload sampling
Date: Thu, 30 Apr 2026 08:25:53 +0800
Message-Id: <20260430002558.712334-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes:
v3 -> v4:
- Simplify ACR group indices valiation (Sashiko, patch 1/5)
- Fix the issue that new acr_mask may not be updated into HW if
  match_prev_assignment() returns true. (Sashiko, patch 2/5)

v2 -> v3:
- Fix the issue that user-space ACR-mask is not properly validated.
  (Sashiko, patch 1/4)

v1 -> v2:
- Clear stale mask for all events (Sashiko, Patch 1/4)
- Enable auto counter reload for DMR. (Patch 3/4)
- Remove duplicated CFG_C MSR value tracking. (Patch 4/4)

This small patch-set fixes several issues in auto counter reload support.
- The stale ACR mask is not properly validated before setting a new one.
  Patch 1/4 fixes this issue.
- PMI is enabled by default for self-reloaded ACR events which causes
  suspicious NMI warning. Patch 2/4 fixes this issue.
- ACR sampling is not really enabled on DMR. Patch 3/4 fixes the issue.
- Two variables are used to trace CFG_C MSR value independently for ACR
  and arch-PEBS. It's error-prone and fragile. Patch 4/4 fixes this
  issue.

Besides an ACR unit test is added into perf tests which would be posted
in a separate session.

Tests:

Run below ACR sampling commands on CWF, DMR, PTL and NVL (hybrid
platforms), no issues are found.

1. Non-PEBS ACR sampling
perf record -e '{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}' ~/test

2. PEBS ACR sampling

perf record -e '{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}' ~/test

3. Perf-tools ACR sampling test

The patch (https://lore.kernel.org/all/20260420024528.2130065-1-dapeng1.mi@linux.intel.com/)
adds ACR sampling test case in perf tools record test.

perf test 148

History:
v1: https://lore.kernel.org/all/20260413010157.535990-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/20260420024528.2130065-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/all/20260427085513.3728672-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (5):
  perf/x86/intel: Improve validation and configuration of ACR masks
  perf/x86/intel: Always reprogram ACR events to prevent stale masks
  perf/x86/intel: Disable PMI for self-reloaded ACR events
  perf/x86/intel: Enable auto counter reload for DMR
  perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking

 arch/x86/events/core.c       | 13 +++++---
 arch/x86/events/intel/core.c | 63 ++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h | 14 ++++++--
 3 files changed, 65 insertions(+), 25 deletions(-)

-- 
2.34.1

