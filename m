Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3022F7449;
	Mon,  8 Sep 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325673; cv=none; b=BKhm+DUHm6nK/YEDeqqYPajSr7GDYx6Eg7ZAC0k+xbHw/ShCKiy+7Nn/YbaEzgnKUezTWd6VpIAo7HR2iNDLkyyp5RYEPhuk4wmqodhcf6reLG6B6LgCc1TLjoJrgabq0jB5OMjP1mrj0ceFFG4d7jsaNw/rz3Qb2Ulw6H7JGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325673; c=relaxed/simple;
	bh=HTqUsRXqv0uayXlXxBww3HqeknMt/byBk1GhhunGYGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9xBJV9dy8pYhvyKzyethVznnIk4qQl9maKg/frLZVKgYPoJnXIo2ScsD7oIcfiA4FEYwXiTpu/rYzqSEDecA3zsMAz5ge6tJ3If3HDw/0e0i4Lfp1AP12OAYFRQE8rW2mCYnh2GMDLWi4h04dekfPJlu1psgCeRHxUEcQQDg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGyc8cCe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGyc8cCe"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso3731299a12.2;
        Mon, 08 Sep 2025 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325671; x=1757930471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16lNfyPp2lVpupbRAD1MY+eMmDibLLbMsLULc43CNdM=;
        b=cGyc8cCedUJDYIFMqjO5YC6lVW64cfigPBKdP3AnyDt86qf2yi+/zS8zcILOyTPKeg
         tRnr6vqZfE9Q6+T6S/+/GeoP2/hgNr9n5I+02bUNQBG7j7/9/YfLsMrtIsAIERoT77WR
         ejTmgGsiZX1gJ1I7JLxkiHxN/1u9jBzaBHpuQdVbG41C7nYevYtWIA0a+bQTxDhpAcOg
         b2sXZsV5QGeSRHMu5ShXWYw6Qqc9h0ZyswmRwp1RV/4gHXlo3XOJQQK+Ny2fRFcL4VUQ
         CNIin+qccTnmtSR8Tw0TvO98eTB33L6z/SFzQw+K2tJHTlWvfpTB2FDa1JDGK79zdNiv
         nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325671; x=1757930471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16lNfyPp2lVpupbRAD1MY+eMmDibLLbMsLULc43CNdM=;
        b=Tb/s+ThtqrWWpXQxBjZ7fkTeNKp4c6J42u6bJX1RoPqMjFnbtzDJbnU9YpZ2x6QN4s
         di699gpLSDRkklwaulywzkTDRfy6I9OxBTG4bXsfXdwcrzvPmHaB3pZrEgtmAcuQ8Hwa
         JmyNTuhE6doU7r96WfFuAbAMHO8aQB7SpkYHAm2I7iA883tqZD7sQB5gKAchwCliNZDo
         639JUAHYOU3uCE/FhrPY/b3f3+y9sNywcIJSAv3tYWG5+CSFKMQDOHSplgHRQDUx9+sL
         gwmEe3wizu5SoCvjtwVU8OCiOjGvZvw05QEWSucU7v6RItDsRG3Xi6afu/630py8jNmZ
         YYRg==
X-Forwarded-Encrypted: i=1; AJvYcCUKgQJHsd/rSMcYHOb3OKreYQVFpqUpKI1MRxuIl6T1d1EGQx0S9grqIvzPsV+ovNBdZJBlmWoweP+u@vger.kernel.org, AJvYcCUu9sFCtRTMhlm1GiGSlLAmA4cp2v7miHAWIIxhEpW+alNRAnq0kZ69j6OQxw6U7GJDRUg4HWyqGY67d7Z4@vger.kernel.org, AJvYcCWkf6u+2UxMcpD21fwDMiGhTHe/CQlWN4Nrzr06lOiAQEgd8kRpuO5alj7ZvQWD3Pg592z1u1J3MXjEXSnEFPdQOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzisfOsblL9OSXm4WWhTFMQ5gS/Xtrkvbt+aJ5jAsMZ3bAzWWQq
	rt0V7SvL8n4baP9gcIDF0rOdxSkfzvwnw1hndr5tJdtloGigrJ5PxhNk
