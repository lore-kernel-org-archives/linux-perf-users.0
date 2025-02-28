Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAC1B414B;
	Fri, 28 Feb 2025 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715944; cv=none; b=JaL8/QLz8PH5zW5WqC9fmuno+frC1+r8qks/R8M+eulY/hHf8dt9yI8/8KVeylxAxwF0FXFbQgazrxdG6sql9pSi41vCPOyXOMmHdlNLZd2zsuleF5AMzqT/optOdwV82FoWQPuyk7wS4qt1y1coqZ878hgdgDvCNN1jZ7l+j0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715944; c=relaxed/simple;
	bh=6YoEPxJ23tlB05Hr5lEn9IwiUxu3JyxaBoeQXV7L+7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXdJq16C7QwLqvUvjY1VgDzncXftoFkJmgZQKYaOtZz8bk56tj3i0TR8rcryCq8hvSPsSby67ucHa7SlQnlkTkDzUbDDz62XloDxzswIHxZDE8w9J/SsLGGzK8X57IgozFIpgbwQcIXjeVuTccYsktVFIn3dsuyfEFcTDhetS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxwXl5yK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxwXl5yK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so1268671a91.1;
        Thu, 27 Feb 2025 20:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715942; x=1741320742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN+eZpJ9eIG68InE3GWCQVcY+xomBgCqyQkRTUGWCeg=;
        b=cxwXl5yKP81WZ/AfSdPaaicBSjhceN1DejZdhflWjU1BhB6RHZYh56V8qXaOyFkzAa
         o6761wO4Ucbh4UyxZ0LEmW1Pn1HzQKl+Ko3nbPp2gncv4ZdaETOgBa8Q/aM/Rbz/oBMm
         /hZwAYsJ4bDni05wDepclpiKJOFhEmMIodO5VNYrQSfqAPiSCxFQl1mPoTJZpea9mXre
         gZ8VEbvUrpFZj0sxpZxybPdC405b97ZkSkVDEUmJQ/2Pm7Xkl1AOlDcemHmMr6ylzMSC
         /bNpicsNUzwYRf3UM/jpLZN0eZNRj3crmZ6582VUv9fWS1pLhuVuTHmqXU4NrUM95+mP
         oFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715942; x=1741320742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN+eZpJ9eIG68InE3GWCQVcY+xomBgCqyQkRTUGWCeg=;
        b=d5iq3xlXAm3GF5/NDNBNElZfK9pkJVSiSVNk/L3FIf+c306f4y7VF2Lz0+d012rn1v
         3rXAKWsa33JS5w7U4VRlVjSa5HIRL8vNbkBVlkrX9QA9sm8Q2UV5H4arlumnyYZhDnGQ
         vDES8aPK+F16sTVSvj4DmCDKbHKvBtkc7cB2N4VSjF746nd/mGt8julZZSX1iUOuPRPP
         Ng/JO8s2NyRaPReiwrwCw+DofLMz9PaLTvHlVASc3MejON2th9AdNl+BRVOvb6C+280U
         gkffsuxJRakTCSJG6gqI+V/YsjlNSz78l0jsXM9gz/35UTsSNZmck0B6IYj3ql6tuEVd
         Asug==
X-Forwarded-Encrypted: i=1; AJvYcCUzyc5ZSmSbibiPP6ulZAfYv+y4scIcBn9SZtrsMANUMr4zsY0v0Dol3WVQv0OfsBkC8NzvyUV1ys1k@vger.kernel.org, AJvYcCVkD4SII9VEP0P2OrPKMMNH6ohhHInVVy+Z64DvGwQ0BD1orzDJ6yHF7Jb3lyleJfsByFRxJBt6CcNyvn9D@vger.kernel.org, AJvYcCXchAImCdcd6AWE5F18vRiaHzdFkg3PFJU1OBOang0GTiMTb7fFKVPWnQz5DOnfgPYbVZ+cXfB6ieYDm+HE01w/wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFOjGUVtDTx8FeBXwUvIinxVt7T5I9X9iSyRO3PiiXYw94Jp4
	54QemfHWBrP+zoNsdeEGgf3QNnf7HTLEeZPMtzvXLpj8BcQGLIv598387Q==
