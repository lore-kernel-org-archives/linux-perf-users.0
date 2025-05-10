Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE1CA4B;
	Sat, 10 May 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889891; cv=none; b=n8zIhzApYQm1e8z2h8Z62Y62nHp85Ef/TqSq9nhAKDOiBptE0upw1nglltIqSwLiJQuJTOnZlreo77tf0qroc1a7mtpheomI4ENk0DeEciUO9gmaZfuiopeVDDkr3sFxx/oFO7VDRmw1YiyCpinXiHkHsO66+Dy8u8bttpbG63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889891; c=relaxed/simple;
	bh=IImZvUkpMAnwhvmBNPBZuUuP3+ZC7bdMT4Tj48zkB6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IK/zC+5vTqt7QYRUwxW+7whbQDkdkIOtBwFSt9jF5uE/2NsDDU4CR3pFk2y2zSU68U7JjYgwlij1QXALJtxBbwoNiJ/RwXzMagJpDwMuN51hn9mhr4YM407THmynWmGeu14+c47Tefehauybf1hFNmH9+uSL3NTTudMZXCSYryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHG6DaJ1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHG6DaJ1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7394945d37eso2770286b3a.3;
        Sat, 10 May 2025 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889889; x=1747494689; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sR6qkQWtty2THn9HV/oPVYY8q0oy4myszmIk0XskAD4=;
        b=MHG6DaJ13nnrq+X52DC0JsljBXR+mTK0j4zb91ZTKJnG4dfDJC/ZCBsnC/n/5ja0Uq
         SrW7ejKIZ0GxZ2SOHgUv9OcRrBDcJ2x7wxbtfdLY0XKITdseOViaZEWJj4JUnxQIBtqI
         CGryMW2yLQ9QTCqseWSBFmgcm1xSuKSiRW+upYnKXXYqyosYKp+rV4i0HasddsyiZoQq
         Gxv6aIcZDv96sQPIt/VdBq2urX/VvYREOhVVIYpKdIKb8s4IF/9Bb7C9OJCiGCPEj01K
         kosR53JZibJucKeleGdaeJQmqormCSxfhig5pTEZrwe2pghVI9FvTnUmbuz1qAOh716x
         KhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889889; x=1747494689;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR6qkQWtty2THn9HV/oPVYY8q0oy4myszmIk0XskAD4=;
        b=nMefc4g/JBWul+cmHy0ox6tdhvjn0baz5+BWZ/TvjkCE4Skf19zPTMB2APrfU5XF2r
         G/RaQFMZI7xRXnWKYMAyA8Jlk2wF9XfN0CXMFSDzLiR3LtLXeCNyGPvHhi6F4jgtaOjC
         ApQzU7GBN/wAjfTBpmDZfuI8+ZHFmk3Bq5pM7aTyUB8VNnpkS6M2PcPHqgpwRzeOPtv9
         aPXY7CjTrzQ9YPozDPCSjoXS+tjId36HrsmJueaSr7H3Dzx4hb64S3rWU9YNJE5oD10h
         GrjYVw8Uss+ZGQtyq1rFrFqziPtiUOCbervgjZkY9xT0MRw/llnfaLjsXBv72QP4TyAs
         avcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiGmkupbOMeeaNJnI8CJSSEkS9OfR9pKpvv1DybasFCOA/anQU4VzpOokJj9GjqHJ2XNH4JKe0foe3@vger.kernel.org, AJvYcCUxV3h2vefEB1vm98wWG3Y2S6jpGWkMy91Aq+E2RpKJs9iXl+PKliiaw1/+74WfHZU286rRTaokNgVwCAeY@vger.kernel.org, AJvYcCUymjgYonaRfl7x8QVFIHGn8SlmhktvWK+YORZp2si7X/s6M9lDVCIdS2c4ImFfC6HPOxBMsCUfwxcUXNAkhO/q4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6q2G0uIntcqDcmeBkMA76yg1cvz0fJQFyjjet4NVUsFyqkAV
	fdb0CebE9p6RvOzvcjTUONZ0aSeJ969/Menjw/vZLqXKJ9t+1W5a
X-Gm-Gg: ASbGnctDg8n0bQYecsFFRgKwkbPNYZdGwb7rtc4Md1qnAPxDytN+z4XmtUwBjOTXv/y
	QX1vruCOdNXsDE6yUW7VZgk0138Q5tqlfpaiF8dg8z3oCallYA3gqqSDzl7c4SVu5xkxeQbWMbO
	22NM0utyjYRzXUq8yb0HF9AMHtj3DKVhx2Wd5n6OIsoCEjOSIyy6XWruQeYdLYYpJ2quuJM7a00
	h/k73Z1DnYW9EqzMNYbnGhXy3ZQofukaA5VX+WTNmtb2Wf/ZKgNN7ZJ3JWj9Y1+7DXyAqBha1v5
	ScqaZoZU0x+Tc2HDICPJft8pD8CAU9tyBqrAKL3VdcsH0v5rVkKPPg==
