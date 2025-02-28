Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D571B653E;
	Fri, 28 Feb 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715948; cv=none; b=a5BnMNuQZMmc0BfeKZZvZB7b/Ep6AJZXOzU/rihzVsavDAbE6lfxtorvpGi/3FQwxl0bQDpvGncmi/+iEXFJ+s+GSS6W1o1mQ/K8sWmYd3nZrzZN2jQCliAXnRzjz3ZW6kyRr/lZVh2UGsbZzImo6hL2RckJ/Bfrl38XHY+SLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715948; c=relaxed/simple;
	bh=ODunfawf7CVe5hX+5as3cMBvBCM9oIodivRV8l+gVA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOmcaJSCnARdmAcRgceMscm5kHsAnpvydq7h9jG2hidTpmxNNz0GaI11lat2RUp9fZsu5B7GWgiZiS51LQMHSazA5JbYBHfw3mX4d2pP+PYa+R5829Op2fVclv37LMTl8swOC7c5WaRCdmb/Nn6skjXCHORVggxnNgPhKSoQcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn6WTRvM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn6WTRvM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so3516975a91.3;
        Thu, 27 Feb 2025 20:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715946; x=1741320746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkIjPnn91/SRZervKGZC0B8yDAzqnA9SsHweWh8Mdhs=;
        b=Bn6WTRvMFIjZm7yVszwNwqRbZaIrvazBaZAxq7+SNS4ZiKfQgGznXz5t9ew1zrsRh1
         4YakHTI8WQNZlRbKDNUTVRS6tA4kYtOBvf11tGLNVJZn/r59hDuVCxNw8L8PthxvmVlZ
         Jg+Gz1cE5fEhNA1oofOKmSIiuhCV+xdb00wLNbXLKQcakTbh7a0SgCaoZZH+VAttNQQ4
         0tLqRnakX3X7WDzAQ2qdnHhiDburVhZY7NpfKPZdeR/5MndDdTbeAnDfn+qfYZEBBuMW
         PMoPxs2p2jWXLxTbrMdRq4IJbuPzunSQKyFNxmQiunt5mbfvdmaHOC/Qe3flTTlvlKN9
         EJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715946; x=1741320746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkIjPnn91/SRZervKGZC0B8yDAzqnA9SsHweWh8Mdhs=;
        b=w8qSnm1lTSW/CZZqjInyXAMd4bpz2WO6Zhobuv0lpC7ZLAVgeH0tIcgt5YfIkrcjIW
         KJhXoRNtg/hC1hrlcFaLFV7EbHzOAfv5R7S/2SH2nqwBxQnlVvzFEdrrzCHFw+cwYq3/
         pazlCmdBn+uJKS193nIA7wpMrqF5j2PTywkARl7SVfgT8VIKpfgWi4VG2cSU63GyVeyw
         7JMVNVYnsz5tfuuqF4mBqgBPbR2981hePE2YSvZeDCo5vM29xJTE+DtFiGPMmcc9dDSW
         3iNrpgBtavB6IDrq5/DWbqTka94yYQDBbEPEPdNq8nUq3L6MNMIJKxekI50Rbxkuaj5o
         YEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGfr+Kqcdi/5adm4hrFoGAAYLpO9fXzhZx8592mgUlIhWo+IHHEwslowdck1udaW0/jzzZBLM3V9LZ@vger.kernel.org, AJvYcCVpj9CGzekzYyat/WcWvxUIInf/cssYJjMitmrL/fgDopgf7wG4qe8Nli10RCDOGKbkP4SPjrkpyP3entvo@vger.kernel.org, AJvYcCW0/YVYprGkIp3f9W641eJk7VIcqbrL8yo2ejOVTFYTLXz4DL2ZV2npofziuHxrMKUfCjzNO1Co6bl20drLJU6daA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QmIDiOjWc3WS3Sq6pBs16qE5jbiB9jvXiWtxg7FO4yWJZtaa
	CLKPliGFMsZ/hE/Y7mLtcfdT/xZHSR5gRAlvjf+PjHGyrCfq9qnUz5/HDw==
X-Gm-Gg: ASbGncuefY62BWMtroYKLJHO5fH8FNzwLtVA+gPj6zmaAqNsZBrtuERgSwODnpkWR1z
	k1qxahuQ+MX8wGDXtTdR9+GSyz0o/zT+kG+hu04ZXf7b0dHZszZBJhsRuY/Gl3+KwCQ1i96eKEW
	5HE/yalIWAN+Dp6dBd50/BpODpipltppvps+/sAAL0VX6stxgMZ16jkV4GEoiiV1crGYm2x2gNs
	vMYs9DKGzHsfzAn2ZKsbCEY2Z0qYXP3lyqmnL6riTwg23cSRuibO0DZQqKysmBWu+XU2ah+9GW+
	aEyMvnCPi2EwJNGKmVRLJ5D7CQk=
X-Google-Smtp-Source: AGHT+IGHEIpcdEcISrBwhOH0M3m872e7avIuk+po2XsNHsz/FvPF88+rn1jimOEudTdFV276zI1J3w==
X-Received: by 2002:a05:6a20:2585:b0:1ee:ced0:f093 with SMTP id adf61e73a8af0-1f2f4e4de6cmr3653744637.36.1740715946184;
        Thu, 27 Feb 2025 20:12:26 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:25 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:46 +0800
Subject: [PATCH v5 06/11] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-6-9e124cd28ed4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ODunfawf7CVe5hX+5as3cMBvBCM9oIodivRV8l+gVA4=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeIh8PCw9htkPM24Wl/Zh/QTeVgaglkWxNlc
 VysG94JI76JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3iAAKCRABygi3psUI
 JIddD/oCNTgA7arcUloG6g0FN1Dv2auoakexelhUz9xCaAin3goV2BFzBBzrgyLx/1RrUJc1jAx
 4iosM+43Sn2niLgfuaYE4K2wzgiot9PrXCmT7/GKsO40Ox6GrnaQIa3eR1k0+Xv+mzwYfgpxYac
 GDof7/+DamAVN8Xp/vbH/E5bccEmIBOlpG9FwCR1YnlU1IsEQg68R6TaA2uI/arrxjq1I10z5aI
 Ftu2jI6NnIIkncYiev65c4vupqTnluwGM0tVf0r9qqRpng8w/sYCsj7ibB6kcQ1GxrF6EJw5DX/
 +YfVPt42+zpa4BisT/49FXgdjouDNmF8WO9t12PYKcxv6TN2MySK2BTUzGQnVpkyOX5U0NkObAR
 KdofpVJTBQWmeCiMJnp0oWAv23MN3Dm+MT3w/Tt5rfl7x0belHAIq4fp5EpqQVBUIoLjEuuxwoD
 Vxe5jwJddjAVbOxp/+cx0cNIoSZNi3bzpAMLmpB2N6rebTBULPtWDLvm2aUEB8LmQKlkpRCPBgo
 UMIWEPe3rJYx0o1M0nk8RhgmiNVE1YAF586sWYvptu395XJF9VkWtgwcAalznMx2FhNos419Arv
 dPi20SMdNwq8zhysiqAma33qdVeHlY69Q17Mzt24u/eJrTdbR7YNDvZm+LG2zm7vc30/u/F5DdC
 uD/Zm8N5ETVXPvg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b601d585d204f9e59ad7f5216679b97852a46a04..f98f3e95bfdbb5e9d0fe66357f6037f056fbf25c 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -612,7 +612,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -625,6 +624,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -635,6 +635,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -645,6 +646,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -655,6 +657,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

