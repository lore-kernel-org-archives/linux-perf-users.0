Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291120DD42;
	Mon, 16 Jun 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037556; cv=none; b=cZSNZrJj5KEPsykmHeDm8KlTX/NRtIbZ4SKiZdL3Kv8rm6CkKB+//gwokDXKx5O68rClDC3wbl/uwnQPYNpFTSG8Y4Cr6HUAJclqB7EdeQwrbDdYNx42IuO3Uuii2muBeM8bBuevzAmuE+MJPFzJKEoZJ8tIvnLl4sXiW4P/sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037556; c=relaxed/simple;
	bh=EHqn1hF+O5cx1kCcX9b9emwg/l7WZgXjC8JEUTZtaNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nENjSL8DRFiU67EUgCSQHQHpQfZK5W1a7lIn2zJr9AW5IiKOjN/ZJjiMHvyPx9xS0bRRmU7YDqh8CEvjP3M0xXlRe83dF74rkoNaZyuMtJcgxUNNQYwDnum9TrvBYG+Xf3DlB/2B4ikEVgq92oYH5EAFXlcOL/t9GToty95NMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHVXGK+z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHVXGK+z"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236377f00a1so33434605ad.3;
        Sun, 15 Jun 2025 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037554; x=1750642354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8V1iPWcqNA0HiKYEXXLEH80k6K3piZxher31w9nAbY=;
        b=BHVXGK+z1xeed/FQxsmCxkA0FCTx96RHxD0lPBPG4QiVTgNOn//FbtNrzhkMAej7jX
         SvdDLFhZNrOb8QkUn3jkI4NXJ8Q5+7wj/pmQ4LhgKthngczYc/PdIH0enyddF8LqAxAv
         RjHamZCDjkEl9ZQPgEc4vE3k+hdMvVxUznOaxNCb8cUIHyibGW+OoRysRKcSSERI47/y
         yCcqNYPg2rHm+koHeBotX4MZEXGOEBDq8E9OKnMLkTqWBwkwXPlOXEKSk/AV4G1QROFY
         fVXxaDTVlJP+82d5XKdrLOSvXm6cikix+mIW0ZhqGka1hPllQyGznj7k+0TNLNW/AO0v
         sPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037554; x=1750642354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8V1iPWcqNA0HiKYEXXLEH80k6K3piZxher31w9nAbY=;
        b=kom4u44jmkmAQ/cLiRx67PtLJzbnxIBojoZIVULRRg8JRVoQ5Y54tgMI8b6JhjOdAv
         GE62OhX7OTdt53hRLzksRG1x9jv1qCGId8iWLQl3XgrY55dTqGMSdpNr4+yzCeFQGqdN
         CWArL8YsPH5GAD8RbBQBmYWQfVLh7Bh52KiKEUI09PPL1lxS/xsNmY5gfwVQ/gQzfpo5
         THVtcUQqlxA/fltAakLspD5jbMULjjJwh9/fcLPkvUPnJRLrLKIY7W4Hcjh280ITMMsn
         vcx6PJo8AGi7kFPsLozKwyeFqQr6zRtQW547D97mqdbjMuHFaazj2ANRaRKPgRkHJ8vp
         hrRg==
X-Forwarded-Encrypted: i=1; AJvYcCUx11KZbAirNNARlqF/DGl9RzGL1t8dJsocbGo5rAM6Y+ccxkLrJ9Xa3I2K4Hn5C/BdiBMDCcya6DrgGc6/@vger.kernel.org, AJvYcCV0CDWSf2Io6pUsyqm3iZsayo63mu6M609D9mneM3dt0h9LErEEqjNPeMVXgNqUB/k3MMbgMHw0Hxbll49nJ9zU9A==@vger.kernel.org, AJvYcCVTQ5IdvxL7KqwCQ5rHQwyxrglHbVGld4W5cdGZ5Ljvyx1usdL3SBYZXIn+ftANVvot4wez1UkML1VP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2h1TfpqXXSSxCJlqnXiCTLoBqTfkRV2Pc0mB/IBUi57NgFtPM
	dEBeMNsYtYzFsOC5tOX/sbuE0fqoP3BAk8J4HEwNS6FlTRzRCP5O7LLnxyTxCQ==
