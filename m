Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039592C1786
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454268; cv=none; b=GVUG89YbPtaa3JJitR/AVEIlqMX1Gj3VdI1IAKlkjkJd9xgGytH1dBwdEL5uIkRUg8zntBfXv9STwtDYnsW7eXMm4Q38aSU6fjWH69oYcnAwPWtuxn2FwEfe8Ju+WuTVg1HAqt/JDB0nDv9DnbDf5jpdl91so/eYxWh9XUnzWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454268; c=relaxed/simple;
	bh=LWdyJWF3F8SjS8P7dCHoXr3nix46HR/GnW+584oj+64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuGol9zYXTfDDADvNAjw+kSCWwFNgGaEir44iFmzB7snI0S8zV9kG+UhYhph2uh6irWRAinxhpE3saM416dV4P3vtGdpQKTKrnDXVJDcMYcAHKUOCneexOG5yKdWXFYCVmHmdK/rin3E33175VpY5ycUeMy5iCc1gUKaf7+Oq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyXlPkq2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyXlPkq2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so4676993a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454266; x=1761059066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQMq4XFtoATrbQB4MivFxur0yQnArRqt8i7j0LTryyU=;
        b=iyXlPkq28EUINuASZprHaj5V6Czn58R69yXXaI+YgYo5ebfy6Ly9BaMIVd80gT+rTJ
         JhNa3RoDfmKS+Kql0XGCMnJyOtviBRpATJfZXOh+jEfGiAFjJ0puCk9hi9hdpt0/GRpT
         8sAqH2NmCgjXR7Ok8JSE1Dm62hlbJyupizR2XkbbrnXVi1twh1fCRy2OnpMiXw6wDQBn
         PzP2JAWlpateRGPVYHHHEbr+t0AiaU0OMSTGlM2HenrYLwP/FTNdMS6xHIi51YO8uOEM
         H0U19mv4tDASZ8++Mz5vBcrFB8H2rDBtLefLTZqixnZflQr0XMENjoGrkU9w8f5UCTm1
         Virw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454266; x=1761059066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQMq4XFtoATrbQB4MivFxur0yQnArRqt8i7j0LTryyU=;
        b=d3ZT+iMrGMAi9/3OpQTA/NwYnygBMGGVA179jSbhcgBMDxQwJC3SeRKCkUnUarspBK
         7f5dU96QmWXouiipFPN5DsZ87xXVixuMrZb/q6U1BKrPVwrpHsolO0iE5dTj2kNwIZKX
         xkGLV9LQj4dPB4uyt2KMNCA9H/XXAlz/THeVkFhnCdY8hCF4OD+H6yIWO/xRMlwjkDP6
         KY3vOY/AqSldI+fzieYhBDwb+4I8H34aQKnXjAlmDG6VSDfaxOc66nTLChdTRG4O/8sa
         TrOb+KG40zavARKXD2e9/l3pTlG9w7Z33LV13EvFoci1Q9hQezbI4RWtOrn9yhkoGJqX
         0nrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/dqxVe7sFLX2AV2RuQi2lqRR6thfpEexvupjpj1zYskx1Sl4/fl8DTKSnuzwI54aQtAlmY0pM5ZnjLoY6cduD@vger.kernel.org
X-Gm-Message-State: AOJu0YyF829h/6aP/WP5iYw5OabxuCEijy8sCCf1NVM0OcUFup1IHWcV
	q5+pcgyIZvaDyMwlhJLbbDRF4VwWdtGjyPnsCnMiTYP2/SMrKUXBL9xk
