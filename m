Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759332;
	b=D6lvZDdZjm7Mht2zUVcv72z/RNxzzrYNSd+EmrNqFnDajSSr2d+EJUx4H2FPngoiyLKl
	 AZxMs5fPaoq84JA3ED8fuZD1ujxKP99Bg6yiMi3antcVZ9HOCUAwhERnwd10IVtgqz2aW
	 rzZoc05kd+M6sMIXTS4m5A1KXb8Lme+HpEkME+zbY6CLd51oTWCyvS8RFyNaV9TzhWY2S
	 Z0Ut7RQ+mgUJEhXEe2C5RVE8k9R57C+SEIhWfE/23O0ELuqN0Hyn2zAqmjIAX3utQU8x7
	 9RCWxze63eyHo5O4g0daYjUJSz8FpZSBa3yGwagvNak67YY7okOTCP+wBS8r+5JiGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759332;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qwH3BSdGJ4tBzPV5ZXb38aIa8v10G0LRzFHxAm5cfzU=;
	b=OuVHGwHF1/tAwtgJbqlpGu/WYuoHRhObzQ1rdII3oL8Zdnfe49QqdWI/nuVSwK4s0+Am
	 o+M+fwlHonIIiQ0lsM8AX179c4gcohWiJaHBmnwg7KPUFKArAox4ioqKsgpdEjmmsW8SC
	 YiF/JxziI0FXtShHKJ4cnVe1HTTcOgABcaXc1P4uxMs/Qszc4uL2uEXjeUgumfQr6WZYA
	 fklUnnUYZwXVcWjjCPmNOCQXiIspzTwDBZG+4/FX+3u3qnQrn4JQ5qKeonsFokzUM09Vh
	 P2jwN+DZx94FkaLeqBEOFCVXJ3A9LxlndhGoWkuEpPEgJf45zDv/MjQv/g7uGTE5yhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho1ExbbC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308A606A31A;
	Fri, 23 Oct 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho1ExbbC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744471F01828;
	Fri, 23 Oct 2026 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792759331;
	bh=qwH3BSdGJ4tBzPV5ZXb38aIa8v10G0LRzFHxAm5cfzU=;
	h=From:To:Cc:Subject:Date;
	b=ho1ExbbCub0f6mqpW/c6pg15HqLWFrpAu3NrCjz+XtGCN2/EN/pAzW43v9UmjAUuC
	 QXhpvNb2aQ3KRM144Mr8sBqAjgC6JOuxu1viigOm/yc9swubc6Cdc0XuuhniT29lXq
	 /W2MRM7YZxT2dZlJL7sXBvs/WoAo6aCu69wxhOgOyqTGAPjSuMzATdJS/SHhpilq29
	 nIm0/azbdAt6Twbz0c7uuS5hBFRDQxY+E02KiEtKnwpao801/HpDggGdroUOImjW3f
	 mUzXqBWPxXtq0DO+9RtRY53M1yNVSqdqHEXD1jBUIWZOByNWAgedinEgVPqSMOF1h7
	 pkLeCI/2gdnBQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel branches are recorded
Date: Fri, 23 Oct 2026 05:41:56 -0700
Message-ID: <20261023124157.75524-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
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
matters only when branches into the kernel are recorded; without it the
stack fills with the handler's own branches. A user-only filter does not
record them, and parts without the feature are never frozen (see commit
598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).

Freeze unless the value written to LBR_SELECT, which is shared by all
events on the CPU, suppresses branches into the kernel.

With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
CPython, the function of the sampled IP differs from the function of
LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/events/amd/lbr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb8465..7ec50380ac81d 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 void amd_pmu_lbr_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
+	u64 lbr_select = 0, dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
@@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
 		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		/* Freeze unless the filter suppresses branches into the kernel */
+		if (lbr_select & LBR_KERNEL)
+			dbg_ctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+		else
+			dbg_ctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 	}
 
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);

base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
-- 
2.53.0-Meta

