Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7A241667;
	Thu, 13 Feb 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457397; cv=none; b=i7Tnzl8lKikhQ78IKfSlkEJS/WeszYtyB64luQrC9jMggNP/gHi5a5u6DD6Cc5NuqfZNMbJiEbFHSFiVSP+wmdey163uHPsw248Hn8CuLMNmIshteYwbEcHJkrOvCf6K8mvJ7bNSnCst7v1/u/9urBgZWiLy3ISa/kIJVccBJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457397; c=relaxed/simple;
	bh=JtntoT+/7KJ8q2fmzw/EEFzk/pZROlC/KV344Upuyvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeaQX44VCz1sSydGAuviTqwriHicpEMBPfr9WRkBynvgfvcnQgwf6aFKOox/sESoo8lYHflB2mrsFixowSFSwbpSlsZUWU4lM9DYF5Yzrrixpxo7aS046xZXOsieTC13alx6sdtFEDzBZH4HKgZvsxVBRDSZeG/UQHcqtRFig48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzeQ3Cr/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzeQ3Cr/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso1768143a91.3;
        Thu, 13 Feb 2025 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457395; x=1740062195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbWzWCt8OHucPUBoPro0Zk6O9SHBNwoLoq7UIHpho+o=;
        b=BzeQ3Cr/cKEfJUN8YRaEdSbWzuymArIVsCzasMXvcYODeJ+WkDo59WpndNcPpFNlmt
         4lFwlarHVKDzGxUWOZE0ndcjGv9HzADQF+RKGa5Rk6K/h5NNQja4rKrAu8UUvG9tXua6
         cOa5+hE9gyFyOuT2+t2US8i7NUj70MMFItQPpqApTCOsz3VCN1R3cjoQRxfOJmvdcMLU
         aKMRWSSdbjubkylq+2aAAOziuvSDb2SpFMrdANnsREiqh77J1fsel9rA0ANCLhZWUAcg
         o668cponrcaDjclcD+D9QL8oE8hRYRjceakF5Yvo7L3zBBPFkU8AiI8I3cpxDIj6c4cK
         cw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457395; x=1740062195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbWzWCt8OHucPUBoPro0Zk6O9SHBNwoLoq7UIHpho+o=;
        b=Qijld1A+uYmm3F2bL3ABPfQ6nyaoinwW7rNot4yqS+FPI3+70S8/me51jsExSpiUgG
         K2U8r4EwyuPrVSDIQvj6pHiVhg7fj8wIbt2SHxpRfotW4lIDwFK0x3OMiPg9uBuy72GC
         iRHpodpxYVFrJAhDY/6SApQL6H14CTD5Ns7j23OmmBM0EpaZECysEdSQy97MP+fmHIHt
         iGROD3b1ERw8Wp9/kQPrWA6K++h0crgPMNSBfHyEqwGCnoscSdut+GmTG6YuGls11Paa
         UJAkKPzDhiH18FIEFaBd85YG+uJBBDU289JUBcU9gLWvvug0/t6EHagg0MW3CNRLt/s/
         LXZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZkHzYWz5GJ+wwdHt4uEoCMsyg6ntZ4RUc2/A18cIGVspadwTIHh+7uMUZAB1XBnPXbncc7Z6UCZQu+W9FPk3h5Q==@vger.kernel.org, AJvYcCWgoz5UP0H9+cdPnqpaCZDwInQKcdmnvwVoKO6RUS2+6z8fvXIDnBVkj4PaXtxwi16YU0AZfVh116wJ@vger.kernel.org, AJvYcCXdHMlLZY9WC6vK28fmoDWMTaf13x66jl66/LwpW1F21ppzTHmyxQignM13fEseWZ/oCDtuSlTrLChbRf2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBjw/m5aWK7AGkI3TV+FN3m+D760V40yjSqfT68wdMPZDKO4e
	kGYjrD9KMzFbnYVPVK+cqXOfe1ILQ7mPeFu2m8hynO0M+uRu/WE3ttQecg==
