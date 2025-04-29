Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D12274FC9;
	Tue, 29 Apr 2025 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898240; cv=none; b=o8s2D6DNNO/97aEKIssufE/gpgSQjwErXm0nVVmORYb3i6i5RzWSMQa0HPFIO4M4no2hL6DqsY1kkdkZKQFkZfY77sgGuZklfo2wwWPtXcArlitq3Qy1NU5BUW04MMW8KDH5FWJ02ZABH8tZV4Mez0TefHm0Alu7zoYaz3e+6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898240; c=relaxed/simple;
	bh=XuN7zsZ7YOoemig6fmya2Ywu9aWxTuisbfQnSd0HHz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrulBRELITDkGZmcOtDY+2gnzcGnCn+L82Tjvh3dN2e+uP7JlBVpJ3ZQMJpFz1VMHFC1yRVUvPcwHw/Hhci2kBq4Bylv9QW9qQWhr3JsXQoMyxrV9BZ+hHtOdvqVN7760n1DkiaxJ4YZpkR9lMpHbDaLQoR6LOw6CPQKWN8fBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul+ajOE1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul+ajOE1"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af579e46b5dso3908690a12.3;
        Mon, 28 Apr 2025 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898238; x=1746503038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qETjSISznhSwPPS1o1aaIPNAE1fFREGWY+BmDgwUuls=;
        b=Ul+ajOE1iFsIocTzsRfUopGjvp8DMnqgXbxFOCLGajjabWBWrjh43nnn1V86FyXcNP
         LAbxGuxaPCOa0PVS54yfDcB6Vt6sxEadcLsBq0uLJTvqGyM4vDe8klNgoYkv79WEnNd1
         MfBhNpW+xiIIXS1XNTJYAqkijOebF4hNoASSvVOHLedx14qc79owFwY2VfMq+shWnMB2
         KnyJx482CA1LjPWL5soU2Y8EiwNHAoqSLfo+hEyLJ0ukbExcv4NTVyc5Ml1tYvJThfng
         iqiph/52IlppLSYpnKGNWwRgO2UaMPOyNDA6ZPeDNJlOqaXO7OhwirqdyEGRfpz27zpU
         Xsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898238; x=1746503038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qETjSISznhSwPPS1o1aaIPNAE1fFREGWY+BmDgwUuls=;
        b=JE3qXIJkd2DEMsin9w0HhGRf8Wwj01zE+uVKy/sjmdSPRoDVxZq5zHAsrbxaPBt0ZM
         0TmDJO+VsJeIf5RRBGwtyf0yPWuT6QNar5C2IyA6n3Q4uGvjAh5/ymh6az7lY/L7tP5y
         GsEitovhM72sH4gJZ7MqTGyV2oF/iKj9+cBzBMT9heUbTssTjTCuqU0TbOaWiiKVvmXm
         6b9P2skup4ZjhBHRCNgGds06elEvGqsM1AjvmEApjTjHV/rk6wL0eRhnegf9lbMW1gnw
         s0lRXuhK4DXTd/34qm0vbvpF9068sU1jHlp7wwNEa5uWvR1KVwPsKI/JJ+P3f7/azvsy
         +rRg==
X-Forwarded-Encrypted: i=1; AJvYcCVs2aW2BVKJkJgS1Nyjs9js9tWuicPiQU8PDZEoDo6aCs0dTeC+DbhWAdtxd8diC1lwNbrM8E4xFagV1fYWutIl3A==@vger.kernel.org, AJvYcCWCM2Tmd99MELqnsoyqEz6IonZt3DtZe8n8d7cSBApw0nPS3NXzKQglN4pQ/8V3DAJXqTe08kdP45RnYZEw@vger.kernel.org, AJvYcCXhs0XeTX4jANPpXuc42lAOGrwvVTrP16rJjSOaaedPRyGpsq2cdbtWfy2c+nfHfuE7XIfn4PGGukTf@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAc7Y0V27Yyi5S9hXyZBQSNOMc6EIrO+HPVeP5VCcXwzzr0z7
	FkfN/PULwrkfIq6ZOe1ZopCqiFoYh8d1DxIIX86k9W1hTWl1tdLK
