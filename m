Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130F3AB273;
	Tue,  8 Sep 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854273; cv=none; b=ixgt9cHYuR1LBIkhk0IzsnYZZqQiC2OwKx3vlRDoEjDNTlBqiL38X1zDK1YDnMUmRXcsgCz6l6HrL+jj+E5g7PS3CCEsMyL3y1rH/dDasbqxq98sk34BiSLaJryz2kKq5ERkKKR8Halo5SenBn6+JiynQsvdyd6y0nVSLQoWYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854273; c=relaxed/simple;
	bh=Zj7NUrEL3uxtSk21S89eIuOY2EvO9WsDM9rGeOWXTwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BpwbCX7yN4vK7QCcsjhKF/RQy3jn6CZDnaaKZVrVkR/TGx3WlsnEAG3X+8Qbxea8JQkeIs6pBtlM6UkN7t+mPkHlIrPlA5TO83p9xcIUwYXOgZ2yMlOMl8J0+Q0N0yWfvoEzsADjWe1IEY5wzusKSdEwL7gWzoMbe40kBJHu7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6Rk/+60; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6Rk/+60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788854271; x=1820390271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zj7NUrEL3uxtSk21S89eIuOY2EvO9WsDM9rGeOWXTwo=;
  b=k6Rk/+60IwAjNSf3uJmC++bbOlMGUSHJSgJ7jWWDGdig+O9RdGJ/Zbst
   exaJU5dVopmfA8fSrvErCEbFDOkC/dMMY6DJomO4YLbSGfDFnxDnXt4M8
   khO7bppO6rLSMrbD6E9FKQQ4ESltBcDOj6xsGQA8KlVBnmNsXHaJXxfY5
   uOW7xzRHD2j2AqZbl+EYwugNlTQy5Ag3546JRLzrr6UkDn7Ap7/agfls+
   xpaKXj2XHGdPGfcZOBdbVSqQpkruz0/12blrcQzK2V2kaOv2ermi64I6d
   p8AjFxxhzDyVYn1XtGRT2oqmeuDW4+5fBbie1l/E4fS8tPgk/YQ8Ihfee
   A==;
X-CSE-ConnectionGUID: Rm513JYcRs629hvyi5pjIg==
X-CSE-MsgGUID: DPlZ20csQpS47xh5NA49jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91758412"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91758412"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 00:57:50 -0700
X-CSE-ConnectionGUID: HW2lgI8MRfSaImrUdZF5BA==
X-CSE-MsgGUID: r0DUOEMoQEGjFpMSrpgz+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="266576225"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 08 Sep 2026 00:57:47 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel: Correct pt_regs->flags update for PEBS path
Date: Tue,  8 Sep 2026 15:51:01 +0800
Message-Id: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pt_regs->flags holds the saved CPU FLAGS register. In the PEBS path,
it was incorrectly set to PERF_EFLAGS_EXACT instead of being populated
from the PEBS flags snapshot.

Update pt_regs->flags from PEBS GPR flags if GPRs group is present.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8940f0292229..d0bb767a0fef 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2432,7 +2432,7 @@ static inline void __setup_pebs_basic_group(struct perf_event *event,
 {
 	/* The ip in basic is EventingIP */
 	set_linear_ip(regs, ip);
-	regs->flags = PERF_EFLAGS_EXACT;
+	regs->flags |= PERF_EFLAGS_EXACT;
 	setup_pebs_time(event, data, tsc);
 
 	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
@@ -2444,9 +2444,17 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
 					  struct pebs_gprs *gprs,
 					  u64 sample_type)
 {
+	/*
+	 * Update flags with PEBS data. PERF_EFLAGS_EXACT must be set
+	 * in previous basic group handling.
+	 */
+	regs->flags = gprs->flags | PERF_EFLAGS_EXACT;
+
 	if (event->attr.precise_ip < 2) {
 		set_linear_ip(regs, gprs->ip);
 		regs->flags &= ~PERF_EFLAGS_EXACT;
+	} else if (regs->flags & X86_VM_MASK) {
+		regs->flags ^= (PERF_EFLAGS_VM | X86_VM_MASK);
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))

base-commit: 609d28fba41e977425eff9848e553740bbf155ad
-- 
2.34.1

