Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972254;
	b=j9ZQPKmfhsfFDtpTrLLikMu1hiwbIDyizwwgVC7rdZmspTcMW1+4olxpUW/0jTcTedl9
	 VOoVXbxByOPG+Sr88O6DPbOszL4PaY4JXmKM9aVpsNTfGT/iOhojE+DxOL8V1Sh33fVdh
	 f6s0F/iffDuas2uLiXNgEPiQz7JpoTb36Rrw4w7Aip+d+UZ+e1F4+D1nI0jZ0IBiAWa4Z
	 57bEFyokpB9jAjwOhkdRSfgK6iiKIO4gL6cbvgEheqvwNaiku1xoXb+xqErwznHPDRTSK
	 oBHOdxUzncORrIN5j1T+ruHx/O0+HAvkpmSgneE1STHcEt4fCdFsbc22pDmts2UcvmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972254;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oV+IIDpK5tI05A8Du6BzRhsI35JY/bRV8Mh9TRlzCng=;
	b=nzv9f6sR4e5p9DNWz9+Adycyag0u6NcJtVlG8ausW+J8FI3yWm8XawGzHUwJQ6AmAghV
	 gUGVfJBa6evDN0Wj7jdhn6KvzMi9Ibj0T18aJ4B6HBcau1CKDZu/0o5SfuMj8n0FQFQO4
	 CpyRt6rbUWX5im/saMuZlfxc/OSHEyITqWEShDbgCaLuEq/0MaEZsKM69HLQB5oNiANZ8
	 t4YxPDRp8WSCFsQRyvNr8OmdevjOMTmBf1KboyF4Xp5z820pJt7u0kRuJD4kNZCCM6lxF
	 20ap0KxKQw5j2eA3H23A7fKaEmRsM8b3x74U5orn7Q85nxy1vYDeLojX1MRMjvROqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7CXeT7l;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7472606A338;
	Wed, 18 Nov 2026 03:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7472606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K7CXeT7l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972254; x=1826508254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCFokyLp+EsScfCTAXd/Ud8hvRtF1fAXz9fNFmcrE4c=;
  b=K7CXeT7ldeMiUO7qj+SOAKUg5m+Ak1TPXb4fRGvoAxisZMmfNfD2K04f
   SL1QYfsMbA1Qf1g0GXf3pDk7OPU6z/kdyIFvJ7Y3RnvPm95pAszEMKZyu
   ISxiXUiOLN1buVXlEYlJL3fqeDyPiyheEhlDDHireq+JZsaVUlvSqlAq6
   3BfIyd92o2MLeCRoajsW3TXAhyR0gg0D+K4NqXUVQJXJ7RVOchlNrKIJk
   zJ51Ptb64iKWoVp3uuc6LqeMFv1KiQ83ienjZyIG54KyI+Y44icJY6Zmj
   bA8Ul7m+sQMKGeBohbLjeA9ksnnMcc/HasRkg8z+KkofTLHrZTskHyg+N
   A==;
X-CSE-ConnectionGUID: UZCT89a5QGSl8lgAJYcaiQ==
X-CSE-MsgGUID: SYDXnCMSROqWaIyIbAIsbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629989"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:14 -0800
X-CSE-ConnectionGUID: WbFSkYjSQNaQsoLaCp6clg==
X-CSE-MsgGUID: QNb9CDhWRFq5eZJOC1fARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894332"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:09 -0800
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
Subject: [Patch v7 18/24] perf/x86/intel: Fix draining of un-overflowed PEBS buffer in PMI handler
Date: Wed, 18 Nov 2026 11:14:47 +0800
Message-Id: <20261118031453.1353625-19-dapeng1.mi@linux.intel.com>
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

When a regular counter which is read by a PEBS counter-event group
overflows, handle_pmi_common() drains the pending PEBS records to
ensure the stale counter snapshots are processed before handling the
counter's overflow. Currently this is done by invoking the
x86_pmu_drain_pebs() static call with a non-NULL regs argument.

This is incorrect. At this point the PEBS buffer has not reached its
interrupt threshold yet (a real PEBS buffer overflow would have
already been handled earlier), and the PMI being serviced belongs to
the regular counter, not to the PEBS events. With a non-NULL regs,
the drained records are processed with perf_event_overflow(), which
charges a PMI to the PEBS events via __perf_event_account_interrupt().
These spurious interrupt counts may falsely trigger the PMI throttling
and unexpectedly disable the PEBS events.

Call intel_pmu_drain_pebs_buffer() instead. It passes a NULL regs to
x86_pmu_drain_pebs(), so the records are emitted with
perf_event_output(), which skips the overflow handling and throttle
accounting.

Fixes: e02e9b0374c3 ("perf/x86/intel: Support PEBS counters snapshotting")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index aa7034c5ea41..67275a873dba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4045,7 +4045,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			static_call(x86_pmu_drain_pebs)(regs, &data);
+			intel_pmu_drain_pebs_buffer();
 
 		last_period = event->hw.last_period;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 332754e1da4f..9fe84e4880d9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1262,6 +1262,14 @@ int intel_pmu_drain_bts_buffer(void)
 	return 1;
 }
 
+/*
+ * Drain the pending PEBS buffer for the current CPU.
+ * This helper should only be used to drain a PEBS buffer which
+ * hasn't overflowed yet, e.g. on a context switch with large PEBS,
+ * because the NULL regs argument passed to x86_pmu_drain_pebs()
+ * makes the records be processed with perf_event_output() rather
+ * than perf_event_overflow().
+ */
 void intel_pmu_drain_pebs_buffer(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-- 
2.34.1

