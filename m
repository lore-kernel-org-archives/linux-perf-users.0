Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50702512C6;
	Sat, 10 May 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889914; cv=none; b=GjcFFaf0oMZztnLHBGSR2PL6fmBvAKXuGSFPneS6f0J6iEJtcmYgWt3hNBcKO8DnzZ8WfrQqJZi6br0eXfRrTBOoGbdO1CUlqhQW+7zSGsFzZoHbTEOjfL/Dpdpc66FhKK3mTkUGJP7efnJFbERwDE+eGw/bPedzpl9o2cbPUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889914; c=relaxed/simple;
	bh=rgncqluFC8hqHT0y83Q4VleXE9Vishjne/f3KrvYdxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BG0C/JqUZIbrnogg2u8sbjzhO6f8SpTfoygBLqsR5ossyzv5m/sa0y+ujtoHHLWE3AAlKlHOoInuuDiFQuK8OnOF43k2TsJwHZYMV5zlBmMw9g9X8+alicW4oHia13sPnePn6MNEGmJPyfaT1yFB0q9vnp5t0x50wScbHSwn6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpGYtdms; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpGYtdms"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7423fadbe77so1558799b3a.3;
        Sat, 10 May 2025 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889912; x=1747494712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHnX3hiTgygahZWce81xiavlKw/l1jLJfkiYMRd1Pzk=;
        b=TpGYtdmstk2dc6IB2S8lIlhiKpp++0W2JNXBtNQ4NkJZ1ufn2lhVkO6XRlymDN6t1c
         10oag99pOkJYM4En3wvr4Kor2FjzSQ4ZCoA2RFHa0C35Uu0oXCiEU/TvLPEkqWAv82fn
         KkPDA2IPt71G69xuq7KxfxNqqZ0OTsuH347on3koJr4Zo8GfsI0rIVnYskUm7AMw6WIW
         HrcBCxOuRla3fmIfz8rb50l5JmFIHWcA5Y30fSGLwNPBogJ3Yv5A+/aF108RDwiIct91
         9ALEf2V1QD7EDTm04jb/XwROGYE/mTdNkotTM+HIGdIx2hlj3ckZ6jgGmt1paNPlFzSe
         t17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889912; x=1747494712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHnX3hiTgygahZWce81xiavlKw/l1jLJfkiYMRd1Pzk=;
        b=EV8K5+1ntVwAWNJ1r13z4fLCPwI0oT/vvZHcJr87D70Wk8ACiMsKMPIkg5MQoOzf+6
         ZWjQZVXN3Yn1ApxDKdk2uNVF5yC0IixzL+TJG55b5jPoWdBE1NihpL/xFWX5byq20TYl
         IBTNFYQxhCzKZ5jLTnnO9ZGNcceM0SEh4TNa46Jc0pTY+Tb0/o98fyFCWvNvevhykBnB
         B4bboJ0G2Ywv/zIEPkzFaSem3aM7q3UQpLfMwVX45aMlgzbld/zuHO7TTiTu7kENkwMF
         1HQ7bpCnXUbGyx6+SpyVa0bckrmW0jWUeK35yzD97aaW0BLp60WHVLY+08/chPRdbuMs
         dSOg==
X-Forwarded-Encrypted: i=1; AJvYcCVpoCt3NnUU4+CVe/voi5UK1uLx5AmCR/1BEigbZgTBhb6vfUaixtTLSY9SCLEeWoLdiu1708wPeXsHJLoq@vger.kernel.org, AJvYcCWgDVt0EQkKpGOr2Ltu0EriMYwuHszQ5MU5ayNBI1cQxXwlySACd7UVp+FlnJ1/tSbkg6LNhdLjIAZB@vger.kernel.org, AJvYcCXCX6452fu3FJT+GDT4rDomaBnIe+b+u0GK8GIrIc+JSgCjmJ3KadxHq38YpUJg8+naS3R6hfqdb86XkQrrHZTtOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylem2IFTkjOb7VnHnchC9EdtihnGkSY/yGqBwBikiNADhPQlrC
	cvXs7PwgWRAyxtJAfTf/IkWrk4KcahpnXD01ZrMtBLfvYWsUjV7R
