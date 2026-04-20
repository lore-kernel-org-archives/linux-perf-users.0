Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952833C532;
	Mon, 20 Apr 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653411; cv=none; b=E2YBazrSm6qNDnU2ju9fpg3eG7TwPKWwx6oVbaeO0WymmOye0vhkcc7nNUNr+OrcrMvKDDQ5sHylS8niENTKBQFwcbzjJTeUhm2cEk0w6rTi8ME030Nl6fTaa8UmNYf2eefr/VFyJkLcPtLeIVs3YAweg4M1vZcBs4/MTUp/n3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653411; c=relaxed/simple;
	bh=+eRofx/aTZs3332sRA6uS4ZL4OTUWvjaAUt6u9EgDfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t+tMmkZtS0kPoDpSAeZ4ILvQxg/vjjmyYsYigHO+PoYyCh0aYuLghiG8OLfSOHRM3YXg9AStR8Ob8ravljqx9pt2046vZiEy4cbKeehm85yYSNmSJ0osj+uRPPmkHPjTribIF+5aqwN5OlTT0d1kzqGcfc1Yr0/EP/3tyhMKpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1qibRK0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1qibRK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776653410; x=1808189410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+eRofx/aTZs3332sRA6uS4ZL4OTUWvjaAUt6u9EgDfU=;
  b=C1qibRK0KukK/iblt0RsZKH+7W53MpFVUTGU7xJlNslurqYBsabQ82/w
   j0kLQkukyPa5NGvs+iKXSy1w32HFdFAmUiuHOa9bRhGTzD38pfpGcSu1i
   lWXgMv8GeDPxZFuoGfbmdc/GpBN4ndmNKE8ezl7c/r+WB2xYio/mwdqLm
   wx5qTjprRbbJazJ7AirNqowhjKN2m4/l9/XwBbn54LQLHhCJqlSTrOMh8
   6uNckdsUWqIy0GuLBQOldSGAgocn+uzjNWf/rbOVtKMUhaLNmqc0Ew1wn
   E9Mvi0LqcasqzAkBjd52b4x9yg3reIuzzEvzZrEXeGFIigwg0MQUHQCsg
   Q==;
X-CSE-ConnectionGUID: vzMAAvvhSe+/IQMiQm4FSQ==
X-CSE-MsgGUID: kjhSij7ISHOPSeXZ4c3kvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81442146"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="81442146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 19:50:09 -0700
X-CSE-ConnectionGUID: eIz9uAfjQEu8invxAzoqIQ==
X-CSE-MsgGUID: RZAyYEh/TSOv3PySUrM2DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228907988"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2026 19:50:05 -0700
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
Subject: [Patch v2 0/4] perf/x86/intel: Fix several bugs of auto counter
Date: Mon, 20 Apr 2026 10:45:24 +0800
Message-Id: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
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
v1 -> v2:
- Clear stale mask for all events (Sashiko, Patch 1/4)
- Enable auto counter reload for DMR. (Patch 3/4)
- Remove duplicated CFG_C MSR value tracking. (Patch 4/4)


This small patch-set fixes 2 issues in auto counter reload support.
- The stale ACR mask is not cleared before setting a new one. Patch 1/2
  fixes this issue.
- PMI is enabled by default for self-reloaded ACR events which causes
  suspicious NMI warning. Patch 2/2 fixes this issue.

Besides an ACR unit test is added into perf tests which would be posted
in a separate session.

Tests:

Run below ACR sampling commands on CWF, DMR, PTL and NVL (hybrid
platforms), no issues are found.

a. Non-PEBS ACR sampling

perf record -e '{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}' ~/test

b. PEBS ACR sampling

perf record -e '{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}' ~/test


History:
v1: https://lore.kernel.org/all/20260413010157.535990-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (4):
  perf/x86/intel: Clear stale ACR mask before updating new mask
  perf/x86/intel: Disable PMI for self-reloaded ACR events
  perf/x86/intel: Enable auto counter reload for DMR
  perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking

 arch/x86/events/intel/core.c | 37 ++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h | 14 +++++++++++---
 2 files changed, 38 insertions(+), 13 deletions(-)


base-commit: 9805ed3c91478b08a586861b874bd8b6a2fed648
-- 
2.34.1

