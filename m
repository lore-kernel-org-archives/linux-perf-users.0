Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72041221F35
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876016; cv=none; b=kKsJ1a8W7SeZx40Fdi9Bt2BXVXI1fxzKumox7NZ0xpgz5IYmFdATdCJwmqim88oymzHHz22tbsjNk3yLzrjMHbSCpyRxou0GSjOWVY/8WTjtVfI2Asxm7+8EYsO3OVsIC4X809hfN9vw4NasFYpbPa8zfUXS6g1RjzGdOfGS/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876016; c=relaxed/simple;
	bh=zotOVX0GKcJhB9q8CrlCdh+sHyQP9XdYbY/hluH4ZmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9xIHOsGiQL3TP4LvgSKkNr+q6SqCrI5UN8JM1+hf9B6FtK5scbVJLjw91NaNCishzg3NSVim6p0voBGizNyeKudC/FY2STc4nOUcgLk9eUCyTdX0IcQRudoxDudkDxMplMxdSrlocjWAIhSKhYcpdqZvCtYKma9uEpGDkeJSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=liuwXAUu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liuwXAUu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cee550af2so99745e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744876013; x=1745480813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mRl6BLXH5K84xhTJUJU2+Misv0b0a4XYQFm5AwA7mY=;
        b=liuwXAUurUD2lTGbGqmvs4pyYh1kwb7dCRFxXLelH6TqkJ/hbde29ix//0m1YyQ0uC
         rmTtfsVAMw3CUIPwu61oU+iTXpIHHnHlXYK/LaGWe0v/272P9oNH1qKJ1Xy2prfaj2pq
         CF9qcDGx9XyMJSays/7Y25Tp+csAvLSwbCkMUNKdV0mix8Q3fqhJ2IQ3ro/0a4dB9Sri
         ABst3LQkmIh/7WCiUMMW/L6Vri7yv4wkK/XEbhJAcm2v+Ov02YPHLxKmH5fvkQdoxnOI
         ZLus9haAguM84dyh5Dt81o/6Iw/5txt3ToiE5ST6euSC9EzAQ0DeCf0LTJjZuWDKwfR6
         IYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876013; x=1745480813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mRl6BLXH5K84xhTJUJU2+Misv0b0a4XYQFm5AwA7mY=;
        b=vWfSvfKMeYx2UK3DobG0cbnTOg/pCmK4jZAm6CQ4zStZTOB1i1plH+oCVoHz13KaNk
         r2Wnt0lFr8opoB2CLTDZYBoMkQKwnaOQkKowhGhvHftM2rbWmWnS3gx4TfNTTjuq/T8q
         WT9PBuynsbKcxqqGW/aknb1xN0GBQoy72fnHi9FeoPd8qccb95bxi5MAWRI6Z4fu+CCl
         Db+X2Rgg94m5023TnxOu4H/1PbU5lijcJY3y3Xf322TDRtd7Q8xx4d8p/R4j5HTYVNE1
         tcFiOf0bg014hg3R1bzD9mrDqMxbCo2e0eVNZHGr79fqCO3iDhMsfNSm9QeMWvDvwALR
         zmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pRwxW49sr41B32RjaziW/5sWGLP2jPqxfX49hki+sn4ReZjEjzzfNVLaVKvR4q45dmL/km8cPQTbfYMo1AjI@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZ9J3KqAqG1HeQQazK3MJ2ODVbhHpY8N9GdKEhkvJYwOpWDt9
	9BP3ZsLxa7+VYYa2TeFGc49bMH6x24EIf21PQFdh++lgGEi4fKuTRw2Q8jfKXns=
X-Gm-Gg: ASbGnctdr2fn/K2iPdXGvwm7IYcqe5GWRVhgjx83uoIdz+Yk1nqRM6wHes5OcbokjaB
	7vr3s+yzB29x2ts5ERbTenBmUSq9RXOBRRj9RSgRTXiQyppSEUtkfh4WavZbe/VUogl/0svyYMm
	T7qLJpiTORFscj0mkQunxLGdDcMvb5TeownboFQVf1RmGkTouaDD1upXF/uw703KpiDCAxUCPmt
	QS4rseovUbj6nRWH01sgI6yLLSeuquj9NJNo3eYLaakny7eK+xuBV4+zAHO15rffUsnSmOIza3F
	94wzt0GmdNrQBYWCK8q7RAa/p+oel2pFFzM56Fw7lxhoghGopzmi1q4XV2QvICOv9lm41LHos9l
	KyNy1zg==
X-Google-Smtp-Source: AGHT+IHLmIpfEcWfWbVkxDsxe2X44HIa3xR8bweYVogbYXiAiMnpleL2yNH6D8LfGendAwXp5oxeGQ==
X-Received: by 2002:a05:600c:46cc:b0:439:a3df:66f3 with SMTP id 5b1f17b1804b1-44061eb67a3mr8079575e9.6.1744876012631;
        Thu, 17 Apr 2025 00:46:52 -0700 (PDT)
Received: from kuoka.. (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b526ee9sm44037705e9.32.2025.04.17.00.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:46:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] perf: Do not enable by default during compile testing
Date: Thu, 17 Apr 2025 09:46:50 +0200
Message-ID: <20250417074650.81561-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers, but only allow to choose to compile them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

For longer rationale:
https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
---
 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4e268de351c4..278c929dc87a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -202,7 +202,7 @@ config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
 	depends on NUMA && ACPI
-	default m
+	default m if ARCH_THUNDER2
 	help
 	   Provides support for ThunderX2 UNCORE events.
 	   The SoC has PMU support in its L3 cache controller (L3C) and
-- 
2.45.2

