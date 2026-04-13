Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82840DFC3;
	Mon, 13 Apr 2026 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776042401; cv=none; b=OKs4rham1TWyDRDZNTGMg9D47as5cxNaTlToE96Q9Xk1lzW79gWXz4JWbXsLvNRhJk/gEKKShr5Fl6haZKP/fCprxDDws6cQk8Kp2QScCwfDIm1YKJpdItq15dPz+4p1JyfxKzdNbnK/kRhSlO2plI/cb2UwcHKTEMOp6w/m5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776042401; c=relaxed/simple;
	bh=FiILHNQcKVD6IeD5lQib09CU6pZGFbPsjNEOZaRupkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwBKVamIGmuGGPymKXGYjxG1BBzvEnZsvhFcQt7gZLh/ie4PxjNqWclsI3SgKWz+3SZsYgiUY+UurkbI42nGA6AcTakGmHTkNoEkXkA0tVeQf62HiTzdEpLDGrX8kXRCLQ81I7uSHU2N/WOd4TXslIQ7DIr0lp6mVXU5OvbRRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2A+R7cr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2A+R7cr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776042401; x=1807578401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FiILHNQcKVD6IeD5lQib09CU6pZGFbPsjNEOZaRupkU=;
  b=R2A+R7crQVy9HLRq27QVVmeUZutRmPsx9n4ZgUPvzBnpgG9x4AcHEzfq
   cx6oSyMQpK8x3k1CnLwA13sD1WYFv65+NmOkH9cySe31dOtySQxAmf8sO
   1ghAGJ9HSu1yylnq4HhvHBB7I7VBiDy6OdBSBXCqA8bbpjm53Pmh5MDIZ
   HWkC/TwKJIm8GCd2l8u/vFv1b9hH+Ekyo8GKMx7ZZye3m600aA33/5Pv5
   7CU3Q3EJ0p2+n3JArDIe8ZOwMIr33tGdlTZH2sH5FVuRn7uINC4m9Tlzo
   eN0e7RQNLNl+uNNr3YcCQm7h6+XRzzIzjIQjG29hP69HRq50gk88qjOPH
   g==;
X-CSE-ConnectionGUID: kBomAAXbQLioZ3ami43LhA==
X-CSE-MsgGUID: hBIkpDR+RxC/hFJcOADuJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76933871"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76933871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:06:39 -0700
X-CSE-ConnectionGUID: h3U8oDcaTLKu9RkcmlKCpg==
X-CSE-MsgGUID: jzLDZi6URpC5t8w6KvQQuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="231366302"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2026 18:06:35 -0700
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
Subject: [PATCH 0/2] Fix 2 bugs for Intel auto counter reload (ACR)
Date: Mon, 13 Apr 2026 09:01:55 +0800
Message-Id: <20260413010157.535990-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch-set fixes 2 issues in auto counter reload support.
- The stale ACR mask is not cleared before setting a new one. Patch 1/2
  fixes this issue.
- PMI is enabled by default for self-reloaded ACR events which causes
  suspicious NMI warning. Patch 2/2 fixes this issue.

Besides an ACR unit test is added into perf tests which would be posted
in a separate session.

Tests:

Run below ACR sampling commands on CWF and NVL (hybrid platform), no
issues are found.

a. Non-PEBS ACR sampling

perf record -e '{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}' ~/test

b. PEBS ACR sampling

perf record -e '{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}' ~/test


Dapeng Mi (2):
  perf/x86/intel: Clear stale ACR mask before updating new mask
  perf/x86/intel: Disable PMI for self-reloaded ACR events

 arch/x86/events/intel/core.c | 20 ++++++++++++++++----
 arch/x86/events/perf_event.h | 10 ++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)


base-commit: 9805ed3c91478b08a586861b874bd8b6a2fed648
-- 
2.34.1

