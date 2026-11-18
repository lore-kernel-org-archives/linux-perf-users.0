Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972232;
	b=HfdzJuOjl/2oJMWakG+ECbYpNn5Xdx2pKmnSati0Y8LgyL2SRvWQKvk5G+UQdZWuz5tF
	 Y5IEWUUjbdnVhBEFA0hiV8rghFyyXaZKIIXFyv7p6Z3/RptUmB6oUC6GOWTGa+XdZZma3
	 sGtOHTi8EOPBUtyHsGEqHotR7LoDVEcVja8LcnyGK1KMy4q9He7wS+ifkGOyz+I3S5eJb
	 NyBJSnJQMfKBt4HeL8eP4+lP5vqTl5nTJKEkai96rOZvyi+CCQ2YPoV6AKzcjERLYmpqq
	 RQvHRAKq9yZqPrWbwn3QUUToIOZYd08DrXO/4v4C8siphSfHXDEQ3OhQ4UQyXPLPuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OOxXHYvrMsWKqg1U3DyreV+OItOVCWFfzjCkL8Fbmis=;
	b=dE1N5fa5nWT8DrpDCREBRjda6p9eV3fSw0EMGHutQWU+apYpMQLFH45GokxZiPQGhPut
	 DuMnskaJZ/OQEz9OknMVdOctxihvs5zxYtQY1TUBMemJrAxu+tl3r3oGUVa5v7QUpNc83
	 DBaJLnWiCYY+7QxWo5MBTY0/V6gSHtK9pHFGbDM/UqSgff4rid5wm3dAUmxyKP3ZhmyzE
	 9GgvreUyIgPptxRQC8UZYc6GHGtAxW7FuGz+DecXFSYbga1xogAbnmWiunEUakp7GnqjX
	 aT+shanfmakgrSuL3bxgS7x7IilEEoO5tq65T/X0uRISDbUNG3H3PKb8TbGFXPXaQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWg53rey;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B9606A8B5;
	Wed, 18 Nov 2026 03:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 813B9606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWg53rey
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972232; x=1826508232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fFkU8Qc7GUXQUHtmbuiNq0ZHt42WBEfkwp+Dae/iYUE=;
  b=EWg53reyDBWNETXv0YqIdErs6H0btvzZPfsHQlGvuEVxJeTJ+pi/hAnr
   slSGvq4t9pNK09SX7oQTPjKA2WJIjRSJ5L+NiU+9Rapdw4ygyLtpemIYo
   HWwXHZojVrosrcXIRLJ96WwvNkZfzKH4Xr4WViIl8/fAKeIQ5LeK/Llqj
   FsfgqCwAlktxDOksl9fOuWT9W2jVi0QEmpomnzBrqb1xnbHDUF1zIuYL9
   CTDMoaEJKZu/zv5BhWC3rPeYuHc6e7MwvtRLy9WSePcqyMOFAJGr+4cJN
   hB5HMJOGToDsOni4KpYJnghZWtIukaHvda5dzMPK3sNL0zAMvGKQMN7k4
   g==;
X-CSE-ConnectionGUID: nwijRD5NRKurJtbsQklRFQ==
X-CSE-MsgGUID: MWxvY9zbTMSJIpw642rqpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629940"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:51 -0800
X-CSE-ConnectionGUID: NY+5fMEuSAmKZdUFJk3axw==
X-CSE-MsgGUID: zk6G7KyxSNihelvH7XTVeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894285"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:47 -0800
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
Subject: [Patch v7 13/24] perf/x86/intel: Always snapshot live hardware LBR state for BPF
Date: Wed, 18 Nov 2026 11:14:42 +0800
Message-Id: <20261118031453.1353625-14-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() is intended to capture the current
live hardware LBR state for the BPF path. However, that snapshot is
currently skipped when all LBR users are PEBS events.

BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
no longer a risk of clobbering the shared default LBR stack. Move the
lbr_pebs_users check into the PMI handler, which is the only caller that
relies on it, so the BPF path always snapshots the live hardware LBR
state.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 7 ++++++-
 arch/x86/events/intel/lbr.c  | 9 ---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b560f2e96848..84b134bb91ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4072,7 +4072,12 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
+	/*
+	 * No need to read the LBR stack when all LBR users are PEBS events,
+	 * since the PEBS handler updates it.
+	 */
+	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
+		intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 
 	/*
 	 * Keep the LBR state frozen throughout PMI handling so that the PMI
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b60719adcc1c..6c7123c1f9ae 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1042,15 +1042,6 @@ void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
 		return;
 	}
 
-	/*
-	 * Don't read when all LBRs users are using adaptive PEBS.
-	 *
-	 * This could be smarter and actually check the event,
-	 * but this simple approach seems to work for now.
-	 */
-	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
-		return;
-
 	x86_pmu.lbr_read(cpuc, lbr_stack);
 
 	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_counters);
-- 
2.34.1

