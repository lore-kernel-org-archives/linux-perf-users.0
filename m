Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249268;
	b=ZZy94YiWNKESwSgnL1RzLsd5wwYEaHGFCh4s3hSoG71yPccbTSQL9PMjADvXFZR3wcj6
	 pveBrevieMcv3Nwn1umb83oIhwwKvpgKdWwuP2tc6Tsx8ro72K/Xz4FqU8Jo8n94I2mX8
	 8EWLnsXamFBopoPQwSxUnBOvmHAXKiv2iY3f4zxNqTfn/Hkl8TrWtTSAuGvjx2xnHy0qo
	 LoRdnfzcyRqHvGopAwawCpZZlgbe3/qPlbOUdv1lMFHFKXPq04VQuhEu0fT/jvOBjX4Kf
	 bNu8/jWazJ8agb0QpqX7ctVlyXmfozZdfBHLWBLVnh9d65Jsk1ejtv7R9eCLXbs+PZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X4Rp5v7nf12kt4D+sYe+LGdjY0p/1zEfBTr65G3+gT8=;
	b=4zmY/D3z3z+lPBYX+x+PAk4JiqaBKbLGAckclXZvzrHvpujRJWWmQPPR2u2xNa1MmP1a
	 cfLyx+9+yfvGXlWyc3Cr/KOHZG3Nx+4JmDyLYTeQ/lGF5bHtHSY9E94RGEXPbBmzZR0D1
	 XnY9iUQUJQtQcZ8Hm7Hq/dczG4o7Bi+Xpvrqnj4he8m6B7zkHB42Nx0/Oc148BokSG6WV
	 rYa3mLOBzl6uq1AOhaG+5+RsGP9Yz9Y3ptginSauZtcKGMp2FUiK8JlGfI5Xq2y8RtmX6
	 V+WZLsLKBnLnqHNfTBJnJtpV75Rvxmr0X6WjmmTeLd4qCBoq0jKAPsul/xYg30vrIxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WLey8huW;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381C606A330;
	Thu, 29 Oct 2026 04:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2381C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WLey8huW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249268; x=1824785268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVmih4eK212kSDHpWcpk99CvytQMhsjvmQYcG0p0YBA=;
  b=WLey8huWTfXak3z2KzwPdrBBbBN35uv4LQMZGBUn619VhamLCtGEW2wq
   L6x7dPp2WSImtIAJuAGNf+cmWWVpgG0dyK6ejtZz0WQmlQyNC34LynY8U
   oBJ6YopdnUHlZIYWa0HcQZTW/3vA9cOGplIz2DgDCSJFHxHQUMuJFKw4P
   2spal0efTb79hxXV7JYkXaFYL6hUp3ItPzLphpD1dQD9jzduOGI6CYJDL
   +8IrwYG0s+KznvBEMamhhA6dsjS0XDtOBsBZJtiQqFzb2LZIkfQNgVSsC
   G/t00VsU4mTjfVGKXnqR230gNiFXQ1CvdJM2u8O5wGaRYeaDqelD9EC91
   A==;
X-CSE-ConnectionGUID: rIT59sFNSz6eqXhqqrhxiw==
X-CSE-MsgGUID: JLZdU6PaRHGWPl5ALLC67A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986328"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986328"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:48 -0700
X-CSE-ConnectionGUID: pqEGzak+RI2JZ54BKhsyog==
X-CSE-MsgGUID: ITDvuTjyRj6xqc3qj/xVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420567"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:44 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v5 14/18] perf/x86/intel: Account arch-PEBS in lbr_pebs_users
Date: Thu, 29 Oct 2026 12:39:10 +0800
Message-Id: <20261029043914.1395147-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lbr_pebs_users tracks how many PEBS events are currently using LBR.
It is updated for legacy PEBS events, but arch-PEBS events were missing
from that accounting.

Add the missing lbr_pebs_users accounting for arch-PEBS as well.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 4 ++--
 arch/x86/events/perf_event.h | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 790580f96040..2c9c9cf42e94 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -618,7 +618,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users++;
 	perf_sched_cb_inc(event->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
@@ -689,7 +689,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
 
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b942a445038..82e0c20e435d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -2085,6 +2085,13 @@ static inline bool intel_pmu_has_pebs(void)
 	return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
 }
 
+static inline bool intel_pmu_has_pebs_lbr(struct pmu *pmu)
+{
+	return x86_pmu.arch_pebs ?
+		!!(hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_LBR) :
+		!!x86_pmu.intel_cap.pebs_baseline;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
-- 
2.34.1

