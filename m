Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F028EBE5
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518396; cv=none; b=jAV6zPnZfbSSoltUfVHhQlpheuc9h5pWoC5B0qsxCIfBH/3j1hskeYA16I2XuoKLhBqkEtyqkYj0tQ58GFiuaF/EiBzsQCEu68KQnh2NZyDtaqXNm03VkWEG36ZvoFjVacgs9HNMw3e3Kuc6PxngzJJVmQrIyWi+bpns8wVrREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518396; c=relaxed/simple;
	bh=bhT/vBdY445hdiJGnxyUjZuj2JipKZSpecA8eMwMkO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQ8NUMl4N5NBxlPRUWaAxoNCSvehUNJfve68uQfVyz7uSyH1pOe3vJhKdGa/IXrTGnSPM2pjWxQyErn9HMkstpACIOFhDPZQmeDRJV8zOkKwnPumNCXhgzuok5jzgR1CI92lj/1Db7JdZtZMsMoyIP/43ZCIIHrWbmtU+HY7snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qI75gdiQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qI75gdiQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5850415e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518393; x=1749123193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBh51vvyiyhareusQPjv3Jd+V2PWdf2x4DOb/Anfvgk=;
        b=qI75gdiQU9dZxdDIY2zh4VkOCcPNvyAus9RgqyCsuBIVoYoNNHg2gzMZYmc0dXxqR7
         8xFHYDuFwQzBZwBUlYMJQhmqnsZ7rLpMpcO+i8dKHD6S02iYrSMauNn8NKUctPy13GIv
         lkbHVp51V4CeYYQlWev7h6hrnTPo+EBbzAX4pj0DmZmNBSldW5J6YwseVqNK8buft5xE
         jSsgXeuNpmDYyKzTomv6Bh+UyHM2Hz83DNL0nRt3pW4/7CIHdtBJpayjHbnzSeq8ZtHs
         mIoquA6MD0GXC8HQfEGTfDWFZzDjzVPN3mpRdBKkJ8VCfqmDYPaJ7+zXsSR866AoJRZB
         0jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518393; x=1749123193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBh51vvyiyhareusQPjv3Jd+V2PWdf2x4DOb/Anfvgk=;
        b=qDuSV6rxaSSX1AIX05DRcVWmqK2YL4nRHt7B1RwOMTn2Zx3iS5sc4wnAsY5ZQwL97C
         JP10AG3s9x/6rCcwWohgl3uOj98u9aGfrqKtDgIx5n19ckBU8lOGE3Goy0cEWCNkDof6
         oS3vBhkqi0h8GE5Lzk0OoAIayxtYJ9kVYuSOsxicmlvSmwUrN0xTA+dvXMygiPZPOBKu
         Ne2W4Evy9Mx3LK9DRjwnelBip5JLz/i0VZSzSfFgnrWvkeS65tdgxr0qNtEBgysMRKMo
         Hla8dn0zmWtHxo6Za2o3ifod2HAEk1OX3DULPflsYGYt5VEqikTdKNsMFkDeuPUutUyK
         EHDA==
X-Forwarded-Encrypted: i=1; AJvYcCUEOuzKLH0Z7Hs5ha1Mv3uyMmhF60tnNtL/vmLGmAyQw+OWjoVbL4l82K7O0gImhxil0JmuzfmooLCrkaQW0/UY@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzlpUInKV8DWtMF7O6P88+0cUdzJHq4BRVfB3dptTsvX2IboW
	5be4pYenC0pGVIZrLC8bIVOe+Ony0jXQZaH2Fh3kTcLkGD+LxmVpU3n3kuoGt7+0n3vOcrojq67
	SuV3VpXqPAg==
X-Gm-Gg: ASbGncvfiD2jcIjups1BqaMMrnd6JH1a6Yl3qqMkGPTDDAzs00hxhkO6U7RPYAZfS7y
	J5iM7MyhgLQ6KGc9ug7d9VRr9oMb9U3lz/SnH1Tw0QhBjSm+RfYsUzGZlCJc6A2d5YHdPD5hU08
	Yn3yvipAFbXCxSzbiffa40QHyim3kEYtYJYbTOb9nuPDzEuQrqDgjMbGTdEkOr7DU8rcH3t2Q4f
	ucARH/F+V7mUMAXZac7ydTdfQCpd94PfcE38Ndb3e39VGJ27jFPJHeMxQ3MW0Jzn8AJZcBAmRXJ
	iShLGucw+vkM9r+XtBP120NMNSu+sEOIVuNDUfDiMdBK6GtlFxabwgjzyPje
X-Google-Smtp-Source: AGHT+IEtrMK0+qCLgw3Q1exhgAhuym8fUYhFgSSn+IhOQ2msA1tWH3EQ6muEHr0G05oi7CZJdKSgdw==
X-Received: by 2002:a05:600c:4f0e:b0:442:f861:3536 with SMTP id 5b1f17b1804b1-450ce83c85bmr27386615e9.7.1748518392610;
        Thu, 29 May 2025 04:33:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:24 +0100
Subject: [PATCH v2 03/11] perf: arm_spe: Support FEAT_SPEv1p4 filters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-3-a01a9baad06a@linaro.org>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
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

FEAT_SPEv1p4 (optional from Armv8.8) adds some new filter bits, so
remove them from the previous version's RES0 bits using
PMSEVFR_EL1_RES0_V1P4_EXCL. It also makes some previously available bits
unavailable again, so add those back using PMSEVFR_EL1_RES0_V1P4_INCL.
E.g:

  E[30], bit [30]
  When FEAT_SPEv1p4 is _not_ implemented ...

FEAT_SPE_V1P3 has the same filters as V1P2 so explicitly add it to the
switch.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/sysreg.h | 7 +++++++
 drivers/perf/arm_spe_pmu.c      | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 2639d3633073..e24042e914a4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -354,6 +354,13 @@
 	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
 #define PMSEVFR_EL1_RES0_V1P2	\
 	(PMSEVFR_EL1_RES0_V1P1 & ~BIT_ULL(6))
+#define PMSEVFR_EL1_RES0_V1P4_EXCL \
+	(BIT_ULL(2) | BIT_ULL(4) | GENMASK_ULL(10, 8) | GENMASK_ULL(23, 19))
+#define PMSEVFR_EL1_RES0_V1P4_INCL \
+	(GENMASK_ULL(31, 26))
+#define PMSEVFR_EL1_RES0_V1P4	\
+	(PMSEVFR_EL1_RES0_V1P4_INCL | \
+	(PMSEVFR_EL1_RES0_V1P2 & ~PMSEVFR_EL1_RES0_V1P4_EXCL))
 
 /* Buffer error reporting */
 #define PMBSR_EL1_FAULT_FSC_SHIFT	PMBSR_EL1_MSS_SHIFT
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..d9f6d229dce8 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -701,9 +701,12 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 	case ID_AA64DFR0_EL1_PMSVer_V1P1:
 		return PMSEVFR_EL1_RES0_V1P1;
 	case ID_AA64DFR0_EL1_PMSVer_V1P2:
+	case ID_AA64DFR0_EL1_PMSVer_V1P3:
+		return PMSEVFR_EL1_RES0_V1P2;
+	case ID_AA64DFR0_EL1_PMSVer_V1P4:
 	/* Return the highest version we support in default */
 	default:
-		return PMSEVFR_EL1_RES0_V1P2;
+		return PMSEVFR_EL1_RES0_V1P4;
 	}
 }
 

-- 
2.34.1

