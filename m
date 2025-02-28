Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313D17A307;
	Fri, 28 Feb 2025 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715921; cv=none; b=E/uubljgrQb/gJGbupoFoatK5cnmlRGLhowtoi9EISYI8CbJX90tPCMVElhhQhIwqZsDJEmBl+U8GSJZMuud6VQMyS1VELiyoOMA4TOUatuV/vHHx64nzJh1nSEWirvIIqJF+9UX3wP/IrCMGxlWqXFFc6miV5LBxYI2xfqytEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715921; c=relaxed/simple;
	bh=ooSMmw30cz5D27+zRI7E0aoCWg0Pk9onv0uZIC+J8nc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ngbvHokS0OQOiddjDjHaJU+ibYNLAA48ZJxLftMc6R+K47ZJwku1FLd0dM5zOE6CQ9hRsRqrA44qtVsArs7qtLYpGQiIvc46MObT9IEtclwAuz03g4hBVY6D5cFFLVx4Iqo4ynvrjt7pD1qzsyIP7Mkgr6dhI+mIeTiCdRC+KBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF5/Ngd3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF5/Ngd3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso25466665ad.2;
        Thu, 27 Feb 2025 20:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715919; x=1741320719; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTBMAhg1wwruL3kSpjABOucD/sYIlHMkHK5KyQVOFfg=;
        b=TF5/Ngd3vp2m+JxOPyYrVKa3a8ah+L6k+IIIvqa2ABdNa0K9qjNPuNefjKDONiYMgz
         r3akQwNAyxt+o31qTvnpqDaHBGSP9odSaiZhQinyOH2cBaJCDByqLpdPFia2XyVf6doU
         WN9qCfV4ZTcz4Wr8ZWC438Zn5sXXaYfyzEzqmcN0B4zOJI6R87Jexgod6m5/ER0fFZRC
         ka7KjlWPS1hWO0m3/7tDaPFSPJeDrp6orarXlDoRYrZ4aXP+j2HV+MMzsYHje3oJPNXI
         XjB/VeWhgiEJUwzx8Z+/ezC7IOIvHHRzXQOhAMufD3z0PDp0QmoLepHjdzJAwj4oW5pf
         Bt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715919; x=1741320719;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTBMAhg1wwruL3kSpjABOucD/sYIlHMkHK5KyQVOFfg=;
        b=eIQtC22VLt6YKrEke+QixEBRn8D3fA7bEnZu0CeXNTVt6pWj6vY92aTfHhbPGxKtTG
         kcaeOodVpIMsukVK4jCYp1fHGIPaM6MDJ9D/n5DSUfFqQvbPs2I4lINk4ZWvxAW3Nq40
         iWxR3MW/iiVP9rxw7246bZ1YeKt1VSnJGO9Yv3WDrtmHKc4V5T6yjGwtSFrmFxN+OfP4
         u7lkJ1UBRGqLOCkVgtGiqZdIYtj0UJ9vvz3Flz6zZ94EU4qxkrSfUDD5h9vYJSjpcwH/
         +U0+fbK7z9EI/Tz2DadlsjpK5qBEun8PrAp1PrCfEedGNdc3fGQGAjjW737HWZqUrCJl
         Sy+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLIIcczH6YHRoxn53XVwfqcNKSoRQr9fK2Bi+qg+2w83fcxdVDAfsrNJgPIDNqjT2Bd2svPBv33ulR@vger.kernel.org, AJvYcCVLaEiOS/3Mo2/5oPzQCW6ZuBn/j/EcrPxKPAcPD0TXTlOtbMXinqBYpuqgY0jcOA/K4mokOtubgAlnFQpA/5Qu9g==@vger.kernel.org, AJvYcCXcjoFN2j6nVjJC+Nmxc5S1cwoCU+WXAo4jDVZOpH7nVG9jUI5FBacYy1PtvQFCPGW8Upfcz2AZvpSert+D@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNfocer7vyGMtDD5C+kNZBzHHH3Sy/9aZKi30LgX4KAFKo0KX
	unN3+bhxCQ0aEauca4Zvzwmdzqkc6vk3AsgXso95NcIL7aj2PzIq
