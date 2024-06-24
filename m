Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC5256E;
	Mon, 24 Jun 2024 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221594; cv=none; b=gKqhW1kq3zHlQctxGtG1Wom8ttwAlMss8UnAjivbYOFJmSQY8FPVRKDkzEZxhqX/JM6v4coCJFbDyNiEAO5T1puwdcCZZdW/XIJSsPF9HnIv9bEd4LVfJMMmXMP9JuDU9ivibvmMgTV0//Q/dl+gQ3LzMBn6oaKYdkZlID7MM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221594; c=relaxed/simple;
	bh=uGShTT3yWj6lQt8zWhRk4igFFEKuFOanTXDL9HxgtDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpfIGvR9wZljM3DnNxNNAVRdmwXBDzzr0yqvvYIetbITGdxGWNqsQ9WOi6yHRghHmA3SrmIxeB3SOCeRlqcf7PAZe/kpC28bgCnaSrLh9bUyo3D6wOJx7R/TXRjcTqjaKiJ7EIAIJQTsRudZB0LDRbJFkJKT6ax+FejouOQCzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AauTATGJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AauTATGJ"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45O9WbWG018555
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 24 Jun 2024 02:32:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45O9WbWG018555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719221563;
	bh=HtK7zbTeMNBQDP5GRzOvrYRCcPCEB2uMzRmd/LSKfxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AauTATGJ9v5O07BVmaQzJ3F7KJz0F9iNn8mzFrDuOclNeIQ99SyuWK5vkLVqljDoz
	 c9yrkzNz4hTwOdCW2R5McnIfhoe260Jmi2uZw5I2hrqCyCwzjIVdwncPmUZ30ntZ2Z
	 2N4i2uiI/5javFiqz+PT1rp/hzHlwTz3yB0A/gGPwaGpwqw2ptov+9LMRgeAdFl6Lr
	 b7V37V0AKcWPUMx4/P8ymu6Ai4zZ0sSGwxvIaduFJyM5TlZrmXZdY8BURZ7YCayrDQ
	 nYPVRpID7mKaC8d2El6g2tyPS6eRbEgAl85zQ2oY23IE+vLXQwI8WHjl8KNwavCXYd
	 JPN7TyGCyRdTw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com
Subject: [PATCH v3A 4/4] x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
Date: Mon, 24 Jun 2024 02:32:36 -0700
Message-ID: <20240624093236.18543-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
References: <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
script that generates the required and disabled feature mask header.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v3:
* Checking NCAPINTS isn't necessary anymore.  It was needed when these
  macros had to be manually updated, but now if cpufeatures.h changes
  this header will be regenerated (Brian Gerst).
---
 arch/x86/include/asm/cpufeature.h | 69 -------------------------------
 arch/x86/tools/featuremasks.awk   |  9 +++-
 2 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 8332f596ba3c..8161dfb3255c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -55,75 +55,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 #define test_cpu_cap(c, bit)						\
 	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
 
-/*
- * There are 32 bits/features in each mask word.  The high bits
- * (selected with (bit>>5) give us the word number and the low 5
- * bits give us the bit/feature number inside the word.
- * (1UL<<((bit)&31) gives us a mask for the feature_bit so we can
- * see if it is set in the mask word.
- */
-#define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
-	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
-
-/*
- * {REQUIRED,DISABLED}_MASK_CHECK below may seem duplicated with the
- * following BUILD_BUG_ON_ZERO() check but when NCAPINTS gets changed, all
- * header macros which use NCAPINTS need to be changed. The duplicated macro
- * use causes the compiler to issue errors for all headers so that all usage
- * sites can be corrected.
- */
-#define REQUIRED_MASK_BIT_SET(feature_bit)		\
-	 ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  4, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  5, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  6, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  7, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  8, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  9, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 10, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 11, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 12, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 13, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 14, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 15, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
-	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
-
-#define DISABLED_MASK_BIT_SET(feature_bit)				\
-	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  1, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  2, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  3, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  4, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  5, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  6, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  7, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  8, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  9, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 10, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 11, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 12, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 13, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 14, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 15, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
-	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
-
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
 	 test_cpu_cap(c, bit))
diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
index 989b021e73d3..2a936411c219 100755
--- a/arch/x86/tools/featuremasks.awk
+++ b/arch/x86/tools/featuremasks.awk
@@ -77,7 +77,14 @@ END {
 			printf "#define %s_MASK%d\t0x%08x\n", s, i, masks[i];
 		}
 
-		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+		printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
+		printf "\t((\t\t\t\t\t";
+		for (i = 0; i < ncapints; i++) {
+			if (masks[i])
+				printf "\t\\\n\t\t((x) >> 5) == %2d ? %s_MASK%d :", i, s, i;
+		}
+		printf " 0\t\\\n";
+		printf "\t) & (1 << ((x) & 31)))\n";
 	}
 
 	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
-- 
2.45.2

