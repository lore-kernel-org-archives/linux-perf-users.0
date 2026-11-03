Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700892;
	b=x7O0ZKpt4xznuQCAip2XhOIy7VPPOCig9t+gJmtRpil8+m6k7cSVSM4wvzIJfXf83oEC
	 byfEuS0gnFeskuG6X0pFYOD7wNQQC618OK9Xx66ukv58Cdj5didsMlP7B2vrEXgwDLe+A
	 QbLMGMkcmyRB7NdRQVCfL8yv/mUNQ088r7Fjt4HuCZjymqw644Myp9qn7bdTJyOS/TKiB
	 MEMsu8GVkrvcXgt9nPvP+E8Y0Ng11jSGCYcDnAsCbQBQvdoHvz66KbpflPNvksfMowGoK
	 u25C910yOvdibtmCUq7lmiRPHnY5k843tf8DsbTCqAj3yBB3v9KcSW3StCG+K5vtwBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700892;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5uUnmeLc0CYAElfC8k0do6O7bJC9D/W4X1f4xW/m1l8=;
	b=RiPefNb0ocT5Wi/Msahzvc0nz+O44dBLCF0/oljgqf6l4nEs7n4onr7XRgMGrFEFlHw7
	 bSskn8xgAdCTqtnmJCzcxtRTTbpEHDC7vC8Qxksdi6p5ok51VarsbCwOPV9xb+57/ZIXv
	 XhGFxzeZUZVk8gwGUwH6otFE4U09dBGVnpiO8H1aIquEcljHs8+FXib1+Wu8UvV+EiPNr
	 CrsLQCiagVX2n2iviYizZbLa9o9rlRvx35uuLQgUcIJo0mVM8U13iZtbOq3Vs6Iosf+ab
	 yMxxa7Q/MbfQe4NSzRmbcyiYxkOY5197lwtE7jl0sshyKfiGcTr92EkOJtIRRN6wzdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwR0sSdd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138466085087;
	Tue,  3 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwR0sSdd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700891;
	b=2y+SmF3bfF0VW3ZfSiWIZgPJuM3/oe20KBnxdelzIAo8llncscTzSjcrdDUBCGudNLO4
	 JCJblIxkQBITYC1trdg4eu+g6Dze/tpWD30DU/kackTXL7JooBGxo+3N7m0ofnu6JPilN
	 iWHLKplwvnsRzIPpp0kTuRQv9CRtMg1S4UthVWToiwAr+JYyMF64yoKWRWnDzdMwo4Z0S
	 LCPYuAweagC9Eu9Uv3N30Y5vny5Xggbi4zxprN+evRQI8S3g1BvVmNUh1jgYm/uPy9WSG
	 XVWtjqyp8FiaIsg5XJFhwLcLCfLwKUczmS+6ENfPyMQ0U+ID6mc2WDLsDAQp0py1rrg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700891;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5uUnmeLc0CYAElfC8k0do6O7bJC9D/W4X1f4xW/m1l8=;
	b=KOVLV46bKi5nbCm6Rc3llJ5SakpcgMJtH0gCd4oijDKPbR0R9V5kOtLUArVGfEUVd1Rk
	 +n7GC04vimBXO79SAciGTcstkGDM5KP0ID1BYP5N/kWVxKP/0AscaH0U0aukH8TEw44Ly
	 3Xcrb3FxhxVsw4kPEf8tWl+54kuzMVLZjuMbFJtLm66zUimT7mpfFAdysgEmaFZ2GDTlb
	 ge/R/ZBxLXck79RJyeF1WHEnS3N7Kxs4ZSvVFG/TviT6RA8jF+mlk18uhFGCYkYY1/sbg
	 QgvTxBmCJwXXDIdyAH8ueAQwPwfcw8bB+WPJMnQHNBhlXJ1SMBfpH/9Wv/KUF5qDPWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EEB931F00A18;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700891;
	bh=5uUnmeLc0CYAElfC8k0do6O7bJC9D/W4X1f4xW/m1l8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XwR0sSddp6focA2L2PpVbbdRiQ5oVVO4AS3GTKaLLa48AV6hmIVtMwCtClO4J0LxO
	 iwyUzs513z/PGZm0D4vYteSkhwNGuqPaLrSFc08CjRDBJNJ92TK3jwpEWuaJMgRoux
	 N9031GRlqiksnex+lRnFIGU+b/g+ffxqKJ+0HN2mqOKZsknvLjQysdMIiz17Fva/hE
	 FI1tpaNPZDN8nVNJJfx2rEJ73XIkQus7pWb4VfF8R5Jw+P17+uK/3IX7gghUnmbklE
	 EZYyc8RZYj9MIo3URwgjJFROSADfTIjaZD/v4ZiUQi/ID/inwI9KNt1rFc9jqTsEPT
	 55zcfTMdm1VCg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 012A4468B5;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:44 +1100
Subject: [PATCH 09/13] arm64: dts: apple: t603x: Add PMU Device Nodes
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
Message-Id: <20261103-m3-plus-pmu-events-v1-9-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=SO/LMlSi+PPXYEpOttKEw7SF2blcwlqNjHvogmCvFiQ=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEX2/rmXrrU8TQ94dUlC9uIUxVE57efZzvTKjm
 QEhUwyl2CZ3lLIwiHExyIopsuibpmlPZmu4VLrMdQvMHFYmkCEMXJwCMJG//Az/45m+Tjx8ib/Y
 ss3u2mmxHRUndM3Pahz4a/VgZbYd7yf3Xwz//fYobzmeJezKutn578RLz9cXspy+qbkkYOs+pkk
 rn3FUsAEAaN9LrA==
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t603x devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t6030.dtsi      | 12 ++++++++++++
 arch/arm64/boot/dts/apple/t6031-base.dtsi | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index 85a16d03e22f..c3779e1584c2 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -239,6 +239,18 @@ l2_cache_1: l2-cache-1 {
 		};
 	};
 
+	pmu-e {
+		compatible = "apple,sawtooth-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,everest-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	reserved-memory {
 		ranges;
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/apple/t6031-base.dtsi b/arch/arm64/boot/dts/apple/t6031-base.dtsi
index f62ce0690182..3b97c1240934 100644
--- a/arch/arm64/boot/dts/apple/t6031-base.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-base.dtsi
@@ -308,6 +308,18 @@ l2_cache_2: l2-cache-2 {
 		};
 	};
 
+	pmu-e {
+		compatible = "apple,sawtooth-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,everest-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	reserved-memory {
 		ranges;
 		#address-cells = <2>;

-- 
2.56.0


