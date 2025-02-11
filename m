Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B309254AE9;
	Tue, 11 Feb 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290109; cv=none; b=h+TatqK6phpKtuL3V4v1lRWvpI6bzhsyqnQyg+11Xxexpc5OzTfcwzeXhFAXO92/WTY2d45ezdjiL40RuK7wWDPyXQrMw8LYcI8jVwvSuPRFHWoM+U96B7vu9Z0IhGo3+HP/8cRCKSRMTwcSeL4+KfFNUgEMh31ecrSA9ZZcq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290109; c=relaxed/simple;
	bh=/xQSzk950FCuvtHGQpngGIk6ngOfd9HdKv/UR2YVLS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqOqD0gO5YGEEkn9mFXhoQqpRdt+7X7ovNh91RElNAcPfgsErox5OH4d1cQx+EHhgEaKeUYKqbefdNZitymU1IDiO9bTmLoNJiWfYjJ5c/liuO562wp0GchWTBAsVz6lH8Gbnr8RZwfrfNDJ3BdlmHZJ0LN1tsAH9grvSajygCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixFRFqul; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixFRFqul"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa44590eebso6530665a91.3;
        Tue, 11 Feb 2025 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290107; x=1739894907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/bCCPIxn4KDDZBLFDUwD7PiQhomaVfOF5iK7lDsvVw=;
        b=ixFRFqulIlk9qDR7t2zZcSldlqMCvbODA743CxwbJx0dumzWChLVxkgnADGo5cGpzA
         juHkCsIM88VZSoY56m45SCf4/jcnr7HRMVX2nl0KdAOYCVdkFFOuPkYKapVfOldh2AB1
         JhG/5+E0TTG019YO/burd9nktz88xPwym63Tf6YV8lz0OswjnZ4LNFnO6n1TE4nl0E2C
         KJwkm3E85h/ZKJCfJLuHKXHGUbTkY6w0Ga9cayqWiqbIZI12YmSleNjXkuoND7RgOmdf
         d4R+BJ1SF30QPPiLZB7rYcokdTMLvH3p48XEFYWeFrOmeLUpS3yQF6i2ioIQiJgC8zw4
         hH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290107; x=1739894907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/bCCPIxn4KDDZBLFDUwD7PiQhomaVfOF5iK7lDsvVw=;
        b=kdBmJPMB0x6uk/2iWxJn8Jc1wLhkCNS0asTvz179lmHqqIzaxZ8YCTQfKnq73qWGsr
         CF0s8k/0kI40k4rxGvTkIEwkNatyJn8UE4S9wG/cbLcoVyFTvYY3aBerhxvBOoezc8U4
         FY95JfsVTFVWLkCERYbIzt5EtjFsYX+CNuc6su1KZBo4LmbX4yxO9BGPWJoNJyOf9/8q
         IbplW29HraeD6QzDzjgKq26NTKv8RN7Uqo+w8F36+N/huu96+paXpM86FnkCbwEGSaDW
         jZ2sTwWNIrzdWujrA8fvB1ZYtdJHkgNq8OwPOGjpZS6RAFtrh+edrlFcsCXoeBsadSsc
         xPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxN/Ejku4YwFPy3j+Wnfk92K2uqKjvDNkss7GnJNMjlLLBAs2jA806JkH9a5WpqYAqeXqIcpC1kO8df+Hxqe4FRQ==@vger.kernel.org, AJvYcCWUYHAkpNPDYrhrO6sv3HogDbMikQT0R+7WYizEuz0w1x7hcQv4oPOsAks1yMe22wNAXBQPoRfXVuTzXqAT@vger.kernel.org, AJvYcCXSZyU+z0OIi8BkyLkbsdw6fSsi162IfZq7iHl+9BbpoxvAsshUpUoTiP7oP12CI+YUzAJpFyKqTbEv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32/6IOJoZvDB955VT5klVOVY7QbwC9Kkhh/bvR2TjwxptuVMv
	ucO0fWprIiKlyLS7jRmTiEXv3rwzvsEQxD5H9QpcGxRJbv2+/qKt
