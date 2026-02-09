Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E231A808;
	Mon,  9 Feb 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621916; cv=none; b=Bn1sFZeWQXYJsiH0fQG0qDr6MCP/se/MewVZnjmp/Dd00VYVnL1QxqvKQNjXzE0Rzz2V+cRNeCdwqRW4bPVf9RZh+3MMEmtiYVTrpEf3GdSIm1Q+57iCW4BANDxEFatPGps/6hLpwdObn2NlA67IpdPNjTX1rBG0K3xRULm5N5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621916; c=relaxed/simple;
	bh=3YbUpPFsRka/sotlraM+1DpA2t+Dw+JX6Y9ceVUB5bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4UGtYbtVicAzUuzFdRHo3C8gAfbNUMcS2lMESgxnnY/Tz6Kz/ZM00ZMT/U7tS91QhhS5o+fFvp6U6aWLH/XQrLzBU5Pf4zFxHm3q0js6Uvw80DKyC9QbMl34E+zKmytBpIu6eHrPAKBdpJlV4FQRhMYT2Wdtyh534kGMdCitfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1yDCVv7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1yDCVv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621916; x=1802157916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YbUpPFsRka/sotlraM+1DpA2t+Dw+JX6Y9ceVUB5bI=;
  b=c1yDCVv70OQnVYX+DdUMLyAy+HUNnh+5UtKzFoxyZeAJQNCWWvCPq2pY
   BBRxzomvJ0KFe+xTWVUeNbgtdjEpNxetobTKrHO0rySublBO3lj3cbitv
   L4kKHjKQeFwTAr23xl6nj4uLBoQW9SKceKEJQMGvQeP/1o8tSelK5iPnW
   hJ33QX5dyGHCm2RBMw7T6JzIVEDZkPQaYVsN8Gdv32+NUdm9UcimtVNli
   HdVoJuFfnzFoG6+Yi3DxBaUj7URsgcyEKOeBmigy5WtY1TF+E+EkAnVTd
   BbKbRJ3fubJOtB+P1T+c73ihl5tFllukscPhDsYXAh8AqUMoPOrICewA5
   Q==;
X-CSE-ConnectionGUID: i0qsBB1sR2O4wL3xDVdemw==
X-CSE-MsgGUID: 40Ewr5fIQAWbJrZggQBoog==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098306"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:15 -0800
X-CSE-ConnectionGUID: PapH08v1QJuXLK2ZR+QE6Q==
X-CSE-MsgGUID: N5zRPzTWRSi35EC3zMLWYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694618"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:10 -0800
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 05/22] perf/x86: Use x86_perf_regs in the x86 nmi handler
Date: Mon,  9 Feb 2026 15:20:30 +0800
Message-Id: <20260209072047.2180332-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

More and more regs will be supported in the overflow, e.g., more vector
registers, SSP, etc. The generic pt_regs struct cannot store all of
them. Use a X86 specific x86_perf_regs instead.

The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
is no functional change for the existing code.

AMD IBS's NMI handler doesn't utilize the static call
x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
IBS. It can be added separately later when AMD IBS supports more regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6df73e8398cd..8c80d22864d8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1785,6 +1785,7 @@ EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
+	struct x86_perf_regs x86_regs;
 	u64 start_clock;
 	u64 finish_clock;
 	int ret;
@@ -1808,7 +1809,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs.regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs.regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
-- 
2.34.1