X-Google-Smtp-Source: AGHT+IFqdmSlPKPteFj6aFoaXv53VGI6hMJqHMy/+z2wasnrmqyzjdM63pzuW5ZpYok0awQTBpZ+xg==
X-Received: by 2002:a05:6a20:c6c8:b0:1f5:7873:304f with SMTP id adf61e73a8af0-215abcb169cmr11920239637.37.1746889888698;
        Sat, 10 May 2025 08:11:28 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:28 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Sat, 10 May 2025 23:10:41 +0800
Message-Id: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFsH2gC/3XOQWrDMBCF4asErasijSRr3FXvEbqYSKNEEMfGb
 k1K8N0rB0otQ5dv4PuZh5h4zDyJt8NDjDznKfe3MvzLQYQL3c4scyxbgAKnQGtJw3BlGYbuSzp
 yZCKZ1qIRBQwjp3x/xo4fZV/y9NmP38/2rNfrbwa2mVlLJRMGn4CC9ta8nzvK19fQd2LNzLClp
 qJQKPqTaXRrgBH31PxPTaEn9gkpckSd9tRuqa2oXR9OgRRbp63nPXUbClhRV2jLGmyIgBztnjZ
 /1Cpf0aZQYgyQAFyoH16W5QdDpCuiywEAAA==
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4111; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IImZvUkpMAnwhvmBNPBZuUuP3+ZC7bdMT4Tj48zkB6M=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yHw4CuFivJusE7hlGbbgqG9szRqZ0CujA+7
 0Cf7L4U69mJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9shwAKCRABygi3psUI
 JPFFEACjXZ1zkTpXhVHIBbRagB67W1YYYd1s69NMFjN6J086u6h0kJPWk9bwFUXgVaemwUZMZBV
 AEcyPcPPaSI0suoozIWe4JQb2Gg/dp/m+/T2XApZGAZRiilFi+QNnKOO0Sobgkt6iXvrRZ3KRXp
 u9FXdsXxxoabckir6nvpH72iE9f3W0V0Z9Hn5wdmVExSPtq0eudWTMEtH3VkncU/4kD96uK2hrn
 hAe+BpWQQZt+AOiqa6fRgtcuWWLt+sYGQgidT2zXWXFiYmZ+gPGH2SqqqEbk1vpm+QsrGXsmL/J
 MGjgXR4ziP4qsoW5Ma3cdKfrpP21hcmqIDh1cKCCsX6ZlJtpwhjrTjKu6s/+o4FrWdRBirggO3A
 whENu/e8sEX/EcwzwYamt0bNQuweGptXfB4nAope7nVo0O7NrtYDoVSotGgxMYnyK1dzGkUPDNc
 N4I6veIVcn+MsiERtigpbeBLW33lmJvcEqcQ3NQXuO7j3al91tbABzQ2LC8KMYUgKoeYj+4bqiN
 HKkOk0fQonVU5JVruGDE4BlJQNHWlfPen+44A2ioNGQPJ4B2lB5f7rK/I2iOM6PLf6Tn49CHs0E
 g4q9XSgp5Cs4gc7Uz7+wkflr+ceIg2xQLFKZwp2Vvzy7Mc3L2gULSGdYjxRNqXV1X7iJsBtIpxO
 Vpaaq8ZLrM/OYFA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-7 prepares the driver to allow adding support for those
older SoCs.
Patch 8-12 adds support for the older SoCs.
Patch 13-21 are the DT changes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v7:
- Fix a W=1 compile warning in apple_pmu_get_event_idx() as appearently using GENMASK()
in a function prototype causes a warning in GCC.
- Link to v6: https://lore.kernel.org/r/20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com

Changes in v6:
- Rebased on top of v6.15-rc1 (Conflict with FEAT_PMUv3 support for KVM on Apple Hardware)
- Add patch to skip initialization of PMUv3 remap in EL1 even though not strictly needed
- Include DT patches
- Link to v5: https://lore.kernel.org/r/20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com

Changes in v5:
- Slightly change "drivers/perf: apple_m1: Add Apple A11 Support", to keep things in
chronological order.
- Link to v4: https://lore.kernel.org/r/20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com

Changes in v4:
- Support per-implementation event attr group
- Fix Apple A7 event attr groups
- Link to v3: https://lore.kernel.org/r/20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com

Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

---
Nick Chan (21):
      dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Only init PMUv3 remap when EL2 is available
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU startup
      drivers/perf: apple_m1: Support per-implementation event attr group
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support
      arm64: dts: apple: s5l8960x: Add CPU PMU nodes
      arm64: dts: apple: t7000: Add CPU PMU nodes
      arm64: dts: apple: t7001: Add CPU PMU nodes
      arm64: dts: apple: s800-0-3: Add CPU PMU nodes
      arm64: dts: apple: s8001: Add CPU PMU nodes
      arm64: dts: apple: t8010: Add CPU PMU nodes
      arm64: dts: apple: t8011: Add CPU PMU nodes
      arm64: dts: apple: t8012: Add CPU PMU nodes
      arm64: dts: apple: t8015: Add CPU PMU nodes

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s8001.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7000.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7001.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8010.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8011.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8012.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8015.dtsi           |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   3 +
 drivers/perf/apple_m1_cpu_pmu.c                | 807 +++++++++++++++++++++++--
 12 files changed, 871 insertions(+), 35 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

