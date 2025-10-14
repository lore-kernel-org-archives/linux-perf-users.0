Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689A2FFFBF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454286; cv=none; b=j4A3Fk4gcsxTggxyIXucAtjSu8OYYzvLrkIYclD3deUgpZsct8veqBvEGw/OpFfUgppJ41zZ0J7qPl3rhU4ceAhvXSXVmlhHcwXecOqThp7kTzVGyl5EQNBarJsaXiyX+cWqEx1LuE4a9EEnGAXz/Nun7TGpvFWsXGHdhkv1zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454286; c=relaxed/simple;
	bh=HNTQqQJemqX0WI0eYRGH+l+1PjBhJi/4JkQ/C04BuCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGGx5NyLL39HRViZ/MmIDK63nG1gWCJvZ+IzqGrjWc9KHHP4YgdwNhupqLuR8na34ua/zaWIOTLn3w4JzvKDRuq3WcdXQPApJLJg6RQu7JpmVwZ+ZZCDoueQD1HjwsUMSuyPBabK1rqdUopQAy+OXTwu61jYp7hDcFRljB7GQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2cYzEtM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2cYzEtM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f1f29a551so6969147b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454284; x=1761059084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfwDPpCiVyJ0buY5NGtfte2dcu4mrKn89k8yErLBKTw=;
        b=J2cYzEtM7hfLU8SxMAf536Bnx1W0qdLWTNIK9mBaXHG5Kc6JEr/sfI0CRfSXmv2Pr6
         W0bVhX/mvVPmMUiRdkjZDhXKkTauCQZdYfkOqAqLeehzdcpM+aCBN1zhRpa5WkgfCqpK
         94H0ka6NubBmb+6pf7nbPeiQ297Gouk0Oi+TvpV3Ym2y5orQFVAR4o9qRq9wu/VQiWlT
         ClH97Qx941eXzc+TvOgDLlvQpMAnPpe4SPZfM0rJi1fWJcorUmQfre13soCfjh6SAUb3
         LdoDB3qrNqDRVraeAAyrxgFPifhCT7MsRnAbEjIAGpjgufFVRqfE1cbJUtsgUwWOAd46
         1yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454284; x=1761059084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfwDPpCiVyJ0buY5NGtfte2dcu4mrKn89k8yErLBKTw=;
        b=LVDKLihzWz9L+wseyO8cR9QFzC9fPUR+i9B0moNE5f5BV8tC23/TdPOCLQddco9Iy6
         lCkyttAW0xzXJslVRXRXwHexuzQc61oL1Yy2s2S6J/7q9B90FlqMkdAiuRkluL+ECKo3
         l9HPLCnXpkR0Yh+/tj0PtgkAaMesVML83rdEjo7273N49dA3WoI5ItZSTZ7w1BaQqDpN
         JgeCND3frTLGu9sxmtYtixDlOxOZDHiQyaal4ZN0GIbTfXOsXyox9VdXqmJqG6eJdqFg
         t+0uEHTbvg4OZK9W1pGSJG1Z84uKkGoMWnmrJS4L33yrSwJ9Tkvej13tNBkP7sE8wbdR
         oghw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pYr6C3pMd8LC+sjWJtVwngx870eg2prrRgtJAHi1znzSIN7bRtBnXQudtLqzDDyqm+MNCmtHR5/VKWw8+TE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tFWRJu2cfXhr/uWeDrL/SEZnDjBN88jGeq/HpFVpftLhR1ov
	MdhwW9T2KmLc+VVABosWrRrL+9TXJNjTiCfQzFhtp6n5aIAo9QMv88qI
X-Gm-Gg: ASbGncscAUrcmpQ3K0ElrdhkeqJppv8v6Na0BvKKSK+NaQmt0/KLtxTYcmTZqaqds/f
	Vtv1fWoXonnijkfL3rSFGUDHCBTEYA1UsQ0gGXr82M53bO448yN41JbICq93ELfBV+W6K+HZAPT
	ijjSXVvVF1NPNOpmxy4juYuXEuf0NYiBBW6mZUDOI5V1CXFwTGvA3NaC9gV4v/2WkiMLRutHfWd
	d7RDeDtSO92hAXPVs4mUggvf/mEX7bicfbGg3WzFXhJGC3tuyqSIxKktXCm4KA2bjMpA7CEvkzI
	u7lzlayqLmTqHDVLq9zKAb4Z8p2r25H/PmTRR44stbnf00jqMo42yzc9AU6tAGDmC1T7b5MPmVn
	KIWoCHiLCoCRyfIDWk8AYyReFv97m2vSB8SC1PxzWC0Q=
X-Google-Smtp-Source: AGHT+IEUcKWN4BM/rckq+Z7v24QtVl6iV0VHt+z7yTPuHHzwk99+jGJZRM1YiVCJ8sEIrmXiCaMaYw==
X-Received: by 2002:a05:6a20:158c:b0:309:48d8:cf31 with SMTP id adf61e73a8af0-32da83de278mr33888699637.32.1760454284167;
        Tue, 14 Oct 2025 08:04:44 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:43 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:40 +0800
Subject: [PATCH RESEND v8 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-7-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HNTQqQJemqX0WI0eYRGH+l+1PjBhJi/4JkQ/C04BuCI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZt+33mUgbufYlHVGEXhWTArkZwbw4rK+t3L
 3JK3LrfMTWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbQAKCRABygi3psUI
 JGsYD/9znkC5rAzIdt7p0b7H6L4B7xbkk+HxpkH85ZoVUmLNgveosIcz5Gyq3HXZq+kHAmOfnyJ
 KUJc9b4QRajZkLSGVUx0wb1GgySCYBuDATXx1QvL9bsTQEttURZbArA35JKtENAOj8Ik53ln2bv
 jxdO6MaRZVVSNOazCh3mvwO/y0q9tfmR//S6VwQ8G243/RWa07UHGBp2gRqbRGOMSm8FYottgh9
 Ctz5IKY9KClKMbZ94XRTQLy4kA5r4nhQpiGjoBTmYq7EaAYvbjpW7siBWAItsOfD+n6yVez8hT7
 csseEnllr22746D6LJoWm7tU8re+DC+hfK7OK2Doxt+NbrLRvAVWtIHT4Tt/2hA1pGZEYkamqzJ
 MZ18iXbSGKpRy6b5fpHClzsMO4LKR4tKLfKZD59tf0XMyxJ6O81/wi+A//QVCDvdJ8BmTaxpC/3
 PgmaGqAQD7ZNk8x2gHXir/lfEcXr+Tx7iAj7tlqQ+zfnnn83w56NC/KbRq7QRsrpQpmrvAV6pqo
 +5t2xj2dUTxPAO03uItkrj53zETg2wBwBxVVzEMjo+a5hpOACkhG4Atv+uDWXkBXUSfuuqMd1Ap
 evJgI64NRMudpI/XdtmHWeB9EX8O/bl2cASG3HeOwP4WmyZnXTjaAfRi7p1YKASPma/S06RkJMZ
 JAX/NiDIbAh2VEg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 303c0e62432281e899a33fc197365c70078d6ac1..d0362a1813788776f4210523efe33a3018cfef2a 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -668,7 +668,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -681,6 +680,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -691,6 +691,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -701,6 +702,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -711,6 +713,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.51.0

