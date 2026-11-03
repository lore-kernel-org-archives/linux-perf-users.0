Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700892;
	b=O8h5BvowKb4066iV8tzRR17xpIcEZCuRCrJkBjFjb7l53Pw92AsX2VIFI+U9ehYO3JQ7
	 N72tIM8Zl0AxRslhLN/Rk04iPPxQ1sejCkpnHl7Bw2+Gb9KkC/kVdqefQdJq/7sB18ang
	 zOFYhgMHmlf77wobK91NiuIAbR39RsoKJ0wB1uPzu3MfQnLfzPULZI33bhpe4RrblzMOZ
	 p44YzFVphlYP4XKa2kXeEZ/PZVp8eVwJHTorwxzxW6qfDMzcuC4ewchizLZH/xvriwXDo
	 /IrYsxQ5DW3fHhr4rE6kv/eUczY+DzN6+VNkLe8iouBgfAXVLG7A+HVe3KHKXZzD0XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700892;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fgba86xwfdZqqRHiaO5L5Vm2/4yrwcvPZGNzBFrMW20=;
	b=mxJT01FkUpBtd+HJlCggw9WTg4J5pMrJEplAVdtKtM9I4Xj2n6BZgtlw8+EZ5/8QWEPi
	 x2qrtpeobi3u1T84u1TStKsFpiu/PdessQWne9DX5lorZ/yrxE3gJnntDgWIfhhrCqYt4
	 uAaFMw2bwuSz5ahY72Z7N4tHYBv+UrKX7/bJwq66NacUzUAiXYovCejljSMoQKL6wk2jV
	 KFZVj24Fs1vOkgW/SMFgoEaQTL3m6joavgHR1jrMt854KvHzOC6+ZMcnlb3AsIUjE5leU
	 ei4iaVPFV7tm289Q1hrzU/W6mVqW8Vf4VrDW/XkGEYppxqTM0asfM7tPivDiTyFboOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbfLVqRc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153560850A5;
	Tue,  3 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbfLVqRc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700892;
	b=3YipTnSjcXyT35fYY4XMJ/l4PxXyW1xSeohm6HTD1nOhxMKAlmNJqepNz3ofX15Elwyt
	 I1pJ/2zk5qFYfAbMfs3baSD/aY0xhZvnaAXihdLdtodGto+wwao9VbnrwsXHBLZIVewVf
	 J3SZ1fPW5/NWg/ddpcmBl0/mWdVDyXHIpKN6iBDbgBfHy/qq7wXlvR+K8wZVk1b+IcxOB
	 Oywyu54+KukDxPbpwjVZ7eoiIBVZsgQCZFgovocn96KdXeA0EYpT59snEYHfGUsZEHUx1
	 WbOueD9WLLbJMtvw55FmJ44bZZTOV958BORBhaxLKyWMA3xPNJ4pe0M+h0li0w3eWrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700892;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fgba86xwfdZqqRHiaO5L5Vm2/4yrwcvPZGNzBFrMW20=;
	b=dkjSZpiahhqeXfigZvfGDh7fyACltTFf+jJh0Dcg/VXWNd23ne024dBHKeTf4GF2EUWz
	 1/sNzq0GoOcGUaP0iNA5teoS+WhqNKqokIRzwEDzCq9k4oL2oTT+AQiDyjuyVImv6lO2S
	 c8K7UlJdW/y6hoAqXkeuUNRAHHznz6YGyud6Ly1Diu4j3YTTh9YG5gMZ1/637yTUWl0gN
	 fSlqR1ezSpE4o56kEE4WbfitTHKfC2D3K05VBAhGDMnjQVpWcLiSJ4R8ZYLV9S5pgzp9j
	 4HabftMHJGFhLC66lqC9fgMXoBICZkqonLnn6r6IALRqJko5CSzVdbA9jwny3Xupf/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1DB2C1F00A22;
	Tue,  3 Nov 2026 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700892;
	bh=Fgba86xwfdZqqRHiaO5L5Vm2/4yrwcvPZGNzBFrMW20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SbfLVqRcJ+1Vn4fFE2+i4Lbh6POTJz4qq7m3BxSwYm5qOvKh1PayyfkqXTKr1enef
	 b85cFVBzyq48vdx0l0f7J8k6ityXl5vHeCO3NK5SV2MqicdpJcMufc4EgiW+oKI7tl
	 4ZtQx52rqaHpj0lMT3/hA0H8pJ/lzCvvWNUVVIG/a+2AX5RGxwniTdrvcAfQX3ttEa
	 RLO+c1PJDdKPpQZAjnNB/ddkMAwvLjRgYeheu+TCr7v7UMsKwh6U92rMJENOMb1tVZ
	 Onj2g7Omt/aCXGub2z5Bnggx+5NqT+IdFz93y6Hw093cRD5i1mqfuOUBXPGPY+4jKK
	 UYhTYn1uYFfVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1D053468BD;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:46 +1100
Subject: [PATCH 11/13] arm64: dts: apple: t604x: Add PMU Device Nodes
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
Message-Id: <20261103-m3-plus-pmu-events-v1-11-a8eb6c1139fe@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=82FeCkY2XmEN6t3vU4Vm+A64GuN208WcUOTCqWVFzu0=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEZU74nbdTu92eseNXkWGSfqiDSuWvjI7vOL04
 +vJkmd9j1h2lLIwiHExyIopsuibpmlPZmu4VLrMdQvMHFYmkCEMXJwCMJF+I4b/7ip+59j7rmn0
 XHC6l1O15O2NjW166+xSDJcckNg6q1WKneGf6c7vDWWGL0OlGHVMud/OPH/Zn+F/zrJnLfeMmtd
 ZrP/DAQBaZktP
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t604x devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t6041.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6041.dtsi b/arch/arm64/boot/dts/apple/t6041.dtsi
index 9110d05c896d..2c72972d1219 100644
--- a/arch/arm64/boot/dts/apple/t6041.dtsi
+++ b/arch/arm64/boot/dts/apple/t6041.dtsi
@@ -314,6 +314,18 @@ l2_cache_2: l2-cache-2 {
 		};
 	};
 
+	pmu-e {
+		compatible = "apple,brava-e-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,brava-p-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;

-- 
2.56.0


