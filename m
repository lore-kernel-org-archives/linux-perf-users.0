Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4B274662;
	Tue, 29 Apr 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898237; cv=none; b=dzswxUrRBjWA3g5wGl+av8WzyfQcuiEOWgDfXTDRXtw5+A81+1xloTK0f+12uNcyBc/OJUj3jXugRYxTRJPNAZPJDyjuTjzXsyWf/cBbT18TG/lBW99t2eH6Zs55T/DNKFVlMt3Qkkkq6GEIpUnsxRnm1tpook5PurdlgQjCHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898237; c=relaxed/simple;
	bh=ow2nagzt8cdbi88jV06ZnLC5cMis8xMzKWgyHSgosSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwyBuwP2klMJtcGIc0TFTf7U7esQDU9jQDxSJ4uwqLBN5KnluEu6Wuq4eZNdD4By6jl6lq8LezjpcTT1gKq2mWDe24TQdQupR9hBaz2U4H6+hbu8H6DPXWBZ3xaokPnIt8S75iJN4v9oWraTuoQ3ytyTN/UuW0FqVtk3EziE4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K466Nouc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K466Nouc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a0c05e2c6so2465587a91.2;
        Mon, 28 Apr 2025 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898235; x=1746503035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlZQxAuIqr1JT83/pU2DIYPeCs7+afDmDUJaJYT1ts=;
        b=K466Nouc7U5JvjIvYrDyD5wJCCvpICQ/XlBzNPz9CS33PP3RQA9/qdMvUk6o4/JC/+
         H9Il6mGeQbbkRYdpyooR0A8VW4oErYqMVXVDCkBSXdqZOhjHHMvBj4cY5UKU+e16qxIV
         lc7a2DUJVsPHBnC35+0GjeG2dVZOXMPf/5jvMMyJTWs0Dm4PUqY+iHzLKPoAuYgj1rFk
         4ctSou6SsmZ9Fjt0dfDN8/wmfBgBsm/LjSheatz+4ezEnBjs8Xzdxy0Zq3Ku/VYM2xPs
         tja9xZOw4zAGBEGpxLl1CxdhxuUgXF4icgr3wq8L18HWZ49v7m4gPt93N1u8RjqszwGV
         lWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898235; x=1746503035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJlZQxAuIqr1JT83/pU2DIYPeCs7+afDmDUJaJYT1ts=;
        b=np3NDcWNXAhvqm7Yaz0oYGNxIv+r0RTPe4cS/QiTeau29jAXM6IGfYMVPr4CxqGlId
         9bOdW2FSR2Bxv04xOyhgFt4SOlqGmn7M/X5TJZ6UIyEFryTYOHA+vrlyRYKk5Pd7swAc
         Q5b4Lz3U4jgMIqxSYp/X+OGVY9uf2/xubL6EWNMfYFcRUn0ypv+laXe1yqKWitucrmlT
         wW2c4BVFw7a1q8L7jcWtVP4Lqa5CaWBIFqZe9FSN7LUWnhfFAcLPVXyxLnfdk+3P/kpA
         ABQTYBrNxT5V9j/+3lWB6AlzCh9uhATNoS+hRKEr9ov5TGsZAYPWYzQzYFhEJ51Uni2P
         yo8g==
X-Forwarded-Encrypted: i=1; AJvYcCVCOf/S+Iw2kkXqJ/4GEb6kQ0wY8rSe0tdGDFflMu4iu+2koTcaB5t8N2MmhSZCG9mC7uGe2D9ZFy3b@vger.kernel.org, AJvYcCWTxQ0JuhhgHbsCYQXCnxpR8kBFPMz8WovRdzz9uqQtvDpL2HHdkscqqT/cEWPE9um8CunwwiivWnDPTIwe@vger.kernel.org, AJvYcCX76vm5TJLN0UTgD0Xt96+OziRlkWB+w3RChJ/eDQRlYEQFi4qE0zai24dHE9fSTY0NfrDw6lyMWjzz2DoHmCGhCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLtBQFfnJyAwXeARFuLthmb29dZTBPJOUayhoZoH5gRDFlAlp
	08hCSQXlr6hP3UJOtxMW9DedXtM9b41UcrTiameqc2Ldd8/YstIB
