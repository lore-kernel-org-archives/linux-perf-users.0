Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BD2D9EFA
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103121; cv=none; b=SFbjZpJJhQfojAQUzL1KZnklKA5qWjKyRQZ3wpWD8sPVH77ZOTszWUlwRbQACNqfovHFDN+K0P6ANPdYwVJUVeoUryKfnxFo0/9H8taO4QeHTckGBl+91CE1jS7gyIIEcfwERhvkBIH362dk2tzWEG94UuUt4dS45I36YANUqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103121; c=relaxed/simple;
	bh=nJUr8QBs1Bj7YhbHeTnMBeiABjZ7mfBR47rSyL99+v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNUnz03VLMh2GbbaFFSvTLTqkVRVRKvXsmGj2RYjZZTVKIDR5kmTSH+wbqqkiX4/GaUY7/pMIXGJEvTmyxx+sUtYHh8ZPKMcgUAC8KQsn0kkIAgbCXA75NqMfprzPth4OqtxMyeYgkSGh30i50B+BA231X/cS9DoGFC+HDshwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVbujU1W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVbujU1W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561ca74829so47649515e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103118; x=1753707918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tni0DswMrCD5TnIk9k/V3+/ZJa/XagFEwHSR8GX4s6s=;
        b=VVbujU1WJJxNMWptGL1MuqhqSglHGREDqloEnea94M8o/79Y0Elv5GUHRq9aV8hDMa
         nYEih5oypVNndAIKclJnj0nHkE3SQrFDVGPil4B2sG7ZRQmwUjumjRiU9Ee9YdNhUKTQ
         0lNX8iDqawKj5C3CbFDTqcoxhnyOsI6cXRE1cPHUcikfXKg2EqctXYMl3ru4S+/y9ZLV
         xgGxlczM7TuaYO8bAYwkYTEquN/MnP5vCFr31wT1rj/pfX7d1hteZsCx0ItM7amh9KT8
         Zn8huAyG5sfloZt2pRZI7z4LoaDM5w6RsZjE+4w5zmwghTJexjp4ZiVXb8xyAZHYwrbS
         NHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103118; x=1753707918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tni0DswMrCD5TnIk9k/V3+/ZJa/XagFEwHSR8GX4s6s=;
        b=AFlrweEsBH3/1I7aR7LIzqG4gvfWA+DBpH1AcuA2GCBb9kb+4+FvYx56OdukYsySDD
         HuaPs1IoyESqCKoMSSkoL3O/NxYmVEij4doZS35UgfNDFMM6MRVd673ZqFfio/QDg38g
         SWrJi4nHfqIvO0dmafR+4yN6RlzfPn1miFuzlRbYUhVwe3UmxUXiQTTpe0x3KuUxqEkK
         sZVb7Ju94m0V9+Si0oZ+loVRoPukCoBnS2zjmQfQkfSXZGdZU0vTSa6CLVPK+gJ5a6FB
         tUK/8DI5SqLKRunmNRHGnzeUT9X+n16CQnFWZrc3jKe4J30898tqz6DrtEeytEnnOXpx
         9f6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZKrE4axD2VQBt9cyEsD+mLjv3gQAtvtVQ/YmOefXQV/EipyZZccQSYUkv9219FnMQka5+mH8JH93yWsv7DCZ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lAsMOsH2vS8uRL57GCuF+1cLqd3bN2nxZ0tToTM+JMDSp0an
	rv4pVL6LvI0YUloi54sQ0EnsPtYJeN+sBzJGa7CD2YLfoxkiriApt9n/MIJIkXHVXqM=
X-Gm-Gg: ASbGnct6D+7CfyoUjz9h9Bp+00JEWobVYEKeL8u1KocNblTRmBOb/65IE/3GQbIdDDd
	JunH0xtYdKWe379qsF0WPYLvbxejxICed48S5c0AD7tudx8GG4dE/b2yR9+2hpced6r5lEQct9+
	FM5HuiD10KkZhQbiYTBNMb8yZpzpUPfLDZZlrlisaNvUg5VS5kMN5jyoDBAE6dLl0O+ZKLHW07H
	z+Zd0Hu6GT2UlS5UTKuwOGK901XGz1mjFDgNX/UQRP1lnKtr44utH47GjBtnALlLxISkdEMtsAX
	LSGGV8ad45k5peqZhEZdnGHxdomGYPzWC/fgYP8vNnQZZjxUfkhta5GMiPt5Jjmeq/UuZlqV9/4
	ut4eV7nQKATTW59Yyq53FAB9c4SywdxnPlNEr+vIsdQ==
X-Google-Smtp-Source: AGHT+IEbTWNhdSsCoye5ChJxrRKNCcL1bytD0ny/gbd0G1tPqNJCslwd6wNxX0L6BGInIzH8XxTY9A==
X-Received: by 2002:a05:600c:5298:b0:456:15c7:ce90 with SMTP id 5b1f17b1804b1-4562e38a72fmr200645775e9.12.1753103117481;
        Mon, 21 Jul 2025 06:05:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:00 +0100
Subject: [PATCH v5 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-6-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

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

