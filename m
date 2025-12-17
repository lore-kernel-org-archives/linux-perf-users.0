Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3C34D928
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988700; cv=none; b=T3HznbNEUWhDszf2/NC9Q8/UXFZVfx9+8n12/cTIP5uw6RytvfAAWIQ0jabFzcF4zWKIPfMP9eA8Jl64y3rdqH/jy7EoutCT8X3+J/Dkti3pCTJkAlCSb8TCZcQ73Ul9gFJGYEfrHJBHFwy4kmL5z6aMLpZmtuKuSouCl7SOueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988700; c=relaxed/simple;
	bh=EvpktAwcuUmIVDFq1R1ot/bW7FD9M9oCQoJjxbhIT58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpqQHEdEPH7WbDZdTAYjfl6wjKl3Qhsd2WX8ggrw9f3TpMnWgVg6RiPH5eks7xvSWe9hM6Z/naLC5M8+p0iX3nl6/64NCNwZdQHAJ4Nvp9T2/9S5AG+YaRFlF4h84EBiUWEJPYk19uSOMtEr5gFOvKZqaQFNLTZLH8FEstVJZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEBG9b4j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEBG9b4j"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0bae9aca3so52433375ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988698; x=1766593498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV04TP1qOyPuEJVZ8EkDOfgn7C3GBNsDLm8LDcSrTn4=;
        b=BEBG9b4j9AP6RRjgrevpe78cspjq4946bwd+f9Jj8YZRM8kcMzw8liwwk4DGToBaIj
         CzEavRiOPLwFQb5dafIu1SyjItkGm9NMvB5jDVhoprrmMGmGK9d6QBkWiTLxX1aq8MsU
         F382JO60tCBaO2+MX6mM4vcVt0UrXb32QqJ7ypucvEvmDLpICS9eOWdWRCWXR9uvlGSH
         f5U5cCmOsu/uNIVEtfu2BFH2EUxmjckkv1HXM6L8AXC352fxx/YhgjcFerO4NEq+wA+K
         39rr8vnkO7wIIHoGG4hZTzwggEDn2BnY0JFt+cqyMU001C+eBa8sgwSGpNt1t+Ea04eT
         I8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988698; x=1766593498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VV04TP1qOyPuEJVZ8EkDOfgn7C3GBNsDLm8LDcSrTn4=;
        b=aSiYY7sJhLSfImSN5z15vmXAfVEAoT9lVUUWES8Q9tGHK7AX9bW99l7w9+5gYvCL6L
         Elra7cd1CYXuuJqlRd4YRGibY1Pnds+rys5tYa6SJuAtSzu6LRykTC256zLDFf5Fg/7i
         NyHcZUKTCN4l0RUb+gC4jnv9398gQRTJ4EpGqhAd03VKfyHxNA5DsF/yION7wLEzjrZo
         cRdApwM6X4+uapB3SdeI/5vgu9Wet9EUVfMnBFYsHLnjzcih6w9zNsAJDZLMPaQ64ntG
         E+vFaWx9dfUtCnc5PLu1CemQ4M1EsI8xFU45iSuV4H5VAeqWp8MeNC2nRuYN1Ya8w/FD
         +qJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBVWJryKjfSoCjs90Y0/3xvV6t0IBxvHdltZOvdANrk9sWnbTWsLdVtYBK1reJtTlgY1COsKGSeBieduU5+lFl@vger.kernel.org
X-Gm-Message-State: AOJu0YzA8mCgWA+Kmu4CfuZffb/MQXGGmiqgfmQX0/KdXhzzOKuAbX1H
	kxmtSlAnyTM4n8JYo4RVioVEuuCueHY/xu1VPJw8qFzC0SUSaLSNt1l5
X-Gm-Gg: AY/fxX7a2HinO6xN8UFnYfb9GLYCBStbRBn/sXDzFcjgZksIZJuvUtkvQvvbZ/2DveA
	y9zIpmgmCmUmMnHYJUHG64cIYZErvZ3Vv4ouqoWCtFJ8ays5nwI1EyQFMsW/Alyw5WUg+wZZK3+
	5eUkf7M0thWSWqEC6NdwQuzLZV/+yNwq/hMc7JjlF1jBUcZsU0jA0v4k7PiRqzhJ3RLcVmQr0CB
	Q8WFT1nhn30/iC2BC0exWyDo2C7d7mzgvofaGMyHxruLnG2zet79xcDyVoKmfSkhjLTZMPHBdil
	ABX0Mo/VGZyxAbZWgzfUan0pmiIcoq2euu7+eO6/lKQR97ZAmdofgO6nrZNpKJ6GPseKEKE7lKZ
	F8V1eUUTYaijqixMwE7SjOzk0z+80kngQv0vCb1ywWetT1L6NjrRfmTASj5L1zzHl8jqrIRAPNd
	DI42sewsUIe1rI
X-Google-Smtp-Source: AGHT+IEpTD54HFdeMnaw0VjZN9vYnC7ljfIwzHHvSyRXdlKEsVX/LGgWNkU7U3alrGNq/8FyZgpAeA==
X-Received: by 2002:a17:903:1b45:b0:27e:dc53:d239 with SMTP id d9443c01a7336-29f26eb2a1cmr188775065ad.35.1765988698277;
        Wed, 17 Dec 2025 08:24:58 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:57 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:19 +0800
Subject: [PATCH v9 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-6-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=EvpktAwcuUmIVDFq1R1ot/bW7FD9M9oCQoJjxbhIT58=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlA5q5NsoNM1LMrGXCePOowzgKrUqQ5mi42o
 JBGkhTTFRqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQAAKCRABygi3psUI
 JE6kD/9DDhF4RO/JQidMPAlnqSVBd/rn9UAjC81WNu/nQnhSoMkXh4rdDE8vZciufv4QYb5SHVt
 QsALf8hFy8NJUP8+I51BSwqEHtNPQoJAFZzKgAt67v16ZQ/yyDHYPhY9y8ZxmEoljjFGCSsfRoZ
 7DzFgEnkPzogAVTazoe17QqJgIuTAEoJMm7TrG+WC97CDwCgUjxJkA9cvt8Ftv7iNgu05124gOz
 exyhpXoV1ZW9gX7ZDIA9UBTQcm02nK2GekfaInFaWlnULiMfjotmGu+QewVU+GHG7uZO0friYTL
 ayTSCvbwYwzjw5PODzRpzKQbKyjh/Z3WC5npjLjPOpLAB/evsOiAthhiyhxdYVmd7Zojv2JdpdH
 XQ0V0AEVjB1Nsh28NwC9IxpbDZdl3k+yOIu3yoKcFftWTWrOAVKcmVsPJZGPWP3T0rDhln8ujk6
 Yp2PvnOh9IYT327M0oKe749VDt0oXMT0pL+qxfgRXlCb9cpPlk0iat5MbpCHuLGKeWS3IbRAhE6
 i4Ie1S606zj9ud1IC1Uz9YHzG9+LLGt4j2lztc5NbzgcA78gGJLEp2YMHNrwJ2iGLcSe03jyYie
 gLn5aHAg44Pw2FOdPsvsmk6mgcqXPOQaiRB378X2CHxvOi5j+hw5Q1osulsXl/fucqYcNJYExPA
 a3XIWmgZ1cngAiQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index fb2759069fe9e47146f0342fa46e40f3ab836926..303c0e62432281e899a33fc197365c70078d6ac1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -659,7 +659,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -681,6 +680,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -690,6 +690,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -699,6 +700,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -708,6 +710,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.52.0