X-Gm-Gg: ASbGncvRBLyvN7ZesIZv/VJhAgF9m+6Fe2U/oTuFNDg8LfPMlZleJkf/RPTRLGjY/Gd
	B/BNuz38gXiQld1q1yeYt8SvUk9j1WQmf8xH2peYqeE+gDjKoZZt0iYDDvwfP/lB2qAGzmg/1z4
	kcPwjCSMqfw5aA/kri5KiaVmR4HkbzjvX368lhDiCo4sORWBoDe/f8D3/yKywQdOeo55/fkQXjZ
	4oCYpJ7YOHrdhkaMvC0mhye1r6vbW/f3ETwJ8YohCuWmvdDCsOf+aFCaif748wyfsQFTKwIlMYm
	O7dB+qFPaU0VAQBzx2RatGvHQM5c89cYNN/jCUrb/biZPIo7WVGaZInh6luliiAcYqLNYw/SX0p
	4XIs=
X-Google-Smtp-Source: AGHT+IGnYwyNO6goCwhqMS76Pt1h5EgguWJW1w+NAgLWXSvJ8YRko+g652YOdF2HCeek9omQa3nO2A==
X-Received: by 2002:a17:903:3c25:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-2366b137c14mr110398865ad.37.1750037553638;
        Sun, 15 Jun 2025 18:32:33 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:33 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:55 +0800
Subject: [PATCH RESEND v7 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-6-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=EHqn1hF+O5cx1kCcX9b9emwg/l7WZgXjC8JEUTZtaNY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QXUmwc9/dCynBWE/WKymn4LvmWDoaAkcPa/
 twzLeqXmI6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90FwAKCRABygi3psUI
 JJt2D/96iuNKzAxGnEHVosM27pNigeAU5uos6CMZyL/eSOYYapNkzJGuEJOz+7fmbN+kamRLRxd
 f8iUjNFO8N9IYliG2cSGn8hV8NudpPs+0nbt0Iwz9QaZ0y+1XPMobYMvrRw/DzYj/YPJ0boaj8P
 ZAHPMAnw9roc9EoJzyyvj0+CwkgwVGZ7SvuYWsAJ1dMLtRTF0Uc4mtU9feG3KSn8xcODyBwcIzs
 eE3aNyPEtCBLqh26Eby3t7EvnNlD01HiJUIIqQAT2D8tHvqSwuHBujet9sgHIw58UjEz4h0vRWm
 JhsJzu1IcgoQckHppjcxvB2xZKd6+Pkoe1rmSpzRPJFu16DGsD7sCOYJu9dZipGb+RUBWmpiVIj
 hCy+2FSj53gJvQ1TMhO9kCi+4Dqz9O3VWV2LnC3/Sd6FaYJcy79vf8hFXy9sc/OloohbE1+7xOy
 unDyyWbfXnGKkOw68ocKgvFSZinOEtgnGzsw0MPrllKDoB3wmXTUcAOrjySr5NBQJrZHFjJSNfz
 4OX3XhU9PKPAb4ZPix4I/LW00wGMyaJxhGsN1bkS+mFkX1tTaW9OPZYUXouet2u5E6GYn433WMb
 IQrseHjlezYTW2fVewcsPYXJqXORyZfrSziRAe4NE/8YvG6iUVjYdBr3LdcjVFNDD3p79jFyz+Q
 DTwodajb9kcd8iA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 6736909a7df672a08938a392d450dc9b5b7bce9e..f4d8da4a8aa0c197cd16af422b33f4cd943d379d 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -660,7 +660,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -682,6 +681,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -691,6 +691,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -700,6 +701,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -709,6 +711,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.49.0

