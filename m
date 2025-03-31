Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981D13A265;
	Mon, 31 Mar 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416641; cv=none; b=sbgZ/4/glOjiFaX1TsZ3HcwRNThjy31PwMJ72EuRtLYWqK+BNBmVsgsmGv0wZVgpFexy1Hpuh0KJMJjlgK7IlCocIyEXBAOe5ZPWTaqtjUYt0g7UFc0JwMQ2dfnKSCMjZgu4w1POn5q/kKmpzWL7qbOkvm/BtcJTlFbgajZ7rQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416641; c=relaxed/simple;
	bh=+oxYkuhrp6URVoi8ZfZtcgS1qVnWtosXRc+y8vkiEtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWUk8tBjqyRh8L34D3eDvO8MqQJLcNhSPjdqWFYzio9y3AN6ZwQlYuee+vM4DCP8ckjQNjkreA4Wgla5x94s4wWl3+vZ3qR7sSyrGWeKgNOGikNP3boJji2uoAv9tfcEHQHWQD48T0cEahFs6i6m+eaUaATiQctN95se7zhYnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN/h6bnI; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN/h6bnI"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-224171d6826so51850915ad.3;
        Mon, 31 Mar 2025 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743416639; x=1744021439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV7xKYxy0jYGd0Qm2mj0JBA759UToJ3LiAjKa48PaqQ=;
        b=LN/h6bnIxEOTPk/3uA2G8FEWXTHza2OrKCT0N8vMDj7CzwGV3fXiTwISjfkFiCXmIT
         d/O1sL1A2WErpTDCm6J20IEoCeg6knkIfCKDLr3zCeyRl6UEfCRdHEPSGvM78XYBye37
         /SSuUUSE0/9N+fz6yq1e7U0FlSILgikRo22YS9WS0+RCJ57+4OKnsqoUTdAsFdRpDkzM
         8RBj4fHQO7AUt28m17xhbQoEyO3CjwWrJvl7YmI92PydMGJfg2Fzfev+Yj9ZpTpGHbDW
         LdyKoVY9ppt4jdn2k06KK0gm2N672R1U++aDil0e5y0WLbmn9UFwOt0OxSRF+bg6FGvO
         XLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743416639; x=1744021439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV7xKYxy0jYGd0Qm2mj0JBA759UToJ3LiAjKa48PaqQ=;
        b=qNguwIAYmWwqUwGYPB6378TNH5OjeCHvCFbMfqXlQjR1UZSIGf15fvYxFNHhgUXh3a
         wxySuuWcn7/POxtjOnxR3g8dRxx3CvGFd0vlCOJ699H9Z05sEor55y6w4ykmrgVrn0qS
         GtRp6DW1Z3qjdZfwMqpRJh6GCKSFBhVcIpYV14bw5TMY98BpXw+uIGn762vVhlBusN3d
         WSqJhmi4ioFc1OWg04noCPWlct1nsGwvts2CBqJESrU3wAlbHqAl2g+X6wLoVBftHEZ8
         JCVrrTxauYs0da5GyVaoEZcBE0KPHSAj22I6zCL/SqximVHSIp9Tj30PbJ84ppKA9s/Q
         7gzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDhRMbS/2xHr9HQR7/+qODMwWp6X6AAnLGgAANuG8MPrGaXYVWozTwkrGMx2khf+aY3yWS0PUpgmXxsW45RR0uQ==@vger.kernel.org, AJvYcCVDAZ/gMX4zUdNIZZZbTyXGP0Vcyu22Dg/0MztxckdQvdq5efa/7DH75sZbrY8LQ3FN2JqlqV3AKzRqxnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCIHC5qE6F6GkDh4/nvQt1QMmbAKQvhKtn4PXebfqhIyJ/r5r
	FP1a3faAkui8A3C+yahUoopNXATliKNUWv4CR1JZo+WA1W7u+Jw4
X-Gm-Gg: ASbGncs80EgniKi3mWXgkIADfxfJ+gen8pzieVYzcluWaYvO+HAnCoQnZWe5ETUZlwF
	YDdXu9MtcM9d11wXzN0G5Smo1c3vBNiLDyCllhCb8pIgLGP2nTfuPTSGW0YUBiEcqPMmFmK71Qr
	q/daTvg4pRZGWE+X/C2YxnGRIqAecx68QklBP0rgS2tVn3YOtIWjirK9puQc9Dh2RY8jxMAY/BL
	mmSn11PaGiqX9e4Pi14lU1PUZdrEbDVvvspwljcg15Ewlmat02fmUtznbvp39FBwsDwF74vzP2D
	/c74bUbJpsmZdii5smQ/FH5Yyx2v07zBeZGvQKlbSxPRQquD7JYiO07tUCgH5tFCh1P6TUw=
X-Google-Smtp-Source: AGHT+IGp4CoHfPPUsld+NS1s2r/2vq7ZsLc+k42RNLjPQwX//XT+3GZe04D3h7pNubLVfwGnIeLbPg==
X-Received: by 2002:a17:90b:544b:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-30532178e8dmr11706279a91.34.1743416639470;
        Mon, 31 Mar 2025 03:23:59 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca203sm65873385ad.30.2025.03.31.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:23:58 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] drivers/perf: Add NULL check in tx2_uncore_pmu_register
Date: Mon, 31 Mar 2025 18:23:46 +0800
Message-Id: <20250331102346.8772-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function tx2_uncore_pmu_register.

A NULL check should be added after the devm_kasprintf() to prevent potential NULL pointer dereference error.

Fixes: 69c32972d5938 ("Add Cavium ThunderX2 SoC UNCORE PMU driver")

Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/perf/thunderx2_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..ea36a82c3577 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -738,7 +738,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
-
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
 
-- 
2.34.1

