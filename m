Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048546;
	b=uwRPDLRzFGBooLyVMHkAtvYe8NFIvcfQHpNvIqRN6N2SkOJCYhvteDRzeguFYeCN9Rfo
	 M0O1gZkmjGwID6cZIPU1QduraXPfUu3nTjhGZOgt5X6EBjOS7sM/Y/AG50kxD73vixwt6
	 9lcjZEJkz3lmVm1ZwwqQREImBbrppw03vsydEvsETdTRZO5Rj8TVdzwZjkHJ+lMvDtiN0
	 i1LlEaGl0X/8dlhIU8glkOBmJnd1HasMS4SyQh6AHFMqsNtNS6fQvB972JQSsBX9tpAog
	 UaMyht5AHT0p8LgJh6M689C3Ew77+rstUt2KYpCTcpBrW9dUwT1a0fVq+GRb+bsUfWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048546;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=iWQaOuUmJOZ7ujMaHwSfbL4+y/sWW6js1cOAS0Jv+ck=;
	b=mmyoeomDrA4ca+uCg/XQdqT4eLraEz1p5Zdob1J+rZB+ZUNKJFQKs69lxm9TJII9vpFd
	 Zbks+COf+MJb/7NYYlxoNmhGvD5VP+EcZwO8IExEXawBexdP3XeP2b4wmp6rz9Fi9y1oP
	 SAs4ZTeoAIKm6EdG8WnshqdiLhDnIE8DcjrIQ9uF5+ps8my4cI2xgNmGsjgF5sNNwCacH
	 r0WiA6Ja1HnkusLLxFdof4lYUceY4QbgLnPWtlCv84fXp586SH3h3ZhphFR3VAxCAWqfZ
	 UmeAbkDuGbaqXZfN48sGDHsjFpzGBPmncL1GfA4WfeqLNmTlz9yAqRBBt255aYFewRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQWTZgYo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F8606A32C;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQWTZgYo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048546;
	b=QW29BaD7x3kZVy5flBjaLbFgROjd3/OvNV8aKtU5AF7LSQ2jdg3ABlXFjMDoz9g/ucbX
	 W+ZBekzSJLsj3m9B0fvNeBuFOu3I52NjowmC5E8s1phDox8rAbvNFcDXEjTN1CS/8Ext6
	 iJLEO+AZsICV5BDXP30y+d3GNlj/i5+UHe+UcFwcV4oOkiyPprdYusDIeQlRy9kuKrhfg
	 lONALt3wfupy9L3vtoy0smJKeq/hRcPDM0Ea27maBFdnevHMbXaqZjior1QohwQScr1Li
	 e3zGRXPOc5oc5K8Gl5YV9/p5uaNEPJJNuaFEo7Yo/DjXH3ZxJSapIFOMGLr+6/8Ya1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048546;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=iWQaOuUmJOZ7ujMaHwSfbL4+y/sWW6js1cOAS0Jv+ck=;
	b=COb8IJdf67oJ7eA4GWqkl5XD4Y8s8X/zB+Ll1zY8RgEAPdHK2Kst8Tw2M/p6ad1o2pGo
	 M1Wp/USMiRvnWo13Bphtah+LGEtbhz+A4bY1zUVVDqnJG0aRvmpjtvWKbEsAvvPAzDtU8
	 u4zuMGkF7gqQFwSO9l5tbhomaDSdeXBw+yl0YzGHcmCZ3xHHuTHhG0klvyuyKY8BCzhD2
	 7LtkHkvdKQWYEyGOhLVV667WIhtkdO7WbNi/ZAL7UJJVG23AfM7gBaifPm2z5ae46JiAR
	 tNPaxgx6VUZTZfpSllQyZw5Ufbfftu9MnMvBbWU2dgQ91UxdS9LlRdabBLTyI9SnbxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0B2781F008A1;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048546;
	bh=iWQaOuUmJOZ7ujMaHwSfbL4+y/sWW6js1cOAS0Jv+ck=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OQWTZgYoq3aozgLkRwQaPepZSODNr3/ou490IbQGTUV339K8lvnNe3/gh7WtkNpGx
	 8Aok/7PlY542vdQk5yGapR6GSxsDUCv5gTM7SG/2Gy3C+jWV77zFJPdZBltc91+Pyh
	 TiZtFe2I2XsoxHO/gqUFn0qJghd5R0BZzqsXhktFCGNviqNXtG26z2pjqMj1quwFEs
	 k0eO3kCPyx6r5/aws7cjXYkUcKOMKGY2c9nhN21Qo9uHNHGHDF9FuxOg/YS6APocKm
	 k3eZBdmkaUkNejYYqFW/rteW1XE+WZjX2AWWc7NiiOXk4Z8g4rN6rmFCGIjGTqKJLE
	 M7xOueQ8jZjKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62D7947B72;
	Sat,  7 Nov 2026 10:49:04 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Subject: [PATCH v2 00/15] drivers/perf: apple_m1: Add M3/M4/A18 Pro Support
