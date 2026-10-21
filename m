Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559672;
	b=3BiLD+C8X/oHWB7p1N66nedBI6G/c9bSIUUPcftyvSj6/PhMPHRsv7KC7t1N9S31oXVs
	 uuoPVNRrlgiAI8yFpBrZjprznPKi1NqAa+5NcBF40DBoHUqYwsO9SsAvn2xHZnUdlXeNL
	 rDBOY/sp/kjsgxZWKZ1HB0dc8EQqcRxODyNozYysFFipkUY64OS7cC6b/RtSDgBtomPwS
	 Lo62+RHPKHn+Tz5lmGchKx63ZcLy+5GLbuN2cSjImJl3uR589s/Pcyp/Inqv+k0amn2W7
	 dV7ZMztaH2ivbqH2KoTpILZshUjWgpTW/Alw7FXtUI9BnU8cJYVJ/QhaasC8nRVKVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559672;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wRUSn4ZK6uGfwRBI+W4Scz9TcUi05NykdYX4M6juL7E=;
	b=myDlXjsu56qIRRoKu7BgS6IoX9B3i6c58ZrqCXeAE9d1YfZaFxpeDa02tSuXlcun9X1g
	 gILhyVVL6imgNXKGoQ+Xeo0iHJJrcP8gTjakcT5SCUc0F5r9HPrNpuGxEXSrkiGEaRySh
	 c10zWyMKIntjMgS1k3VTJGAQUGfzJFGxGuD+Gwta7JU4xDJsO829JMGfrSTnaIs1x7uX1
	 ktdGEKTlJ2cyE6ANg/clA2dNQ802GL/Zojsk8ct4DuM9abL1xdbojqemnmC6ACvq78kVX
	 I/0yxXhSC3Pkd4eT1gaNiS6AMhTldP3HbfHLjPbPUGQ4LlTU9Y3gb0dG9EAqHT0PX4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iW/LQ/FL";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A864606A31D;
	Wed, 21 Oct 2026 05:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A864606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iW/LQ/FL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559672; x=1824095672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ztKI29W1PhDQ3lV1putQ6PjnfM9OSri+lPDUzGiNsmo=;
  b=iW/LQ/FLRLSSiK+EdeID6ymmbiZIR5SdBzACREkX5LKY/wgu+I7oRgKC
   XNNTph5mUDwGpIW/phe7ausFUdLPUVpWiiVL1ZAkChvYrIAwVCeOJCfHS
   QVXiFK6hDo2zW6y3ksu0yvX9gol/Qj0kCLScuxCQallgxgCJHsG/MvCR2
   IcwNHiWpqc8KBYZcPxLsWntSHUrEmncyyVy76iWsauGRi0BB+meKG6HAR
   iq1eAf5b4PnVOfTa4k51oT8RhBX6JfxXaIJkzsVE+p+rc2kdOvCc4/0hg
   DtgUNkM5iQadoOuaKSshwJyJl1G+UjToitxJQiGRFzqe9hTX+spK/D+oH
   g==;
X-CSE-ConnectionGUID: yLAOYJYrTd28Tp8jM+WeJA==
X-CSE-MsgGUID: /E7y9x8FQyS8Qv+W1up3Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149159"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149159"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:32 -0700
X-CSE-ConnectionGUID: IGXf7RmDSYOmMwByTcGH2g==
X-CSE-MsgGUID: LTNxAz99Qc2h6Qur6UWUOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947634"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:28 -0700
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
Subject: [Patch v4 1/5] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
Date: Wed, 21 Oct 2026 13:07:07 +0800
Message-Id: <20261021050711.4043703-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
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
index 4df792b139e0..002a04c149c2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2645,6 +2645,12 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.config_mask)
 		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
 
+	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
+		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
+			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
+		x86_pmu.lbr_nr = 0;
+	}
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
-- 
2.34.1

