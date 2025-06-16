Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B61C5D5E;
	Mon, 16 Jun 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037536; cv=none; b=btJZSQqn77HX+JKh/18o+0jeif8nMmEdOopgtPBtCnAdFmoPXOoeWQoFyLUsTGwP7RLK8FIOeOKxCM+ddOSmJmIzh4xehJkF/5H7t2QPfAuFiiT6MxkOqhnlDVW09bLMJuPOLzbridZ+betLLRU+5npQ+yfBDLDW2pjTIElEpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037536; c=relaxed/simple;
	bh=IImZvUkpMAnwhvmBNPBZuUuP3+ZC7bdMT4Tj48zkB6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kLDEnJVRxKEaALJpL9WgAgTzVGjktxB6XenJk+vWwwFzpC/p/qwrNcyFP6phxHJkGvvFkWKJSkKl1f7JX2OgoXTO+C7lhSlqtnEchWrs8v95r9LubCaeWW6Lj2/t6gU/X+tsJSXwwYPhPrynDpwykIu+XZqA/fvT4Uazixhj7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVdFYXw5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVdFYXw5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2837600a12.3;
        Sun, 15 Jun 2025 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037534; x=1750642334; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sR6qkQWtty2THn9HV/oPVYY8q0oy4myszmIk0XskAD4=;
        b=gVdFYXw5RlBxVibkWVK3c7bNck88IAXKB5cv8rsxqAO1E2rGwfrnitDK/O7NKa2Udm
         7WtZYp+GPDK45aKxnVcf26P9R3jSv8LAGBej3kQMR11I9+pWNglGgze549h3pNE2v9YJ
         N91+ri/wXYsYZv9hCsgt+sACE8FURaLgvCDSJRZAhOm0cbWnMlwJsiDgh3CptPk301jD
         NfVkhEJCwG+FUvWYa8NmaMdpLavIQngwTGXivrcPMNLGWJAW8Pr3OnVoiAOpe0DE7URO
         1EFdBnpFngBpPp9HFNSFhqTP5QNWjogzgeWN5D+vqLSC/v3BPdhJFIbjRkSr41eGiDrD
         0L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037534; x=1750642334;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR6qkQWtty2THn9HV/oPVYY8q0oy4myszmIk0XskAD4=;
        b=cGlx51rZt/YzyKQh5GEfSFFmGeFyjp1W8N25TDxmpau+cW63k7ZtyO2e4bMQRml8Um
         GPQyAQo6zAAMHOgLcPfNUKuQmsUEqlSg9EpoX7hBOqRjYOcp+iMcXfAXy7Abvytv5ebY
         rdVrowwGLvp3e3QiQNAD22y4I55oarIhKWmPfHcO5/oQdiKqgS+r3nIVeroIm2H2/+14
         l06OLjqRDWvEH4chvd9o1riSGw8kk65VqKlYra6Ec1juKFjTALyLAa0Xm/dlLu2EgrH+
         LLNsnomVUtigtGlM5BSCvMXgoOyxsQAwJ19z4NzOX8mAUCamAjnldBmRDSXGluwtHzwZ
         JCRw==
X-Forwarded-Encrypted: i=1; AJvYcCV31b10zzSqPMUt+9YB7w8qxYFOjY+VYeytJqZblPCgHvOov+iZTNGZi57glp7/F8Nu6bCQkk8mkRoS@vger.kernel.org, AJvYcCVa5BHbdhrNCFpsh4TqudnRYWNhmfJHDVJePAcBzZCHCThvI/bwHNy/T7cBKtJQpAx/BH/1vqjWQ5SVvzwuUD1q5g==@vger.kernel.org, AJvYcCVh437mzHa05ig79NLpmKUlKtV7VV4jyxU/kfTfrUSXXuQReOYHi//hv8c2q6W7SRDZ7NETislX959iEGRh@vger.kernel.org
X-Gm-Message-State: AOJu0YwREsTgw21n3iVgykSUfZG2dgjBQjQDmCa02C4P6vmhVdUx+APJ
	TMn3ZQhAhleCOlpXrIGD6UPCCosSuMXHbDW2OE9V1RNmZQe+B5uh/dq1HwgK7g==
X-Gm-Gg: ASbGnct39JCMZmyWaP9Blkw+vMEumgfcK/KqVV3fZubdhDIxluV9L0jcV+uF3FhMmxP
	jzcNu/rpWc9wERKJThadpwKvwh60N7P6ltzFSoQOK5WsO0vXRJfATMOhsHvu5SGf0gI2pYRdmgu
	en2K5YkG1Xffnk6JnAJn6pxRtz0aJgN/Ke0Uueto4mQuVwg5M6l9Xp2080zIqmoYcyikXnuTDPp
	MQEYWHYOEzKitRfhGBQfexk0Epn/6ZllrK+x2un6FRFuyVaObMteQkSonKc4q/FI9+dy+fkdkYN
	BfZoIedQ6S69sC22JgEpagHnTZibZU9zV95VUdjAmobHc0ol8UuTUb27VOa43/9BeYeBGdEYg4W
	4kNc=
X-Google-Smtp-Source: AGHT+IEjqUySqGRQmucLa3hYe61oVihGWXZ54gO48AIrBbAmxb4PLDq2yHwjYLsiPdfkyoftEBxaKg==
X-Received: by 2002:a17:90b:1c04:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-313f1ca7f9cmr12489670a91.9.1750037533701;
        Sun, 15 Jun 2025 18:32:13 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
Date: Mon, 16 Jun 2025 09:31:49 +0800
Message-Id: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4111; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IImZvUkpMAnwhvmBNPBZuUuP3+ZC7bdMT4Tj48zkB6M=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QWFDqwdlCT87E/lnHN0y3uxYwVNCrcfXdEv
 r8W31VQ5I6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90FgAKCRABygi3psUI
 JHOcD/9aqE6YzKXZcdiBW5LIR1CLL8vrnqMP86Z4ipOHcMcJQdQT15eeRJduzxpeFzUHsqqlVko
 S9wtuUkyLZlSRNuwIzyh9bkSDMvgTIMCcmGqpNIgNbqZ9IN8AeYyxjfJUUqoZ6q9wn7e1j85aDS
 BRAYn0al8oDlTlWq+LPbEvMJtGdc+oYqt5scMf9V68svvEdjqsSqL/DpUGtH7obA6hYmx77etoa
 FFPkshJ8PGB+WAFWxQkSm02PU8YxFzv0TZtxJwH3t2J7i6arjJfAURZt26JL7rFNZXsTq1hCIlK
 bN5fFrzAMwFtrLAox+nZ4wUDBJLTl8bWvSN9ur9Ny3MPvlBxifUEtnsEslTP2OsGXzhVF22Xesr
 bFoA8m3ZdGrrFH+VNsLJxys1NNkiWHDzh3wj8c/JENOFtDdU08WLZr65UatfL10vzvCNyJHYSKJ
 oU80Bszn2ITw2U3knG/X2MTklcmDHK7/xkWRmiTnPJrNBQu6SJOAJkhvKtJ3cTWaiwnBE/qIvfh
 C+ECXbFaoNIwW+56dUdKRRGcFpFz0LWt1BhKa5QZ6Q8qxYSGZwr+oc/8TOpSNaCNWnYpIRpi8bY
 F3EhnhR6lLnxPffH2+YqunJwEFDPWlVgZlj/E2AaX6SWiS33WoDsKo7uL/zQDDFybZqbvEU/iRZ
 9EkuYkCRyCg4khg==
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