X-Gm-Gg: ASbGncu7fyhSoQg5BwO8OnA33jdLa6qFomcNK0ozAn0smfUKjyECgb5a0nsw2cEDmJ4
	sev1XrMduYwqv6zs4PaQt+tHJycJXt5nZI4XEcmzrmBbT4YTqxhtHfVn9cKTSA/RiwIv1GDIwrS
	f9a6dNtB5pUAD8eZiSZqZM3D4WCCO0kgJDd0WPAWj5FYFFlC+aONRAmyp1g84KZsVYNr5Ke+SP9
	LzROaZKsrNiXFuJlghGccxswu8Hctl6b9UBMR6fN/SJXpBf5fehg8Db7Qf2CR4YEtitzSOdStj0
	nazSmcch979ZhonlvUXq7UdpMIg=
X-Google-Smtp-Source: AGHT+IGQdF6ah7D8WVtQqj5tlB8T681HfUUtCnXKbIkwtEbPe096u1zDzUDD1CQAFOKPJ1x9jbndsQ==
X-Received: by 2002:a05:6a21:600f:b0:1f2:e31c:527e with SMTP id adf61e73a8af0-1f2f4ddb787mr3214705637.34.1740715942338;
        Thu, 27 Feb 2025 20:12:22 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:21 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:45 +0800
Subject: [PATCH v5 05/11] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-5-9e124cd28ed4@gmail.com>
References: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
In-Reply-To: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=6YoEPxJ23tlB05Hr5lEn9IwiUxu3JyxaBoeQXV7L+7o=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeIR+A7oyzynRaKo2M82R3bzQoc3Ggu14u3u
 zrqtHcCrbSJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3iAAKCRABygi3psUI
 JDNpEACnujBcz8W76KNJTc0D/JzlK3t8TEZg0aeoZGLcmlkABBd0w8zO0HMby2QqTon3hXWcGUe
 fsd4HCdSenkuFlu3mS+Sh7moZT6CzOFYAzTA60Ltt6/Bte2kaN/SCDABXf6ga/pbxt8I0DNnF9y
 JvNha9yZ28xLrBaTSyUaVsAmR0ACZJXAJrbvMiyO4RpIMT/zoYjNmJadrTb3+WaFLnEi2yxIJIJ
 mQ7cbjVF2Gnf1jI4zM09YTGOrVH18fumF0/HDbfF+RUEYtKKBdsMdQaTQ1UN4XgoWeiRusdu9h/
 mGQlPUqJh98gPeoHSZTlvZONKsopGoZxpngCebQOjpoH5RXFJnm/K7AqWPHKSLPablaeR3KXlEU
 xNxBykfAX1om8ceJa2QydGO6IhkuH1flBWV4nzmdpZQeYdJdR45c0+QilOFfTKx0PuswdGxl8II
 4YbZKPmzhg/mCpl2a3vHBSmutsC/WxFjg7RP7RmJY0fu4FHSRkPe4hEq45Hp2XOqwxBAAVvRL9E
 n3mUulLJW5pRGT2y6vRzEU727ryGX3+GzyPqhGRAOndGTfUKREl4iIGQuu5DWiFJG4m/x1cDbie
 CtkVTL7XGxpL57bm7/uyR+3YK/QdONoVo8UL81RV+nYvsCY6T/XYRX95GI8ofPO5tWalAJFT26Q
 ZJmByVzMquGTX6g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 73ba9861a15ff931b5e388b6d809dedb140e2292..b601d585d204f9e59ad7f5216679b97852a46a04 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -608,7 +608,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -625,6 +624,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -634,6 +634,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -643,6 +644,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -652,6 +654,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

