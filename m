Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8929B793;
	Wed,  3 Dec 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745092; cv=none; b=BkDKZLpoqEJmdyZqHi/AwqEL8x7Urfr+EtC665oq1+X5OuFK4UfTyGS1d6vWDFSubRS9hYu+8Il7RZYr25aT1XkIf3+Lj+h+9fGAmcaonbiVKOCG95ZcYlZti5+CtUn/9PFvwIqbCb6CtqmE5ZLajM+UMp7o9OVzTibS6FtGU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745092; c=relaxed/simple;
	bh=IJylo32d8+Pz7OvO2NJYwcN+sWaBEGNEfF89JNYCDEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxcIa2scp1ZQbas3tsDJ9+FX+5xWi/PnAsEHFtpER2gl6m/Ld4kQ/5uf61InzZnkw/kDMnEk/2Wdh8UiAvVcgj8JgVctv4V2TJwM/fVFRfFlxwPrN/cdtpoOZWWOfN4vrA0LzsiEQYQKmq0Qea/gdBjiL/FoqsuwVHMcSIVg5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC3/JaWf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC3/JaWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745091; x=1796281091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJylo32d8+Pz7OvO2NJYwcN+sWaBEGNEfF89JNYCDEw=;
  b=aC3/JaWfXw+WP8S1nrteD5eh0xjpH0rc9HY7PpamAk8cWwSe8RMlRuT8
   2yy3cf4XAyclIHr3/Ycm1Y2+piRplSfyAF20WXPoOlOxILp7r82pFP94X
   VqwG9I2TuMFoS6iBmH15Kcg4fp18j7xPr+1TkqfPKUIKpHC+l4H5Za69v
   uY0SmsCmsdLpR2/Qu7Cf1SY15ZDaeE4Q+ZZp1JKBaa/X0CYugQBYdC6z4
   dz5++E9xjIvGo9JEwtg8NVkjKdkrJ6sPA+zWvgoKpBARIdqFJAu8zFvGO
   ucIcWQUx1KrJ2Ie6hbpN0i6qlz3dkFdlwbmOFqjh2uJmHwonDzGgG8yXl
   w==;
X-CSE-ConnectionGUID: nNrlu98fQPaUZpKvSpuDng==
X-CSE-MsgGUID: 153npsVcSF21u24iUSa7kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324733"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:10 -0800
X-CSE-ConnectionGUID: Kx6fwX/VTDyUdsCegoCTXA==
X-CSE-MsgGUID: oxZ4/GTTStWjCUehomLsfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003764"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:05 -0800
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
Subject: [Patch v5 02/19] perf/x86: Use x86_perf_regs in the x86 nmi handler
Date: Wed,  3 Dec 2025 14:54:43 +0800
Message-Id: <20251203065500.2597594-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
index 5d0d5e466c62..ef3bf8fbc97f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1762,6 +1762,7 @@ void perf_events_lapic_init(void)
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
+	struct x86_perf_regs x86_regs;
 	u64 start_clock;
 	u64 finish_clock;
 	int ret;
@@ -1774,7 +1775,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs.regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs.regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
-- 
2.34.1

