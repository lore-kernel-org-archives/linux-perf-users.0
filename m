Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE0257D;
	Mon,  7 Apr 2025 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001166; cv=none; b=a0rcy+0TqivUMj255+JcDgak4ls/erHnqlVafkemPkjC/etrShwxpRn0LGv8VGCIprekvOWJop6br02FngNVGOZpbVR67Gd3/5h6bS4dSVbryxJjJye7iuOAw3fP8NI7xODY6OLm9KXVRgWh3vIkt2OQkC1qV+d9pHQ5zt9UuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001166; c=relaxed/simple;
	bh=A/h8OXs8Wekr7gbuWaO+81ojzwQgObVHH0lNAKAIdNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FsJ+/mTE5llsa4PTv2U73bDD61tfaY+18jyS5V3RnNSB1WFn12TYVAt/73uyLOcfcYEH23LHJD1EkQaw/DAFf/xj6Cp4fF6UBNBJ2soN/M3AkqDgLYJC+7f0IfJZ3RNPJNrLSpkkBUckKZHmZz8G9RcYerB3C5GZLl2Fdu05S5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqcZWVMY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqcZWVMY"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af9a6b3da82so2439172a12.0;
        Sun, 06 Apr 2025 21:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001164; x=1744605964; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EuDa5MdYzDvx9phCQyiyQIJ/EzyBR8j5u1DkbRAKbc=;
        b=iqcZWVMYzMuW5xZLX9ci+BOfEcQmQ/ZifiMkCWzQa9bNUEwY3JJaWsAMj1ea2aFi6T
         GqtdfUn6SZRzKYX86qv9gDyI99lDYvfJkmRpXsMJajdd87lDLbUg+uFu93mVq1b6bv6M
         h9XtnI7wMyJ5Z7zXvzI8MZtVsGIJyIuSZ/aJ7j9YoqkJwUWy6KQFr0gxHArOp9suuz8/
         n/DEUH59ZIhzF0tL25NqTIsv7OoFN58v3SGvZ0D5SSg4oTjOtNbL87OGMZfc2tAaiPLz
         3m5l9feaTrt33huYVMxJ+V9OkLfpxhrXc8F3VmiuK5ymKxDCErn9WFrdIxSkOVI6WjJ3
         anaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001164; x=1744605964;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EuDa5MdYzDvx9phCQyiyQIJ/EzyBR8j5u1DkbRAKbc=;
        b=KIIZXIB3GFGQ2v2W2Z6tpuNDau9Q2c0rfExPqsTFdARrZYA8WgeOOGxLRL1j6IL09D
         YBo7dOzlEKhiaOBBiQWJ0+B6ztwhzguKyOoJnKejwVW46Uh8VQeJ7I4x9YGGa8+2a0e2
         XnMUcxvOLi0z0v1u034Eoi3Z9TrCZjMV0sRnW/7LJd1f8LNfqjtMTnwkVK7SqBhYl0+v
         Wku4Kv5mUkZgmpWgleL2MAp9Kya4+k/cCrcZdAFzIE5k3bX0CSJXNkhbdbORpio4wnCF
         WfNzOL/eGt11BzEaDLiHuqNw6YTmlum930yIn2RFkeZU6LAaLm5VOz0zU1r1B6FrruRs
         yfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZIBNBuvMZuxhcTZpcgmY6q3xIJHTMUBWl+hLoy1l9uxe+rfbAsdFOfXmz6m2RQprDlX12R8C9E38@vger.kernel.org, AJvYcCUwHn96jDFjMO7OFzoC191jRZRPa9501wLnwNcpluZI87IG9x9B2avH4MbjvC+Zc9wKmOSYOzbkt3ZcXfm3M9kSgQ==@vger.kernel.org, AJvYcCV7irv+lQACfbNWLP/KdhxWWrSj274xEO+x17ysnDhCYBgvpMN1SWgO28iS0s+3jiorvGEEDmuv0LubpOjs@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9wb6hZiHP9S+UlE4V5wtP/5DWOJLPkCW+kcnWx0TyKHo6dVo
	hrlvzSv5YHgYLkN2qTuTffTf0B0lccvWCu6xa+ZtIrU4B7Zt4BKh
