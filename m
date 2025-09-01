Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950D32C315
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730519; cv=none; b=olmzSRo1FjDqYExH8QEOEsXJA0cYMOc9BhfF531uA8XvbsdM8dUgiUUS9c1rAsQFk/gkk8gFjyq/aiaRe7wnUbwdPp6AgPPSbWgcSMat4qip59GqONLKrctRT/upMxqiVafv1mUYKXoL8Uo4O5WRd6xow6S25hEpbpsVkkRQY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730519; c=relaxed/simple;
	bh=oruhsQ/XnkBWLsHo0pDjGsCJg2Naa/yFYEoihUsJuQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyjBhGpH6U/QWm2XK/5rMbG6Ilvqh50BufNPbQtxmVXyjTL9GdO7qfFATIFCXkEtgZQF2QhCDLdh2B9lmw6DNEbmUiA1u0pCD4mJYR1jeEVxSINHao+/apekuelxa+xTTQBzYVHX8aUUJDvgPh93go102/BO8tHKuq5wdfB2+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePXwn0MV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePXwn0MV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b84c9775cso10735305e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730516; x=1757335316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH4IhsI7u0PxrBs1+bnHSTEJenEfrd4F7dzjVPqlBZM=;
        b=ePXwn0MVt5XH9a0y83Mm4/qPuBH6c1iqF+heiqdhm6mdcVaTNl09RjCndaUPFMYIXe
         2f6QEOMDKVXkhjXhsxWUjuz0EFd56W81UXcWGtoIQQ1EWR7FkWwVZHeMCaRl/F00dWJ8
         wOTViPmFHbxSh5K/O43+ROhAHCbjiEtfroH3r0XBi/CK/0RU5ZiD5aABEeVdIaLuFcCT
         Mz7YqdI6eutp4FM+Gy286/s77SleRaKz0JUoUfj0JGurRhWx23RPXsQjMmSyA1xZzmNd
         sJ1pvBXpvymqZm5DPJtdtty9K9ntvCJRAEawBzb1o1diPUvfKtXQrD2aQ6t9zAP1duRj
         QBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730516; x=1757335316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH4IhsI7u0PxrBs1+bnHSTEJenEfrd4F7dzjVPqlBZM=;
        b=o4pZp2dvtHn/0epO7PR35RNagx7wNOahcIN3GzrwrCP2eW+XZEo2hbTYDJOwJQwqDf
         QsszdzhA3Zft1O2kLZMRgozLIMu61H2aBL38NzrZG0cwcR0Tm/TA4tzKUoDoCdM+Ts1V
         dXd/uqHpCnmjk+nOjaU1p1mkvU0aQwSYEfzDGanDVZQCQTduUyqLxXI2IgvD17zjIBAF
         taNLplEdvW8kM1wr2ndCvHmnPFpzQwRbvczL6vC8liyR2Nkfuu4LdQbATeoJUtDq5amb
         Nlnhd3SvxChomhKenMOGJNt9giIUhWlFE9ArJnq6zh4rHQx+cPZ4pFcmD8+YuubZmxNS
         qGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVg82Yjy176KpU6hHg1YnE7CCtFenJ67BTlcuLZDFq5bqq+BcjpN4DyIjHVPCmXNxe3hNLLN6rmn4WfYUFQelfo@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7q7+1xPN5fcCrlyhTHr/WEMfVivQbl0e+SaM5o7SesEdX3C3
	2S4U//FJlclvqu4aF60YekNSsMchUahj+szhr87O1BSOMyNionkiEAJipHXtM65Cd4s=
X-Gm-Gg: ASbGnct9Uqvf3FegUfh1XMKwe4cZMV/KPVBgtVFBVc0imaudEIN/GKRZbrJr9GfQUx/
	1wItJtyjrNE7pRmdaSZ+KHkfPDYPtYaJP1/9WsyM3L/YcaJ/zjdFvgU2R/pNwOJiMVUrXMkcH+F
	K02NNTDOtGsvARVs4Ljc6F9eVAT4L00cLWcfyxbxPJ73vKr1x3Sg/7urqT+aOrPbmYMttZEKlSr
	iGtlGo5FFwkvPMzyVGzh9aAmWsdrKL75gnDAeYuLetlz5bzBXVfFaS6Mc1uzFzTBUdYaHLFxCV2
	U1TwvV3jXQVBsT2xQiQR1LpzLdlukHcpEDYzulFTDf4aifRsXqidF1BPvuIwh55MS1eIpBor+pX
	0Ty2NXBxkVf5SIobeLpgYBWHZSO0FsYo3VxYcTRzwaA==
X-Google-Smtp-Source: AGHT+IHhau7EY0MQDlSyqPT+GtgoSvzp5Mp3oC9O8x1gCNdLj74/uD4J58UjK1u3FTzG5sPU+DMpPg==
X-Received: by 2002:a05:600c:3b10:b0:45b:8f38:8d36 with SMTP id 5b1f17b1804b1-45b8f388f6bmr19047285e9.30.1756730515555;
        Mon, 01 Sep 2025 05:41:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:34 +0100
Subject: [PATCH v8 05/12] arm64/boot: Factor out a macro to check SPE
 version
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-5-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

We check the version of SPE twice, and we'll add one more check in the
next commit so factor out a macro to do this. Change the #3 magic number
to the actual SPE version define (V1p2) to make it more readable.

No functional changes intended.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..a305386eb2e3 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -91,6 +91,14 @@
 	msr	cntvoff_el2, xzr		// Clear virtual offset
 .endm
 
+/* Branch to skip_label if SPE version is less than given version */
+.macro __spe_vers_imp skip_label, version, tmp
+    mrs    \tmp, id_aa64dfr0_el1
+    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
+    cmp    \tmp, \version
+    b.lt   \skip_label
+.endm
+
 .macro __init_el2_debug
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
@@ -103,8 +111,7 @@
 	csel	x2, xzr, x0, eq			// all PMU counters from EL1
 
 	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
+	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
 
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
 	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
@@ -263,10 +270,8 @@
 
 	mov	x0, xzr
 	mov	x2, xzr
-	mrs	x1, id_aa64dfr0_el1
-	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cmp	x1, #3
-	b.lt	.Lskip_spe_fgt_\@
+	/* If SPEv1p2 is implemented, */
+	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
 	/* Disable PMSNEVFR_EL1 read and write traps */
 	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
 	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK

-- 
2.34.1

