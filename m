Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E023AE87;
	Mon, 11 Aug 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920546; cv=none; b=OgmYTkLk2VUYY5g/aHkRCPcTSEEAyBH8IZU9X0+Sjk4c/wJe7P4Oa56WRVk6BcjidisaMK+1eEvbTHxFKtTA+jdhY8CjPe6EVvHsO1HimAs0mwIjbseAvu4JGaVy66UoSQZFGVOztkrEXAtD3y2Lo+6zKSZsgRpcVG3KtNxd6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920546; c=relaxed/simple;
	bh=xtnMIatmASrpTNqfCZXR2dLamBkEP1A2TcLh/eTOrpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKUHpJA52aeAQi7XrTK+jxNWXgwaRTzj6unh4cU7VJDB+ZBeO4ySNUuZkVLHBAzkbmAoHEBetCQovq5/oUmac3HeKBVrcZvJebzyCxeaZ+qcbSKSSVqf6ntyyDdiNFk7Ra+lwW300dXDWHCA3myc68Gtw8amn5GQyHTUbzdcSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQbJvZNI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQbJvZNI"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd7676e60so3673421b3a.0;
        Mon, 11 Aug 2025 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920544; x=1755525344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWF3GSE/4dfsA89aZ5XCm2eNtW6YZVBNZAI7dFS5mHs=;
        b=dQbJvZNIdkzjXvj+1y851bK/v9nJHL2jTNvKoWIiOj0/gH7XqmLrda2A93yccbaO7N
         zHQqO0/Ofa2yNEyc+PmZKfBokLLf6q6c+iqOFlqxK+52c7oPPrWNqEeawQLU+uUJBkIE
         /AaXaa39kyvQFONjjc9FWtelYsXzhWW7+Oy4IRBKh6C6dw4XOLOhovo8ZsQ043nUYi5p
         9S7WqTCB+DbwplMQhvbob6XBxeZDoJYrMt19v/wuHAQmXu1TnuESeUmg3DVVLDlZ3JN+
         6dhDMSf45JiLy+eYkV5f/icCMt9vwrvTeG9Vl0fVbe4CjaER4nM0Rd6Q6NGi/fG4BZ5w
         Ep8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920544; x=1755525344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWF3GSE/4dfsA89aZ5XCm2eNtW6YZVBNZAI7dFS5mHs=;
        b=g6cbTHkz9BqLat44l+tiHVWyTMGBjV0OIxab3Pc7frI+NJxOYPyqAXoCVzCbu7GVH6
         B8PN9JecEGDmm2mTP5p47PfXzLJDkmv3j5lweQ0Yfp/+WXPofKIiSP4WJkaTlfVapjVN
         bhCuFZanB/TS/UjR/jAKnq+Ei7E1soLWK1f7GFMamSISmQHLOsvgXGYd/JIj7X7vPzD1
         jQ4AwHNLhfO0e4gHwUknw0RCfsIBIk+Ru/CQS195wEpYWSFbUAxZd5jaMF+2yTGZl2U2
         tb9kWiPsR6UACTOmEmA4FqY1NFRzF0/U2TfelsYyqWgVtYYOBT5W+SuhT2fOkDAt/mjd
         2Mog==
X-Forwarded-Encrypted: i=1; AJvYcCULQ5HiP12VnFdKEWW4vSkeVCm3eiwvItkHu0bi3N0GuMoD268a0tCYpNQqlX0cyMhsmr5VH1h5Jm4Z@vger.kernel.org, AJvYcCUMYKcgGoMqx+bG2djqeuJw2lOa5l1J66ci4rnvH6Hubf1M2di4no1X4bkde9lEPMzDFclerTSBtyRkMwbJ@vger.kernel.org, AJvYcCUYvQPV5BzFh6Lc6M8Y3E0E6+rA9B6YBVDs3cvaaHqhs/w88fXR7Now/JCFQ+uKIR3gTaeheMXFKo/K8cEcJ2B3fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl0TtuW6wuRZtvQKJQwOlTq8pQ/BrZsUntD9K1XZer23s4ySU/
	+5PaUETQ6jFzOCYYujUtZFEyh7/QQ+s5E38P7pvhsJMUgNMsyosBHCnY
