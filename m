Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7C2236E9;
	Mon, 11 Aug 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920532; cv=none; b=TaJXDhpy+nbdVkbAGmEnOMdHceVTe/Z9f6w0RoINwZYMNaLFxOG3I7CTihpziRcuh2ZBNryOLv4Z+yZnbwhjs1hBzQfRfhxql9/EymyG7luKUxx7IUovwIXBdj+1UFPvvHlaL6A/MLbzTuog9ufZKGEXy6caxfekOTdJfKD62XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920532; c=relaxed/simple;
	bh=/PeiCZRRXTs+WYDUarH1jFdEbam99TBMronNZaQIczY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBTIkJ01baygxDwqKLUat/JIJeM6Qf758+zQYSIUFW9umXZe5ajEejz5o2hTuMnXxLpxRfGzbRUDKIivuBA/kFGLUhVU4zV5qTGzwnFaJnPBvqLTnvQgk3nUT6O2Nqn8/v3kGcCZmwWcfdY2VN/DL6qXRdtNevIgQRwm06vegTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YExabs3z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YExabs3z"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdea88e12so3711129b3a.0;
        Mon, 11 Aug 2025 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920530; x=1755525330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9Aanu/g+hL9gq0ALIBjFsl0W4g2TJYUNRbSh54dgYI=;
        b=YExabs3zGuUqCuxuQcUGSP/u/TVaQQD/rES3eUHtdtHGK5xJTCwpM2Od35KKqeNOXu
         fQBLB9ZMF/NJNxxcnck+hCG76vWDiQEfea0s2/vvLh+iI/D3Zgpo0Nu1zJGkUQX7wdJi
         fheLMSou1Gf/OSp53kzuLSJM4SepLE5uLQ/StI+WBCYL/v4XrzCzkH/SKdo5KOcPEcax
         FmdqhMehwCy6RYgF8FdoBUfvPXaScAm2y0g1Mp1xqgD4hTwFBlKWJwfxZxSVb3rgq0E1
         8Du0+KmMKYOc2Q14kgRZDW7L3HfZgbWquEg27WkyYG+1M1GU/xKFkq8yMtBMTEC3rctC
         GBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920530; x=1755525330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9Aanu/g+hL9gq0ALIBjFsl0W4g2TJYUNRbSh54dgYI=;
        b=S3NbJPhCA/d5QshiUf4ZG1iRKUBXcMfor98Hjvh4qpUVGS0zKh5xEheTkPX6gO0z3o
         nJ04+tD82LGdqj3aFWBQC/XEWViuMccW7lFejdg4MlA8/UYdHxxGYUyPMjpzb9gaUFp1
         AbwlTbAKrs9i63iFrAhq+MNmIMuFaVbs88YXwlQeTTIw501BzcK/Zgg+tq8v3DqT0que
         2eMebhftBGOXc71oxy5qL1N6zx4+HwFjJC/n4dOvV7fnMBEjVV00Ornjnik+rDe3W0Qg
         Iv4YN8Ed1fc4AelDD7fKxy1O8M+ySlJ+NbSjbLU8B1r5mhRO/I6jzSlrDzwotjbQ4mJf
         ndgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxTPg/K1EqwdrREQrOUJvptBAC0j15X2wRLx/U2Bl+KB3K/dkMKBhLwVonEUskbLvZX+Wb7ZPLOi8hsLAK7Rn+aQ==@vger.kernel.org, AJvYcCV+ds2JYqDkBBkb9K8+1hZ6rrpzcP8nNm6LzncWQ1oUvAlDbDojfhFDjPQRmBqUj8dOo2tiD5MxUceo@vger.kernel.org, AJvYcCXkpSvbLJBD/qBkiqjuZwzJ8sCNLOjUnp8bzXiDXGNs+JgZyH8EpIYKC7OfJ8YUhtMFsHDsmovLN+T13M9m@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjUKu275HnsLzLYyK1h/3DJDNl0ZY9ne+lHbMW81JDbGu5eJu
	i99tY3EWlWP11RjymwKhHwfbUOvzbEMAVLBiC2TpJib0lIY1EUb6Q77mTkxXiA==
