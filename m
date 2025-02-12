Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93825D52E;
	Wed, 12 Feb 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380994; cv=none; b=Xw7dDqaGJnQX/l5IEgp7y8k3IsESeu3xZY+cRNevsAKAeou7b/yptv3vmrydlklVIQXAMYRi3zG+FnY86TVjgIU+vDheQTyRGXXGDq0mLhyWZ7BH4ppGiwHxg9MorJ6NFNcIoyOtqANUiQXMEHbCGVhkUXsjRLqMMDqdn14rTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380994; c=relaxed/simple;
	bh=eNXZKKJOVES7/Y5XuX0Dnwa0JJ327tz8i8Lgu6wPJJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h18g5XMj9IEoeDS/Ir2IyaR3YFA0JQvpRnC1egeMH1iM8b6fH42y8iIZb/T2v7pIUJN8k6xfL7SsKz2fp3BX8K4X5vvba5RVduEkP0qPaNM3xVOafwVMT0kLA2csAmjAYd7CzbeQeg6qRL1PmvZoB1KttzzTiAa8vGRMWj6+5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlg2Iusl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlg2Iusl"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f40deb941so156204175ad.2;
        Wed, 12 Feb 2025 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380992; x=1739985792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/QZ9Cdu0zKxLgzr6zBi4dxJDTj6qdFAvLYx0NNIbaM=;
        b=nlg2IuslmQzsZ/s/i2xTO+WzFaDCsv0OfYKEFSIYvMFHpH/mWjR6OwF06z1CSo3kEx
         xeyrA2fdoj2/zt3SgADW6PE/eY3U1UPAh4rUIfzjHtpdmmW/3M//uFk2bVfXvEUT4c4X
         +Igvm9qjgw77RJ9i/58owkKoEiXwK0Me2OHrlFtqs/8tz8jbfkSoVfTxvE4XY9rrHajX
         ruodXfz3ancKiVhdXtzZ3uDohhI9/Rea7qeY6OIj6TA4W+Nqdtm6ktLi60ydR1n/Qpgl
         uke7z2RUt3z1RyW+wzsd7ziImosXGbeGSh//mFCUXEqTo5e9JFV30goXPkcyZ8/pHC80
         UElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380992; x=1739985792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/QZ9Cdu0zKxLgzr6zBi4dxJDTj6qdFAvLYx0NNIbaM=;
        b=J6qjKGrw9DWnnXauzXQapV+eTrk4B2E5K+6SJjY21hNf5/Q8rzUaFINjc3SfuA27pc
         mrRB4noMmVFfToa5xWQWOabsLjv3U67YOICFQHsO9FkcDktp4MjHvPZnnONxgnqy0Iha
         /izxdJi83V5GsRe2gVTnEGsvDw4QgXBKP0SRxjYH7Ll7hLs/sSgQltykTkmJVhIYvo2N
         tVeTMBjqLCWRXnX3Y8vOiKIR8JyHtJxe0qBJsrdDwPbUPoWYwYUKgWPrPawPhoHPU5yX
         gAADfwkKNqCKURVrHFCwJVH9EEQxDcSXCf1FdvJFNrSYUxO5jWNzZkQlWFye+xiBiBkz
         ryNw==
X-Forwarded-Encrypted: i=1; AJvYcCVP98RL5GpRH+wPmRaBUKeF5yNy+kZfzCEf35dmrwb4vLKXRu8d200yLmex47izxxeIUHE3WDOyrlvN9BUhZELcIQ==@vger.kernel.org, AJvYcCWY338+33YUm9aQ7Hl7mshmB1Z8DYjeyhY6rmukrkyhCe6vGf7XbLCLOW0hT6YqRvmMwJ41zIW56Fbt@vger.kernel.org, AJvYcCXMc4KjZoYUwev5Ln1sbzHlZoX1vZZ3yiRZbhTNWJhoj7nKIdXR29T18gsuRF/0vwlB/EWlKSbEFppxyUdM@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqNzQ1o/mmL1A/3W6QkzHBgC5aedO8pFQmhKpdjnmQx2sP40s
	RB2QA3gQIMEYf+9XqBtmzRnjp1aJxDwZTcCBk+0E1tJYbX8S9UXk