Date: Sat, 07 Nov 2026 21:48:47 +1100
Message-Id: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OwW6DMBBEfwXtOUtsIGng1P+IcjBmE7bC4HoNS
 hXx7zWkxx5HmnnzXiAUmASa7AWBFhaexhSKQwa2N+ODkLuUoVDFWdVFja5EP8yC3s1IC41RkCq
 llWmrSpcnSEMf6M7PHXq9vbPM7RfZuJH+GoG+5/QW3zVojRDayTmOTWbE9Hw03g+EMtljF/EjP
 8HG6lniFH5230Xv001Na1X+p7ZoVGgu1J6t1mV9p8+HMzzk6Qlu67r+AiN3E50AAQAA
X-Change-ID: 20260929-m3-plus-pmu-events-e4010ab44135
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=SHSP4+Stn2d9XSzlQdogEo8YrxiUT8uylUSvN+wOoCI=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zSfdpLNzJfKRKZJNE+hfGgrCygEpxle3J67uK/
 7k73Do21aWjlIVBjItBVkyRRd80TXsyW8Ol0mWuW2DmsDKBDGHg4hSAiUS7MzLcfhf/ziKT5dqX
 C4lL1OPmOjzxSD17eO/v32bu/2ayz2ayZWRYvn5vsnlHj6Tr2qWfGhfV/j3Nv6V6RsCkK3+fJNx
 7FdLOAwA9M0sY
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com

This series adds support for the CPU PMU in the new M3, M4 and A18 SoCs
presed in apple devices. These PMUs have new encodings for events, along
with larger codes for these events. All of these events are as Apple
describes them in the various kpep files found under /usr/share/kpep on
macOS 27. More events may exist, but we have no idea of their affinity,
or what they actually count, so we don't include them here.

These patches have been tested on my own M2 (t8133-j413) and M3
(t6031-j514c) devices, as well as by Yuvan on their M4 (t8132-j713)
device.

If possible, the device tree changes should probably go through
apple-soc, as this is where the recently picked up M4 Pro/Max dts are.

Tested-by: Yuvan Shen <yuvanshen09@gmail.com> # on t8132-j713
Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
Changes in v2:
- Remove extra cell in t6041 pmu interrupt specifications
- Add affinities for t603* and t8140 aic interrupts
- Make the a18 interrupts use the m4 function definitions directly
- Remove dead pmceid defines
- All changes address the sashiko feedback
- Link to v1: https://patch.msgid.link/20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com

To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev

---
Myria Sarvay (14):
      dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro SoC CPU PMU compatibles
      drivers/perf: apple_m1: Remove unused variables
      drivers/perf: apple_m1: Support per-implementation event size
      drivers/perf: apple_m1: Use macros for per-implementation init functions
      drivers/perf: apple_m1: Add Apple M3 Series Support
      drivers/perf: apple_m1: Add Apple M4 Series Support
      drivers/perf: apple_m1: Add Apple A18 Support
      arm64: dts: apple: t603*: Add core interrupt affinities
      arm64: dts: apple: t8140: Add core interrupt affinities
      arm64: dts: apple: t603x: Add PMU Device Nodes
      arm64: dts: apple: t8122: Add PMU Device Nodes
      arm64: dts: apple: t604x: Add PMU Device Nodes
      arm64: dts: apple: t8132: Add PMU Device Nodes
      arm64: dts: apple: t8140: Add PMU Device Nodes

Nick Chan (1):
      drivers/perf: apple_m1: Support per-implementation event tables

 Documentation/devicetree/bindings/arm/pmu.yaml |   8 +
 arch/arm64/boot/dts/apple/t6030.dtsi           |  26 +
 arch/arm64/boot/dts/apple/t6031-base.dtsi      |  12 +
 arch/arm64/boot/dts/apple/t6031.dtsi           |  18 +
 arch/arm64/boot/dts/apple/t6032.dtsi           |  20 +
 arch/arm64/boot/dts/apple/t6041.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8122.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8132.dtsi           |  12 +
 arch/arm64/boot/dts/apple/t8140.dtsi           |  25 +
 drivers/perf/apple_m1_cpu_pmu.c                | 654 +++++++++++++++++++++----
 10 files changed, 717 insertions(+), 82 deletions(-)
---
base-commit: 84a1163b0a3ec0acdda113d4c920ed72955dd6e8
change-id: 20260929-m3-plus-pmu-events-e4010ab44135

Best regards,
--  
Myria Sarvay <myrialsarvay@gmail.com>