X-Gm-Gg: ASbGnct8i8hZrXaU/NUzhsUaNYppReidA4a7EdMC4G0woSSvlNafQwTY4kCyuDf2aOF
	S6lIsQPnZhQflcMmV4WPo6TKeo3068MuCHp2R6yDF0hmEZHUf6UndauxPT52CbGHtTnXVZhAZkC
	ku9a4sAW92R056yCHdqyuCG2lxHtWrjftWvIgOCrRmULtN0mE3sO2iv6u59WEcLrhnDHdwXEfuC
	3+hpFDKkDPuvCR42D3Ddow3LID7u4V+0e+vys7XkP5JrduZyoH8yMauydauAEDNQHElY4/Yf7hq
	IYvjebL6YNB44HPMmr+kFImh7fSyG0RzMfekE9ArM+eI+dS+roa2zQ73Rw==
X-Google-Smtp-Source: AGHT+IGEe3AhsETphSlWIph6FXEsmPwCoLFqhyrdsd/Ir9BZysNPL0e8X7R5+YzLiTUPjrkveBRuHQ==
X-Received: by 2002:a17:90a:c2cb:b0:305:2d68:8d39 with SMTP id 98e67ed59e1d1-30a23dd6d1fmr2058283a91.12.1745898234956;
        Mon, 28 Apr 2025 20:43:54 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:29 +0800
Subject: [PATCH RESEND v6 05/21] drivers/perf: apple_m1: Support
 configuring counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-5-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ow2nagzt8cdbi88jV06ZnLC5cMis8xMzKWgyHSgosSQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErjmkrzSmluSHWpPcLuLDWP98UII4msj5kA2
 ggHtP3TV8uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK4wAKCRABygi3psUI
 JMfzD/wOvdaDI0puKAZ/mBBR/RM2CGIJHx1W73k4qAImQG2d7LjX6ZB1XJYDIH31FYuSz1EUOUR
 PsUNC9HgogHIa+HwSQXOm3gIsNqcdPFTf2wrmt/U0FlGJ/3Va2M2fZqO1cR6Rqa/U3FvgdWPioZ
 gz8QMUiIAcik5zNGkfAA2lC8Q9OxP9fLjQRib920ucOuxgyDUecskWWgNkTAED0ajkgBBSuUHvR
 Rw058GP5Kq/4SwcSGpybBCjuP/lvZ8kmLFWUORqtZQef8pQH/L8vFstLXUSumAlu4azAipJHbSw
 HgA4gIslgn+wsTMJIM8AYS3qgjyH8+3hGjaf2Dr6OiG3qHT9vyoezxjPidCA4OpR+iIqbO3TWyT
 As1nv47Ka4snM5MaX7s/6CHpWlXrMVFMIZ08EZjHJo3nU9f0RxYqMizdkR37xJkyswIrg2T5bvS
 ctfh68fdTC8I9pu0VhjjXmXI6lHmr13+X7DETjsC2BYJgh5+YHpWj+iEHUB9kWJXPzh7MCh/f2a
 tnoNTqsK1d8Z1dG7TyVOzW2leAENkYuxtuswY1k9xxBQu41GR+Pb2LxfI2lGp1WS4TrGoUQDMKM
 yPNaHFLi53Z7QlcrlQjrFOzz/k1tD+SmH0b6HSVEnpMB6SSHzpH4UE0Z4ZoIHG/p7o9d/wZPGFV
 i60irA/fg1MBlzA==
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
index 02e05d05851f739b985bf416f1aa3baeafd691dc..6e238043e0dc2360c4fd507dc6a0eb7e055d2d6f 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -38,8 +38,11 @@
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
 #define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A64_EL3_0_7	GENMASK(31, 24)
+#define PMCR1_COUNT_A32_EL0_8_9	GENMASK(33, 32)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index c03eb7acbb66790e17967d570c71746f72e40867..f2566a0f8d330fdc0d71ae298f16ee9700a13c23 100644
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
2.49.0