X-Gm-Gg: ASbGncvDBGWjraytXix1zOAnqmaxNpfXxCYbodzks9cBS8zikYAHId7Vh4mmj4tV+vZ
	ByRouQFUmVX7aM4emzOfgXByXFMe0AB/xsLfJXLTQNQ5MQatXigBaYwUjivVYwB6mBI+9wkiVH5
	9QcOFsV1X6akJ+nAcI3CJ5Avyg75rkrvwVp7S7FQjVaASZYgU+Nk8r3jXMwMswKo3tZ2UJxUzve
	iNol/NMqgGMd7JyndzhYYUMO28OhqxAR+Zyq7EcfMK9P4UxfSSGuf2TyFtiw1LGsYdspMfmUTGI
	7FYmJrGLxKCrWYehYrpN4UdKmAunKXsaR2M5A4o+iwviDEt5AS6fr5CJuBn9C7mc4QPbmuYQTYi
	+FQvAmK+ms69rF9JtKbu3SpIyhS4MNZQDlhPN0nCh5r1u5Qp1zg4kp/qIFQ==
X-Google-Smtp-Source: AGHT+IHBmVFZyoKMG8Wg6h8Jh5M6Q67rGKi2jNKuxRjU+SqT99Vf6o2r/iuoEW/+nJNGDHEjArMQgg==
X-Received: by 2002:a05:6a21:6daa:b0:220:78b9:f849 with SMTP id adf61e73a8af0-240551603eemr19802309637.24.1754920544346;
        Mon, 11 Aug 2025 06:55:44 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:44 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:37 +0800
Subject: [PATCH v8 05/21] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-5-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
 h=from:subject:message-id; bh=xtnMIatmASrpTNqfCZXR2dLamBkEP1A2TcLh/eTOrpY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZB/dg/RHdFjAxNBqXHOldYRPqycv+vcx/Ez
 XyK2llBy8eJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QQAKCRABygi3psUI
 JMVfD/45BRjXAHLm5YqyfCfUhQP2PwOD1WRl56SyuyNQv36fUcBNpM/ERYzgfNT1UoLpos1chxh
 lehGTKQAJUZY2OwIs279qILgKGXBRqlpaXQVsUcnNsm5TAagvITimAxTIRnwC4YF0mLRO9cN0wz
 ZzOxVaSGztxeVB2IKT40AR+3Gwomx6rg4ZSM49NzkdPuRx/2D64MUlpC8Jpa+zIr3IbAiZfzP/O
 gLAAJ2BwnTemgwz8++KFJw60xaIOm3hNJZW1clw2oFwlehs/UU+XrFwddK5Dq1hnGk45x4Yqhc7
 8481K4CeD/pSxQqthFg08WziwUIk8oTznh6O02NpE1iZgbKHzEelS4vOC5OEPbLvfOIGP+5h34O
 GhLRGVDu4unyIjoGtzBNpsEgt2VA8+zrAz5vGhudSimkZM8UF3Lt11vY9IQyLpaq7H3oEjc3RiR
 X1juNO7oCnP59Zve63U2bqa9Tro0OSb4msi6e3XiOrV/czprHQA1EFGQ3F7skVOBstcKajJwN8n
 lQowfiEbdPqonyh0h8MUvtwSSifc9K7P9078aHUlOtztScyZK30Q9hvHsY7xi2nMe85sm1FRGZ/
 GQwV1HuOs8Jw1AJpX9L7jXM9qXFEZZfIP75Nc+UcGIahVsjtB18Vw6EFwVWQopg9EKMpvaTZp6i
 YSGO4GAp69cwg7A==
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
2.50.1

