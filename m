Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F093033F5;
	Mon,  9 Feb 2026 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621900; cv=none; b=RZbTa6+zbZRaEZJ8lSELMvFuh9IzahRqJBJbGa4k42hMuMuDnzjAsU2YtAXtFKzpMDEiMLdO60sjvPI0UaA/k5KJfrZ3gtMJ9cBBIXHkyV53muiiWBlJfndpl4KWJoJU59GffPjM2J0IP0Kzxw1qHfIn1NF8do3BsaZe4WhTRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621900; c=relaxed/simple;
	bh=JHL5STerb4I0PRzZceXpsPfRmTSSHrsbR/CuUhoQXN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJWl5S/6uOtB6tvuvpVACrXY3j1sTQOFiwCglQ1Ja4oMvaqi0M4PFy1JQKbOb3u3wmxOUi7IU9LJrOgNWowpn5/hTTIEzeFnJlFZX1I+m5PSZGGh4I86xt6burGI7drLXzMu/fzRsMO+svkG1edVWOnE6L+38W8bvNjrWccnhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFtdKnbv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFtdKnbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621901; x=1802157901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHL5STerb4I0PRzZceXpsPfRmTSSHrsbR/CuUhoQXN4=;
  b=VFtdKnbvWxbEo4spP9/pW5R8laGGZglLsGRlVTec6YODAu7M5D1dj78e
   IviK3eDUqvthj0sRTVzft4z/IKB9sR+RblrlFYyRfvguUgFQSRcCg3cip
   yvvlGWPKyKha2TDnFQERn3XTZXi/CfxpL5sU6G82MJ1aW7RM+2re7SE/V
   ph4q4dAhoPaSEv92wMOjZZuzzfzuR9CSn4XRePH5vozJ7F5hXG/KrdUM2
   Z5JkjJ/pNBP+IjbpwJh/QIb2NHkhLT4+7jPxnni4IbQaeEb6hAFXDvCeL
   r8N9lRatrPQkBrJvbKE/wjl+W6eVmslNpDsKLHq1pYLYMYyR2fWPAnAYW
   w==;
X-CSE-ConnectionGUID: PdlgZcd0QI+bdS0uOPDqYw==
X-CSE-MsgGUID: U6Ix6ahIR5uV0yu677cOkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098246"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098246"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:00 -0800
X-CSE-ConnectionGUID: OxeMcBprTCW+lVkxHhfKEQ==
X-CSE-MsgGUID: zB5TDpVIT7CB/zGrvJDRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694590"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:24:55 -0800
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
Subject: [Patch v6 02/22] perf/x86/intel: Enable large PEBS sampling for XMMs
Date: Mon,  9 Feb 2026 15:20:27 +0800
Message-Id: <20260209072047.2180332-3-dapeng1.mi@linux.intel.com>
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

Modern PEBS hardware supports directly sampling XMM registers, then
large PEBS can be enabled for XMM registers just like other GPRs.

Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V6: new patch.

 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 546ebc7e1624..5ed26b83c61d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4425,7 +4425,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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

