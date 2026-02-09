Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2231770B;
	Mon,  9 Feb 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621895; cv=none; b=MMhyg2WkiZQNjl+2uz+GvSvpRwQN5oreuPREDPMqr3U/MhgNfhBj/2srzlKVZLPIszE+aWu1jznM01/QmUATB+CXktU3s/yb+C7M460gHTAxX7PeqCs+HA3DT6J7mTTH2Z3xzfCMOedR4FeE0FMhnjiM05AhL5tMdTS/sZV/bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621895; c=relaxed/simple;
	bh=Cq+Py8qfBn01PCvh++AD7LhREt2xWkW5h9nsyAnf4xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyj07UM3Kv9p2Eyow8zCCvlBYrR1DbdyzZLoEkliHaqIvuclPcAyU85WKLmhigRyqpZuFr08bUCyj2zkwxQilOQkQPcQ42N1acJr8kZOhGjGFUXbQ671mp5Tib+BKpYDcxwZ4f08Bc/SvRODf2N3Xj5x6DSxr8iGVyQXhM2J3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRgSLOPV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRgSLOPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621896; x=1802157896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cq+Py8qfBn01PCvh++AD7LhREt2xWkW5h9nsyAnf4xw=;
  b=IRgSLOPVpaQZZF1kANh7y6kY7C4qipvJ4rehZOspaMncDeyyGI3rw42C
   hgfCRICAbdFdc9jS97B1UE+su4JEE3t2QK9xvyUMwJEi1lnvDSGWkhmP/
   3spxwksLr8xtG++GyjTlp0VtfGyKsVYuyn/prYBo/CF8QGPlpX8gZrY2w
   FLFHAFyeChJnG/mUkKZ8cDRg9v/dpTLLivs4GYaDDacuSqz1LNMRsV0sx
   VMaujgFlkx3rUDqcGKc33HKwU4Fd3NZnhl1EG/1LVtz01/RGh4nURiT8d
   +jxUrZvqP55cWp4J+tOkLxhPOjPzpTlKGKLIkuwlv5idc5hb0miytAeFu
   g==;
X-CSE-ConnectionGUID: CpsDo21rSZu6IsP3cDfxZQ==
X-CSE-MsgGUID: Ehc7JZZ2RQi+FfQcIh99ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098228"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:24:55 -0800
X-CSE-ConnectionGUID: NY5L17SkT1qze+7aWgFSkA==
X-CSE-MsgGUID: g1HHoSLFSp+hdDPUEt7FKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694582"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:24:51 -0800
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
Subject: [Patch v6 01/22] perf/x86/intel: Restrict PEBS_ENABLE writes to PEBS-capable counters
Date: Mon,  9 Feb 2026 15:20:26 +0800
Message-Id: <20260209072047.2180332-2-dapeng1.mi@linux.intel.com>
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

Before the introduction of extended PEBS, PEBS supported only
general-purpose (GP) counters. In a virtual machine (VM) environment,
the PEBS_BASELINE bit in PERF_CAPABILITIES may not be set, but the PEBS
format could be indicated as 4 or higher. In such cases, PEBS events
might be scheduled to fixed counters, and writing the corresponding bits
into the PEBS_ENABLE MSR could cause a #GP fault.

To prevent writing unsupported bits into the PEBS_ENABLE MSR, ensure
cpuc->pebs_enabled aligns with x86_pmu.pebs_capable and restrict the
writes to only PEBS-capable counter bits.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V6: new patch.

 arch/x86/events/intel/core.c |  6 ++++--
 arch/x86/events/intel/ds.c   | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f3ae1f8ee3cd..546ebc7e1624 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3554,8 +3554,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * cpuc->enabled has been forced to 0 in PMI.
 		 * Update the MSR if pebs_enabled is changed.
 		 */
-		if (pebs_enabled != cpuc->pebs_enabled)
-			wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+		if (pebs_enabled != cpuc->pebs_enabled) {
+			wrmsrq(MSR_IA32_PEBS_ENABLE,
+			       cpuc->pebs_enabled & x86_pmu.pebs_capable);
+		}
 
 		/*
 		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5027afc97b65..57805c6ba0c3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1963,6 +1963,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
+	u64 pebs_enabled;
 
 	__intel_pmu_pebs_disable(event);
 
@@ -1974,16 +1975,18 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	intel_pmu_pebs_via_pt_disable(event);
 
-	if (cpuc->enabled)
-		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+	pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
+	if (pebs_enabled)
+		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
 }
 
 void intel_pmu_pebs_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
 
-	if (cpuc->pebs_enabled)
-		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+	if (pebs_enabled)
+		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
 }
 
 void intel_pmu_pebs_disable_all(void)
-- 
2.34.1

