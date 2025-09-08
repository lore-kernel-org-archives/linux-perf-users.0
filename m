Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFA2F7449;
	Mon,  8 Sep 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325668; cv=none; b=S2oqfpC82OZpsrpblebC/QWnu7A9wmHi+ItJENLHQ/eJqx+9rsc2cfeoLlbf/M5Hv/v0z3j9KnunvHDm3NF3TVcbuxCxGgxYUJKRCaqoaRsZmMOuvstKziMO7LBLSkHSuhflJFc0+sR1RPZfX3+trGGt+TmsWoteLahUvwp75EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325668; c=relaxed/simple;
	bh=C6Dad8JPpdCuqjz4s5GhSEa3XOS5lpXoC8lCTSueqRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFX6Qc+FriRTHHCo87GC6OPMmYEOjvatJpfDq7BcS+dBNY6jtb7YiTjYzHs2yUNqZ3ngJc1fp0ifaJm9JOOxFpDjRtqpuEwNeaACYNW/xEJL/Mm1nGhzindHOZbN/4NhLiX9vhwRne/38AEA2ULzG50hPnjCoT7uTgK8oxfYnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkRODvFp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkRODvFp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so6164025ad.1;
        Mon, 08 Sep 2025 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325666; x=1757930466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=DkRODvFpJCw0RXQ8fPlzbm0QQ0DIpWtTOIUw6a3gCAmfyAWs/OWO6WLDT5oVR6NuLZ
         hb8ea5GtZoZ6v96XM5QkjpuSmicrp42agOd3ynYmbRlJNjF/GYZmYWfiQoP9r94z5IFC
         3KVt47K630UCldy9K+ovDw/Dv3UDMG6yGoDghKuo+PZuyRVic6JOpxGD4iZpUBgBrynz
         rYPktRwkLkm8EavxCHzNw/ofYe3zs8SJiRg5GdLh0QvUMpaeaAMRCOK+YiRehFdVugvM
         7Q/fA62QgZVirlWxknfGK3MWcHNpTJnoM14mn0GJTyPZYdMsbCsLEf6jFVrNogbxRrt5
         Czgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325666; x=1757930466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=bcqLejVIjLjOoi1V+R+Pmk2CkHVkr2wo/dffCuhEGuxgD48Caq5H1WarxzlN45h0ak
         W1e1VAYs+e+boe/AkGPCLGSjs4lOVwuAmXKlmOk2JxZvyYOhMtgnr+6+1hJvH5sx/4Vk
         uHFZxlB6e//TE0pqNXM1q8gD9UE1No+1CtFsm86JPk3Yfw0Y04DuoyPlWtzsQyhBzils
         OpEvGTDqLaIoX0PclpLiT13KlGfYzxFD62XQsegUebBAHZLoeILcKWyMtSb3WcfhYtgo
         8v1dcaPgcTScBkVkRmrTyLPlpeh02uSZS45m8hS3hlpiR5H+H+2JuC4GTm6boJqF/xyz
         DgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUfZsbkKr0IERmeX0/KF1yoZA+oNgGzYv+aBC0eGKlc9n5PmiO/JdTbM5YrSzHXzyjXofD8tYglTz+tGHi1@vger.kernel.org, AJvYcCWCq2uW54UGf+TlCZ0xA6SUJbms4FZFnwispC8HY3BGEoZrKzJ0WeMQHO87ziq/SZ3yxnIuIHsI9ar2dMxHmRuzQw==@vger.kernel.org, AJvYcCXe3xk9ZDf30qSGjAIUqpzQvZ1JjHsWr4rciGlB/g1W18Mo+LJp3XooCq5Ef937JqpFgTuyxX8jU5Gg@vger.kernel.org
X-Gm-Message-State: AOJu0YwYg46jSYtsK+hGv0dyuG/uKxWR50neywAWbYbI5U1gsXVQMobM
	3GIa9nBKPnBwt5vvG+2Iya8vqZDWvHkYvs02MkFc7jws4/zo7EIyj5YG
X-Gm-Gg: ASbGncu7KTqxv6EYKFfpF8BA7jBCam9q6rrixT/AG04EygfhurfjXavkO81XxzNcv9C
	fCMX8OKhtsOViVh6LI0K58mfqbQbBFtoaaYXnZUbKTUFEip/Ft6u1iwUz1xBS2mcjAsFR0w+t5E
	D85CTXkbpstiGsHvEIujuql8PhXivZCMGeWkZY9iMYrXBud6jNFpqm1dvCqearCv/dD7GxjiOqe
	3/JAb0MIvc3LJ63Mrb7lQm9Gyexch76yQuvCSAMIodrk8Za0rYzzc3FqeAU6gdr1cxhxGtJU0WB
	Y51o4PVIEjJMriGI3FZpXofHLoG7cPPBZr+wV9ywWZWbAFQ164F/vAbu99L+5kcG4CvMScZUedU
	MsERp5m+fSFtM5CFLxejH0yHbevoNyaqN3JRiBQ==
X-Google-Smtp-Source: AGHT+IGWWHiKtpsu2QdAXRL82r5j04D9+oNux4leyEfdfdI4Mn5W+IrDB1mcVdqQVYqmtjY+ExOHSQ==
X-Received: by 2002:a17:903:234a:b0:24b:e55:34b with SMTP id d9443c01a7336-251722922c1mr123807425ad.31.1757325665919;
        Mon, 08 Sep 2025 03:01:05 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:29 +0800
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
Message-Id: <20250908-apple-cpmu-v8-5-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlD3N+SiZMRkNdtDE0OP5I9wS4J2cex7dpSE
 Foy/InTsRKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQwAKCRABygi3psUI
 JCWjD/wKCDBrxnc0BnXSw+ySFzk06gEQT9Hag4HuvuMWKisRlL5pPvn9ri0BwkHcfdJ5TlgE2GU
 MFmEaXtrAXUNG8jL3DDiyBpeZWjLiQZo7G5ckwlKp7S6WDdPhzwFlb5TOsHjg8VUWIcf9wJUm6S
 7wwzd23QfpnMP7k7xvALkJ4klG4koXG7ANuGbnSav7Y3cYEF/MgPaTUm4QyZt9pk0S4JZnZkN3d
 x+8UrV/pvBaSa7osMjj1RTU9ZCiQeGrlmfBo94vzdLy0i4oKzEb8RbkqXObHRaU8jc/9wR9a+YD
 y0SIRETKPpwYOxgkDBvhouVh2PSdEdO8DOEMsj7CNCdrdHmKVrzCDPNiAh8rsuZr9Oy/FcYBHDW
 3KQ70JA0oB9I4xFyNBLviFDzWpHAgYqoo5DWGICYAXBRTsx+uGIP+GwKt/PfTrz7qPAhhkRREvr
 lYvPajB2umqznZFQZY8R1bGCnJEyO1qf0JAmj3zOhY/536/hZFcKZfuUvIlQvtBt42g5pExCIB/
 nEMdo5Jbd3O6KU03jndXs5JNcJMKVRaZz2embvJlhy7ksrmAbb3R7MNKnLwAchDndToqG39uxjv
 zQbZ7WCDnPuMTJFCmmoIZ35OhcLCLNBtRcw/T9YbsCXG5QfVcyn8KAhmau/+NxwegBZPke0tG+n
 Ko3+GvN1XAO8cZg==
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

