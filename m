Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA81E572F;
	Mon,  8 Sep 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325654; cv=none; b=nJ0syj04t0W6CklASn/D3bY+rUZuOSk5ycWbPSXYlRWHeg12qIQEL4vS78leKYRIW8L34wxsrz2szwNkf4xuhKRDKYQ1/IZYAHTCURHPN49cPXBMOjbLdxOw9I4W3gH8XHilql/mvurXoALXeP8k+noDNzmmpzsuk2sHQFy/D9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325654; c=relaxed/simple;
	bh=LWdyJWF3F8SjS8P7dCHoXr3nix46HR/GnW+584oj+64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSLGOpmzZIxcPbC5UdtXwPh2IPitQfrSrfwjfoGrzHARG65t3ODNhZAq7wKlIy3Thp0Zyimf/KEV3tFKVToGHTZL9SsQgvuTuFYJpyIsf/KtfV8lpGHOOW5xJQSh9xAyklMyVySenFapXw4jYdHCPqAYtXOj/8/HzMfep3y6eDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxhinYkl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxhinYkl"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2847093a12.0;
        Mon, 08 Sep 2025 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325652; x=1757930452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQMq4XFtoATrbQB4MivFxur0yQnArRqt8i7j0LTryyU=;
        b=bxhinYkl/5Af2JPmMWnu5sDFb9DK2t92h5gP2rgDIaQtXdkxdR0H8v8B7uIhPPbNI3
         uP5R01CEyyVmIrAzokryV1MyJEMaXd6ujJ0O9M8I4id7nysBOnPojbZmjpoA87faqk6D
         ndujE4IkRhffYvzmo2VkXk3fEZKKN8y3TCg70f2uEbByKnDETK74vdzbe/Ct6xYpoC28
         onU11tBFj+QCxnsd+e8tvYoVj9rUD6LQlxBfOyec979WdSLuvW47MN4xEZg4IHVkl9pr
         0fxO8LLRhMyL0xEj0mt4tRxqW8fA22dXlZ41ZsGXHq8rdFtCzahx3nqBDdvCbgNYXArh
         kV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325652; x=1757930452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQMq4XFtoATrbQB4MivFxur0yQnArRqt8i7j0LTryyU=;
        b=FS/bs3ZtuuuAmFS1gQ1OUTDI6o9j5sdHTrHQFG87UIghDu2ikCrcnV7LZUwer/erJ0
         n+WBLstH+W2vowKPAFhmfzC40NtBqTFxOzES8tHR94KhD2xiwE7ep1Q44iy3Bk77snw6
         2mFzxUI3zpUPUqOiThYojvFTA9YaLpd9kNLOcukBZiOF5Ggg+dCxQCNrf0lkQH3dLtxr
         mZCKjJ8AgU2Pl2FENXcp9IeiG8hQLuhZOdnPT0MQa4RP8lkmFf3Rok3gAieI4iYigFfJ
         t7Qf722OWKmySd4akYMwhoI1G8aPCiFIRQ7l4eqWfobA6DUjKS6F6CX6KwK1SsBV9M4d
         /xsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICpQFRIAyD1WuUKuGJl3TV8xsX9Y+hDVUcfhaz79Yer58PHRaEcAtE9xmuaC9HvBRdLSQ9Elz358b1PpiAwDjag==@vger.kernel.org, AJvYcCXLwqp+Wk8TPT3Z5Fm5Zhgs7BuhSjWZSTcndq2KfB+WiwKushtczNB0MWKp4NLbhTj6UZVQabsICpyCuN2c@vger.kernel.org, AJvYcCXeTKlvi+HidNqYKBD4tL/zuUbZrrL7FRyBZh43w1AMAydK11iDzLXNKsgtvQeANLW8+L7O1RRWD8Jy@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6leRLyYyvHvx9KayZEjCQc/jVoc+RLkmaEITUdbelX9oPJrj
	AjbmEeW2ltvGDxUkRcx0OlEbA/wMeP2mqEeh1RIyWwII7rI3bMk+HGY1
X-Gm-Gg: ASbGncuUwqRjHalOqCgkIY8HM5QY9QMzW2PlCM6wcC4a1xrTs1mI2WnU6JVIszj/O/a
	ZVx+uBOTbYL8ktUVymYkgnhZTAaODb/cGXEqjJSxanovnomPMPjqSc6/dZTt1Od4tu8c3/MS61X
	s/uU56UuXjOkJYDdkboXKfa6hzK4JsQAVFjB8lXhAxJEjxuV16sbv7X1PM9H1nMxV6+ZxHIscYf
	FwAFdsEOvkPNLCoyJJKzjm/eCd3HPCtCdRRtKB+pqLH4YxI1HYweaoQjPv+LEGAPyS4O1tkCeMY
	ZRF6FZQElY+Q1716dLW4r4/FVT+VyMLv6GbBYFMbIb1Khah8lfgOKGqnqECwKftoy3G7eYR/I10
	/4gRkSO0zLCHWugtLunOech/CrI0Hucihtyujjw==
X-Google-Smtp-Source: AGHT+IGl1vTxo4904OtH4SWs6LUChVqEb8VgEVVJCvo1a6Vhe/4uyjIXKuDfOVxqGh5ob3vqwyQS7g==
X-Received: by 2002:a17:903:2447:b0:24c:8984:5f87 with SMTP id d9443c01a7336-25170c4177bmr88762415ad.28.1757325652051;
        Mon, 08 Sep 2025 03:00:52 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:00:51 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:26 +0800
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
Message-Id: <20250908-apple-cpmu-v8-2-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LWdyJWF3F8SjS8P7dCHoXr3nix46HR/GnW+584oj+64=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlCU22oAvgbtrscdWyafurkYoZy3NYlLu7IW
 hWt7fHK+GOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQgAKCRABygi3psUI
 JOdlD/sFhoqfCpqj7FgtxcF7snNtZue8D3D79Nk0lMIuUtqH/nory8bTsgP5FO/zDHh+FzhBEy7
 GJUG5aMxsMgWbZ4oOhu4BcJsEnQ/HSTwuGElbI6pqsP4KbDS1zIvx2hOJNuJRGbx6jaB2f3ey0t
 2p6/ABbDkq4/k+u26kcWYqUpn2dIdm60CPY9K+w8ymRjXil5oDJtvofwwxxccAQamA/PDtC9b0q
 V1iGE5JMO009hyP5Qe0XzUMxt9p/Xyep7q3SJy6/njas3ngxGwhm3J3l4W01bLaA8Ah/ClLiWYz
 S6se+MQzcAzrjnvg0UEmxRuIprQ76wagNthUVbO6yJ3MAWWGl8SboRYantMnCentWT5VNddrkcd
 A/aivnWTHEZ2j4v7EiqlW2rHR0j9cCO1DUMGQ9dh8HbZKkTs+Tz2qFw8Wk4tyLZs4+2ld3h7QnP
 NjOm71HU+AcueUvdudSQXiQwFFwb6WSBvdnod6JRmUo5ux5T2oFav2FobmJ9iMAewbs/ST6M/Zd
 VxA2irnqTESdTNa9WiNDiXkriDS3z05nttR2zhuQTXcQmlplp30PUVF6IwTMeL+LWvX5xEl/EP0
 JjX0qtoT61ruclg+NO98M0UvrM2ll6YLMr6gls5yLrceca8/2rMdUo5cbp3nmCSMNd8Zk7tCfB1
 PchvliyKYEioyKQ==
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

