Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEA2673A2;
	Fri, 14 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543443; cv=none; b=lLnUr3h5L2LZJPu70iHUI8hGYVFd1gNJvWjGaKmeaau8azzdcyPVOIQH9wnuY+yZnBR5ZGDeQ0//HYfaEZXoAMWM1U5wpJ8xaH6Aw87/mU0nhUMI4rBbfJ/pM72qFJIwUtS3Kp+6bb11To+SHI6Wamuqm2diadVrE/u6eHcTJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543443; c=relaxed/simple;
	bh=JtntoT+/7KJ8q2fmzw/EEFzk/pZROlC/KV344Upuyvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maO0MR53XmrvDoB4hHj4Ts4UnMLo+Sm1JviGluArj0BLHpYtHm5pkHaGOABPYU6YrkX7USFGy/p19QS4bRjAXmfwr7CWkATC4d5f8Go9N5SLHuWKmkedO/cvaVJJKK6MxfDpY+l1j03ht8wkBZPqfXaM7WW98EdCd5Imtr1cQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVfF6cGs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVfF6cGs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso11059735ad.3;
        Fri, 14 Feb 2025 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543441; x=1740148241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbWzWCt8OHucPUBoPro0Zk6O9SHBNwoLoq7UIHpho+o=;
        b=kVfF6cGsEZf2z232mge2K1lddYok5Xn8FMp8yoWKuAtbt6NqkeOtA0Tfh1TeWyTXAk
         MxsX9OLEQg0QDg8WfhpxrvnJgCWMaovle4ZnhGoPtUWBGvIW4J/++jh+gkytxHYXXh+H
         j5YToVu+wYgHAAv+Vh4EkTUbHjW/bJ3OS4NENqIRa6087S5zPlH4/ADt8Fcp/P0MGiFr
         nMjDJ6q3wBszojMwjcD+J05jL1AwSn0U9xyWDmHUik+ZcJYSXWu4/Qr+Uv8nxiZ0SZU8
         ravpWXhYgOpcggwTrOPZTV8fds3ICk8YvAqLixmkMizDhR/UBsB95prz30EIyPrFZI9m
         bMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543441; x=1740148241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbWzWCt8OHucPUBoPro0Zk6O9SHBNwoLoq7UIHpho+o=;
        b=M2NH7wMFVuFG/1gJwBV5MR0M80lZ8T6iQ6Oaf1Nczg6gJc4k8CDU8oWzBDQo8b0zb0
         NSz0An4mFMKZSWCKyXM5goucqeU1h01IHqspQ2YgjgQeYsxqjkIXiE7sU2BmGvpNJabe
         Tut5Jm2h1hA3aam/OXIj4s9IXiwLyYG4/Ak8BwksnRCnTV/K3rATIevJYd1aZNEHRckO
         IVEeW64WB/5cwJzvJXKzsO3JMmK4wYTq6yZMMtqjRtVOF8OtEESHXTXbPj9oGyCgaVcm
         MnH/ug4zcrqcHUIhUKl4+VxSzHLat76LyMu5Yx3rHj/5f3gvf0o4ogQefkNJNy++UwXp
         hrVA==
X-Forwarded-Encrypted: i=1; AJvYcCVTWyBP7/fVVHpyxNM/WOmzodsxd8gjeS4AGjw+AWA4iZLv57AdBku/TdJWxr/AC+na7hedAbuv53CB@vger.kernel.org, AJvYcCVXQVumh0sxPWUcSSQe3wjizWMtauV4ap8Nn14tNbTOWmQ9JjNG+ypdFeRKYWTHhBizV5ys58m4B+Gd04gD@vger.kernel.org, AJvYcCXMgAp2XcAwux9bCewotAIB7pDZdqVNYULRJH9TyqBajp2TQ7rTWKJmaRfJvYdj+zxk35YA7lQcoAmSfb/63ANE6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUF0JQaLEO1w6yKBPCg6TGRAk8S0QylhDcqMbxdco4GmuRdpSx
	2tvuYt0Gks6kOKANbOmQ7dWd5xSTGy7sPS1z49tEvboMzvmsx2qO
X-Gm-Gg: ASbGncssCw6P9BJNA1pCP3fNO3X/ZhPLo8yehHWhJzz7G73qcsej35To7RjUPPsY7CX
	i1XHKckMdjyfTYbix0w3xtTJCFBdgJc1Yk6psDKERyL2YTz+vSCCavM8yezl9R5NFsFKb/rcSyJ
	lq5OdoR0qTXB5COPG4FDahPQzJsZ0oH3YftKVbbJqHvS1GyXJuExnGZVd9EEOb8W3OTOHndDynP
	a8yV0ik9sa5+Isb4ORq7q1KIRacKFxVJIaUVDRJxjVY/tSnqtIMX641RsZ2H5BWCznw9KU/UV63
	2fNUYDXIE5bGY47h5A==
X-Google-Smtp-Source: AGHT+IHItG+fJEC1v2jw86RiUwqBiXRX/eR8U/klOPF6QDGyKbVKG1IeHvzHzNB21irjeh1NLw3AzQ==
X-Received: by 2002:a17:902:ecd2:b0:220:e04e:7213 with SMTP id d9443c01a7336-220e04e74a5mr92641655ad.25.1739543441461;
        Fri, 14 Feb 2025 06:30:41 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:40 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:30 +0800
Subject: [PATCH v4 04/11] drivers/perf: apple_m1: Support configuring
 counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-4-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
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
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OAVGEnzQZGgBLLYROuakeok8cZ6GoDeANer
 886jpv7ZkmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JNQrD/9f269MjZYrwrUDFvUQJBrF2mmUvB+bgJ2lDAEEgy0lfcigPi/R5ir83D7epKRHh1as4PO
 3fNnv7iguos1pG5k7ymSqV1wn45aTo1XwJwt23CmijRdhuZoytqDk9VoC7EcYF07Iqo12PaTbuh
 6to9jSyEgfsw32TzrO3eousDXWR8Sl2w4tx8ejVqwqBnLFcuzm/NEIwcAsPZjdU1nikKTMK+2GJ
 NXQ4lngoEJKdNnbi6kIdFos+BRDe/5T8iWq/juGbhxMWwfWeMzpBFFMybJrxiIDi4sZgQQyRFvU
 moSHV8rLeYaSwvYovYJsTDnZvqk78Ig5tCPnZ0fRkJHrg+3TtYdIvtSu5kygB17dWg8CHO32ZPW
 pyuIwcbTRShMMEcr4U5RKjbi7xchiiP8PLcdUZ3/F3iQe69QEkwGh9BOeMLOXVrU7GfAlvN9OT7
 e3HhlsfI3/h12xxUUX2Ws2AUBufWGAX312kaBzw75olaqaI31x6vaQGreCawbR32c1qqBK3e+xF
 pNCYzioKnd9Mv2SvsLc8xNFiIWNYN7d5fUOjnhT5oElfeY+aKcfRTpDqq071JkeqRPpIRDiMlpD
 FUsXRsY2iYVOJzcYH3b1E955q0IT1/RNf3HGaFBAfDmLzfMDMLe8PdGAvE4HSsEbtrx/yFTwFR+
 1PXCB7zP7CCaCyA==
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

