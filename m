Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F69224232;
	Mon,  7 Apr 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001189; cv=none; b=MsNwa+QFDVR46adVDn343+gs32VKeR32JAI4KWTuJUmdeVLt1zblTuTfB+NbFJR5+To+QtBV7iYPE0Ak+LeqYukjHyK/a6A38ExkyR81Ry2YtC8806EDAbqvoH2uesz3+sn7ryYcmRGvBeD/KKnlU5nA2TZKP4E5rU+t5RiZjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001189; c=relaxed/simple;
	bh=yx4ulzghzXPNnasdFXmt4DIvCjCuPnUboqBEbKM2bdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/7l+pwP/m0SDBSwUP1FDdzZiL5JG6YE+MaPaa7Anu9n3fVToLThWyzWWhe+gzNjNnWaqsQrfG0Z1qVj6SrRW41KnWYZ9/He1s9vFaYP0ibr+/k43bfbDlEmm0LZ0j+H+BrcrilYkNCymAHnwhlvxleBsrwPC1VPCEnvUTumoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDKjOf4j; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDKjOf4j"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so5004295a91.1;
        Sun, 06 Apr 2025 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001187; x=1744605987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFRFlIe7m8d6IQT5KN9JYG3eex35751hG/N5r2y+/nY=;
        b=JDKjOf4jNwabHj7J4WQBtlQ77zRrLlqv+vg+5QinTIiyKHg+KYXc4ccmcJxqCdxaBc
         fHu7tNFIzAfDDOxlI821AZmkIlM9vp34+dvmpl48ZauBg4vgd2I4x0aqPb5saC/SqEEY
         BKFY0ALorNw+mrLl25c5StpQIrCB3vTJg6+uZlnsFRqttvuZ9maBZBFe1d8fcWoa8Q3p
         LjJcDdK1qWccmn0kQVUANenK8cqkejIs+vf2zcyjX1udkQdYmFZ1l6tYlKKzsWppJe8a
         MLFC/virfC8HLentCLUKzvRxTHPwndmlCZSF+cikj2OThsjrO8AfsHP9OJaFMjbbkneR
         Ph4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001187; x=1744605987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFRFlIe7m8d6IQT5KN9JYG3eex35751hG/N5r2y+/nY=;
        b=cQ9dj4K8pHViCO/KFbSq1xVlAxMVtgf98ectMfx4tpwu798amEw6cGNFqZFaAr7Ael
         NH/aB0KgysRDJNdaus3gwi/ZOQ2VVnk2qR9vYtQZ0oD8lstEBB7gvs8c4MInrRslMZDf
         RxJoXPwJ5B0GfSpyOeb9n9fgP6hJwfw9KcO6QhzPTLISk4764ron9tbhlmVmbj9jXzh3
         Cu1s0AEPwZIxKiOUvOwLP5914yEqzbnYPr1WLJT64fmMZQ1NMQUKxwLqnYhnlQx7XCCF
         PBai/mdD4axvGi5YWvsfc1+j/ZZ6d025QFEAbdSFHMO/aSLApClSpnlhEACd5h1triLo
         0/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCULGlIccvU7bVPSz3tDZ1xQinCfdqK/ZIHplVVrOcSLmYBWb36cl5vIbhKxOJvN593G4CdoTFtCSeqS@vger.kernel.org, AJvYcCUhCm4AhsWNJYVTrmxtl/t59APeaYAoBwGOOZYM4mqAfcLpZO2/RvGjrtk+l+Treyp4Lw/+0DaGxTFcbBTm@vger.kernel.org, AJvYcCVk2C+o5znOZirFJSdvGqeSUijedu54meBU5NIrUo0i7/BPwm+T98MA93/4R/YpoXX+MfDwZqzzGiMCQBL0auNaDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQh70Cu1OfINNMz5hTq0+mVoBBXzd5GwL99GrONxzQbBCGDW7T
	RgNkRnnW5lQbgAhTRk+QW4gnE8AVK29+2JSAsxwV2XKGD4mW5IumFGBusA==
X-Gm-Gg: ASbGnctPVleJ1lpOXnbbt4vl7CviNalRgjOre1IP2SPbWuW4eMBSGudnRGCfoGiWuS+
	iDQAKSizPhB9i7NVF0uA+7wJvabDN3PvsUbfSYXpCU+PtAh8ZIY9Djbn1TpnfqBV85ASfWCsUeU
	5Cn1L1pi7j1s2lIJTgexZq0NU5B55XlBaVEkbzcEJJ7hI6kVeurezkdBnz5Ex3t+GWqd5bG5kLQ
	7p7rMqOd2bOP+JD38NRtOfdsE5CfzTYszyL0VryeypvQnTc17MEoXH8sj+qV75bnrCwR0WecHrG
	tZM+RK1P+Tta9rwYem+JqhwpBPkop5RDe2dUaH2CaSDz6kA=
X-Google-Smtp-Source: AGHT+IFtOzYQwCPnZ2zUn89rY14sYabFBGbtV8W7FYB2zj8vZDYi8rLaZzpBoEuRbxFF4E3itRzQ7Q==
X-Received: by 2002:a17:90b:5690:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-306a4dad016mr16981125a91.0.1744001187582;
        Sun, 06 Apr 2025 21:46:27 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:27 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:16 +0800
Subject: [PATCH v6 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-7-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
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
 h=from:subject:message-id; bh=yx4ulzghzXPNnasdFXmt4DIvCjCuPnUboqBEbKM2bdE=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iG2cjlECAVc2xh3RvoP5G4JQxHopLKpmx5g
 EZq58CWMdSJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhgAKCRABygi3psUI
 JI48D/9yWpErN8+SzWqorucLiJZD4IWKvA3WTpOs9IDbnYncSBqRyTdCI8cEz9NTaiqmK9rkzyT
 eOs3LOoSZ+zDpwZUisCRnHzpnEWpG12m0U7QT6Dz5T9jxospC7BWtE7jR6erW8qaVl1cyQCLgU+
 iRTqhFHDQzEj+MgveAygx9JOuBbKhhUWEC+7JgLvc5Ilb1JhhUPeK5klyL3Wd1gRW2egeEj1EHU
 GNYLKC2XQGV4qSlT2eJ6e+2eInE2J/JunpGTlzByHG4YtNmtR6dwXnS+qibbxXRM1OkzmZPuL/l
 +1vKcfM163wH1eWvbfOBT65Lnl1eH9AN2uQyNqIvReOdjpybQNNmBmzzczAMoqElZ/Mpj5pd4Ns
 XnBarMiJi9UNyUFDMIKPcTrbPtF1prH8uIgkRAdC+j/7vsrNEiGIgmUIkXdtLHRID+fX4PYEo+d
 ZeVjdI7h4YzfhPLU2EtpmSMbDj++A/3/9wOFmJzyENVyXbWMS4qHd59WSks887yNBrwCo2gtOh2
 Tc1wh4/AliOJ4HOPCFBIvF3IeqZNDSbcHobgfWRRvIsSCIt7wCjIkKveq4uXZy8K5t3HWGhoIrE
 +bxFXCHXYH2UGWPzro+sNN00HB/IYyK4O3EMHdCNHZyzxaOpJlBimgGfysoV046rU0NyzpwHbzV
 hwi9OqF/hPlp6kA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 38fb9200369c11d0d7674bec4f350915c67352b9..523ad37a07521692206cc438b8d777f505506c7e 100644
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

