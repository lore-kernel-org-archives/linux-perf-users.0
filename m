Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940045;
	b=qeQTy/0sKbYLqoHr32daIAHffVf2kPEy5dcix1vWpNvCid61zKeI1SZ+Z5Zv8P6sIQSL
	 q+7EyeW9grxIXvFQwGvMKbbTdLBHn/quQ2bwP205YvYk69Io/xLFuw1EY8zPavfyBf6HB
	 W7QGne9l06+Y0v8B6MtZfCik/FVrPfb6SC/GWaklFgwEzDU22gt1r+haea5/uuJ7lpQND
	 fssrT4pzSLjoenB2jE6CeyaaHegW+/K58zT8gvI0Brby6dIRIY7JIk5yw45p3VwvcwXO8
	 STDhuNopeK4TAzKY9IhdPY1zMZQ3iD2pconV4wJuXyNZNbAzdehh27t/VFhYnRmljkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3HUftiFOF3OBc24U5W7Xe0WIBZTbmiAvlkYjojqBCCc=;
	b=hz12aTZw47Vx54WZwWDNiK5GVFng2Sig8Nd1M5AJh4XQsevcE3HaXa1shM68/LQSa/y9
	 tgpi63mRsHkf86gVkTS5ubPjuXd9uuZOFAUQzh8IQ5Jy2z5fsR4qsFZVjfG6ps2o1oQk/
	 RsbRmP5ZNActR/ZyfsxZoQBpQVbp2bG8O28anJW8hfQR2eVuy5zYKtUPrgmSDzzVHGV1k
	 fewHQVxlhj6XGbYalXmpbg7Vk6TWT0tOo4fZQhJQNkMDBarYJsGkIlAe+PXltoA02Rsg6
	 QsE5OoMOuz6vtoDD5k/OoI96MDoHvxPKDA02peEVPdA/nCeM8+5sS6xa2WGOxKEQgew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PokzaCqm;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D566606A326;
	Fri,  6 Nov 2026 04:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D566606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PokzaCqm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940045; x=1825476045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIhHQ/9T4WKg2B/c0xzLULWNKVcsx/n59dUo/756abQ=;
  b=PokzaCqmp8nPBBrDYZ/fWAjdoDERbv61Tq2J89Fyel+vg5JTXZxMLMmb
   w46ZDs3MqU1SssCkUyl0zY+mMhPFdbNcwKO6sMjtYE/uMlB3l8Azali5x
   uKNYGxjRlhrWfWkApyFP/mVudNx2h9QGYJirUlXDtdbGkTUJNJ2Ykti1I
   Xmew0dJe8WT5qFB94hvs74cH+kX41jE6UZasdYFi2AIQLEkC8wvpxss7v
   m4Dlj5YvKqfSw1kcQ2Kn/MkA6Bn+q1NHrHadQYSoiT1s7TjzQMUk80QHC
   3MFGxtM4NpwPUO/InyKx25cuIogmgekSfmEgmAQFEPiT0fZgSdhmyePqR
   A==;
X-CSE-ConnectionGUID: ChD9qZpURAu+ayIxPTlZ/Q==
X-CSE-MsgGUID: /urDasA5SyqAjnYt/4IX2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780744"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780744"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:40:45 -0800
X-CSE-ConnectionGUID: ulxiH1fpTQilTvtgI5dAVg==
X-CSE-MsgGUID: 3ouKGRYbQBiBMNMx5VC7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222812"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:40 -0800
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
Subject: [Patch v6 01/20] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
Date: Fri,  6 Nov 2026 12:32:38 +0800
Message-Id: <20261106043257.842864-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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
index 4e344fb1ae3e..82d9b0e5ad1c 100644
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

