Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626A3812C2;
	Thu, 17 Sep 2026 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610421; cv=none; b=tW7/QN095JCEaMA9myOW1gYLl7q5UQPK+nqh6zpPOlxPveJJMR0QgQ8UWSoFHfIMYjOxsKynTPaU4xrRbJsCvNu/Jn8Thi0T37LmoLKGA2AH+L9rqC63sNlsE5w5Y568VLjxVEh9ZS2FCy/5VOnWD9BlJwo1KqTcH4VE7zvkLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610421; c=relaxed/simple;
	bh=9YGgYq4ThZaH37Ktre3LgF38pjZqqSjQuF+P4s9YMV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oO5ZruCNcqL+ua2yPNu/1y6LJ75d6dgagdF/Mx9yVVf3Y4uq3dRmthdVYnbEVQx26XBrZAgkvJ1b5RMdLGZW3NUFHMfeezE15x4mzb6IJ9aeIped2bWkr5aO5y4PBjHuz+bu/lD/5ZAKQ1CxLecDBM4ZW3eL6H5VEgEN/61bT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vggk5PYx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vggk5PYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610420; x=1821146420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YGgYq4ThZaH37Ktre3LgF38pjZqqSjQuF+P4s9YMV8=;
  b=Vggk5PYx935QQET99kL2HVoKQMKfHGb7a4Vd7L46ZV5JJ+k3wLj/tzv5
   IHhgkeULs2XnVO3RE6SxLsF1Wtq6fG79/Ez86Dw6cwGTVAspXWTferH8b
   U85lisQvnwCODbdtojgWO5qItf9Gkptd8S3j0V5CIzzQk2lDHW0E+Q3Oj
   veRIO7+/cFGRANhzYV20A1fngrJAr2jaFqHLXbeABlJYwqodnyqd6g5tj
   AfKpIkGo0BgeoNZe1OF3hX0r/oXXS/V11zE8gqdrzLSz8JPHkiFQynehw
   E+OxG2jF7Plspit75GayrmSkSXwY+bZBYQckHRpqAr1Tv9n6UbCyKq7mA
   Q==;
X-CSE-ConnectionGUID: eUVfcAVkRO6FNQrTG+KhSw==
X-CSE-MsgGUID: zsepEQEkQB+MTLsYEPS0TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498650"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498650"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:20 -0700
X-CSE-ConnectionGUID: 3WF+V1GoQCis5zym5q1GKA==
X-CSE-MsgGUID: WxIgWqpBTuu2C/hJTuS7hg==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:00:15 -0700
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
Subject: [PATCH 10/12] perf/x86/intel: Add precise OMR event support for DMR/NVL
Date: Thu, 17 Sep 2026 09:52:32 +0800
Message-Id: <20260917015234.981153-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest perfmon event database introduces below precise OMR event
support for DMR/NVL:
- MEM_LOAD_L2_MISS_RETIRED.* (event 0xd6)
- MEM_STORE_L2_MISS_RETIRED.* (event 0x4f)

These events use the same OMR MSRs as the existing OMR events, but
they are not listed in intel_pnc_extra_regs[]. As a result, perf
cannot assign the required OMR extra registers when scheduling them.

Add the new precise OMR events to intel_pnc_extra_regs[] so they can
be scheduled with the correct OMR MSRs. MEM_LOAD_L2_MISS_RETIRED.*
remains limited to GP counters 0-3, while
MEM_STORE_L2_MISS_RETIRED.* is available on all GP counters.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9462862bf72a..276a54416d5c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -522,6 +522,14 @@ static struct extra_reg intel_pnc_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x022a, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
 	INTEL_UEVENT_EXTRA_REG(0x042a, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
 	INTEL_UEVENT_EXTRA_REG(0x082a, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
+	INTEL_UEVENT_EXTRA_REG(0x014f, MSR_OMR_0, 0x40ffffff0000ffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x024f, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x044f, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x084f, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
+	INTEL_UEVENT_EXTRA_REG(0x01d6, MSR_OMR_0, 0x40ffffff0000ffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x02d6, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x04d6, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x08d6, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
 	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
-- 
2.34.1

