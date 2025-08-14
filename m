Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583B2F530B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163569; cv=none; b=jkWXXzsTyTfcVTWgA4wHqDBRSSBbJoJ1F4L6c+AJc4ayMt+alhdMxuI9S3qgdB4Ux1d3lWYg0Lo1W1zpE46CsOAxexbJul6q2+4UAkwZEbdFgFsN5rgev/gltKUhaWwAXSygVKQn5XK5zfdBhFFSSrw1zRGdnukPxfiZ85n5uA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163569; c=relaxed/simple;
	bh=GxOVOeFB86vYsIqEPOrJfP+toIpofQdbwv56n+DyiyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a420rCP8mxB9ENA0Om/K0vLU33Hh2ZDGKKQGU3IGl/SWj2QtK5OocohcB8YiyqUtq56FjhkHlBcguHuZRKUPWQCbdE29KCG0HX6K+JoRPMggTvsEPwXSHv4aoVYK2BmYoirEHMKsEoTokmt9d6AJ4TiDG+40LbqBSvzcskk5iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ezv7EonJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ezv7EonJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso3226025e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163565; x=1755768365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ufcAb3VHeR+uwp3SrFDBKP9OtJsomlijITnASDdFZ4=;
        b=Ezv7EonJMyPf1NgVaElc4JTZT5urIHO9FIiaZQWcjU9vYDaY5yz+zOyZafgMOsKFEv
         Dq6lzJJ78wtXtxxI290zFatfTb2Ib/EkTAiz/A0tQn/fX2JZ0ZvP6HcgRY5pRb24ANGn
         bY37KrEfl3h/S0MjfSZsqVzqLLbVQpdYNuWEWyoMF9vfwz2kBLOJkyZjYRy5XqlGSyRo
         Ce9PD8SWOgbI92Ir8kvIX+X9mOthM6eo9hCWh5gB0pV5BWOEG43mCuNVFNLSRkxWJkF9
         PxeScJmfHITDSv4Lb3PJixyDVrEwzxJiGPszx87WFLTJ0mfxe0TZ9WicIe6ra4l6pxXL
         Ka6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163565; x=1755768365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ufcAb3VHeR+uwp3SrFDBKP9OtJsomlijITnASDdFZ4=;
        b=C9sXz/KlSBZKVzNEoponJuHePF4xXyWtVH4PRcoN5XwGRtAkazObiMV5jGYCwusKD7
         rmHp1tnorRS8DXBE/fPg6Cg/P9PozgPYdhbqB4/5Pz0UcWoRLhIBu7u8CXq07qPXSWKs
         CAja2ZiMRsf4ieqwOvnUQXiNFZ5/Z4uINQxQQtSZZ3lF3P3P3sZvwai83c5IKegCPQvA
         jgtWFPo9cSGJV76MvRlGdLYCvCcxu12pAtSc0abxu6nI0j+lzRYBSugJJOxFdAfKVWPk
         9aFEQheQdd8ZL4qbS03k2C/5wMV/UQIsYqBobPBQ8F6Cunzq4C+jr3X0s1XKS9txea7S
         BQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCW8NwCyjd1CQvtNYO7+L3aYRkkSKBwjvQcY9ucKwU4uqooLShI71NTglYur5pa6uSiFvqYiVMxgHQNm6ALw03At@vger.kernel.org
X-Gm-Message-State: AOJu0YyT83q43xCtkDXLERufZ9LLes4tbeHl1v8ux+bLN/GwRS4wlAVt
	JsR3Q6zJLGFrsVl0yR08j8k3Hjpe5UWJ7lyXGRTI17p6xPXBT6LLov4LWKPdggug3rM=
X-Gm-Gg: ASbGncvbhweXIEDdB56G7wdLnjTdCrFSCZupBIrR/P1j8PPuppjEPpLFnL4zopxwuNw
	H2knjHvuIe+fkYsn24im18aZatDPvtntFY3AvCb7TouJRusswb66/+Bv3CfK9AP1k4QjO+DM8sp
	w3I2imu/KTfB7X328587GWMAoSHR3gkhaMw9/SMEx5b7RenOZNAtsKjlGWD09CwnJAtqkAs/jJU
	oIzkDxf3UuEd4rMWJ9A6YeVSwXrbFwTFMx32+dE6OevzQNqXxFRYZnvrpv7y9J7WClaS3ttUkrr
	EiFDqsC8KH5zWMOZnysozpwveZ5mumjWVPstzYpa19nG0eEgvdm7cO/eBIdSTxvg/aay/CS24Fk
	mBGG6lisI0Y6yRrdhGlsoXKy0E7vRbaE=
X-Google-Smtp-Source: AGHT+IHAe77kAGKOL9ac19qggXFCssFULmcjf7EqpMgCC95aWkBTN0oGZBZjWaCvCRy5GyrpGxVt+Q==
X-Received: by 2002:a05:600c:450e:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a1b6753a2mr19670995e9.31.1755163565465;
        Thu, 14 Aug 2025 02:26:05 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:05 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:28 +0100
Subject: [PATCH v7 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-6-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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
index 2f666a7c303c..e4f953839f71 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -466,6 +466,17 @@ Before jumping into the kernel, the following conditions must be met:
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
index 3a4ca7f9acfb..a0361ddcdca4 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -392,6 +392,17 @@
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

