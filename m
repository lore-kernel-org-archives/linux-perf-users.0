Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B930FC1B;
	Fri, 12 Dec 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573647; cv=none; b=UTvm4Jw4qwfAAeoQP0r1nTTDrdRlRJQ/iu9nw98UzGxab8E1+HWgcX5qJ8kNvHK+uNPPLQbKATMeC5Yu5yERWGnG9P5Ob74y5ek9jix8Ytu41ihgbvp7i2bh5EGKHq9jUpDNaoFizu1PQwNTGl9JNbXyEHr1Vbg4oY9ccKldeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573647; c=relaxed/simple;
	bh=Fi/VgyUpK1VjQOUpwAxq/WFnm7BDJK7ZbFixboClgmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEdyUeiYmNM1RmbyGTCKSNg9pmuhcNUefKQjX658BPI9etR2ydFBOQqGG6NLAjQmAg+hmO6bBZ9zvszXRQ60DoHZ+ALb7rgr26Zr4BZs6a+AR/fj2x/xVyFTLVVm+KdP24koXouWMjfcBa5MHednDCH9LCEXSsfHzyHgXuCRKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGCaXWzn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGCaXWzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573646; x=1797109646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fi/VgyUpK1VjQOUpwAxq/WFnm7BDJK7ZbFixboClgmQ=;
  b=KGCaXWzn4t9zEMMqY0dQZC+T4z3CErkAj7VFi+yaxm35m7w5U0fPt6/r
   OWGf1u1D48PZiHtkY51vLin9f/nA2HdFreMi9Auf0d0Le/MRrDajU0if1
   ylRlxjKk9+Zo4Zr1Jnn+iPC8kNqLJgWBaV/WmMafp3BNR92Zv3KB9q6Mi
   gfXWqdGyJBbsTnlXAuGyNoYZgaHwziV+eK5kr76pNIKNfw6yX51b1bq58
   SfsUWd+wJOQxAX2MRZ/NvSWSI4DSxRH6GcAGL2p41zGZ3Rz8j+Kq96Iqh
   VYaKHl0lBLZ1cuxBby1MhNfG8hMJZvlYZDCOKV9zMysA2Zwlpgwq3Re7V
   g==;
X-CSE-ConnectionGUID: IC7a/LhjSuC7HBnAufz8YA==
X-CSE-MsgGUID: aU4ZtBZiQ7eqdFFCMlF/MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333599"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: tWMgA+noSpivbkGN8G/Baw==
X-CSE-MsgGUID: uxoMwpAgS9iRwJkPMq6bxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269535"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
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
Subject: [PATCH 6/7] perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
Date: Fri, 12 Dec 2025 13:00:06 -0800
Message-ID: <20251212210007.13986-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210007.13986-1-zide.chen@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
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
 arch/x86/events/intel/uncore_snbep.c | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e5b95fa75313..8068b9404ecb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6760,10 +6760,72 @@ static const struct attribute_group dmr_cxlcm_uncore_format_group = {
 	.attrs = dmr_cxlcm_uncore_formats_attr,
 };
 
+static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x1, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x2, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x3, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x4, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x5, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x6, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x7, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x8, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x9, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xa, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xb, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xc, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xd, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xe, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0xf, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x10, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x11, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x12, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x1d, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x1e, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x20, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x21, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x22, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x23, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x24, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x44, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x45, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x46, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x47, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x48, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x49, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4a, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4c, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4e, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x50, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x51, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x53, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x54, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x55, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x56, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x57, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x58, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x59, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x5a, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x5b, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x5c, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x5d, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x5e, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x60, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x61, 0xf0),
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
@@ -6775,9 +6837,21 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct event_constraint dmr_uncore_cbo_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x19, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1a, 0x1),
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
@@ -6811,9 +6885,16 @@ static struct intel_uncore_type dmr_uncore_dda = {
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

