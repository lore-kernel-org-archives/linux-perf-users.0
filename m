Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940154;
	b=lccKYezZzRDjgMam7OmzgKlUQ3eEONGaznPz/WyKe+L/q4nRzYJE9JCESyBuacYZ66xt
	 7INAC5gdhMUEB/RVjvlD8WmLqowXPJxK35MKaYKyOKJs12zvDTPmsv7zQdMWTcjG6/37t
	 H1sJK6q9iiCewNvcjDuX8hBOh/T816hDlS+ZsUUnixwhLTalBs8Cl7QRsdYSr99jqPqfg
	 Yq32sKo9dpAO+/iIrHO1ykha5HMSw3EsyfHbte4+VJgpecyQDbgiP8x0HaaR2VE6vtSAS
	 JE4wBn8penwbqxaNnWNIXMt68KiOnk3RJmgB1JHEAFEzOtO82XBaLND9PvNQGmDN+Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940154;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jc9H+PvTMIIpUebqTHZZD6M+bJPKsXGhCGcp6ywcIpo=;
	b=FQmsN6VPtbkTZGTjQLz94eqiBBvcZLVofqOlb+lNkruZHl2WalDemyt2y94W5tQSSQFi
	 MDdKjkHon7X3izBuA6juu9i4AS1tuZrO6Xmf2gucxN6kqkN6EPGHFIQjHSnIYrr299LeS
	 x1Ac07YVSD5rZCfqfjm2XKCtyVhSIKzIjdGnR6dG3vM3UahSQtgyseVbAxK/jHyx2m2Yp
	 oJDxvVNHryRaFdLaMd8drecsb3yFphvyvsM3Gp1r39h4NH61uuL+XUZ1fOuYkfbTGr9EF
	 4XK6SMX6c/03VVm6jZH4YoGVPhkDvECMgOOLhv1WeU8Cm+OGOxNPJK5D9tDCQI4Coew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwkQYnLc;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C286606A326;
	Fri,  6 Nov 2026 04:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C286606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwkQYnLc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940155; x=1825476155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03fqwDOoRNAgguvUT/euZ2vAcKijtm2gowGoBD1EGM0=;
  b=UwkQYnLc70qt8YvfGv8flx9Nu9MV8KaiSPPEE1/yvsyJ0uWexlB8S8zO
   8jER9X/+BwamAvosro3YjH/vKIL5Pv1xPPH2yLfAJJDdsud9dUNVGpax2
   vpSZAz+wtQCrLfREdb+FD0JWKslesYzweXm2C1bNkCXUnj9S+PeiX11lg
   CuafaO7br8uudk0c62PDT8ZerAwDWoSxmQuPsnidBoPX6+lBjZmH9hKLY
   5RMQLcSLfH8C6XFyGkCLwiW32XU4Umn32+KhGlTYaG7kwBROBchzC1HFI
   4bK6UMqOY8SSvLqgfRC5epcx1gGcfFElZDj3hLsVnJTuUdYI4ZQZ7raWB
   w==;
X-CSE-ConnectionGUID: qcshmehETFCFtBGn6LKASw==
X-CSE-MsgGUID: /NnZkU2ASYSxOI9eF2sJzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780887"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780887"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:41 -0800
X-CSE-ConnectionGUID: IU1BBwC+RFaCaIMZ5VxFug==
X-CSE-MsgGUID: WbTwPYFxSRKYxGsLW09F3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222987"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:36 -0800
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
Subject: [Patch v6 13/20] perf/x86/intel: Always snapshot live hardware LBR state for BPF
Date: Fri,  6 Nov 2026 12:32:50 +0800
Message-Id: <20261106043257.842864-14-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() is intended to capture the current
live hardware LBR state for the BPF path. However, that snapshot is
currently skipped when all LBR users are PEBS events.

BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
no longer a risk of clobbering the shared default LBR stack. As a
result, always snapshot the live hardware LBR state for the BPF path.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 7 ++++++-
 arch/x86/events/intel/lbr.c  | 9 ---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a3aaa98108cd..fbde874af618 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4070,7 +4070,12 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
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
 	 * Do not clear the LBR frozen status here; keep LBR frozen
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 979b094ae228..27e4be839926 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1043,15 +1043,6 @@ void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
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