X-Gm-Gg: ASbGncv3bR9W53rOUsUtDIBB+pUO5rSNl6xChl9Yf38IkfLQL0DMqeA0cPIYxF61b/z
	j3FIe+FQBr34cCI4BWmX5b4gcghNgFD7rSyCIn1pMy2IKzExd05r9tZA2mcv07QKnOVqmFXCgxP
	LaxTEswkXlb5UMgC75OVtErjjjz4cQTQMfEkunF+kxNnOqnVsXcByOHaPxvpNgyXB0vDn0pgu5h
	qqO7rYVQb9KfOn/OSUBGCTL4oqooy1KdpdlA7LXplBHy6Tja1AlL9yDl708CpnhWG3ooH/myb5C
	fGQ/QGgPlLu0hNWFbpHBfT6/f/qIZ8t9MsSJYRNlaYTUSJ+V/c0o0zeQL/fEhlfv2QpMSpnSxeU
	n5USUZazLCBwVNf5nLdcL1QIh47goiZmuqPryh5ZXgmY=
X-Google-Smtp-Source: AGHT+IHH//oGG+duDcarvnMpMCx+s6l5ttFKPXRC9yiM8WYuLiLPNBvTpEmaQ3ZPfrfAhgmB0mtrKA==
X-Received: by 2002:a17:90b:3812:b0:32e:1ff5:5af4 with SMTP id 98e67ed59e1d1-33b51399fd8mr39464227a91.35.1760454266031;
        Tue, 14 Oct 2025 08:04:26 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:35 +0800
Subject: [PATCH RESEND v8 02/21] drivers/perf: apple_m1: Only init PMUv3
 remap when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-2-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LWdyJWF3F8SjS8P7dCHoXr3nix46HR/GnW+584oj+64=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZs9VdcsiLU/uSNPQdxREbNvTvb8kWSvNL59
 LtT9fudemKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbAAKCRABygi3psUI
 JKDcD/0b0EZQZCeoY92NSoIoBkRH/0fDA8xMHVxYUbUWvKC6BcMtgc6zs/pA/xvkRD7bikc77mR
 VN4XBPEtMvJptsrMqhUyZgZECmFqTIDFUhkX70YTbOlS4wO2Zgji2nmPi5KDfRhPPxuhLJ1ENmc
 VxKSNvir1mUHLXjcIdUczGpI/zJbWoXe0qkAXJSfeebBYqLrqy6648LbmiHe75hFC9x/sdcuOs4
 Xc8kbYTBWEltzNCdwZxlUcOfCkncmP8MeDceDdERNCvr/4gMVafJDN2LKFHFtOCJzPO6d9eqB5U
 kt9EO7uANvrWPdbEzwhfKpna75FRKRM9W29DRg+UiebgNWkjvYmIeSWltMzCxKpmh+z1c9hmmJs
 vBThwOE4m9hj9OpGeG/U3CDC7kQTQwSni+zjScWl+Vh87lSgtDMsAGGfNB6EmOFeWjv6iAqiF56
 FGgmENFXuXwkJIo/oZqxLQQoBI14djgjy4CXCkLzNw+cMZ1C/6Mlo7Mbx/6QrTV509IHIAe/Xjl
 jk4uAnqz3ZF/m2MQCJDVGfUwvcx+Stst8urbES5JHS1VEvDNQnCGDqjwwznZIdLEOjfQJMlAANn
 DMZpgx/jNhgPayfdDeWO4nppPt0oJWaqMAWDLpAjF8EPq3QnYJoVhnDN5nqePga6IYsXCiPwuIh
 iNGhEoD3WwLdm2A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The events in the Apple A7 PMU is very different from the ones in M1, and
EL2 is not available on Apple A7. Instead of assigning the wrong PMUv3
remap on A7 or declaring a new PMUv3 remap that would never be used in
practice, skip initializing PMUv3 remap altogther when EL2 is unavailable.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 81b6f1a623499566ef04d04075752f34e2cb6a92..f3948528e28e0189efd0f17fde0d808930d936af 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -645,8 +645,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
-	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
-	m1_pmu_init_pmceid(cpu_pmu);
+	if (is_hyp_mode_available()) {
+		cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+		m1_pmu_init_pmceid(cpu_pmu);
+	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;

-- 
2.51.0

