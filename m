Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E13101D4;
	Wed, 31 Dec 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221389; cv=none; b=CKlz1SgpdEhSx7YbxpC7MriQbwXfP1i603eyEsK3z7IqPB2b3WhJjresYJtM/LpZBrI5xOHPkwa10k1mcvCzDCdgQ42E0H7agqMvVvlYQLGTzTuBcrmk+6CxhQS2qwABuVpB5pSCc/ccZmOWXySXYV0DFT2ogP3Yb/kb+3q/pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221389; c=relaxed/simple;
	bh=QHNZL+mdQi06dvk7+i2k2T0L80ilBN51q0onOdur5J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4r4hzNtdpmmmwe7WDgufZJ7ALkp+tKmbyY4K6SHiA3PHmyoMEYI5DzJfvPdgNLhceFptV/GQGQxiXVE2nMKg6D6NGHu/Va/0Pn0GbdTiZ/T7HJnSuN2TAup3CnyUjNxO0U7do1LfMBOrXpCuzSkwJqNj0wOmvM1EpcHJV6WPp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK1sw2jQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK1sw2jQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221387; x=1798757387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHNZL+mdQi06dvk7+i2k2T0L80ilBN51q0onOdur5J8=;
  b=VK1sw2jQX0TuP4H1DOpGkNXNL4lbpWccjZuPmSOOM118C7Li5k44kPZx
   Ow1k1MYbzXBljPkexId1x5bP/xtq9GrX18W6KWaAwHNyNqoLkOl0jZQDD
   5lHx3ywr6UdLY8PR7qvZeJIgM8bPNkW7yb+A4zhiQE7P+wlwISPIteE9C
   aIDK0jp5qraxl7n6MduVjtXbFhFLO+sZ671lYHHdxVeZR5w9MfJHfRk3X
   HN+Kj4hoiv4+S+al+UO0RycGOOUAZA20U7jo+XtHBGrr9XG9HKTd5p+ER
   I+E8yFVlZs9VvKk2yShyI5cXntq8tgYu1WSwSHZuJ1UDI3x0dCRj+IZf5
   A==;
X-CSE-ConnectionGUID: RAlvw8ZbSTa6BbPvQVVsSw==
X-CSE-MsgGUID: qpJuA1TsQAOoHfv/M/q4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816649"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
X-CSE-ConnectionGUID: 5W4zaJ+PR82T/4OwXbCu5Q==
X-CSE-MsgGUID: Z4f9f+DTTbyerje5fO9SjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611031"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH V2 10/13] perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
Date: Wed, 31 Dec 2025 14:42:27 -0800
Message-ID: <20251231224233.113839-11-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update event constraints base on the latest DMR uncore event list.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- make use of the new UNCORE_EVENT_CONSTRAINT_RANGE

 arch/x86/events/intel/uncore_snbep.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fac2be780276..3f96fcc8562b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6660,10 +6660,19 @@ static const struct attribute_group dmr_cxlcm_uncore_format_group = {
 	.attrs = dmr_cxlcm_uncore_formats_attr,
 };
 
+static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1, 0x24, 0x0f),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x41, 0x41, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x50, 0x5e, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x60, 0x61, 0xf0),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_cxlcm = {
 	.name			= "cxlcm",
 	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
+	.constraints		= dmr_uncore_cxlcm_constraints,
 	.format_group		= &dmr_cxlcm_uncore_format_group,
 	.attr_update		= uncore_alias_groups,
 };
@@ -6675,9 +6684,20 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct event_constraint dmr_uncore_cbo_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x19, 0x1a, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x21, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_cbo = {
 	.name			= "cbo",
 	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.constraints            = dmr_uncore_cbo_constraints,
 	.format_group		= &dmr_sca_uncore_format_group,
 	.attr_update		= uncore_alias_groups,
 };
@@ -6711,9 +6731,16 @@ static struct intel_uncore_type dmr_uncore_dda = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct event_constraint dmr_uncore_sbo_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x01),
+	UNCORE_EVENT_CONSTRAINT(0x25, 0x01),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_sbo = {
 	.name			= "sbo",
 	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.constraints		= dmr_uncore_sbo_constraints,
 	.format_group		= &dmr_sca_uncore_format_group,
 	.attr_update		= uncore_alias_groups,
 };
-- 
2.52.0