X-Gm-Gg: ASbGncvM1zv9VgyXzKbaByfW0sQz2KZ9+yG4ZqlGImhFjBsJCLVMGup356Hfx8Jbk6a
	N/qJX9l4lSKunHT9JYG5Zu6zz4Z8BE4xRT4X+aq4O0xpTgpnb69w6CNDejcP3Dd5aEF3m55DKMB
	jk9R9af9hZ79bBrPE5tmiqUgZgM/MJ+MMg2Y7HaKmz1SRxZ62TGM6+N6pQPvd8dKFfVv6juHtkS
	xL7158oUZSS1l/4Bg9U+n3Fsj+Z0Q0PWXqiZlYgpCg/9b1b0tlCRvQiZf0zQLRfo0q4vOwwvJYj
	PG7uBKOqDeLkNMfXbCiImIA954eha9akzAYQ3oQ9hsQMA0728p9QS4uYbg==
X-Google-Smtp-Source: AGHT+IGnnwu3PoUM04kNoMa5q/pPcTApIutUUP6YpURP7hymSf7y+lisKuwk4Y0t7sbuK5dmWNv2yw==
X-Received: by 2002:a17:90b:2d4e:b0:2fe:b77a:2eab with SMTP id 98e67ed59e1d1-306af7b37b5mr8196187a91.32.1744001164238;
        Sun, 06 Apr 2025 21:46:04 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:03 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v6 00/21] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Mon, 07 Apr 2025 12:45:09 +0800
Message-Id: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVY82cC/3XOwWrDMAzG8VcpPs8jluRa6WnvMXZwbbk1NE1It
 rBR8u5zCgMnsOMn+P3RQ00yZpnU6fBQo8x5yv29jOPLQYWrv19E51i2ggZsA8ZoPww30WHovrT
 11mP02BKjKmAYJeXvZ+z9o+xrnj778efZns16/ctAnZmNbnTi4BL4YBzh26Xz+fYa+k6tmRlqi
 hsKhbI749G0CMK8p/g/xULP4hL7KJFN2lOqKW0orQ+n4Bsha8jJntqKAm+oLbQVAxQisESq6bI
 sv1hkktWQAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=A/h8OXs8Wekr7gbuWaO+81ojzwQgObVHH0lNAKAIdNU=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iAz4hLMliudNCLKDZSI8+c8gq5cO4dSJTrj
 JFIwGCrcXWJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYgAAKCRABygi3psUI
 JDkcD/9GRYoFGfptUaxyUh/OHaFxIDxYKvUhITxgKDs0lKXNXU6O4QG/aPDi+rBHqKlgfw+pv5G
 4JKAvs+uN4L1tBkI2q1v4dYPEzoNO3qODNIRRY6/5oavcmq8u0ADZdvg/as/W0cdeiSFqCrHaIT
 O1WBwqwyBztXKw2IktrdwOeeeVnYdfbSUpX/0fQiBCBPmo6/p6Whg9isPpwUFYga+/BveBaPvvI
 tXzDs9Pb2XbKiSBWcqMOqeS5KGEaiBPgxtIR5xrGpazJVM7FrkzDpAcd//+XYTHvpkvb9jBG0d4
 Sncjv5mBK/ruyOB7UpE3VDKSvcFaTJlci3mIjAVCQLztuwbm9L8ukjEjD9DanUzwvokko0HfQxi
 O+YlR69WiTUEVWK/USWOP2GHFtJ+GVXREztk1LbpjknwtY7D96IGHtrpZbE+S34ZrKKkfk9ETZo
 g0dUflMQqVk8dx4nUUyfdZmnxno3cJWMlX8Rk/wM6WoS2B/RR9NbHWjyVUM2Mb/MCy+t/38EnAG
 FDHVytWAunHr8k7H51yMp/hWPWRgGbm67QkMQGcRXSc3DMlIdiYXR3mvzy/S3XXYq5fGuCZNxM8
 nP8Im3Bp43WHdCaqvqJXebZipW0WDhDzFvnlnumZsT8UeqNKr+GRrPUsANaw/fJRYj9haTvRuTn
 rVjO4qNRP4w9eMg==
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

