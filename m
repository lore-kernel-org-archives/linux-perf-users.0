Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898232;
	b=iasHoFyarJwAHabyHHf+zHRlQP2MX4xvmsKWF2fBsWmp++ms0Ns4grgFws5kQW8APC9o
	 5Deo+y+VmgR+T/W1Xp7EMQ9hjnsTeIdS3AVEFX70byC9Mll7L81EGrorB3hNrqhPJASOa
	 rTqw6HMTQZbM9sYBCzw4uJPRau6rdYbLkh5JQl5JPWJgvcCkpkug6ufzGmeG0/OpZsFaV
	 OnHewZhNVx9yjk/s+8hBZZUBkW3guzAVQmEskbL8ib5QJateyXi/CLy0rLGVp3fCw4jAb
	 lvUU5nM/CrSfDLqA9tUDcfyTLlyzOy2AFzUQb6OgW7HecQA6Kjk7O6b6jaSSFWuYwCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eqymyfQPmkdowPtdPDEdokoee/Bn++kZOanEjmktYuw=;
	b=2Teb+Vbq18OnAvoLjvGTOAh63qIedCTNIUPVujjCRb6HBeNG7DOqBiX4TrTY9buV/hJH
	 XeMFJyFy7tk0LdOq5n5+O6TRaRrfovgYQRALfmQnEQrbP+2MKOue4yNGG5jgyMsUxUqLu
	 3dBccqGKUbez9Jp061tBeHXuaAaXwcMXMUdluH14t9uv/4EFhNrGP8oz699nv1qPMMiQZ
	 nrdmreBtTMgqtagA/9UeVs67cpporPWaQSb9GiI37vFJW2tZ6piHGTqw2c+svwJwqJDtW
	 /Y0w34DYzp5xq/996n6pz9hSG3EWuyaJE6X828mzqcj3cXRX3rUTc9EGGXaiVNu7MBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlSbgtkL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E8606A31B;
	Thu,  5 Nov 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlSbgtkL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3474F1F00A16;
	Thu,  5 Nov 2026 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898232;
	bh=eqymyfQPmkdowPtdPDEdokoee/Bn++kZOanEjmktYuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlSbgtkL0yI1ibmkCSFcsq2mdd5FstDe2qxfkOX+F8XEgiFGcb+3L+kCxBPA5q3l1
	 s2CVCBpRGDxjeD9ci26z1UhkJVlpPN0GecGP4pz/Zk8dbwnzHIQOiyIB6BPNZ28Dln
	 Z5ejaro/xMhMnZdGz2oWkwa92/BD+yErNsGQBbvE1kr91CAoVQjaAZy5yFtn/IpB4L
	 2L0WZKvJFmj7Zm8fUoJbo7DISmWzgcNCTp3AwKNQop8z8tRl0TVrW0r/i9V5Or2frY
	 QfwYIObGvm6AfvizoffY8UTS8YB6Ecj/XNIGWMHHj379UOZoUSfkSVPh+9wcNTTwmn
	 umdGTAJ9pweiQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for user-only filters
Date: Thu,  5 Nov 2026 09:03:40 -0800
Message-ID: <20261105170340.165507-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
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

On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
PMI, so the branch stack ends before the IP and callchain, which are
taken when the NMI is delivered. IBS rejects branch-stack events, so
there is no precise alternative.

The freeze only keeps the PMI handler's branches out of the stack, which
matters only if branches into the kernel are recorded. Skip it when
LBR_SELECT suppresses them, and add a freeze format bit (config2:0) to
request it anyway.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
Thanks both. A user-only default with an explicit request works for me,
with one exception I would like to keep: when branches into the kernel
are recorded the freeze has to stay. On a Zen 5 part with the freeze
cleared and a user+kernel filter, every entry in every sample was a
branch taken by amd_pmu_v2_handle_irq() or amd_pmu_lbr_read(), so users
recording kernel branches would regress with a "never freeze" default.

This RFC does the following:
 - LBR_SELECT suppresses kernel branches: no freeze, unless the new
   AMD-only freeze format bit (config2:0, advertised through the format
   attributes) is set.
 - Otherwise: freeze as today.

That needs no tool changes for the user-only case and gives an explicit
way to request the freeze. This version is only compile tested; I will
retest on a Zen 5 part if the approach is acceptable.

 arch/x86/events/amd/core.c | 14 ++++++++++++++
 arch/x86/events/amd/lbr.c  | 21 ++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce5664..d63649c756a58 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1404,8 +1404,22 @@ static struct attribute_group group_events_amd_brs = {
 
 #endif	/* CONFIG_PERF_EVENTS_AMD_BRS */
 
+PMU_FORMAT_ATTR(freeze, "config2:0");
+
+static struct attribute *amd_pmu_lbr_format_attrs[] = {
+	&format_attr_freeze.attr,
+	NULL,
+};
+
+static struct attribute_group group_format_amd_lbr = {
+	.name       = "format",
+	.attrs      = amd_pmu_lbr_format_attrs,
+	.is_visible = amd_branches_is_visible,
+};
+
 static const struct attribute_group *amd_attr_update[] = {
 	&group_caps_amd_branches,
+	&group_format_amd_lbr,
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 	&group_events_amd_brs,
 #endif
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb8465..f45e2c53566af 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -10,6 +10,12 @@
 /* LBR Branch Select valid bits */
 #define LBR_SELECT_MASK		0x1ff
 
+/* attr.config2: freeze the LBR on PMI */
+#define LBR_CFG2_FREEZE		BIT_ULL(0)
+
+/* Software only, masked out before writing LBR_SELECT */
+#define LBR_FREEZE		BIT_ULL(63)
+
 /*
  * LBR Branch Select filter bits which when set, ensures that the
  * corresponding type of branches are not recorded
@@ -307,6 +313,9 @@ static int amd_pmu_lbr_setup_filter(struct perf_event *event)
 	/* Filter bits operate in suppress mode */
 	reg->config = mask ^ LBR_SELECT_MASK;
 
+	if (event->attr.config2 & LBR_CFG2_FREEZE)
+		reg->config |= LBR_FREEZE;
+
 	return 0;
 }
 
@@ -392,20 +401,26 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 void amd_pmu_lbr_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
+	u64 lbr_cfg = 0, lbr_select = 0, dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
 	/* Set hardware branch filter */
 	if (cpuc->lbr_select) {
-		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
+		lbr_cfg = cpuc->lbr_sel->config;
+		lbr_select = lbr_cfg & LBR_SELECT_MASK;
 		wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
 		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		/* Skip the freeze if kernel branches are suppressed, unless asked */
+		if ((lbr_select & LBR_KERNEL) && !(lbr_cfg & LBR_FREEZE))
+			dbg_ctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+		else
+			dbg_ctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 	}
 
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);

base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
-- 
2.53.0-Meta

