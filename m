Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972202;
	b=KTrisOSdgTn5VJlRLqYHC+4+4HYktQF7ehTP+6aJGEl55YQHWqbRx2XnQdfbN6jUWwBP
	 pYPafoZw+J+a53ihmljusehV/z5s1Gq70yRMGF2S4V1+eQ14vLBOITZNpFWmwP2FFNf7d
	 aREWmBEYG8h+OU7Ac0mSBA4VLKVkpS1TD1sGHyDYDoctZoyzZcfKCdMR2t/j0rg2doN12
	 bPxScmWlQ/c9uJiGOpq+0eGFFDBboJmo3yqhri3n5CyKRSOQvvxCLwnarRR6s7MoQvUKO
	 zJ7H81ZVpesVT1l18wWJT/dh5MDff54r4uiMVP7qKRBd7Cctjo0mEVXqjApimoh4rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mKNMre+4wIyjQG6Yzck6ZFZM1mMviJI768fELue6gDU=;
	b=MJsUc4HP7S9+tqoMrsCmCljISo/jRG5tRXMova3ZB0oMQ0WuoBNL9VckWDNWGqcDjArO
	 Jzlp/e7R9h8LG+Y2f1YgKxa9t7O19BT8kECMZOrY0LJrMJDOwR5mphozwoPa0hcmFta1M
	 avM86slg6JL7eamiSHuTNBi6+7XqGQaQrmwWswnXAf7IulR0Vg3i3dcmQPtmIuO92nPE6
	 S+QNNf7SRmt99q7FRDqbcqK37MJBviESckGDiQ7TyMKZUumTR+Nlgw8G4uSft4bzZ0Ywm
	 xRFKTpKGed1esiIls3eQOmP2wQQa9vrJZYl8dWUceY8wabafvLHwhAQlUSpKd1vxKrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PdI6hOc3;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC56606A31C;
	Wed, 18 Nov 2026 03:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC56606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PdI6hOc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972202; x=1826508202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQARrhlp2EFy9cJTOKFnvsbj5RuPdBRGhei22wT6fJ8=;
  b=PdI6hOc3eIMHQ79mPjp9JGOT8ZQU31+R7TX1LKXZWEVeOLGAqA2rHBma
   MYul6R2QoX5sXnIG3nwSq11rRtDTzrQXig3ZPv760MRRi7tnuUVNQj1rv
   zfXJqYi5MLZN9rKFUUR2/+hZP+fDa2vhoHFBqqCK2W7g0gcPKdTfoSkLK
   UbqMHUtxuHFlfhfKl45PHU2Qza4z1H1pScHU97CW9FaYfjF27vyrWBEQZ
   3lGuNOy4e4QQzg6Czoe1RUQPwedhfBPU7vijFwKb4+2EkSwwfcVsCig5n
   XG9Chb9EIrYqqWI78++8CyvOx6t4khfMYnKJg1fCeLmcBjWg1GoviYH3g
   A==;
X-CSE-ConnectionGUID: tO1eN21YR+yHg7Blf80rcQ==
X-CSE-MsgGUID: SoqcgkIrQnmEH0Z2WZNJ0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629804"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:22:55 -0800
X-CSE-ConnectionGUID: 3ABpd+OYQYminrjj6l+H/A==
X-CSE-MsgGUID: Qk3yWIjURTSRZao2z7TB7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894107"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:22:50 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 01/24] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
Date: Wed, 18 Nov 2026 11:14:30 +0800
Message-Id: <20261118031453.1353625-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

Disable LBR if x86_pmu.lbr_nr is larger than MAX_LBR_ENTRIES, preventing
out-of-bounds access in the cached LBR stack handling path.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4e344fb1ae3e..df3470c2f9cc 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2645,6 +2645,12 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.config_mask)
 		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
 
+	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
+		pr_warn("LBR depth %d exceeds max %d, disabling LBR\n",
+			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
+		x86_pmu.lbr_nr = 0;
+	}
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
-- 
2.34.1

