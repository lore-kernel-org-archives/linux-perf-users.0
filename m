Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693495;
	b=WcdnWhTno8/L/SYAO/0YuVEbTy8QOuvDix1ckLJZCSX6vYDOJNzyWbws19vHkvYbQ/K7
	 w+KMR/8fKwd2BXJGo8mARNd3Dn4e9Y/ORbtbc3Me4lvq6VzVZ562D94/bg0p/YdIU6PeM
	 p6LIcwNdr8mVCO/e1+s3w6eTKMIFaxcpVH6wE5C4AG11jqtdCw+KhERkGSpdg6wfTZ59P
	 Y59rph2wQGfJk3VH9duCxrtt5zqIy8ZCHsgjVNNymzwWNw8j8DxcbNWRXWmuqqnzhJ0Zh
	 xf2nylpwegIqwfKVPNI0+1ORuZyV/nwLC7SzPWGXHBYSHe80vKBO3MlZPBeyZYaSQRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1XxwaI+UCmoPQLvivEmw+n7HupFmwzg8de70DWq/9Zw=;
	b=xFSBugYPCrAyHecORb36vRqwj1HFf+CnXM2hvUJSDe8RbX+wueytdnro0RYtNTljtlr9
	 jMeu8Vj2Ji0ziehJTTtYmfJRkFBLB2ihvpn0JnI76OWBwXHn0MW7U21Gc0dvEQYuSdncI
	 ZE6y/lKM0yQxe2WtQDQlA1+3pmysy7UtVE3jfW6Q871Ipbxy9r6RjbiedI2rlkUma72Wn
	 ruo+MfqMkFkprH8qKADGCxYFwOBkkH/AFHppD9TTdx2/3FtU4+6xW2go6BBx/9v++y9gw
	 +9g4XzqCTeHJkqLbO82OcrEtu21DMxoYY85nbYRZ1Xe3x7RASOd/y89wOu17hiKZgog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7CLR9VV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E2606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7CLR9VV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3011F031E1;
	Thu, 22 Oct 2026 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693494;
	bh=1XxwaI+UCmoPQLvivEmw+n7HupFmwzg8de70DWq/9Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7CLR9VVsW747ZmqlHq7O8Tb3lRSzaHWPVSD+3AYdUzjmJafTSwkKRP4IEAOIHUmL
	 Zlal2G8H0SFW20hnCirKmUZsDoVa456YjLs08Pr44FF7FfdkUo7Wh+QTeDNQO3tjLa
	 Q4OMyQC8FnvANtPNtvQ8a4olK9jxKyVDyrFlt/wBIEasUDr7j42h1vYSyvhHPRzkKU
	 KcmMZBGdVegfK16POI9/wW/FZUqCL9/ZGEjAjTnDcbcM5CpOshzHs1cvhHO0zWT8yc
	 xFYsLQLa9qlgyGDKWxOpe0Aw8wMaPB1fYKTqG5PV5DneIhg3qFOI3JWE+wQzdBzKan
	 /D0IEY9NyKQkA==
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
Subject: [PATCH v3 04/10] tools arch x86: Sync the cpufeatures.h copy with the kernel sources
Date: Thu, 22 Oct 2026 15:24:23 -0300
Message-ID: <20261022182431.25673-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
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