X-Gm-Gg: ASbGnctHQiuybFRc9h2dAGPidYAS02L3591sJSoihN+EnaWV7ou90q8f2z3WEx+sHy4
	K70e2fpHbcuhE9tdGqw/8E14ii1cuEUU3N06SjdV5rG8ePyOonEvZ2ubwdsRdWeO9KfT4cM8R4T
	acLcDBgVMYnLxc/+R3IuoqWZMONta3QK6wmw4or2JTLMlnYLxUBuOilVD15iQP8Y2DAtlYlM8m7
	iifEOssnaQSsjzzptoHIv96MbC9YZMYWuC+oh8rWo6rEe0HssDvOFGTcmy1bhvX/KcvEBnszwt+
	g7H74oiam1AGr0hPNT6Yo3EQQ8uOONOayt34x0CDjIBKh8ROG4FO9grZsQ==
X-Google-Smtp-Source: AGHT+IGCv7NUMuwkZrzMAT+2m6PloicFqMmCpwFVHUHLjuZ/63RjqjkmuWX8FBEwwdaE+kDW5LKrYw==
X-Received: by 2002:a17:90b:4984:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-30a21546764mr2708379a91.1.1745898238312;
        Mon, 28 Apr 2025 20:43:58 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:57 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:30 +0800
Subject: [PATCH RESEND v6 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-6-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=XuN7zsZ7YOoemig6fmya2Ywu9aWxTuisbfQnSd0HHz8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErkVcoNrjaCyRf0B+oVVlF/FnWvNI8GVPL/9
 /6IEObFdLmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5AAKCRABygi3psUI
 JHcRD/43EY45WDCCOHH/tCk4vG6bMpTVYoxMtOmM3AG6ssXxy+0LPTgCeIbIKhrKVlPPNNF15Kx
 2zGMBcMedxpKxGE38naXV4W9pnSlKLwJsrRJfFtmn/wRrmqtgOh4HEGmrCAtd+1vgop0WVdjXSe
 WJxwrIfA3rtr1qDT3uvdrNqzAMQUuVIK5bxK3IZmaMccEwowCeS4K3m0ljdCQhFlx8yK0JaNOde
 G9Wv6SCT9BPpcXL2yBqDA+qPdnx4pwghspuCxamgW//wFGOnDmUBA5RlUaOG7DtLTqn95yig8Mv
 5UfX3iDNRv+h6/E+cbv74gTyGf9Y4FIsg2T6h0lgXSr1/zE3PyZMZobiHLwvMY/nG9cRoS4sHZs
 WK7bUTPwDGDdM/gF7sybcIDaj5FxG92PRuwVGxUV5XMuDx7/JeOYaQc6jz5cixN+6oLsmCNDP4d
 r5dLJcUTVkVLbn64bkXAhGZ0fLqeuPQrNqXTL6I5m7PDPaMLg3Gre1oTHDBxa856QqxbTND1DM1
 ezH6qet2/HJwAHenrwxnMfkwLEemNnvQTk4AWx2JjUjUw84hUbaX2khnnQrsEiJ5BqCzv5DwAzR
 jeDLZCiJrVFmi2aOB+LGw4dhCyMoe+AlsehCTNQ+3R0eu/4q5K0K29drrMCGgiC1XWEDjTpEXGZ
 jvbwtgkXUgZOdFA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f2566a0f8d330fdc0d71ae298f16ee9700a13c23..38fb9200369c11d0d7674bec4f350915c67352b9 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -660,7 +660,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -682,6 +681,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -691,6 +691,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -700,6 +701,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -709,6 +711,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.49.0