X-Gm-Gg: ASbGnctG6+fLaUTYJ4LLsEU8PXiiNGLyYmDPYJCvSb6JY3EyD2JeP2BDbSZz/VIzvBX
	qVPvA32VK5suFatQrfpsUdqMeP8YcbyNVn2ubnJcNpJii7Hm0vv7uco7W2a4N0J5Bv9cZRr1PQC
	6v1QWASFL6t4u/9IsaunIJXV2Ok+EHoD+mFAc1lD1aCfJR0Yri4fbu5Roz/fgesPb+VDFMcF7Ux
	Zet93bIQmy8VisTvW2dGnrT6fL1fSPLDwg3GVm30Rlt1NuPyQcTp1pobCCdilwenHOo1ZIuW+B8
	mLi4dT8g+gRMcH+3b8zp1TslF/zcfZBVHphusP1JWJZit5UpilIY5h2H0SnrysGW2VFA4nTFxME
	2xuYO4DtufnIwoXqd5la2J3/Hmmo2oTI8xAxlHg==
X-Google-Smtp-Source: AGHT+IFG8nlBga9cu765ON1HNtnAJSKtln2AiuFotPMwkoUfxyXOesYWBBY5/ceXgicQjppuNNDlcg==
X-Received: by 2002:a17:902:d2c4:b0:24c:e6a6:9e59 with SMTP id d9443c01a7336-2516d81a0b3mr106521115ad.6.1757325670620;
        Mon, 08 Sep 2025 03:01:10 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:10 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:30 +0800
Subject: [PATCH RESEND v8 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-6-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
 h=from:subject:message-id; bh=HTqUsRXqv0uayXlXxBww3HqeknMt/byBk1GhhunGYGY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlDETZgMV+/MDSD5BsxF9IFaobbIfNhofPoV
 +IcAuRUXBKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQwAKCRABygi3psUI
 JCbzD/47Ps4GiPxo5vmMsl9FdVJxhCkkddSC8f6nDjwiU6Uoo4+9iniHA/la6Wsqo5kMop7B8m1
 jnWyUbA74cLg6IShxozfTVhrHgqLTi4m0lH+wvGX9yywsSyIvM0vqZ+q2D6ZzfkHszNlhqVFS1Y
 jwTEbBVTJ3Jnp7JbeZCSXxuReIUYn3nF4gRIJ2xUQaMIVtbjjN2boRFbYOsebNR2PClLUlxilXz
 b5JNoBopmGVTD2W4xUin6DpNPAqMFiFeIuV85zgLDvs34jtlrxjTZPMBxuCWmHrdEQ8mIvuIder
 iHez3j6nHY2ZMwCh3fHWTDv2Puvwks2onUPRAmfqSs2+Sg5miSj9mko3chyvdvzXRK9X5/r5aXo
 5pQ39e8R319HRDja2LibYoiS8OD45CS2GpMMYyqQD/s5sVOg9AKKWNpaMMLk4Cb3qL7eEo/extD
 TWzyhVZx1+fK8dwQuoGLjor8k2BeMR1fDObLUHw6jroeevMxjKZ5zN/SPCFVQl9XffiHf5jsUBm
 C13RnAnhSRrJ2siY7CZL16widt7oDmzHquniHTD9jeLFeyrW7B8HhWjMVsnvAAjycR3ORBftw2x
 oTJoJU4LaYLqYGzhTmeXBFkgpFb1eNyi582FQb/bPNTRGXBxdT9I74q5J1gvBnHbL0xFfzeuycf
 ErbyjMhO0s5pRzA==
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
2.51.0

