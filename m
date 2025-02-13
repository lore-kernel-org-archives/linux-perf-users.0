Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24933206F05;
	Thu, 13 Feb 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457388; cv=none; b=chp2F+T6ufef2ZXfm8pajVImoBcJgggGc3jlRfVK4GQys+lN/SKRAKv0s5xy9A/kQOs/o+D0ruXjzMxaHZ5GurjhXPLh8pvYFcgvpAIiHEQbLYKAsp5d0awO/J5aVocC40Uo7eb1ztQ7bYVrBJ1XFI6iKGqLjLQ0EY23mwM+ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457388; c=relaxed/simple;
	bh=IvblILNfK65nRmNXFfVq27lzQtZVkqPdlXpIO65Xo5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIt68M7T8s/KG0fGKVurhiSj0b4Fp6jWOapdyycioJFsq9aB9161FYg2eDpt4aJ78mH/k4YDyDIDNMU07H7OfFuq+702UhvfYQWRsyzNVNl5F4YpqDHTN+ZZp54lj4OQecnc7nh8sEkP+c3wfQNvky4TGU7k0DqC+VOPZ9uZ1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7wNwuGl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7wNwuGl"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so1811673a91.0;
        Thu, 13 Feb 2025 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457386; x=1740062186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vprohxk3JreCnU/aMQ3Cwcsm8vUQGIhxwt5YLfMxZE=;
        b=P7wNwuGlXMl6sgqBe+yQaJpARNZc483d7NcjT+XQWFrGAwfqfYlrv8Mm8GwA1NSeFS
         NjOua89NZdGL2W16w06a5ZLGyYFGhh4SaACRrF5SDT4rNnxM1yxPrkH79WaZ7FKCEfdO
         Gyat1s51HuCUC3imen/RQrq4B4lwJ8mqBdC4a0D5cgLpHfms9h2KHutShhkCf0OAaIVC
         b475+j6mYt1lqzJlYxz8Ff3WmLpF4oP3bDkYO3fKmEfFePmna1+B6flnDSpxasW8o7/p
         GopmaDM1vlAQeu7IFkePOfsSJnxtpzF86Vu4qEYLZyWhqCZbDa+bBsl0GsGjooJR+RE/
         QoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457386; x=1740062186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vprohxk3JreCnU/aMQ3Cwcsm8vUQGIhxwt5YLfMxZE=;
        b=XcTgZoehsazSTdjwYTnbm4M9JZEUkxlIZ5j7JQpElidN4FL9igKJM7uhI8GBY68CVX
         WLKMSHaW0Bpm5CpscOgbKo2Kq+WKKNcKdPW18+ToThH+K6OdTw97spapglqTwPpGwbGM
         7+qFMPkNR3oVJQmomDwzRoXj1a/aE+yALdpEmZiZxLHgdFXLDOMH+F3o+m9/5Q2xUaUk
         aIM6qjFI0WSleCNzaKd8HC0lb0qm6AdL6Jy9ok2FQ7sQjjvmmXxQ/YUiSNoeANXTbnsy
         RjEvQnCwdEjC24bK30LIetTSV4EVD/Wjz7wzjtOUsYM1lZmX/i6HYSQ+Ng3NCi8d3qm4
         0hyw==
X-Forwarded-Encrypted: i=1; AJvYcCWSfVeBIpTIZHC6v8NnzbSUv7gCfMaKxMpm4FTR5tAHphuBYh5bggdvO5jsDf2NR5XoZcl65UW3fAyJ@vger.kernel.org, AJvYcCWacTtjDU9lRhn+6iDbe72zEkTAVa9ZN2ZGqCywlQ18u23BYWXUJXvAuxRgYLqRYhAcO8eD7cslGGysqm6l@vger.kernel.org, AJvYcCXC2Od6G9nmjAjSq/Z7uJ7sW1uw96KrbmB+ZInTG/1mloIB8up3/8AcwQsH3RdoC1we5dEAaMuOSVGMLh3ATvCSCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4chGb/FE8Kuk8LEQot07d5LQXjOy1rI0U4FhilQ/VSbdyDHnR
	nRayLHWVJHk704bSD0ziCBN4UA029FHyErQ46dM7O2QG/nipkQYd
X-Gm-Gg: ASbGncuCwMBGRd53QDGKUbiQ9UkwtfjJpWcR40HmtC5dmioIyaueglmgEdxXjznGPti
	UUswYWeVOHmFsHvFkELdF8tPVDPc3cAeeHsaZS2WlEgY28tBgvhVLoaf3OakznmWP5X2Pq1c9d9
	9kJX8JUXbxSx40sYX/4WRtfUpxQEHDE4H9DLtskdfYVnTbZPbwg9EW0t+6Zpt95cZPzxVe2yYhs
	GEIezU4K4ucZ+g4+FYdimKFxTGlJpiufwU3f87zrmSnL7uxVAHO//W2rPjrh7cJBDDEmSD0CWgC
	xCcgJWCQeITzGhZQRg==
X-Google-Smtp-Source: AGHT+IF4RaBshAbsZAbU0d+7OJwZz5y9P8mEbE5ZRo5bsmk6xrlhZCkCowKA/tadWVVR+OksLyqQug==
X-Received: by 2002:a17:90b:264c:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2fbf5c5e239mr11221868a91.28.1739457386366;
        Thu, 13 Feb 2025 06:36:26 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:25 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:03 +0800
Subject: [PATCH v3 01/10] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-1-be7f8aded81f@gmail.com>
References: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IvblILNfK65nRmNXFfVq27lzQtZVkqPdlXpIO65Xo5E=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNi6bH9gq/2V1s/QQdHuEps9tUpFBbFo4avc
 B9WT3691ZiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYgAKCRABygi3psUI
 JJzMD/9JKed3nvtgK9t/Ni8ZcHFenj8Iiwp/D4Ve9BJ1bFG0fhvJrI+hHA5klcqShBgQOWuqsFr
 yHR5nRlQFoeSHj8Bv0JyO2eONb8ebbYwA/XBkTvbZ31m2KRtDISJJdwsL0vdWO91li87Yr2aPIK
 b9HTj4ZyitNTlZe55/iiLXFHPd7KjAJQ/tYu1cnYgUSa08myxtyZ2yhWe99ka1mwsFtiJZdrXWb
 3nv6uxg50Ufg9mi7+10vUOLpxjTtRbqoYM3Vo5SZEUyMGNGSx5AKyymujuwS0QV5/EdiqnAutme
 jE1mJXD/eJAtbE2yUaGYtmsNrvcS73bfE/JQlr3gvBZX24t/Qa1NcqgsmTYq34RzdOC2zW/LnkC
 pZ/YC46UqKPe48tnPgYWOSGJ7Ek3A7QMgqRVViCtlK4/GkcaQTWrxzWFXP8mPh/3crSN7MC05C+
 6RY1uZV/jFbA+GZvxzg3YzbbDs1HBagXnJu+52StdCvRjdd0548KzCxIgwdnMsHZxm4re4QtlT4
 TlsZPCDlDlq705jcV19amdlPkXQCBYil9tOlpw3XA5LDxyJ+W0eX6veaaj9rZTjqv+ctqGzT6FC
 tMCCe9p03k/evtLh3khQQ5cwm/jybS+wIfPQfba4F1aBdy3uCXUs9cdD5UQqi4MesSIfpq5tDIH
 fefeh9ckgm2E7Aw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index a148ff54f2b8a92fa3fcfa78c1bcc525dba1c6dd..d2e7f19cf6a2d7d2348d163d37c2787c7a36bbd4 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.48.1

