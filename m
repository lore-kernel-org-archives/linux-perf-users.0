Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508702D3228;
	Mon, 11 Aug 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920555; cv=none; b=UpwOij1omGFWL3m7c6Io2MoDSeAguplfzcoN5N8/lYmzgUfkdCdKyigiv4ESbf2gHZApLNM9kOuX+U/CFOi4JlwfTIqEV2iluhVgKufXXO9RgETAVre4AFAFrsDmTfNUJMDcQdDisiq55od9GHhV/B0HLDmnrRHuPJCPxs+yDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920555; c=relaxed/simple;
	bh=rJEh82wGCRPwRPPohQLW62LiSlqQUIRYkK3du7yGRa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vb2oBNfOPYVoQ5FkSbIOm0aUt4zbhf33UtXgeksGW4ELzVK1c1lVH7nReFKzYEAxrfZSP8ochnahhWn/y1g1jHtHcvRF/zQvukJaO5Uh4cH+DCWGQf6lwPq1OeRvkixhYlD03mc7XhkbiZWXixDnXj7gudUTLH7oj1Xay8oD6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuENHBug; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuENHBug"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-321265ae417so4886726a91.2;
        Mon, 11 Aug 2025 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920554; x=1755525354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDVY+floFa2ezVtey4+H9rO7T7eR2nRSfvvxjj1eIPU=;
        b=GuENHBug4tmELSp6OaiAHz3CXkblu+K8WL5hnnYy9mYGeYUcMV//rUH5rgQXYA7X7g
         eIf0Kdrj5HP4TP1W9gTT7UQLbkCt594y7i+by4JVvARr0qrQPOxO7xe7aOKc0wfTVS1v
         qwFHn2EPERNi9vR2jb/YvNSsmbj1mg7c9NnfagjsHvpzOh7KJsVesDnOsje7znbZAt+I
         z2GfC3Ch9TX5m4191BLThiRi/MU2RIycGyXkhY6F+ANBT40PoLTVNhgzTCEHak7Mr/Z2
         H6ktswjTFuKLYRpiE02MPuZbd2Z7i5Cuwy62IFPiX3LbFkQLyj1cQlSpLJBRSsmO3Bct
         hlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920554; x=1755525354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDVY+floFa2ezVtey4+H9rO7T7eR2nRSfvvxjj1eIPU=;
        b=SYL44AFnwm42vVIExPZFxnA8UoOSoxmfExwjHuO2salERTzdCi+KTYj/szHc4oSYzB
         g1t0V05I/CGVr/X/A0kPSMrsDuQYEfm8mvSMk4js1qtrO05RHTjExTSPWWleqe/CylE3
         l8VEP9y1jSiw0deo8trd34uWFNkZsg2qTGnmngNfNnn/kBun0qcYgOaJqchItrk/njVs
         tlGFUSNJk8pj9pOiizAWq+VMjL47yAGfgcgzl21R9ItjidHdqGR6F33PAOp10K89JcJm
         /goBfsj2Nh4i0NZmffkeJUInQkYdcoNrE49TzEhd3R/WbTnn9wyQAEXdpcf+s51q+ura
         IXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfbxDhwjNXOsbeMmBYAB6nM5ipeTHJd4aWuE5PoPdXr/+UoOlt9yBjI7FlbCqd36Th+DncxlmCWOWF@vger.kernel.org, AJvYcCVnPYgP/wfvQqpHIZV6uExd2gac4pMOdaS1IHlTJI0aYLeYrZMQM5QMYyySo6AWVEllgxQbJN0KRtTHlKTDP/PeSw==@vger.kernel.org, AJvYcCWQ+95YgGd6OqGB1I2FJulMjWvZfleXJB2KuWqeiSECBjjPZeaSJ1D46lCcJ+HPx5m8rmMjBS5E20klZ7Pr@vger.kernel.org
X-Gm-Message-State: AOJu0YwO//AhZJpEvpVe6bt01TsGZsiLBTPZrre1r1MF8gpovBgga4By
	5lZuQr6uTf/kt581qYDYRvWemSJiLvGZfLrYLTmA1g6hYF0G9WUoyqan
X-Gm-Gg: ASbGncuVOfqono4sU7fgAJQl9JC7NH1E6NIMjx6a5t0ZRE91U1W2E4/2kxRnyBD6ePB
	whe+9JECC3ZDmA+mYlgfm6XjOFR2no5HWWBilARFzN7I+fcGiJPo4H5hyr3Xi2XQ6lt30XUOzIZ
	FWGjF+XZlkXByog4cUw/Rbkz5LTk1pBF0iDh7lGCzfTkI7h2hXomGI+NNrsi0djL/xumZIe9wtd
	IPYdHNgGs6et89uxbA6b4Pqg4UHjyvKCCT2292VkQ0iHmDkam/nF4n/xKRxsxAv+hRM/tLXXGxf
	GVLIdL8dNUf+wIVyO/GEi8iN9/2WsMkfXKvE81yBIR8RsGDjjJ3zPdBLuvsNDvcxJA0T5eIrru0
	ZAyUT0wPePvKRRmrn68qJSp61ewx5z/suisIFBEivDYc7JbU=
X-Google-Smtp-Source: AGHT+IFHYu4SuygTS2Pv64OtW/PfhQ2vvq33RBw4veHS8wGA7QxBbIvP3IPZUwQnuYvJwPanzLoq1w==
X-Received: by 2002:a17:90b:3951:b0:31e:ec58:62e2 with SMTP id 98e67ed59e1d1-32183b4372dmr20235148a91.19.1754920553651;
        Mon, 11 Aug 2025 06:55:53 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:53 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:39 +0800
Subject: [PATCH v8 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-7-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=rJEh82wGCRPwRPPohQLW62LiSlqQUIRYkK3du7yGRa8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZBAE1ZeRU9azngbXDBhjZOrauWF+RbwzpcH
 d151f7gM5+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QQAKCRABygi3psUI
 JLx9D/0RwIYF7uC/co4Z4YfJCCCwa4GKOGenRwclXld7Mei23aSRP2SbAu7AdS5Lisyfe2ZnnPn
 oY5NZR7E+Hbv5az7uJqmlJhD0Adw7RYeTKwa3IzegadLYOIaOtiqYY+jysGgka6O9L7pZm8YpDn
 T6JmnJ8NI99qmvjqLBQre9fFV0R3h8tMPnuRIrt2RwdANnB4Kfbpc7m38+e/4A0wKbXfaDKZ3GS
 UnhiXU7GHIYMBeHjmE8JOZa+HKxses2Da49GiBDEPeP4BBDrMmWRY/yd7pCdRZxM20JkTpVhib+
 uTJMoCFT7j/+DgWS+lQuNPmzFlMv3a8mMG3p52jkxmY00marEBVFf4AkelJa7zMAa+5haOPNYHs
 9RYuo+LeGIlrTi7PjnqUCqgStXq/pgV1Qb8RFpYlfTUCN+5guVHjBrlbO9GB/46X9ganQXaAHt6
 MjwMD+1TgCgsVJMqFUPjnXq8vVgUgN6PmU8QCTkEnfPfS6oyWkPkXXp+5c6j3GWWMKH6DBC7SZH
 ngFn6ruLwIBn/bFK9P0iXNwva2IWVpIKplz0NF2TXcFkGBdwyMIiiYQvHAxgysB8gWp+9ysjqCx
 cB8hjO+bC2z6NZtIw7IRnSM5DNVM5Sfc+PL13ROLXPAboyr0c06WoaFTs3Q8HYSlBXBNoTj8cyk
 Mw08b5AaPgb0EgQ==
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
2.50.1

