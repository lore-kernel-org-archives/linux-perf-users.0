Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373812FFFA3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454279; cv=none; b=Lte0ABBkgzbRhYh3hwBH8d+IWiirQqMX4AyIMdvrhWJ5riS43xBoQlX1TtPJR4xudF9aJjDNOegCCH+IkHHxRoLfUw3HbfOXUjBul3ZFZPc1+kTJelmS+FpyDlS804SkTLMZsj1Hi6dApYtSQ0pE5tDq2XWgj9T90kcdhTaVfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454279; c=relaxed/simple;
	bh=C6Dad8JPpdCuqjz4s5GhSEa3XOS5lpXoC8lCTSueqRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDgjv7gQ5T48k1RaFFXeT+H+cCeNrdNrMftjipfmLJySl6FkkFW+UXFmBopzlquT1NzZvnptV4sECbMwlvDGdJhNZL0+SoSxJvKJ2zrEMx6gMgUDRJKaprLkjApMAh32dObaItTv4JWZCjt/pmCsvb7wW+oa3YMqc/RWJcfPGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLwUSO8I; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLwUSO8I"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d53f4960so5720312a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454277; x=1761059077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=kLwUSO8IXDx86Hc256rzNrF+RWcYtp8rDCwR2okvRkJcGu++Flof4Qq3zVz1A71dp1
         ByD0CosaP3pe80EZz8noDOwMIqSdMZAy2E/PQPLI3W4nO8OMBa9A5GgU4ZFNhpIwtJ83
         xgq93mxszTUoLffbM1UDaOSBZ9prGqV0DRo0VL1CZr3fIzmiXky7/6d8lH2LTCsBXDqO
         LPIHgVdtvXuqbjcg7Fr4UsXRkoalntbRzJvVolv/CQpiOS/eQgpyQO4U3lmt0mQ/Jxy6
         lnklAMIeYksI2Y1fMSbIToWCihUOKXac3ehCdd+ySq31sxwi95Z3RxRFhI8JXlykUr6w
         BCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454277; x=1761059077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=od1wQYPP1poe30pd01WB7GekeIrkcIZ8SQiuypPa0qA4HEjudogauHnrXCnezT1yX5
         DovuRYjerz5YA2LsR2cMzWE4YkQC5q06R73kO+XDW0HGbuXEW8J7OwYwEeEKY3CAeigd
         vMnr5nIumaEfbePeIMxVUXK69AWeSIpVUMuW2Iz8Cl+lOr+dLnjZ4WqharEqe8Kwr1DC
         p5fJ2TfkV3wv6/cvDLk5NmdFjj2vodvBN1zv50N1jCTHsY8zRTG+UYdq+gF4KVEUZVkP
         6u1zDrPU4yfN1fdu9cOZXTqVYG5+xsi6D3G2aiqfjIdUiKQDWzR/oLPNIz3EWg19LC90
         X9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWas7AOxkZ6zxkqBd0jUXcMEmybA+xkmocPqTuntl2TpaLsmWBfoDW8J5WrImx2spYoTntoL18l4m6ZYuGLXCaF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15wrRK5iBkXZ19KYVl+gebGQzVIvcl7lvBg5wPPPmGPAoNwyP
	9FnYsHUCn1ktxOunUIvQhS94E3Kd8Jll6Qu/uMf2Cbb/Hef3X+VwVX6Y
X-Gm-Gg: ASbGncvnsnA2joaOAwnStUHcc7wxJLCjvSM1q9oO4JmVi9CKzcxB9lawfhmD5wMHFTg
	dB5jWdsAO1afw7iSY9XHHFIy3/yG/gKxI7D3xG+ze0qcruu+Mc8RaYEGdN0DSU8O0JvubYGMDCD
	96nZ/M8wjh3sz4vQg4NaK03jq5mIJ2ydYPGOPnSf5lRX4ddq9+uxhmOLLOTfs6EwgCwevOqeXip
	eKubD7sDveEFPl+jEJzC+BRlG91ZnpcL5gD1GIFkyRPCfK64dYiOgT8Z8zYVZj7q0lJ4aUUWoXx
	vZS7UddFMhow+25Z/gBDHwHwatdE88+u1wOfeHf1WE2/EQN357akH/5S6/Ine3ac/VIG89mpnVo
	OxZ2autrnHBhqGn1ki+cns4IKhrNEkfSyYR/Fmt1sZVfM7AJg4X+kag==
