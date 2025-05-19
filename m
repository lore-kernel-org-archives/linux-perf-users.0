Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A3220F4B;
	Mon, 19 May 2025 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690910; cv=none; b=b2XdMiCJ03MTMeHbfrzUGn9z4UuTZZJpBvslM6JaZ4YaCbE6zio4RUPk3/TPZXeK0Gk2kCk/XKMeNJ2z7pNqR4yZMkk81FATd0cE9fmgkioYlgZ7fSDiHmpulSn0E8iCXYdzU3Rw4PT7S9bqzZheilunDqvmK6rVAryDt/q7ryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690910; c=relaxed/simple;
	bh=fqqLEIImalo83m2rdOHiX4hyGLQa56MhhbmesxMuw4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCVmpkWivd61vHsoARLKUr3VRxu7mXjAws4FKzUUEY8biwcuQ35Y+7xvq9i6dNSBiXisFIFBReFHOiPyGmX45jY+7oWe3lYBhuQHdsYtI8Ifs+/2ROAH8tQG5rIPGI4g0IlRkroKTs3IBY6btjTNRqLB2XxfbrGN418nSyJin34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjfKVabE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjfKVabE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A5C4CEE4;
	Mon, 19 May 2025 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690909;
	bh=fqqLEIImalo83m2rdOHiX4hyGLQa56MhhbmesxMuw4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjfKVabENsexaBzhZds4OZ2ab9bOI6LyZRgsShv02vb24ECnUias7G4MSizJezcmB
	 5uPQEeNkAYktFLCX64M1O78oqVppFtbh0UAascBMrmfpQWXK5VO9yedS2ge0AHNID6
	 ZE3ntN2Ubwfp2UhnuE0Wqe25ntnAWiRXqXi7pbANiqd3y+KOrfkE92LH8IKnSv6Y2K
	 jZA3RHWbV+MwFSBfKIoFpNHkCVKX/nMHsv/o+0+gh7R0VoXgja13hk1BUkNXT1rBiC
	 i6qfQ74/DMKDb04R3VTGC4YT3twxNMbxUJFKuYgVhyvpBHmbRB1oDTXPQRL7/+uqCa
	 3tgf4/CbItfQg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/7] tools headers x86 cpufeatures: Sync with the kernel sources to pick ZEN6 and Indirect Target Selection (ITS) bits
Date: Mon, 19 May 2025 18:41:22 -0300
Message-ID: <20250519214126.1652491-4-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  24ee8d9432b5744f ("x86/CPU/AMD: Add X86_FEATURE_ZEN6")
  2665281a07e19550 ("x86/its: Add "vmexit" option to skip mitigation on some CPUs")
  8754e67ad4ac692c ("x86/its: Add support for ITS-safe indirect thunk")
  159013a7ca18c271 ("x86/its: Enumerate Indirect Target Selection (ITS) bug")

This causes these perf files to be rebuilt and brings some X86_FEATURE
that will be used when updating the copies of
tools/arch/x86/lib/mem{cpy,set}_64.S with the kernel sources:

      CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
      CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 6c2c152d8a67b9bf..30144ef9ef02fb62 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -75,7 +75,7 @@
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
 #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
-/* Free                                 ( 3*32+ 6) */
+#define X86_FEATURE_ZEN6		( 3*32+ 6) /* CPU based on Zen6 microarchitecture */
 /* Free                                 ( 3*32+ 7) */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
 #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
@@ -481,6 +481,7 @@
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
+#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 9) /* Use thunk for indirect branches in lower half of cacheline */
 
 /*
  * BUG word(s)
@@ -533,4 +534,6 @@
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_ITS			X86_BUG(1*32 + 6) /* "its" CPU is affected by Indirect Target Selection */
+#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 7) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.49.0