X-Gm-Gg: ASbGncvv1cX18BIFylKj71keZic5FgTg3kFsoRnuJWKbiPs1l+ykN02M3Y5yDzlIjf6
	pgoUdeSQph1M4GJFpkmlMZ+w9XV748MzqS+ABe7tKXDYlWHppMpSe6IGahtVqSMtHsXfc+aG+Yi
	JYIHV4R8wDKkqfQ3Q55Bdexqay9pKGGzYNdY6Knu44SVpb8wAjhdWQhzg5Q8my8/NzAhWgnVeiL
	s+GgR4NfQZShFwmgzu0pXluiMw/b9t8X9vrXLfeftIRil6qf7+22t3x9kXfkr3LUxbbNMNl6Abn
	x8MnJrQeso3mYw0BJDK4jWhFtodyfaaLZnjHnWO+WcD/6aHQnqDmJg==
X-Google-Smtp-Source: AGHT+IG1oolXpZC71xiAK1KDLMdOMfFPZFR+zlNsziZN127vpwNtiOQFawx3Ol2KIxb9Dh20vgJuBw==
X-Received: by 2002:a05:6a21:1645:b0:206:aa42:8e7c with SMTP id adf61e73a8af0-215abb03fbemr10867630637.18.1746889912215;
        Sat, 10 May 2025 08:11:52 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:51 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:48 +0800
Subject: [PATCH v7 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-7-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=rgncqluFC8hqHT0y83Q4VleXE9Vishjne/f3KrvYdxI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yb7rnuCR7Li8wbbvfQFTwLfFVHzy6bxk2ON
 /21Wc9QrAmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smwAKCRABygi3psUI
 JF9LD/9CH1pB+i6CUmG4pNuZ2YBvdZwzfb8JRt6cxM/87YohcZxQbGI/3lrVqHmcaLEWWyFez0N
 i4Va63nsAm7S+vWinaCwzBufEyhbneBRTmL+Vr2hXow7Q1v0ubMg5llq+e11EZIU0SwkenR4izr
 Cf9suozi3ke/QNH6RiOD/8bOHfoLuv2BhefxXTf/PDjO6pWdJqwcyk5SGFOieFpSZn/Yi6pVTlI
 78zH2nSOqAVyg9/JfjPMcE2ilWZUWDhtciYHclc3oh/Zf7UW0KBtevYjTsRfJwag/hB4ESaeDe1
 UjVTqerq9sccgDDRqIGIWbtuCHQWC2ru2ValsaKUr96CIlpBVMoVigMpCymCXW261NWYvYJDWYN
 c5t7jhHYPkw3FOPAIs/38lW/fpfruX76X4uOGcpJAG8II0qJ2IaDOjKGGSmegJhftIXGKer7gkA
 2UUYxAcQK9DlJgLrDNYbvmo/5mRyVI5OyntCY02k0BPCTvoZH9HHeUj9rzdAH9ujEAfv7joVBiL
 YsSw+zN+TQTQlPp7gzmPB5phcoYVhhBMnTSGnf40L6fAT63gMrF+HfPQepU6GPQMPTnqx9oz835
 ZKldCvRWQ/i/QWgGWqpPR7HRThpmRD1Pw3c87goMfWaS/DGX0+jJjcZ2nzx6NJT3MfE+qQhmx+1
 bl++riHSQxrXkUg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f4d8da4a8aa0c197cd16af422b33f4cd943d379d..74e9e643cef7f9a3c9ed599da36cf9b04b124810 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -669,7 +669,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -682,6 +681,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -692,6 +692,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -702,6 +703,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -712,6 +714,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.49.0

