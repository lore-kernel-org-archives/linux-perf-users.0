Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352426FDAB;
	Tue, 29 Apr 2025 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898227; cv=none; b=LBZtOgWOTbGBAx0ppAOzKuyw3Gxk5WQTWq6HAAJNDjFgwTUKvGjOeiugTopSoMepfyl/jna+uMftnS+6vAAI3E3yEYfOcR266nMM8nSXtdR35cav5dgKrZFaVqC9Qkc7EPezVr70F9n/VdUFT2P+BC4lOujjTh9rTBtUyWQSZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898227; c=relaxed/simple;
	bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErLSLeyEEOEiostdO9AY8K+aq0jm1DYUxXfZlbY/9pukqmyJ6zbOq20nqgIA3uj6BOFV04GxQIdmtwlFaJzyhlAvcM0A9AWOPTh/5ZS7xJisgAsvHVUxqtkxS4fBbQARKnTpLkcV7k4ijRP36FrU9kOOLz+HMNe1tKUqxpZmV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAGfdFxH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAGfdFxH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301302a328bso7775484a91.2;
        Mon, 28 Apr 2025 20:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898225; x=1746503025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=lAGfdFxHlpLZpZBKJ8NbI5ClyGMRvpl7emT1mOCWfkl0x4LC6ZT/pUO4hvPo15jhAf
         jTSDscVYUhzTCNbZJ4iV7xMQRSuCJ0gvGP7RpwZq47SDXR42oP0CNApaNIt7Ky6bBT/l
         2uEp1ZZrXkYg2WGKSNqwkGgNUooa0iVrWZuy43DLbSOy7QB9q9n1g74snmIZo3lLzUlb
         AbIkyEmkxIxe2hkhFJR9wHqOUcqcKIpUrP0wUm4w5whRGFzSOYj9i+cpT+0wGBP+/I+y
         lBH7eJ205Pf0YOiohqNVzyxwsfTA6ZxZCce9T9+Tk11Y4stsQKNvu3yTZnTpWaKWk7Jp
         C22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898225; x=1746503025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=NufgwWdD7iGwVyGzrAcs808nLc9Q5hPy3LkMzfOskvKefbMzbwiRkpUD4MimxhmIKw
         BI1FA3mjK6hUhH5YLyBZYZgT0L96n7JgU+f2TWX5bu2VLv7/wSsRATaWt8LjiRgcJM2O
         BuNo1NzZaGeAMJ89ap3KpkjgWgSRfFYbsEuSvKh4IBDwXN9DSx15uMCER2HnWFP7Kw0S
         XG4CVwZKP1+Elz3oFAJqYhNwDbCxmbwPmmk68gzoUVoyFpHJDUd8U1ijm+Bv31PVO/5O
         eVJm1jGAnS7PQykCcDnqyaO33qh4RI8tGKhdioEPn44f45WbDhj1fFWvvZC0Z+GLwyQj
         IKIA==
X-Forwarded-Encrypted: i=1; AJvYcCUKJcvWvuoPN4EpsznQ+vcgHI+1SV6YT17KvX7Wg0g64y0Zv0w2mUR6DNtB/fgXb0LerZ2Sa4t16ak6@vger.kernel.org, AJvYcCVBYv1505/nlbd3zJHJ+5H5JiNcM0EVdyFWes8xCYRQb9L4DiCdqNTcLA8ilv+A8rxA+OirxylemgGf+S99@vger.kernel.org, AJvYcCX9lqBljRvU6skfVbvuYaYzOqBBpGRaptINzSK0+s+6BC79Ex0P3/FtIrSSXLUgAV3JkwqmSkCOCGt+1r0U5J7Psg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVdgSD6h/cm6v7rE6fT3ZV6w7Mb7NDT9YMi1k1J93b81G9GNC
	2e3A7pcLW1+DLm3/WwtWParPW4tQ62tkJxxwDVPTFjO3Dk711R0J
X-Gm-Gg: ASbGncvo2HtVGy+IJ47XWnVVwMx9NTkYthZbRrgmdc8oEVAc3TSN4WewZdNuh1IP/5l
	KLpGK7FXCnXZv1xMSNb5HowgowTLLWb6NyVYzbjKtDSvNNW7mTqAq+QEM/zB5U+mVXfNC+HXZVk
	tFcvRoBGJ3XYMgBBuMUvpUg98rrJeX0iMn7DPU24+MM54UJCW1MxXjbSWyf8E89Q+7sEvH6mr9z
	A2CwXcKsAjB+S2qpuBuianC8fnLvMAIm+dpISUaKzyaTuhD5BU8xCZI1ZlrfHPoPVHDCuZh17oB
	ZLU9q8nAjoMKDfRZXcgQVKKh8aYilSOQ74Ecy36PYMobk+vzdoRTin1DQA==
X-Google-Smtp-Source: AGHT+IH0QfnRZrHDVi9u9tS8SXfAhYyEOmXMgFJu3ii8LTS/mV4wfXLUnUpn/pv0G898oqDjmezJqg==
X-Received: by 2002:a17:90a:c105:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-30a215a1c05mr2568143a91.34.1745898224710;
        Mon, 28 Apr 2025 20:43:44 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:44 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:26 +0800
Subject: [PATCH RESEND v6 02/21] drivers/perf: apple_m1: Only init PMUv3
 remap when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-2-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErjazzO+NLo3kdywX7pJWIqZFooUQqgBzJoe
 fadMEORQrWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK4wAKCRABygi3psUI
 JOKSEACbThOdFHwrnvVn6sxZv66ea9SkhNl8R4RrTjcvjuF9BIVY/PIZYjx8tfqK4W+fynHpppu
 1+DFqm5j0iM71gkyvAV+981xWKS63ks9e1tJMVwPm2hmPkNnPYKMo8/PZiglrsRvcWCvLY8jts9
 Q3ZI2tAvfmAmmRHzyATaEG0RxGUiJCunxE1XeUQyJSLjGUe9Ex/5j25UNSCp62JlHEIE9V1Q24v
 qJ64TSCl/9nlCt4jRYjQHIM1LdyZlXHIvzWF36c3i6ZICWK/6X7DRCz9ndjuV0lAMK8+GO3leIB
 kZckjRyKGACOvAfb5L+xNJwPqPoXqwIOM8WG07/Gt3zWVeO4w58bqVVqSuNEPYyHR+iWOyKqAwV
 zM4ho/Ph/ng4+cgRTRDuPPiA6HS37DKHuqRqEfylkmajKRL0R6wX3girk1waJQ+nnOol/jOSBbe
 OFnbtNIjeYbv5/Ix0fRyU+Sxuw4QlVWaovWPWjboIHp6vrVzAnofdjnW63M/S+iWHE0z5MAGh5m
 ppwlFArOU6clMBsXhOjKqnun0lhme88ETBTYYuG5DsiA9jK0faJxrthclc12YZUbEIv0u1vw/0a
 QHhgEXkolJBpHhGSrpYcYZ/aG9CfH0BMJXNTVWguK6XKATBuSgWXVqEtWmU/tuK5mSBWYiapxa6
 i4+nnovqZOneI7w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Skip initialization of PMUv3 remap when EL2 is not available.
Initialization is harmless in EL1 but it is still a weird thing to do.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dcfad6f33a0d18b620276b910a36ca..b800da3f7f61ffa972fcab5f24b42127f2c55ac6 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -646,8 +646,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
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
2.49.0

