Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAC7603F;
	Mon,  6 Jan 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147476; cv=none; b=nlr+rT4KBiEvg3BVxluTQRqdUrJp0yrzQN4IW5H7AXX+vYl9oxauEpnKDCwN2n5rYZ3n0CrrY1NLHPKXlxIEcthnlZBa3LsdzBaT4kSlz/miQIeilqRaJe4T0RKEGJpO6Fjg+MlgkzYwc8PuskDXvuqH76QDHOctdYiD4QdaJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147476; c=relaxed/simple;
	bh=vURgG34GrHdYjB3buk5HlnegJCTaxHYf/0eFMWCO8VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoZX8jR3DMchrv0CrIf90tM1LYnmSrPRsPoIIzgBruhEBO+GRWnwLFdQ6W6EuhittLB03SgEjENQky9J1eNvn0juBuzfKDeWQszjZwiiM0hoq7YyAMtNxqEq90Ni08dndXT9s3EjRHL2GgrIJ02K90X/dSvLbsjJ/0KNo6nNtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iqOwybmd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iqOwybmd"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50677RpE3211026
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 5 Jan 2025 23:07:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50677RpE3211026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736147258;
	bh=Re3MfHtuLBMHpeFVMue+szaKAp0SHaPCUZaQZ+mtJkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqOwybmdV2PNIuYs7/ayZms6/Pm/dBp8Tr0tFnD+zBzeixMvuzn5irzOsCtkUq6Sl
	 Pd6JXuoT9UVNM9AirliJcuet6j4PonWCbvE00g6TFhGwwR7hIQGt3gZygXNvFIOp8y
	 iZhwEkfQ6G83sd/eVvHTyLUVA3qMtQNsGOjCes1mkfStr4JQC/gmz2R5nOcz5DtU7A
	 hKzH877fPowLTCULFLB8vlSkVtvwb3AKaoHwwwEUV7Yi0MGDKxfDjLmyH9k2h169eK
	 MLS8v6hzMh7/w0QL8AQb6YR4Rehqz5TeZQt04rkWrzHvYEH86qJLEa3Jr72aA9bd6n
	 ghlrtXLfKVoQA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v5 5/5] x86/cpufeatures: Add the CPU feature bit for MSR immediate form instructions
Date: Sun,  5 Jan 2025 23:07:27 -0800
Message-ID: <20250106070727.3211006-6-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106070727.3211006-1-xin@zytor.com>
References: <20250106070727.3211006-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The immediate form of MSR access instructions are primarily motivated by
performance, not code size: by having the MSR number in an immediate, it
is available *much* earlier in the pipeline, which allows the hardware
much more leeway about how a particular MSR is handled.

Add a new CPU feature word for CPUID.7.1.ECX and then the CPU feature bit
for MSR immediate form.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/cpufeature.h  | 1 +
 arch/x86/include/asm/cpufeatures.h | 5 ++++-
 arch/x86/kernel/cpu/common.c       | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b829a12eda8a..9a2991e7b21b 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -35,6 +35,7 @@ enum cpuid_leafs
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
 	CPUID_LNX_5,
+	CPUID_7_1_ECX,
 	NR_CPUID_WORDS,
 };
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5985e8eef29..59aa04915032 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -5,7 +5,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			22	   /* N 32-bit words worth of info */
+#define NCAPINTS			23	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -476,6 +476,9 @@
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (ECX), word 22 */
+#define X86_FEATURE_MSR_IMM		(22*32+ 5) /* "msr_imm" MSR immediate form instructions */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..13d270eabd09 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -997,6 +997,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		if (eax >= 1) {
 			cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
 			c->x86_capability[CPUID_7_1_EAX] = eax;
+			c->x86_capability[CPUID_7_1_ECX] = ecx;
 		}
 	}
 
-- 
2.47.1