X-Gm-Gg: ASbGncujuPC78NvgTBD5UifBuz6fPX2OZy4w6ZdaAJAWT+DhEoI7ujxqkJNDXEvv//S
	0aFKZ8F9L5CFYPZF2IRjE2hDYHaJ7DujEehMKI+ZOdxsgX51yUUsSfLRig22Sk8hEREtBOjWmG8
	mvHtoq4RK67PF+pDTKK34LvHOTxoOWMnMx3foGeSd118uJclwqMV/jIIIBegzi/ZZ5uxzL3r6fl
	bj6PkQ61wsjgNq4OE9OLT405uEyP1UjoVBpq1s74MBCbZnIypoMJmyXQOw/ZWDM8aNYF/X8kPrJ
	pZAWf0NGQG2uESDjgw==
X-Google-Smtp-Source: AGHT+IEQNqc0PtpBXRyDkY5pgMgEWMrDmrw+ZKbtGlw03mhdng3NDc681UXDqGWL92QJmsEpIhCbeQ==
X-Received: by 2002:a05:6a21:730a:b0:1ee:6af5:e4f1 with SMTP id adf61e73a8af0-1ee6b33e88emr573879637.13.1739380992047;
        Wed, 12 Feb 2025 09:23:12 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:11 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:27 +0800
Subject: [PATCH v2 04/10] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-4-87b361932e88@gmail.com>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=eNXZKKJOVES7/Y5XuX0Dnwa0JJ327tz8i8Lgu6wPJJ8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjvIb/r8ezHFnAwCF3de3uLKdW1k7kFV54zH
 bkJcFnundmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY7wAKCRABygi3psUI
 JAlrD/oDU3LI5XOuz2kAuUrzCCL7EuJrPUKPGH3a6pgI6lWbl55C/oFWyYH4L2aaToPl2s233nn
 nz1HO0vBiAKN6SrAD0N+VDLc9MagLJPU4AxWLGmQPpToGVQ2Cfggl3Yf42/xCiLhw3NZgKwSiys
 0ZxfhVoDX632zynf4Nbdb57UwIeVP7dxkl3Wzj/Z8fEpa1TUJvGvboe8QbIYuYsHVR51QVhUDrW
 ad92ICZ8m0XrvopqmwIlQyzZOsVrjoCwfWdajKfTPRJIBZeFXT1QcVTlf4K5XpNknTkMNzSxADZ
 AE6fEIV0mnElmoNML1efWjfttc4hho2Ynr9HGthMLDk0zv9+XGD0CrQb81S7spVmdaLvwhC+Lcj
 vTX/7v75j9UClPRkvxbw/0xGNq2MtRk1Ow5ye7FdgEXsCV7DiMnxNGbnfiUGOsNpyDF6fzp2f5a
 l1EqfbVYBB1Nzw2CiVqnk8njj6fA37mwo9t+uwtwYlNeSwqPH3Swm51GAy+3azCln/Dm1ba4eeT
 c839YOHRLbrxEOLJKgYKAjRhFoOfuEjDRQ5n1WyXTYxajbbK0snI4CDnfzTPTLk1JGVvIlRBvTA
 EM9LnBLU6w9crPfZu5PY4vSpps/UwCZUyUSYD4Lu3W/2jDKXt0j57uLvLXtnPSjrp+K3K9vLdjA
 griTJjfaIYv5MkQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for configuring counters for 32-bit EL0 to allow adding support
for implementations with 32-bit EL0.

For documentation purposes, also add the bitmask for configuring counters
for 64-bit EL3.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 2 ++
 drivers/perf/apple_m1_cpu_pmu.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 99483b19b99fca38483faad443ad4bcf4b85ef63..835d602a9a33fc812982839799c0bbabef656078 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -37,8 +37,10 @@
 #define PMCR0_PMI_ENABLE_8_9	GENMASK(45, 44)
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A64_EL3_0_7	GENMASK(31, 24)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 14e6fd0c2653912a6bbbcc31e6f4c54ee2d062a1..e7b898aef45e9e18899693774ad673fd370b19d7 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -335,6 +335,9 @@ static void m1_pmu_configure_counter(unsigned int index, u8 event,
 	case 0 ... 7:
 		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
 		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index, PMCR1_COUNT_A32_EL0_0_7));
 		break;
 	case 8 ... 9:
 		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));

-- 
2.48.1

