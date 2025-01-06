Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FB1D6DB7;
	Mon,  6 Jan 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147484; cv=none; b=CF1OxQFhi2CITSZy/+n/ecUTm7xmVZlRhTl/slabIcO0y9PMaoKlacu2v3C/WuhQmkjwGCDQCRWevIEjcFRh7a+oCpXTnzavX0etGtXZoq4bCtyIfSEMKqJVpQ9h6J/rRBvZjSbE/F8EQqK/iddg0CnSDYeN+lBuZwqxpFoaHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147484; c=relaxed/simple;
	bh=zXRPBBDKU65E0vCbNuT01VbPPYNVJuK3jM4A56BAqNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGKJSKEHaVTRbakwJLVScU5/bettm5bOjvCXGDEVdkTA+3WDeQOC1aIt6FlWQJ8B+I/NlyIcYWaE/xOOZ7EU4sLQXlG7t3M+s4zi9SGU/fAadIacqMNiSbqXPnrB7CofBVTORE7Wro1y4OQ5xPSVyQvwyg6zn8wpGt5eiKTXehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=M12ilnkp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="M12ilnkp"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50677RpD3211026
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 5 Jan 2025 23:07:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50677RpD3211026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736147256;
	bh=BYb6ylOz78GzLuNZAC7ix6eMFnpD2g9MHChDW+DgETM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M12ilnkphAKnFYw18Dl99TXRsRcpJxk4MVxjD6ecwAPcSrMBTcoN/q00rHvLZ6vZv
	 Hp9YobzuHIyd1yvGjUgxCRFRNKUlLBzuU2jZttP/gF3KusEp4BBRq0SalcDFBsOBRk
	 cUmolP+keM7qVluAFU2aX4Di3cJI9Kg5PEUQ447rblWd/KU97uF3zvyiZyYdqLFTMU
	 E1RQhXuhxxLizAiKnidMUwYIE2ctq7KqArH27tbMHvsKqPjkqsYhSU7a28PRFMbLEE
	 SlkNRayW3Jy/aiwXtvzvQOzd17ASk1IwKZvxALUFMtqo5PSnIZdoQJGPdCXH866WeK
	 YaR+YyIwR8Q3A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v5 4/5] x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
Date: Sun,  5 Jan 2025 23:07:26 -0800
Message-ID: <20250106070727.3211006-5-xin@zytor.com>
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

Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
script that generates the required and disabled feature mask header.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Brian Gerst <brgerst@gmail.com>
---

Changes since v3:
* Use '1U' instead of '1' in feature mask shifting (Andrew Cooper).
* Checking NCAPINTS isn't necessary anymore.  It was needed when these
  macros had to be manually updated, but now if cpufeatures.h changes
  this header will be regenerated (Brian Gerst).
---
 arch/x86/include/asm/cpufeature.h | 69 -------------------------------
 arch/x86/tools/featuremasks.awk   |  9 +++-
 2 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 077a5bbd1cc5..b829a12eda8a 100644
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
index dfac56a697fc..01e47b31e187 100755
--- a/arch/x86/tools/featuremasks.awk
+++ b/arch/x86/tools/featuremasks.awk
@@ -74,7 +74,14 @@ END {
 		for (i = 0; i < ncapints; i++)
 			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
 
-		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+		printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
+		printf "\t((\t\t\t\t\t";
+		for (i = 0; i < ncapints; i++) {
+			if (masks[i])
+				printf "\t\\\n\t\t((x) >> 5) == %2d ? %s_MASK%d :", i, s, i;
+		}
+		printf " 0\t\\\n";
+		printf "\t) & (1U << ((x) & 31)))\n\n";
 	}
 
 	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
-- 
2.47.1

