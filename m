Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234B2D660C
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102461; cv=none; b=ICSApwQuVs4Nwseg3o/+3ztXID4xUf4Qx8YDp4kEmKMsOOQdQCFqu3LT3NhKtUQzVuPwymFogjXgkI7wpj3nTq3HTldRKSuWemfhtexfKUW5w/BS1G/wHmrIy/4YZ/NDUUF6QHEIeAlfnUIDCpOG9HP/UE1PG++oyNc9mjvcAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102461; c=relaxed/simple;
	bh=9uMRLY3tW+LsgB/KLohPx6Pdb8SvPdWaSQtNDtaYois=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i93X6RN8WAR+5zLjXLajh/1T9T/E0qTu7XSbt2So/bKnh8H7q60BrcbT+j538aYMjdjjf75+GrC9KWkLL8ua6xHrPHKHSKhQuqtwua60YCtbOewUA1j7c6M71psFoF/8Nq+VWI2QCFFC/dswr0snGDWJ+r2wErk0ZKG+/bhujzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8IUd5rF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8IUd5rF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455b00339c8so30247605e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102458; x=1753707258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ei/HnJSvouST6mpmth1X7iDdKdrsxcGxYeWK5nNgG1Y=;
        b=b8IUd5rF3lST3qLZiWb3W7Lv6O1hdCBY4xt1vT07xZDIBK/BSvGx1Irl6oabnSJonC
         8XNSJn8sMgoWfA5wn8ZtG2offtlJEnmO0UdvcKKWpkRa8AIMZZvdhRX64cPFjnlY1XtU
         KDE2EBbAG96tK8po1r4UFt4UgZ2BIGbFBZcoiS6TLZYdmU1v45ZcbVrEDeVy6pVixlrz
         5xR3hYv8nZ/N6RgcvRIRD+qPJSzqtN1rE/OMYh+f8nObga/G24VvnS7owLnrrT7uk3+/
         agqnOu60t8Vi6KXXIJx3owSIHiwuPgq2ll6UZwLLJ85UmMa+DEXlga7NHR5K0VVsdQP6
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102458; x=1753707258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei/HnJSvouST6mpmth1X7iDdKdrsxcGxYeWK5nNgG1Y=;
        b=WKaug1pcu6nfP0NxTSmph+gkyB7SkxNUQN8efI4E2KcdvC9HJTu6mow8F/LUe+HSDW
         tcxvr8illy960vZGqUS+MfbrIVRX+lcCGMIcN6DccfWAnIdgV4Nh+ZeMdkrRllQTCBuD
         /7SbxIXg/Edigxqxxpl9fkknV+WJ9jFCi2th2I0uQIFDrrSFAoOytRyGXbycV/FFNvO5
         jmQyvHoXZruYomifdp6x3zCSH27wZsMY8QhS1AGMgxNUWwsezlqsKTBZaYeqweiq6yva
         qTbhp7229jZDXAPDgHZ+tYXPSFwxDdwqKzljh9LWX//EdSCfSQjjRni//q8UcnXBkJXh
         UFcg==
X-Forwarded-Encrypted: i=1; AJvYcCXaPHS7LFG1teR6bqfz8P5SKjIIrNuPF3XNLj+gcsXVTX+Z89IZyyHcoJlxKwEo3gYsUq1LGdL5bMUsB6lpw3pO@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVY0qqq0OPTl9FkNEoWt8klirkMOKdo6C/gNHd1DyixPmDUYr
	t99dqlClxpwspmyQDbhaNsNDCi1A5KzU7zrMQ8t0aPNJgiJXWGIbiUEVr4fXUHBpe/Y=
X-Gm-Gg: ASbGncstA2M3jGnGBCNhTsHQ3NZ9S+7uV1dvcMOwZbotn9SSmNgWdpy4++WKZPHDTAm
	llsOrbh2izPuA6SI6M7CzAlNwAd8K1BqME/ZDg8z3PcGM+JPKpbCF/vPsYuqi6urT/ptZm0yg2+
	taEUcxCEp6BDfy8q4s/7FPxc2OeuvUp6mCoKTe7BLH+acBkhD59/nrpARuLpmhThtW9jrBKBmy8
	XIRDTYU+jwLBXLktOuCRiCPKd/7eHOsPLkQQLBmffow0KEV2Ulndj7YAvxlzi5WQtgjgUxeE4xI
	4UPStQ2zlvQT1zohkE/UbnlhOLwnA9zeZ2GZb+HqPVCD22/qvVk+0bbVqOucV+gNekVMsS2VtNk
	37EpV9izRTWLqCfz34rSUQiQd5oEp5MM=
X-Google-Smtp-Source: AGHT+IGXHG3FB2msUxbdeDts98g2pPebzoNgn/wdUbPPp8qpa2AIRfLTEy0hX7PjnhlcduPhaxdQQw==
X-Received: by 2002:a05:600c:1c0b:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-4562e37c48cmr144674035e9.28.1753102457591;
        Mon, 21 Jul 2025 05:54:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:37 +0100
Subject: [PATCH v4 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-6-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/arch/arm64/booting.rst | 11 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index ee9b790c0d72..b4f6d487a322 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
     - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
 
+  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
+
+  - If EL3 is present:
+
+    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+
   For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
 
   - If the kernel is entered at EL1 and EL2 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 2bb0d28952e4..7c89e0d6e739 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -284,6 +284,17 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
 .Lskip_pmuv3p9_\@:
+	/* If SPE is implemented, */
+	__spe_vers_imp .Lskip_spefds_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x1
+	/* we can read PMSIDR and */
+	mrs_s	x1, SYS_PMSIDR_EL1
+	and	x1, x1,  #PMSIDR_EL1_FDS
+	/* if FEAT_SPE_FDS is implemented, */
+	cbz	x1, .Lskip_spefds_\@
+	/* disable traps to PMSDSFR. */
+	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
+
+.Lskip_spefds_\@:
 	msr_s   SYS_HDFGRTR2_EL2, x0
 	msr_s   SYS_HDFGWTR2_EL2, x0
 	msr_s   SYS_HFGRTR2_EL2, xzr

-- 
2.34.1

