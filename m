Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030893B3BE6;
	Mon, 24 Aug 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560465; cv=none; b=K6Yid1X/pYickCujdOyEWRmQM8PiFXpRVukL2E8xObu/+Cqpxyz1cK2SV0h66ug4ss6OdvJzA0g71Vj/D+blu5bLHYTNGJFGC4vYZkDKKS06Do9hYTj/mXTztV/losUUsI2eBUVqIyBXjTNIDmSc6QH18Iy1/LF9ZunM72Id6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560465; c=relaxed/simple;
	bh=TVrKAVZ14GwffRfhYVnCcPXc5wxZIkcTc6SChYdqA+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftHqCU4Zmvjt4dCVw6Lqeb8iKLN3Vp+WuSOuPtTcjFJV8v2ZBxgPvhA+wi3+Rot3NZqPpjHuvuEDe7sUvDeun+wtxDtgfcRLl/O05qT65hJrZ7JgotDh4TNW9sQ5zy/Sj5plzK81m+Z959NT+SM+ySHeGPvrdPDMeIkhC5AdwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky4tFemh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky4tFemh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560462; x=1819096462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVrKAVZ14GwffRfhYVnCcPXc5wxZIkcTc6SChYdqA+s=;
  b=ky4tFemhMNwPhdBJ2O9B6qlEeY8mmW0NuQitz9EDIS1XicfXKxY1HILp
   Xk8PD69IWEOBHVO0GprE2K1VPcUa+2N0g+BOIxpQ0zzKsxTJ6E1+aRMv7
   8XVj/2rj8J4ce8ujqBPicsx6nE5JhaYyk3FETdP7iB+HTMq5CRWpASW0F
   8zw+B3jH4CzbvpuKoOcl0QJptp9J4QJvuZXh0OPneISNfcq3VO6Cxgf4E
   mfKYLAVTLm+NsoZCZJSqP0rw0QbVyWt6ZEog9Xn5sXhU9Eyn9200oDVjx
   9K6re7X4Yog21fFJ3UEizP/73dKXV7Q2IFkG+XCium6+2S/ENFZvVrrmq
   Q==;
X-CSE-ConnectionGUID: 4VFN8Kh+RSWayqn/XTSCcw==
X-CSE-MsgGUID: 5KnVaGFLQne3ZOSeNOsEOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598675"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598675"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:21 -0700
X-CSE-ConnectionGUID: i8k6WaKwSGCfE6S/HGMlTA==
X-CSE-MsgGUID: 9aATPqTSQre39d+pCGp4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264325904"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:15 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND Patch v10 02/23] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Mon, 24 Aug 2026 16:27:10 +0800
Message-Id: <20260824082731.1013973-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern PEBS hardware supports directly sampling XMM registers, then
large PEBS can be enabled for XMM registers just like other GPRs.

Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f6ee1819864e..dbc0bd0fe73f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4699,7 +4699,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_intr &
+	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
 		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
-- 
2.34.1

