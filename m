Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703D30E826;
	Fri, 12 Dec 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573644; cv=none; b=kG6wjrlD02/2jpabVLE0itiVidwnanNd/nAFnpTIGZ4hV/hQFNt0AULX+b2ZcGfRGGn/N7tYoFRFxEjohFNV/eHWtcw9+mk2/S5VlwyrBFgF99Zx1in615zwIjt86jr1uwnGgQ4vOO76DTO0sgdVqj52jBCT2NZ89QIVEKxIxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573644; c=relaxed/simple;
	bh=z8y8gFjkFbXJNKRPL8RQIVTj/RICoiUQiZe9oZCxTBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKeHS/2AMz3Y9bKXf/KfL2WN1/42sVSUc4jvkHniu6NU2RM4pRNMXET7qRoW86DqSpSQD9yb3ip4LoZld5GXtwxX6tN96tAjMhe6V+TkatYfPPRjNnHG/gHh/NoRjVJAVmIJ86adPSITkSAwu5f4+vzdNsvRqfw9RJwlr5P6Xes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGvsenbJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGvsenbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573643; x=1797109643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8y8gFjkFbXJNKRPL8RQIVTj/RICoiUQiZe9oZCxTBI=;
  b=JGvsenbJPk7t7vIWO6DG79dZwFrR+b4j95F58+rWD9nGsXT2vISRPMlQ
   AnOi67DKZvHPGiMeQE9ZG5GIMSY8cDi3O8sdJ++tBTG3IvNQqiucEtdOk
   1FcIdKvrEdlATX46kXa86uPKpPTVBoQWYQviErMTMqhyvil5f320EAPco
   pso0DevA+o2ZJsAHL+z/bK+c9urmzvEIMo6EV3x2PmSfJkGzVQCUilJLK
   104Le0A2W9/eL1jn4tXOesSNl31DI7M17dEDblT62Cxj45ucHCVlKF92i
   GfFalcbh5fLERGvlQnxeEMtU/c6v7ezTnYRcDEn/7j8tlKbacgBb2p2DS
   Q==;
X-CSE-ConnectionGUID: ug7m9YHyTgWZCnmJ1pxuFw==
X-CSE-MsgGUID: vDqzROF4RBO9fUlR7o57qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333583"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: MIuINagYQjmAyT7uJVY+/g==
X-CSE-MsgGUID: gjzY4eNXTnSO68F3RFVXRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269525"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:16 -0800
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
Subject: [PATCH 3/7] perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
Date: Fri, 12 Dec 2025 13:00:03 -0800
Message-ID: <20251212210007.13986-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210007.13986-1-zide.chen@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On DMR, PMON units inside the Core Building Block (CBB) are enumerated
separately from those in the Integrated Memory and I/O Hub (IMH).

A new per-CBB MSR (0x710) is introduced for discovery table enumeration.

For counter control registers, the tid_en bit (bit 16) exists on CBO,
SBO, and Santa, but it is not used by any events.  Mark this bit as
reserved.

Similarly, disallow extended umask (bits 32–63) on Santa and sNCU.

Additionally, ignore broken PMON units for MSE and SB2UCIE.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c           |  1 +
 arch/x86/events/intel/uncore_discovery.h |  2 +
 arch/x86/events/intel/uncore_snbep.c     | 48 ++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7ab02638e3f1..88c32e528add 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1847,6 +1847,7 @@ static const struct intel_uncore_init_fun dmr_uncore_init __initconst = {
 	.pci_init = dmr_uncore_pci_init,
 	.mmio_init = dmr_uncore_mmio_init,
 	.discovery_pci = DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
+	.discovery_msr = DMR_UNCORE_DISCOVERY_MSR,
 	.uncore_units_ignore = dmr_uncore_units_ignore,
 };
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 786670276b5f..a558c31ff2b1 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -2,6 +2,8 @@
 
 /* Store the full address of the global discovery table */
 #define UNCORE_DISCOVERY_MSR			0x201e
+/* Alternative MSR that is used by server CPUs like DMR */
+#define DMR_UNCORE_DISCOVERY_MSR		0x710
 
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index dee94bbdddcf..bd1569876640 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6806,6 +6806,28 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct intel_uncore_type dmr_uncore_cbo = {
+	.name			= "cbo",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_santa = {
+	.name			= "santa",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cncu = {
+	.name			= "cncu",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_sncu = {
+	.name			= "sncu",
+	.attr_update		= uncore_alias_groups,
+};
+
 static struct intel_uncore_type dmr_uncore_ula = {
 	.name			= "ula",
 	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
@@ -6813,6 +6835,20 @@ static struct intel_uncore_type dmr_uncore_ula = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct intel_uncore_type dmr_uncore_dda = {
+	.name			= "dda",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_sbo = {
+	.name			= "sbo",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
 static struct intel_uncore_type dmr_uncore_ubr = {
 	.name			= "ubr",
 	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
@@ -6901,10 +6937,15 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
 	NULL, NULL, NULL,
 	NULL, NULL,
 	&dmr_uncore_hamvf,
-	NULL,
-	NULL, NULL, NULL,
+	&dmr_uncore_cbo,
+	&dmr_uncore_santa,
+	&dmr_uncore_cncu,
+	&dmr_uncore_sncu,
 	&dmr_uncore_ula,
-	NULL, NULL, NULL, NULL,
+	&dmr_uncore_dda,
+	NULL,
+	&dmr_uncore_sbo,
+	NULL,
 	NULL, NULL, NULL,
 	&dmr_uncore_ubr,
 	NULL,
@@ -6919,6 +6960,7 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
 
 int dmr_uncore_units_ignore[] = {
 	0x13,		/* MSE */
+	0x25,		/* SB2UCIE */
 	UNCORE_IGNORE_END
 };
 
-- 
2.52.0

