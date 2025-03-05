Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E042250C0E;
	Wed,  5 Mar 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200515; cv=none; b=RC7B2s+KD20jbeo2ArUjxI3WSBzLv/6jyxlre8xYDzuB/S6Yt0NXaMo3MfXgZA3P7TyWFvAwho8tNoJOe8olng+KlPFGVgxZlcMM9hSelXKj2e+R4L0DEP/wjT7Izu1CPuwuc1m9au8+kWlNQbh7oiGZdoE2wHwUBAIByA5ty7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200515; c=relaxed/simple;
	bh=S9RmkoypLdEsxV5/SqrzEwtSf4tN5fmn5VG2+bNrMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPAe7h5kq5/AIDXNYAOe4aMmSa4nNEVNq8ZI5na98kkPaRztzRthJ1G/JDVqz7foq/c6OXNwgnX5xszjEE8THgWGMaNTAAXv0fCMYvhXY4RO0IEUqxVvpVMw3XaXU8nlKTn2Brw0QEj43OyRp1E4ZUeg4npKdnr8ui2Ejlz8k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=E7FB4yXe; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E7FB4yXe"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 525IlQXx3341787
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Mar 2025 10:47:35 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 525IlQXx3341787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741200456;
	bh=ZFEBVjKlUUTl/5spCv5uV1kp2wfbEgloCHMGnuYJRxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7FB4yXeX5SWQyeMeelsLOTRrcecTW4XNjAO955SD3CNIUt8Ov60Xo4J+pZcRlM4r
	 hFXaNLxpUzTtiDzgphzPYiH57bFiYRIbsR5igKcJr13scG8u+WL9YzT56ix7/P2KqG
	 fyWozZZnlcUOM8+VBGyIlZ0g/RZQWry5wo18mLTyZHbzfIJ4hYBcgB3b2lhfiBGOSf
	 otEWSe/jrhqn/9ptE64aW0fHPyokp3ccvFj90swmWofgsJum56cM+w2vzeQmXxocqY
	 9GnwoQ0pI2iCtTza2Dte9zNPRxQCILgwoKKjedyQYdFbp5LQgXxnEPUPaHhdYOP4VH
	 bzwuQbqQxzhnA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com,
        sraithal@amd.com, philip.li@intel.com
Subject: [PATCH v7 4/4] x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
Date: Wed,  5 Mar 2025 10:47:24 -0800
Message-ID: <20250305184725.3341760-5-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305184725.3341760-1-xin@zytor.com>
References: <20250305184725.3341760-1-xin@zytor.com>
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
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---

Change in v7:
* Collect reviewed-bys.

Changes in v4:
* Use '1U' instead of '1' in feature mask shifting (Andrew Cooper).
* Checking NCAPINTS isn't necessary anymore.  It was needed when these
  macros had to be manually updated, but now if cpufeatures.h changes
  this header will be regenerated (Brian Gerst).
---
 arch/x86/include/asm/cpufeature.h | 69 -------------------------------
 arch/x86/tools/featuremasks.awk   |  9 +++-
 2 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index d521759fe40d..7937823ded89 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -51,75 +51,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
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
index fd3e72147157..2d9201c841cb 100755
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
2.48.1