X-Gm-Gg: ASbGnct3CXF90MqXBLy+Lrjgtc+7fq67pq9MIR2JKSgnu/ZI4zUTkSOeE3aTLNQSsFC
	8tJ+/UENq+GQ1DRzBe3k5GvNHq1K7HzsUagvzuYZEBFEVj75z0DRGYJPS8wwN7sHKlgyHMolxEo
	vTyxeHbRfoAe0zZMjfbK4a5EFz4l4Xd5b9rV2SBl8Iv+YCAh0OCrJwJCIta+Pv8zZmbONj8kaWh
	OW2uFYT7zrwFpyZ0OmI6ikG5kiEy25thbnlb/CwXuSLGHAg5kUVSAkDLY3rdjX2MFHR1nRtVTxG
	ix3aF1a5l8lABhI4sJ/K3nw+5gfp+LOrETjwZkuh0ZgoAEQsyJCgxuQ7kRMrpNH6WiWHjrKv7iM
	wZGdPjcydOoWjP9GYrd/gV3V9dAyJ/1wdDDtoqmczqnKPYAI=
X-Google-Smtp-Source: AGHT+IF3ZrUSel4K1BuqKwEOc9pQQQUf7+NY6zqoq22ESLFTV8EiYkuG39Kx4E5+ym6f4Xi+Pvqjig==
X-Received: by 2002:a05:6a20:6a23:b0:234:80f6:2b3a with SMTP id adf61e73a8af0-2405501aa88mr20984035637.4.1754920530416;
        Mon, 11 Aug 2025 06:55:30 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:30 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:34 +0800
Subject: [PATCH v8 02/21] drivers/perf: apple_m1: Only init PMUv3 remap
 when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-2-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
 h=from:subject:message-id; bh=/PeiCZRRXTs+WYDUarH1jFdEbam99TBMronNZaQIczY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZAjJ6DSFyNEbqI7WQb0Cs1/cpoqcmkC5M9x
 edA1YRSzTyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QAAKCRABygi3psUI
 JAlRD/sH1t2xS6IlKyOl1wO70gblqwbM1KqyPFJvf1yS37xaYtta2EkTYwoDnFJRADzM4QOucKk
 EuCEThPdttD95EZUcAjkRVe+c5FInsMfLCUlOnBzOXh6pI7mU8f2l7On2mMyuRR35Nnj5dI1ZqN
 l4Xozo6NtcqOHGkO2In7dkEqrTaiBUFzxdkux/24RHK2LgD5KvuFi/v2PL+IgSxWtB4NcZ3pZGe
 q2xTGJA8h31gqwrZSAhU8NZdDFEqa6vIXJrbuqU3KEXB2xFoBXo07TvFDIBsdX/xolnlcSse+G/
 85NbGGinRlTvj71bYqnYES0DChPgkFHyYdFgevzSPIn8jU77Czue3U17LRln3D0yhQkTW1UIJ+7
 jL/N4QyZj2sHTMqcFIyqtA0QA4HaR+vNf0sSnYVpcv5+suUB1Q2H0LAOxhp/3GpboWnBnX5gi4o
 sWCHwFDJHbuEQyjfKFZYLoKpC6CwfYDZKt9RRxjbwwcZn/0wb2YzTVU46pgsEyuQliProBHsmyA
 MttHNUmZxVqRt7qJt8eVNu86C3ZFZr+mPqeOa2Hd32VVqXsuGPKN1iLkhKDZbO2BdctJdCyhykG
 lAJLxrUwg9aSmiXbsAIFyhpzqSAJlh0UBDKn1GH3sD5h4NmbdbX2msqe9IhVZwvtXLQ2kr62VY5
 oFjjgMuO95pcYYg==
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
2.50.1

