Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69F37B3FD;
	Mon, 27 Apr 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280414; cv=none; b=r0nra9xMVdEdLKyJJ05qWXi6OYKaTNjyWQaMaKQPMt8Y06TOQdEfl4Nu1wAh3NZZHhJSDfjXPP6trAKP+BjV4N3eK0gsQCcBC4V8KM+PyQ/IcbYgFpsFUi2GeY4EK9urvdBbDAFCtk1+NdYT8QQcti2qd+17ciuHBO/QakwcSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280414; c=relaxed/simple;
	bh=O8aFJy8wiMf1u27Bu3mcjflFXYQ9CwThbCzGOvmKkEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EDzuhojj1FGSHt66XtW1FeNCm5tl+INvO7dl9yUys80MkLbH30kks+HDiZCLSSJp3vJBqCNbNV2e+IDvpw0poYSQDzEUzZ/Icldn8LdEVikcIwuGAft31XJsqOzTmRc1TxlLuTy+ZdHWYQHYJTq8ovGSy7ua7MDYVH/KYX+ofow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyf0Sa/j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyf0Sa/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280413; x=1808816413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O8aFJy8wiMf1u27Bu3mcjflFXYQ9CwThbCzGOvmKkEc=;
  b=kyf0Sa/jBNTmRMHDAM4FBhNSHlE7ff8rRGbJD0HfkhZUfQ7kPRUGL5Tr
   b+WWDLKb52HvEKWmFX8aHsXFs9WDlpoNrCToVEuFm7MkPZm+p/9+l3j4M
   6EVkqEg4ynUGfwS20HYHFN0EWMSye5j4p+iO+LCIQtceYLOTcVeDPWFGU
   sG+3id+gX9KIuWOae6/NrKgSM+nh0UQIDgRJehcBQlT3SlmMqco2m+tsJ
   oNkxGm4vUlSLOzoIMvVZRNqwF8b0HSjUzk3yG50mFAGcRM0/Yjy2IA3Uw
   o/P20EKIHk055/cH/CcKrOsYDWx+oKSEG0EDg0NQkohrYQ5JolTzuYBIo
   g==;
X-CSE-ConnectionGUID: /ZDjoNHGRC+D3/+WUjdPXA==
X-CSE-MsgGUID: OiSIWE/2Q9qy2g+sQnIA2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88476322"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88476322"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:00:13 -0700
X-CSE-ConnectionGUID: Qg+TqAvjSq6OxGfHdR3aVw==
X-CSE-MsgGUID: 1pwLgoXuSgWou87KbUC+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233850585"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 02:00:09 -0700
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
Subject: [Patch v3 0/4] perf/x86/intel: Fix bugs of auto counter reload sampling
Date: Mon, 27 Apr 2026 16:55:09 +0800
Message-Id: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
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

Dapeng Mi (4):
  perf/x86/intel: Improve validation and configuration of ACR masks
  perf/x86/intel: Disable PMI for self-reloaded ACR events
  perf/x86/intel: Enable auto counter reload for DMR
  perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking

 arch/x86/events/intel/core.c | 63 ++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h | 14 ++++++--
 2 files changed, 57 insertions(+), 20 deletions(-)

-- 
2.34.1