X-Google-Smtp-Source: AGHT+IHOP13PRRe4fGKU2dX23aWl9ytYNiSEVee2M+QWQRc3N0N3lx+44qmDmxKAuSsya1+ebXRuBg==
X-Received: by 2002:a17:90b:1e0c:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-33b513ebbedmr32981127a91.34.1760454277165;
        Tue, 14 Oct 2025 08:04:37 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:38 +0800
Subject: [PATCH RESEND v8 05/21] drivers/perf: apple_m1: Support
 configuring counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-5-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=C6Dad8JPpdCuqjz4s5GhSEa3XOS5lpXoC8lCTSueqRM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZtj5N/ZWQEde4e5ZFUO3AlX4qFFD8lhBDKy
 EoZXWDxP9yJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbQAKCRABygi3psUI
 JG4BEACXO8SeA3FJFQKbiTtnTJEBCSvQBz+ZfDqNYwU0oRv29B4KlTl2p+d4t5UTnHnfWgMqObs
 bkqHaEX/JgaUrBV2p3EF4JiZuTzDM9CSxpmhMX78n3PBWBy8eEiYI3dnXWyVW+kO82Aift2PjhJ
 On99dgGH/wkolrZE9y5qo7X4YCBQ2s9BeaPSnqmH71jKw/IEc+pGDvAaZqQyx3/7A41BXBRBgeU
 x9oNiTPEw3rmIoTtkb2V2125TXN8qJNdiuYLNJrTALHCJ69Fk2T4oYy9HIbRnK3s34PZh0Nh9IT
 cSokHqlhB9GMMWwsyBnHu5PTPME6609MNPNZNrQ8kjBWbXrJiZoWzX9x1wJDmUz5csPVa/Io34Z
 7dMfpQTdGa6ihQARW5mJvso13v9zKBeEvZUi4LjnLZ0xtv7rX759VWCnEKRpdLUdXECWI3FHbEj
 IHSQLtDohunqO6ZqtI+I4y3rSqxYhSOKSkqMWtU7lOlNjcB4PUpn62xKm09AknM5UGAwhwO5KGb
 R3gW+qMf/ZxKw4hat16SIjSQq7JlO2jcgviXIEYRO2k6lWtHYivbJKTJ3bS2sOJJXHr0ME80/Tk
 bd0GUypd7crXvpMhwfv59mKAtj9WrEUsPNIKVbZMZ/dympBIbjomJCSo09nTQShOGWVi1PBN4cF
 X5JBu3phEhVYSCQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for configuring counters for 32-bit EL0 to allow adding support
for implementations with 32-bit EL0.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 2 ++
 drivers/perf/apple_m1_cpu_pmu.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 02e05d05851f739b985bf416f1aa3baeafd691dc..8a667e7f07a517419c22a4f930947347be8546f7 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -38,8 +38,10 @@
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
 #define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A32_EL0_8_9	GENMASK(33, 32)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b5fe04ef186f04b4af32524fe433afb79979b791..fb2759069fe9e47146f0342fa46e40f3ab836926 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -348,10 +348,16 @@ static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
 	case 0 ... 7:
 		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
 		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index, PMCR1_COUNT_A32_EL0_0_7));
 		break;
 	case 8 ... 9:
 		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
 		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index - 8, PMCR1_COUNT_A32_EL0_8_9));
 		break;
 	default:
 		BUG();

-- 
2.51.0

