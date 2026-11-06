Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940080;
	b=zOLxIzhwOI+JOZmL1QIcxZM0etM6mZw0BR+SOKVX76LukQlmJE3JCzKI7sh16bBCzL6x
	 JcllyYUKmVezj6BnFiFvGw8ZmF5w4yIzC+X2UAfKh2eXpb3/7ke4Zwx+rboXzlHcMtMcR
	 z4Hd9hxYlp8i8C9SdDUx/cBfW/hN/g5RnZ2q1MW0kg73WjCORegQ3bU94WZNY+qyQR3Fh
	 viH/wPESx6vcMSBBCW+8TXkfG+jMyrfoLlKY7H/cIsQIkXGeHIiDYBcy7kBjQFJ1EGFEb
	 FQr9VSK8lNKUbo3OqiyGMSEYS+hUTCBSY3aIodskVWRIGCKr/nVC2N+VlUt35pLxf1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940080;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pygvn842jga790SjY8o5kVq/R/0MWFQ+kp9cGyq7BRU=;
	b=Eh/F9e7umRxnd+Muz9AYXKV26VpqwBwqjK2VAVhJSNfdzaGHxdSpLifO7j/+rMza6z7Q
	 UgRZM8DkbSSKpzZbooi/ThcfJhIwqT93+XDjm1md1gwYAiERjojsy9Dt+VsPAUOPMye4N
	 L3vVZc6xsh+AK0WhqaamWUNA3EPru8E54eVnaSKyNZ5v1p0pJZsHSmD28oSXPv+K5vkwD
	 f26D3wD76qqJjuNg89x/j5JNIajNZghUQc+DT0SBy7gah0AxxuBFqY2qvQjklhbAZTRoD
	 OSmaevCYsgHOUG6pfy0c7bLl7zH8hgSwCBU7ca5TPB0kayMpO1PARoPdaAqCWifTQ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I8lMQzul;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD9606A33E;
	Fri,  6 Nov 2026 04:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40BD9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I8lMQzul
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940081; x=1825476081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxqY63QgkRk72t6lSQXhuujIjk0eIxq8JszEtzd37dc=;
  b=I8lMQzuldWYd84zKjW+bnM3zSvfHgXnGVy7QbsqnAkOLevKUmk9pxjzH
   Lt2JkdgIHPcW+D5GkIoXuSnX+Uq6skm7B23CdUJxD6DgA2pF+AoxAJW03
   TK2b8nRhLKhWEEEARgZeeTxJLUVn1WdGZh73CFKWiYqnHJD3dcqn6099P
   Xg3Gd4Xnfl29GpZCrEh3H8lgzwwbnrMCje7NWuz2kIa09YjoKhDDCoZyq
   nVKkbbhpNxq65G0P8j3IGOGg39MqOrI9tB5ENbD4vnpqjGFXKm5e4NJ1g
   ltz3LxRNYuYnVeY4r2GFAFfgnNLJPpaqE1raSND3l44XKQ24Zk6dX7geR
   Q==;
X-CSE-ConnectionGUID: TB24zjHXQEigv1f8AHiQbw==
X-CSE-MsgGUID: rTJ5CCxMSPKngNTxi6/kjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780823"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780823"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:21 -0800
X-CSE-ConnectionGUID: Xip2gFYRRgieuVOnN64ARg==
X-CSE-MsgGUID: hEKIBCzmTIm+6fsD9sjiKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222937"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:16 -0800
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
Subject: [Patch v6 09/20] perf/x86/intel: Keep LBR frozen throughout PMI handling
Date: Fri,  6 Nov 2026 12:32:46 +0800
Message-Id: <20261106043257.842864-10-dapeng1.mi@linux.intel.com>
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

For the platforms which has 4+ PMU version, streamline LBR freeze is
supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
a PMU counter overflow. However, the current PMI handler clears the LBR
freeze bit too early, allowing branch operations that occur during PMI
handling to be recorded into the LBR stack.

This can pollute or overwrite the intended branch snapshot, especially
when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
In that case, branches recorded while processing the PMI are mixed into
the original LBR data.

Defer unfreezing until after PMI handling completes so the LBR remains
frozen for the entire PMI path and no branch activity from the handler
is recorded.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 739c454827ac..ab6261ab54b6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4062,7 +4062,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	loops = 0;
 again:
 	intel_pmu_lbr_read();
-	intel_pmu_ack_status(status);
+
+	/*
+	 * Do not clear the LBR frozen status here; keep LBR frozen
+	 * throughout PMI handling.
+	 */
+	intel_pmu_ack_status(status & ~GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (++loops > 100) {
 		static bool warned;
 
@@ -4081,10 +4087,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Repeat if there is more work to be done:
 	 */
 	status = intel_pmu_get_status();
-	if (status)
+	if (status & ~GLOBAL_STATUS_LBRS_FROZEN)
 		goto again;
 
 done:
+	if (status & GLOBAL_STATUS_LBRS_FROZEN)
+		intel_pmu_ack_status(status & GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (mid_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-- 
2.34.1

