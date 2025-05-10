Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6C2405E1;
	Sat, 10 May 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889897; cv=none; b=OsDz91tZ44gnNzyP/ovjUgIg9NyjarUBEyZFG93NROpPW+vfo4uRbu04ygitSCrgulw5hDbkTKHdMVBcF39b7SvMeCIP5I9dMnem5P9HOWmsJK1MQ6+qI+nAgu2YO8ylglvgNx+F/6k+v5hgNz/H8tGufxypmXtlbA842onTA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889897; c=relaxed/simple;
	bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9fbeNMgH0oV/PzZBXqTH2gLpj7fE/DFkLgqJlKIX/YqnBZBg6ibE6jX0PHtdEhSQbBGPGf/3NlXSLmA/cmBS956wy0AuYWP/8Y/PvPacVnDwR3SwYOBcJdvpb/3G8J/oLvGMl9G5AurU+CrXGNHCCWTDNbS69Esco22cOIgkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvtWHId5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvtWHId5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so3202315b3a.1;
        Sat, 10 May 2025 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889895; x=1747494695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=OvtWHId5gk56+Pih/HRnOEIYWNnBKGVGSHuRcrHflzAU4eJdnYcojCd+BX8PKSU8We
         acqM6Q2fpQP6eFPYdjczXafuxiltf21t8SCGyL35kSz1OdVTtl99WoHJF5S84fE5onFO
         M+VlJCaydvf3wwrDIxUotQUIy1HMFtm+IuVO/d2y5PNnHrVkNCECQk5qUJm6O1N86We5
         LKK2V1xFvLcVmkKshfFVEFscU5QN2IlXe0mwpZP5f3Z27zH3kHcdc1yzc7owoBPsOjoa
         aQsrWaO+GGnJnTtYx5U+/IVcYXpPUXgJhO6AxPDRLSqftcWeuDIdJmXrKI/zqzoLPbcZ
         j1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889895; x=1747494695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=hn5HlaJwPdX6vULL7VABREIROJqZ5sIl6ALSsPA8sQNhElKlG4HfYV3LlbH1FnYq+t
         Ce3k/Lp9YxTUoDq390Qj0bg8k/bCuVQOBAfhmy9z6ogLGk6XftnDWr501bdW4o/UjJ7x
         2wZ5sptspUfP/+AeLUikwBWNeCYBJ1gDvrP4G5FoSYSrVWrmlGZJn6CHJ10IxTctYPRS
         Dt7JLvhLJscN07zG+NNDvAlWFr/ozswZawkxb3H/7gK5+wIP6x7p1o12J3IPoUsbLzPM
         OLUcKV9PRwiQi8aF4HrB9a30lTn5dPNr0I3oOjRvkFewmGmnjNHSVaKbKl/TsmkNX78d
         7K2w==
X-Forwarded-Encrypted: i=1; AJvYcCU75U5PJlL6R6l7DmQmBpIAi0jjibE4DkrqLp5iiIRRSYB75OQK2zokSv5jrC4puXO+aWx6B0PXz2q4d6eB0r3aIg==@vger.kernel.org, AJvYcCV+1Hk2ygTfLVyQ7JqqigKpcIwELDEDfrhi9IGcdM2GOWnBHnPMnwoBHt+DFuWx2lHwuye6heNj1EIV@vger.kernel.org, AJvYcCWdb2agU++Fge+8DqWWOiAp1YESCIx+OL5tpfMiycY7m3tkzyTKCjrzPoi9uqmKAd33PmI1EuV3NOSJRE97@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlvmhB9v1tbmU5LDOLF2WX3xeI90hnZV8JfUSo/6UmrNXzQYN
	1o6giqHGLrExLilOfuRGuv5Y+IGAUh+tBZX3l44ClcnXuuu9Wylr
X-Gm-Gg: ASbGncsQ2kj8T/w87HuLqwi/nc6Agi9JK4HsmfcdmQT95X97KMGsHuKCXUaE0yI4YjC
	Wn4pFDUNDUy+WoM5XyldD7KZbc9UkhYcceJbOrknn/3C+VxCOWiY7RikxU6PLQUV6Exg2Mx/IYc
	30U9/wic4FNulcHmSuVSEgKGuZt8QeX55WajkbcbW7y8VQxWxeAXR1RwxY5k2zLWzBEuGgLz+Nj
	Zf0CPhrdSUtIUpjA8JhH8UphVhmy0Xi+oz898rL67t0RpjiFzDtlt95TsC5uP8OTmWyvWvtIUlz
	72toiCXAHq2/sBZHK6J3Ns+R1xHEJ45gpn/Ix6Go1P8FW7lEhMBW2A==
X-Google-Smtp-Source: AGHT+IEpcdU2W03L+ngH4AWr9L0lLRQkWIUU5gRbEMYis7/i7CZr5CfIxvk9oscXP6NkX/AWz9ny+Q==
X-Received: by 2002:a05:6a21:6485:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-215abc1734amr10948928637.28.1746889895444;
        Sat, 10 May 2025 08:11:35 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:43 +0800
Subject: [PATCH v7 02/21] drivers/perf: apple_m1: Only init PMUv3 remap
 when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-2-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yav9dcem4A4esX8WAldqGX7YwMpYCRI7OOn
 3K7b8i2BX6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smgAKCRABygi3psUI
 JLe1EACLtRiC5KVJXJwXQjR6Xb90p8ucZZefv3oZsoNIBadLSFhJ8NJIXGk6/RcQiTB76WSWRcM
 O7VXYLdMVE3s1XAlg6KISddaztrqNc+lUCiBvAjp+GYPw/QArSfcSa77jH5cON9XvFq7BjlI+CD
 balJfX5gfKBehIBeNZUbVanuqxvDgPe5kND2ER40WAJXclW+kF52eBtHXkrVsZHBtjxUv4RrlHA
 4yV8pXtk0qXOyu5xrmr8Zb2fBHFbKznsWfFPGjFSMPNXnWN3kwbYrenSr+c4QbXFb5iSh9ssH1c
 pdkij9B4LovNDVzSOF0mGaAxnPPAl08EcQfDMiMEvLm8U6xuxiVEZsBIB2UmUhuTEn0NQ7GWKM/
 PxxG6Mr7pjzpNxy5h8Yu++0Hu4PVC63qyBIyrmeO+FsZisAbij38AacFSCC1b1p+phPN2eCkpef
 XFFgjfTIsFf9wO+4wIbD3QB90583LrpNsQ5YOLLLZxH8+WX8s2RF1/rWPfOqw9e7TmZHV8mvbff
 D8LIYSW6VSYlBUwuG74drWhuvONC55Oxy8nd7JdAhRaKCDwQf8No+mnMl32+2Ow6wfwyAxZLR7G
 jFCr3J4Trd25S7w+Ywugz4Vq2q2LjkHr9JqZvfAyIVW/FqtN7wF+Mj3QjnuVEvSmqni/HEMed4J
 0qIAWTXJlqHHgXg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Skip initialization of PMUv3 remap when EL2 is not available.
Initialization is harmless in EL1 but it is still a weird thing to do.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dcfad6f33a0d18b620276b910a36ca..b800da3f7f61ffa972fcab5f24b42127f2c55ac6 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -646,8 +646,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
-	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
-	m1_pmu_init_pmceid(cpu_pmu);
+	if (is_hyp_mode_available()) {
+		cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+		m1_pmu_init_pmceid(cpu_pmu);
+	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;

-- 
2.49.0