X-Gm-Gg: ASbGncsOXABK5JWVfPQ4Cd2mp5OTTQF/MXtdkzQITC24csDA9FzQKldjevMMC/CksQT
	18hyDYecYNLfQ1BgBtRxyABRtFKfDUP8/U8Z4BTh46KfPglugOk7y85Shm7JcqB1gXOrT19nzjT
	08v30LKV9+voCMORbCJJXzu+RT4+NRVfvxAEtWNNGkpgIPudOkphiNGa7oEuxWlTBmhdVxStl7M
	+zGw85b3qvl6CqR3d1rJsSlSBC6GFWIFjUoaul3cltxsQMzweH18assi2fBaR0sSr62r+1wl7xz
	xgSJ0Z2ZIPsh5OnOJLT7Dy9eeg0=
X-Google-Smtp-Source: AGHT+IHq8gmcOMDqOVdo+g9rZYBeIqtfOK2M/L9LkF65xTdSYF8sFK11DHNEV2+dC1CJPZQwQ22d2Q==
X-Received: by 2002:a05:6a20:72a8:b0:1f2:f1aa:3322 with SMTP id adf61e73a8af0-1f2f4c9c65amr3182429637.1.1740715918611;
        Thu, 27 Feb 2025 20:11:58 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:11:58 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v5 00/11] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Fri, 28 Feb 2025 12:06:40 +0800
Message-Id: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFA2wWcC/3XOQQrCMBCF4atI1kaaTGJSV95DXIzpRAO2Da0Gp
 fTupoIQBZdv4PuZiY00BBrZbjWxgVIYQ9/lodcr5i7YnYmHJm8mK6krKQTHGK/EXWzvXKNGaBB
 qZYFlEAfy4fGOHY55X8J464fnu53Ecv1kZJlJglfcW2e8RCeMgv25xXDduL5lSybJksIXlZlac
 4KtqEGStb8U/lPI9ETGW2yoscL/UlVS9UXV8rB3WJHSQhkq6TzPL8KfZVRVAQAA
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ooSMmw30cz5D27+zRI7E0aoCWg0Pk9onv0uZIC+J8nc=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTd4UpjDk1D6VVhs32o2fr75EqGV7oPNKd8wU
 jpFbOIUVN2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3eAAKCRABygi3psUI
 JEeyEACvfwlc5UHSrdYuhJ5H0m86mSEx4innOuKs7G+tgX+cWzTzuhKzZuGgUjitXKURzePB0Y1
 SqIcgFQqu3nQxSbGkWJCS0f7kfgGAKoZiYmpoMoQUka280whTaxNUdS0gx8E41ostYPwy0usSJa
 5EHfq30oztKI5FCmXpk3GMpezzRt5W9mcLB5Glor8S0HaP9qNdVEaxAk6Id7D6C/jLKT3P6CK5X
 IFLJ3Z1PpGBQ0St8zWoRNckb7d1h5pL+Kqg6QoKLKSw7npbFkEtb1nuSiTQKyncJGXXw93ph/hr
 v6UR+egVn30ZXCBnb2Oy2N58MYgIssdkBn5Emy2Ei+/CnFtAl0zchqOjdMkWCFFCz5QN/4Yrkhp
 O34aTlM9oUi7ZmdLuU2A/5S7gnvDZ9ldGqdMI/l9f8LVAjOmIpwmSLs+QoYZJYG+O9hFxzLISg0
 vTnH2ct5JUDox8rjr7bx5HzgsdFq0++LT8WWDDX6ubs3IFNYhlGxYNVYO1Yc8phJeS7S39D0qEP
 sc/T0igR6f2uMWUMTKzgnI0NIy5klNVLQEwxR/2jUs/KIQeYSSDTb2jcSUzCREGntEcDPzCWonk
 k3drxmbFlpc4NLMJV5KbvJlcFiIgOSbUAbYbgUtsHHUSn4UC2hZOPGbzaW9a75oW+X1ILrOXLcP
 1SRUVXuAvJ8+10Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-6 prepares the driver to allow adding support for those 
older SoCs.
Patch 7-11 adds support for the older SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v5:
- Slightly change "drivers/perf: apple_m1: Add Apple A11 Support", to keep things in
chronological order.
- Link to v4: https://lore.kernel.org/r/20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com

Changes in v4:
- Support per-implementation event attr group
- Fix Apple A7 event attr groups
- Link to v3: https://lore.kernel.org/r/20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com

Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

---
Nick Chan (11):
      dt-bindings: arm: pmu: Add Apple A7-A11, T2 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU startup
      drivers/perf: apple_m1: Support per-implementation event attr group
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   3 +
 drivers/perf/apple_m1_cpu_pmu.c                | 801 ++++++++++++++++++++++++-
 3 files changed, 777 insertions(+), 33 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