X-Gm-Gg: ASbGncvlbTmie4m3Zj1wkr4Su09U44ozuGrvo+SO0D/rOfcufIU889L3YcKXWcs1ul1
	RbNJ8upIMw82H8wqypVrkEqC0Fwe3xcu3HI2O51HeoIJqUJPGaCwJOH6ytVnzFGWpPPOkioDOk0
	PBlibRsJw60rios3nHSXC8ZwLV95hHFiBGdKC/8et9RH2Wk+Rzdv9VyXz6drj1p92/3pqIj28mm
	++NUR3ZxVghlZeZgtrucsDpxa4d+3V2YnwvQZQPMzCrQxg9IUEufHY9a01C3qWsdRGxkCNpgR2R
	L6+KOeetV4cxctHLXQ==
X-Google-Smtp-Source: AGHT+IFDoBSLFXS8fc2oKxZ7u11430kH7lpuCMLsImbDx0eDbX0du8ImVtICDjL3/vMG4Cm2HPnt/g==
X-Received: by 2002:a17:90b:3647:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2fa241776aemr27656016a91.20.1739290107060;
        Tue, 11 Feb 2025 08:08:27 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm6040478a91.41.2025.02.11.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:26 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Wed, 12 Feb 2025 00:07:26 +0800
Subject: [PATCH 05/10] drivers/perf: apple_m1: Support per-implementation
 PMU start
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-apple-cpmu-v1-5-f8c7f2ac1743@gmail.com>
References: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
In-Reply-To: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=/xQSzk950FCuvtHGQpngGIk6ngOfd9HdKv/UR2YVLS8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnq3Xn9nZDkPLT0KDldq05E5uglg+bM8uK4wN4T
 UIOBBR4oGeJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6t15wAKCRABygi3psUI
 JF7FD/4wv/qAAOyZdCHLlU2G+92h/urYiFuL3iJJOQ5sxB/pz44kEDVs9qEL4Dy9QvoUYnldG1P
 tauf+aYAe4YLqfeicHvZNYljYUcvTQmpbTjfPTTr9gkAweHEiRJDKXszaioauKZyLGn8Iy24Ss2
 gjEbPZRw+eoaO7K1PtTKXzK4vczJuV71a5Kd/uscSzJbrqV80sBTv4frJkuxcdU3KcxjbwuTeIv
 jkJibsOCUPhIdRew5KVoeFtnAaerGdGTwK6hm384aRdHT336p+hEO+6k8RacaCZLxfNLRMEPXDN
 tl4f54G93X4MJrUzMMt5dPh4JH/A+PQ2ADKJtWnKdzYFF7GWRkM7tQYkEBaXYMpxfshBDDJjZmp
 EKdvD2Heb/qqF2ivHp5tRPG48BV3ivXH7ZaETcDeNzetX6VaIVwPMv35jw9fVrRrZsMIgv+MLxU
 QNVyB/+dOjnJ59Oof+9Z/E0pgT7N90MpS/pG18fP7EiBSFJ74BUP14cISabTNY60rpcdLR9D41O
 5UHtNR7WzCyzCvmDKMr6mH4q7lMf6djqpIjEWVp5qUaX0pHnKolIcTygmzd8GvQrdlQwtvuY238
 uG8nIgpQJ/ygvxt/A+vWw7LR8S1YNrnxPatPvi5vHWjEF39RULSbcqvhBmzMfpEHVYSpRH2cNi2
 9oFASIjH+CeKwLg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation start function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 06ae20332e79f7dfa819f764a3752fefe53bf5b8..39fcdcdb9e5dd6d4edad0a182dbc2eef62780d8c 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -605,7 +605,6 @@ static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags, u32 counter
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -622,6 +621,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, M1_PMU_NR_COUNTERS);
 }
 
@@ -631,6 +631,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, M1_PMU_NR_COUNTERS);
 }
 
@@ -640,6 +641,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT, M1_PMU_NR_COUNTERS);
 }
 
@@ -649,6 +651,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

