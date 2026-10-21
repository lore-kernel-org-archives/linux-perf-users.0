Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622182;
	b=M4fpmmAQFIQyNq/vSndAbFyJCMoHJNJ8MFzlfzQ8PntkvI64Kr6w2+ipa1GuMfKno334
	 P32oW6RJurhNUrP2cWB2v3+r2FQ9mtAPorYFUgP4IRJLYq1tR1Gat3SKz+XltC+vLnxdI
	 lJxAWY4F052ne4r3K0s84/lF7ZfFD2jx+mNRrjNez8skIHWJqmEc4HjgENrk6rX5artrF
	 INmh/kvb7iUJb+bLI+373NyBrLjLELEX1TnUKXF3qc28Rg+BG0arcRQfPzoPoLuIrkhIL
	 YgrUlETNR6Rm7TxxlVjo18BTjTvjeT8TTL+xkYIVTDILczdNhp6CUjutP6Fr9dMkM2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1XxwaI+UCmoPQLvivEmw+n7HupFmwzg8de70DWq/9Zw=;
	b=00j7A2SEtyyGk8Udmwp8f4zev1EfI8s47Eu18egEUw7ZGWhRkGISy7gyCGC3+1C4YwHx
	 sM1qJiJV1uhI84cFisYdyhVL+1Z+ndnb+pPBVRQJUp9POrlTjW28gNEspHkDFF9lhvWFg
	 B+YpUfI98DSzFdTgWedSuoP8CIoUVo/hY2tahRPPkXrrM/qYjCNij3DBlygnOgf088DV6
	 RkIBMGqSXtFmVrKRpdu92lHFZYxI4+X46oF8+PmTHdZKzM2WZxRP+qpKp5J3736orl74N
	 wqkTtnlYD5sojWNaLbvKSxKjzzq98GbjKTbIj1tEGP29V+JJgpZB0hMenz25uBl5DYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2I1TGfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85B606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2I1TGfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8BD1F000C1;
	Wed, 21 Oct 2026 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622181;
	bh=1XxwaI+UCmoPQLvivEmw+n7HupFmwzg8de70DWq/9Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2I1TGfrP21dgKcUscU269SIopnNQ9N2oXCgkrVsE0OJVrDsmqr4TOuY04uoew63v
	 qDeMGnvauPxSIraTeGIJaOnz5Bzj2wdM7yyQd+pT4dfqWvGS1RUObCjcjpYhPRn11x
	 Fi1SOgeaNDnFyZ8C5CICNF2G4VvbLwQJWd62k8GvyhDSXDNaj3ULN6QB22XkIRD0Zn
	 26X00vdkcpv8Ll/xS3/UYqMC37l9zWT0WxmpdgbKKFYfdtsQAdv0qX/uVSTG5GgR8t
	 lRmWkG3F55FHkEsbEtdd63pgsLOlL2ip5h37qQgncengbz9e9dhlyWLpgpcu3g/D/O
	 LScUVLDA2kWTw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2 05/12] tools headers x86 cpufeatures: Sync with the kernel sources
Date: Wed, 21 Oct 2026 19:35:44 -0300
Message-ID: <20261021223555.28372-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  87db7795cbaa ("x86/CPU/AMD: Fix AMD TLBI Erratum #1718")
  dcfb0f2c067a ("KVM: x86: Expose Zhaoxin RSA CPUID feature")
  54db9aaacc2a ("KVM: x86: Expose Zhaoxin PHE2 CPUID feature")
  93134f14106b ("KVM: x86: Expose Zhaoxin RNG2 CPUID feature")
  3ee865eb696f ("KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature")
  d99fc2a7c5e2 ("KVM: x86: Expose Zhaoxin SM2 CPUID feature")
  ac5cc691eb4a ("x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt")

That just rebuilds perf, silencing this build warning.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Please see tools/include/uapi/README for further details.

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 6547c0aee45b7781..fe84cf4e97d35a7d 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -136,8 +136,12 @@
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a hypervisor */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			( 5*32+ 0) /* "sm2" SM2 algorithm */
+#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
+#define X86_FEATURE_CCS			( 5*32+ 4) /* "ccs" SM3 + SM4 instructions */
+#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "ccs_en" CCS enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
 #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
 #define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Engine v2 */
@@ -146,6 +150,12 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* "phe_en" PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* "pmm" PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
+#define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
+#define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
+#define X86_FEATURE_RSA			( 5*32+27) /* "rsa" Big-number arithmetic */
+#define X86_FEATURE_RSA_EN		( 5*32+28) /* "rsa_en" RSA enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
@@ -365,6 +375,8 @@
 #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */
 #define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */
 
+#define X86_FEATURE_DPTI		(14*32+24) /* Intel Directed Package Thermal Interrupt */
+
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
 #define X86_FEATURE_LBRV		(15*32+ 1) /* "lbrv" LBR Virtualization support */
@@ -465,6 +477,8 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+
+#define X86_FEATURE_TLBSYNC_SFW_NO	(20*32+ 4) /* TLBI Erratum #1718 fixed in microcode */
 #define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
 
@@ -575,4 +589,5 @@
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET from P-SEAMLDR clears the current VMCS */
+#define X86_BUG_TLBI			X86_BUG( 1*32+12) /* "tlbi" AMD TLBI Erratum #1718 */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.56.0

