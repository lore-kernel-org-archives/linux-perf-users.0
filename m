Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858C1EEA37;
	Thu, 20 Feb 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067659; cv=none; b=AFhI0KAQCceH1D9AIeGuLQJBoMrGvpuak//BF8Eayj9BMLYVAzOtwcuDDaQPGOA+l5HQDcLY4mmv++5qs8AB80BUHa+iScXEgLvHzdYAVPB2jHa+cLX/LqTLzXG697FDrobLuSVP+Uqb2DeqDsYBrcvpCrMDQGVp8dg0IsOc2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067659; c=relaxed/simple;
	bh=KXd6HmaYWSKCdFUWjFo6dbjbrQlIxzPrhqN2Q+aeBeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kh60J6g4xisiLzxy1zy9f9h/8oNp9h/E6v0XG6aLuvqwF3Dj4v4OPYSyHHffOnGZrXg5H69wxdI6/ORpu9sKvcSemPVNQWyZDXFSPez0CjRFSe8bKdj82gaf8AI68xVPg58KS34pjPXA6ugVDBRvZ68IgC/e2grBtdODmMyhooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2XMwA0n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2XMwA0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067658; x=1771603658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KXd6HmaYWSKCdFUWjFo6dbjbrQlIxzPrhqN2Q+aeBeg=;
  b=G2XMwA0nQBR16dcdxx2KLAfIImgRFOXi1wvj5G4mesr8ogdcJOJuEXoQ
   Cjn9cUZwOGGV7L3C7d3IjFxwhlYQ3uJwZylSL6XP5vK2nOMOoKIFCIl9N
   oiG39XnO1PP+jLVo4A01hOvnAPtZATCEpX6twHO0UoVoY1kt7ITcbIIxv
   LZmh445U39Og2EF14Nv86TU05inmu01WgARZ0M7rXHrRFBmZsdW6d1nuD
   l8pone2XaCgc+dRTC8faY2+SaZw6xPxYAyagiaSbeUnhl07yRsueO0x3b
   TcZb7OhpCHUk5WT0qI3sfoRCMOonh95AUQSd7geQ28b3D/eZ9f8su+hyT
   A==;
X-CSE-ConnectionGUID: Lt2RvwajTm+uL+gRoOEk3w==
X-CSE-MsgGUID: 8l61JNz0SI+awsGd01BUdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40041570"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40041570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:07:37 -0800
X-CSE-ConnectionGUID: P9rw0PJMQPOjnB73mf/YRg==
X-CSE-MsgGUID: yoaCzzJdTf6r8NYE7bT8Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152268814"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:07:36 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave.hansen@linux.intel.com,
	Zhang Rui <rui.zhang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Ulisses Furquim <ulisses.furquim@intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH] perf/x86/rapl: Fix PP1 event for Intel Meteor/Lunar Lake
Date: Thu, 20 Feb 2025 07:36:30 -0800
Message-ID: <20250220153857.2593704-6-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some boots the read of MSR_PP1_ENERGY_STATUS msr returns 0, causing
perf_msr_probe() to make the power/events/energy-gpu event non-visible.
When that happens, the msr always read 0 until the graphics module (i915
for Meteor Lake, xe for Lunar Lake) is loaded. Then it starts returning
something different and re-loading the rapl module "fixes" it.

This is tested on the following platforms with the fail rates before
this patch:

	Alder Lake S	0/20
	Arrow Lake H	0/20
	Lunar Lake M	8/20
	Meteor Lake U	6/20
	Raptor Lake P	4/20
	Raptor Lake S	0/20

For those platforms failing, use a separate msr list with .no_check
set so it doesn't check the runtime value to create the event - it will
just return 0 until the i915/xe module initializes the GPU.

The issue https://github.com/ulissesf/qmassa/issues/4 is workarounded by
reading the MSR directly since it works after xe is loaded, but the
issue with not having the perf event is still there.

Closes: https://github.com/ulissesf/qmassa/issues/4
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4241
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com
---

Maybe a clearer alternative is to just move all the platforms after
RAPTORLAKE with a gpu to use the new msr list.

 arch/x86/events/rapl.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 4952faf03e82d..18e324b8fa82c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -588,6 +588,14 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
 };
 
+static struct perf_msr intel_rapl_mtl_msrs[] = {
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, true,  RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
+};
+
 /*
  * Force to PERF_RAPL_PKG_EVENTS_MAX size due to:
  * - perf_msr_probe(PERF_RAPL_PKG_EVENTS_MAX)
@@ -826,6 +834,16 @@ static struct rapl_model model_spr = {
 	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
 };
 
+static struct rapl_model model_rpl = {
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PP1) |
+			  BIT(PERF_RAPL_PSYS),
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_pkg_msrs  = intel_rapl_mtl_msrs,
+};
+
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
 	.core_events	= BIT(PERF_RAPL_CORE),
@@ -873,13 +891,13 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&model_spr),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&model_skl),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&model_skl),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&model_rpl),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&model_skl),
-	X86_MATCH_VFM(INTEL_METEORLAKE,		&model_skl),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&model_rpl),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_rpl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
-	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_rpl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.48.1

