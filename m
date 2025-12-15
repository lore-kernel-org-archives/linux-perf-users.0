Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9F2F363F;
	Mon, 15 Dec 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823567; cv=none; b=XXJKul7OOQOiQjxZuOJQzfuEMoKvwHNfxsQGgcqw8d9+BWHmvh1a+5HKPPVF682FF2zxVAkI9BlzezNAElbtlL0z284Bp/Slrt2jyw0NPCG8Di+Vxt/4RswIjclg4IM4Q0PqJ83uVcDAzutPiODg1hRw9woTbfCdv5gskYu69N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823567; c=relaxed/simple;
	bh=aRTWzgBY7ckIi+FjZP340aUZwUJV5x7TVSHyf1hbOmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvuBfVqnnH9KkHo+kuPOD2V575/ppgA5CS77U536kEiUGC75y+7/vY+dtevqT0zyBhI8DGxo7+vjPQ1BbvtQe/NEpQYw3oHqwOArU7dlYVdJMd54VzamPKWfyN1KV3ZST6YqajvxzyRs73ba9BnQ2cMq6t5t4cO61IE1N+OdtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clQhFoa+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clQhFoa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765823566; x=1797359566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRTWzgBY7ckIi+FjZP340aUZwUJV5x7TVSHyf1hbOmw=;
  b=clQhFoa+yj/p3/PkFiBoO1WhBnA6cDNsiSM2Zfirb4ZRzVdoIapU6/GZ
   Kr1XBT5WooMYo4LbBVjHwMSGZaKzEMTn4Z2Ma8fNd1g804TNczu6ow45/
   QFuSwsj4oO0MQ+/FYfHqOPpK1U25ARihhtXFXOCSAQbo98TqHv2C3nlk1
   hXFTpMqDjQ2lb3jAPaS5ZzTAtIhv18imC+sEqhrGaMao1UqB082Hfu+ET
   /8+NSFEPj1Ts2L/EzYKtEoYva3VL7brf3R4qgeliq6ej8XWEZFNxoZAC3
   HIndmLz+6C4HDswvbfS7m/B4wvi8XDzzfwFgcb0oW4LwW58NjyXRGjHM8
   Q==;
X-CSE-ConnectionGUID: CpB6e/fATJ+DaEPZClXyZg==
X-CSE-MsgGUID: 5oCL3TTaTRepVBJ3Cbzy3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67697567"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208,223";a="67697567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:32:43 -0800
X-CSE-ConnectionGUID: P1iP/0kyRLy3jNNETFObbw==
X-CSE-MsgGUID: u3bKziJKRxK9pwZHRsKYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208,223";a="197547948"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:32:42 -0800
From: Zide Chen <zide.chen@intel.com>
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
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 3/3] perf/x86/intel/cstate: Add Diamond Rapids support
Date: Mon, 15 Dec 2025 10:25:20 -0800
Message-ID: <20251215182520.115822-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215182520.115822-1-zide.chen@intel.com>
References: <20251215182520.115822-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From a C-state residency profiling perspective, Diamond Rapids is
similar to SRF and GNR, supporting core C1/C6, module C6, and
package C2/C6 residency counters.  Similar to CWF, the C1E residency
can be accessed via PMT only.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 008f8ea59315..1e2658b60d91 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -652,6 +652,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&icx_cstates),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&icx_cstates),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	&srf_cstates),
 
 	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&icl_cstates),
 	X86_MATCH_VFM(INTEL_TIGERLAKE,		&icl_cstates),
-- 
2.52.0

