Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DB30F7F3;
	Wed, 31 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221385; cv=none; b=Ei0suV3s7UQ59I8AJ5LHzDjBGHxs43gJTOGuZkN+T88+PUJZHLSc6XlW0FJ6fTvQA38z43gMVqg5yJ2uWkMyzsn7H6zYcLE8mUjbJAl6PWToCzD3M/pupQspWc7q8PwgTWG+hXr8r4nXx28GBJK6xvFL8Z/fllRqE0POHsKS+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221385; c=relaxed/simple;
	bh=fh7K1e2bMIslGHzn20U+WdYQF2IjD8UXNfjVQOY6VlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6LMYWcaHZmX2CHgzYpXSDL0Aro+a7oPV40juBVcd2Xkxi4+n/XzeZtD3rAHR5PasIrLXnEkokm5YAe7eukr5LuJcfpcNZ0AuSctkKtvNV1sB9g1rRxWVXZdSGu3DwhgBSCTvKkWwvyHfxlLb2wjx15JooB8y84toG4IAPN1lQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE++X/kB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE++X/kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221383; x=1798757383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fh7K1e2bMIslGHzn20U+WdYQF2IjD8UXNfjVQOY6VlI=;
  b=jE++X/kBgXW5zLCUmuVTsRjE7+RDutcCYAhp6UK81a3H2meA7ivrhBdG
   rg+POkX9CpXbLseHZVd3wsdvxb6dSauSnLPV63QO1+Mz7BIY+/ewy4WxF
   VurKIYfN9x/lEEavWnu2pj/v+fj6+BVp3sUU3vBywe9UqYj4alU0ld07o
   //PoPflY3e8SSBQXgKIVABnyIz0F+lRqEZGXCNPdHo0bsRd1XHYKbnOpH
   MWfWtvah+g/kDXOM+4e2uM/kNQFjXFzPqjeGeMSdy6GoZc2/p2xO8jBQh
   7nKkbqh5gdrWmlUDiff1G8MOg6p1W6mjKOiNgdVy31UZZqDyjlNCi3f/1
   g==;
X-CSE-ConnectionGUID: hGP/lqjJQeGFd/fcFOICjw==
X-CSE-MsgGUID: WZBtXeB9SWqmw8ZM2H1sQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816624"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816624"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
X-CSE-ConnectionGUID: V6mZ9772RLqKh6HIEV5EFw==
X-CSE-MsgGUID: ghNRn7YMSve8VhUTurHmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611016"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
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
Subject: [PATCH V2 05/13] perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
Date: Wed, 31 Dec 2025 14:42:22 -0800
Message-ID: <20251231224233.113839-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
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

Additionally, ignore broken SB2UCIE unit.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Rename DMR_UNCORE_DISCOVERY_MSR to CBB_UNCORE_DISCOVERY_MSR to
  reflect that the MSR is not DMR-specific and allow reuse on future
  platforms.

 arch/x86/events/intel/uncore.c           |  2 +
 arch/x86/events/intel/uncore.h           |  1 +
 arch/x86/events/intel/uncore_discovery.h |  2 +
 arch/x86/events/intel/uncore_snbep.c     | 52 ++++++++++++++++++++++--
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index dc2b2b272bc8..1565c0418fb1 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1837,6 +1837,8 @@ static const struct uncore_plat_init dmr_uncore_init __initconst = {
 	.domain[0].base_is_pci = true,
 	.domain[0].discovery_base = DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
 	.domain[0].units_ignore = dmr_uncore_imh_units_ignore,
+	.domain[1].discovery_base = CBB_UNCORE_DISCOVERY_MSR,
+	.domain[1].units_ignore = dmr_uncore_cbb_units_ignore,
 };
 
 static const struct uncore_plat_init generic_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 1e4b3a22403c..83d01a9cefc0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -615,6 +615,7 @@ extern struct event_constraint uncore_constraint_empty;
 extern int spr_uncore_units_ignore[];
 extern int gnr_uncore_units_ignore[];
 extern int dmr_uncore_imh_units_ignore[];
+extern int dmr_uncore_cbb_units_ignore[];
 
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 618788c30ac6..63b8f7634e42 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -2,6 +2,8 @@
 
 /* Store the full address of the global discovery table */
 #define UNCORE_DISCOVERY_MSR			0x201e
+/* Base address of uncore perfmon discovery table for CBB domain */
+#define CBB_UNCORE_DISCOVERY_MSR		0x710
 
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4b72560dc13f..df173534637a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6807,6 +6807,28 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
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
@@ -6814,6 +6836,20 @@ static struct intel_uncore_type dmr_uncore_ula = {
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
@@ -6902,10 +6938,15 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
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
@@ -6923,6 +6964,11 @@ int dmr_uncore_imh_units_ignore[] = {
 	UNCORE_IGNORE_END
 };
 
+int dmr_uncore_cbb_units_ignore[] = {
+	0x25,		/* SB2UCIE */
+	UNCORE_IGNORE_END
+};
+
 int dmr_uncore_pci_init(void)
 {
 	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
-- 
2.52.0

