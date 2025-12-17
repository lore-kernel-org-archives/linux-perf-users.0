Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84D34D4F2
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988697; cv=none; b=DT8sd0HZ4oBVYMOEbjb0rD4n1z4jHuCZQuP7Lrh6P4mIkL3b1JbL8x6Lgek5CJC+3W/STd/VxQlih4CsoqUCer6P3NbC6lPGAsQc+6C+YCakp0vaDRE1qdDZQBxrhTkl2QCLpweAf4Z3GmApoNRPTS6t/Vau7hywZPxa2+cwVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988697; c=relaxed/simple;
	bh=7bXhbqBuf3L7P8BkQE01YWRVlFsdM2eh/RfdYjmLgaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVYwTOqCTAALsxy8/tJ+GO5HoT/qeZEm0EBYc33yx8rYEimKJH2GOOYA174m65e0MhUp2m4hDlCKrKoDRuHH+FOOK0Gygnpe36hSmxSX8poQOVeZXdjwjKYNciDPpoybAFI/vhkNeSggIMFp7IcX8BkwuS/pgls+6AICwZiCHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN/pw95p; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN/pw95p"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a081c163b0so46250425ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988695; x=1766593495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEO9StCrTxXvNpc0CG6gz+jT3FNQyYyGTLdJvKY2VFA=;
        b=SN/pw95pMnbQuEQxXzQA0/wkVqNbsOpgX+q6fzY7rvuvh5AkFucz6EYeUujsL11zDV
         8kW0+ILPCSLQp7hWWoB5cSqX5dFRoN162SMe5MLmPD3zMyetqCdpkZNmyGIGYbWB7xwK
         ufYItGPOaC2uCL17WF12n0ghPcC9neT8ys4m7fVJ9G+mds2So+RhHpkq+VDewEV2XMiC
         NqNtDfUCcHI97Jou4eeVOuKWD7wBHJxZhtuCYXaFKbBjcHYxUVS+8KbuenW6V8Cn06wt
         EGutURvlPF6GhslI448zbURAkGNp3/d6lCy2+Uza5eckBGy2TqpcPstg6kh0xctCYtx9
         a+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988695; x=1766593495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEO9StCrTxXvNpc0CG6gz+jT3FNQyYyGTLdJvKY2VFA=;
        b=vd9iC6cLCopc/EkvaVtlCHLmfPivodVXzOL9dFVvg/C1dSg/VTIpPXu4WimoY4ArAZ
         FrbrFsGcpPztgd8zCFZvHi5INYsI4fHA9kMeR6Bxk+Q97cd1HZoNDbt9UJKbCgLmimlc
         +VGmHpW7GFmTnpBsbh/h+Zp2SU2NIy7Npc891DzUBd4KJl3DxKT/slv68LLEyk30S9oZ
         YS2vubEp3p9++5+44yq4gAZb5O6+f6wX8EKvgZmQ2AkgBoI0ejwcuqXycaKkgkRBHqk6
         DxohQE9jnmSDJ26kG8yvfYVgVsMg/42AjgoY4VFzAe1bUa340Wvx5n99OtqgjWoFa9MH
         3XSg==
X-Forwarded-Encrypted: i=1; AJvYcCU+gUKpDVlVeCH+yamJ9gQD7EJLLHPOEiEF263TXZHYkvjZBvN0OZLxoqXCu17ti5KBS86WTXHIdj66xbl05Luy@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDTf5ZR7Q4kxmxLdhc+osLp6G4giYDtd7E3cRxjwmHmkZiF3v
	VXVcH2l/hxBI9iD8PYKYwRQwgJV+DUVkWky9mI7gVRStTB4JQVanwaz1
X-Gm-Gg: AY/fxX6aQqqIDHvomgC1GLD0/6xQYBbXp8pKpS0cSpFisJPuX3S0gearXCMGGlzcvsF
	qIOfbnfoX48ELuuTztgfX5gCWHwk5G+SZPAm0VeYFre75v8xOYHwzOmwNvZn1XXsAGCxkqx3fQZ
	vrevxGS5VKeraQZZWD7wGiHVYn0QVeo5Maak9HdCItWFoxTeO7GMt6iL+TRdE8eNn08FKXi5ipf
	F+911R6Y3dvJrkSPGNbBUP5gXBXt9MDY5vsX3vW5e6eJonhHAsRMTNUH/TaSi7OoyuZfQr9JJtN
	TBqKVIZWjda9gNFS9N7ORCXPvC49vpqsOwzB7VVDNmUzLOJgiexNrC1vQlMNoJh4NwAwRCImxbY
	o7CIlBg+V87g/TROip0jmJRsHFaGXgpxV6sChlv5+sgW2R5fnmRgfcGPsaon3m5F/qsTdFh+Ay6
	ecBu9uZb+zUttv
X-Google-Smtp-Source: AGHT+IFmpldl2EnfdJLLNFecnxN4BEn3qLT3U4ZtBOkfTCMmNYM64weQR42jpdgzZIVEBX+DVu2log==
X-Received: by 2002:a17:902:ce87:b0:2a1:c72:a41d with SMTP id d9443c01a7336-2a10c72a703mr119320995ad.40.1765988695124;
        Wed, 17 Dec 2025 08:24:55 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:54 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:18 +0800
Subject: [PATCH v9 05/21] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-5-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=7bXhbqBuf3L7P8BkQE01YWRVlFsdM2eh/RfdYjmLgaA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlAef+nJhReDRN+pVlLcv8GiPeEbu1GXItBX
 8NUJwhDxyuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQAAKCRABygi3psUI
 JJnYEACaUligWBNlh+4Cyx5bBd2haSpcf1uv8Iyz9L80+F6mnLCgzV4ucw5xjJPPSAtsm+v9Dc7
 y26/bEmsMHPW+MH6e3CUZCdt6N5juF9tPbRZ5G24neEkbHqq5crgYKZAuv5xmavOxSnzk+fkAiy
 Ud9v5zCtRqxzrnpiFvPLKE1CmccaHrLi4cM/C+yfeFq8YN5Dp3Nw7xFciXBONr8SUMvErVbRTOg
 UGTSOuZSsHUH5ZIVzo01laxXoE1ALejU7nDN56soAPhmfI0YwRFZ+Mblz8ncNx51KeSE2QnQFIN
 vkWiooyVaJFc/NnDqevFvaP7FJ7yyeXs7ZvEVB5J+r5IA4u3YdxnssUbYGiOgPoObRorWtmQVdj
 IHRC+TT+JBOVs8KYGWv3smgwegxMzqCaRgzSJ4FfezmgUDvocsUL3X/4TSkhl+ZMVjPZm/NTrRQ
 yAb7ATWidvyGDNSoU87pS+qjW//P4dizYcH1lukjGyUZbgY9M8bOBCuxMKfhwjdcrU24oisCG1Z
 0yC0mOJFPzVeBc854OPDSicZ3QnUvkQ/5XhNTln/oTScT6A9/q8rIDNothx5ALBCDqDN86G8KWI
 2Q2ZQovR9cQkc1+cxFWZQ4aHYzFuHEdyUv3KVIBR8J9fpuIrmbQESOt/L/oXk/HnE5aQ8CfVTvh
 QVwkpRwPTp3jEQQ==
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
2.52.0