X-Gm-Gg: ASbGnctw+rINQHMbb9vaHcOuB075Sjb6272V+mepCOCNqqv1CsVZTiZVZ23mqQGqCcI
	svDfDEkZK2IspyjBQ2iP724lJr5qYLYBp7Wcwhjc8vhRyF7wmpwQ30olv2at/NqPm5KUTyfyPad
	vIi1A5Fk9SJoiCgPveWgF67mNzKqRQuwLNVqj5xmE5lhafGG3UE6Yd+q8oCet2pPtYNbSGy2nfw
	w/9ACnsW+/c4IUOnn72UNhM1flA6oEfDjUWrO+lS5wA183TtsH6tEqPqB+6M1/fdtfR9f0JmxYe
	0X0eC0hSdbIDEEnwOg==
X-Google-Smtp-Source: AGHT+IE+IzEmh99k8e5LtSg3CmKmVTOX8Nit3XAE4gsqDcdvOIrzDYawcvAU7K49o8FzFkBHNudGGw==
X-Received: by 2002:a17:90b:2549:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2fbf5bc1e3dmr11295490a91.7.1739457395506;
        Thu, 13 Feb 2025 06:36:35 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:35 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:06 +0800
Subject: [PATCH v3 04/10] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-4-be7f8aded81f@gmail.com>
References: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=JtntoT+/7KJ8q2fmzw/EEFzk/pZROlC/KV344Upuyvg=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNiS1k72FP5Vi8yzUaV70bEMzBky32iQouFq
 9hIdRhC1G2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYgAKCRABygi3psUI
 JJNxD/4kWh0+R/dtz0Y+C8oJSBVp90SpR2M0VAJxr71rhu3sK1EN1s+4tZ7KevDVNDQ2PmgkKNx
 jtMXSJu/Jr9pPTWJh5cEiHqAWGWgp8KmGK62WFx2oeCkh/d/CXC/8xqI2XMQcIVXpX+Kstxqxbb
 cua/JIbj78C290rvFDL/bc0EHI4WPZEw2+DMDfu9/CMw4QVrDAATi/VqJjZzJf1ybYLWio/zcRn
 5zUmEIal92DmFZDp493LGF6fUKudvEflb4e93F9Gd8gDm4r/Wk7HX1vaKpsQP1fTgy5NcaY5c5v
 1kZ1KNbcKbusKU+up33mSIkREg1HMJFvdCLBjaoPc0p4PJu+Limq6iRIVHfo3LI3ZsUwVL7XOsJ
 wowVAAk1uqzDEK/qw+JSQeD/+9+Csc3bNPleZeO45HMV0rWh+l1rORpabuqjRec5NKRIpfHq5mw
 sd5TZpWHA4neV5UW9gVZ+wKFD2EyyS2sObiLW+y25BWfFsakND0Qu7kzRXy43DahEEqFImgCPal
 DKVixg7rc7L9rj7L5fk0xpyoNafq8tjGM0BEx2aNWL892CnatL4iwVuvrDHV/JR0R48aVSAJmFy
 yC+3kcwoU19FkONVISknjxj+4HueXKjBYbC1YZ61drvdnxZa34HcHDiBVAzMUwPPOQV2UE4zAmo
 o4SfSN4Lti44YQQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for configuring counters for 32-bit EL0 to allow adding support
for implementations with 32-bit EL0.

For documentation purposes, also add the bitmask for configuring counters
for 64-bit EL3.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 3 +++
 drivers/perf/apple_m1_cpu_pmu.c       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 99483b19b99fca38483faad443ad4bcf4b85ef63..75be4b4c71f167a6874e22b38dc7c0bf30d25a47 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -37,8 +37,11 @@
 #define PMCR0_PMI_ENABLE_8_9	GENMASK(45, 44)
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A64_EL3_0_7	GENMASK(31, 24)
+#define PMCR1_COUNT_A32_EL0_8_9	GENMASK(33, 32)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index bf397fd81230007dcf52888f148e3158dc02e29d..73ba9861a15ff931b5e388b6d809dedb140e2292 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -335,10 +335,16 @@ static void m1_pmu_configure_counter(unsigned int index, u8 event,
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
2.48.1

