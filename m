Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048548;
	b=dJrPrWfcaP8/uVRaabroeAeekUa5oJOZ8fEQBQGfVEQXvUJj2rRRGNcKPCvGzB4V57LE
	 CJ3mcyPoLC4UROPys1BG92NuU+Cl9GeDVafetUXsZKPggmilItx0Xwg4pYFtG0pKgQBBV
	 NvVN/YrteNc0ZKdI7axm39V3phZSHqiwb91+GW+ai1tP6inyXCUj+mwtzKuZ8ZmIK3Dq3
	 JsrA2oinmIHStpCIJPEycx4HU3AYNAgiYrKkt9MXVIpB/N7IdT3DkVt/ykZZQt1VmsYcA
	 wWnBM9mJ1TWVpprpy118RtauOZ959RiGJHiMFiKsFhSzWV4km58DLSrqRDRpp2DWL5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048548;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VHTLybPzMLGIsfTFpFBqEVoyacMyVYOjjlRuTV7oaXk=;
	b=pxSLV8kxXGL/OCHI+TQb95oT4K0h0mTmSUfN40Vi7uZdeu+n+NVgUulur+ZP5zZa3I/r
	 ih934M0SOWPoiPC2TFibveS+kVdAgHAshKNXgNYZSJhlZrjO1Z3InjZ2dhOyTcx/0YB+b
	 A3eZftkqZKrOTIm+notmxfZSCZUIeLpGwvLLNah7eVAtDvKjwE91HRfCxpd/HzKvRpunG
	 N9GS+WHiKnouaOWspl/fOAaQU1xc0rKVu3rEuaAvNfiSFQG/IQZOai+BJeyucTR5XvXf0
	 QEPe8NSvxWr5v7J+n65xyBto2a3HvidLjOMf7ByiWuzm56/bfbGkNrxSBfOwcvSq1iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTVJ+wuX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612ED606D825;
	Sat,  7 Nov 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTVJ+wuX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048548;
	b=JNr/nFJ9fYzF9uBhD4gRWhHgCGYBzt3WhgwjzvkL/imXRXwP/wPguBsfkztZiTmGf1MP
	 WpjMrQPYS3ta8LVpkXByD0KtWNRuHLuzM/NIZICmXapEXlzjIvecNpN77ANZalX1IzxOT
	 ztVbOnl6rx5bgtl1TIzkLZKPvNiHO5KhKrsBmcym7IHqtgiOCuX6UcM2t5ZWdntb0yern
	 e9tLwmMNb8W//ztAvN5hEOQa4ESu+833mi92HDFxZZqBqXZwd03dJtryZP7ekgGNM5iPQ
	 NoTlWa4dP36l1wvcIUQoOWj9yJtMeHIH1QbvJNfqJBoSsM7WchRX+NGyOBZ8Q4RXdog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VHTLybPzMLGIsfTFpFBqEVoyacMyVYOjjlRuTV7oaXk=;
	b=rsAD+s4JUawhuzLGvKm1y4/AXNyMWnMjfmOdgBp+bpeP7lLKfIAmypApB/H+W1xKs2AU
	 ldaCsYrEYb1teSve9UiMJ1A9fSzF0460mzRp+wFV183uGkpX7LR9Xyajys582tw4wtLs+
	 1Vj4lP6d8gc9wIhyE2nEmEXyTodMXeDwNIdcZIEeoeMH56MfTnSUWjCENZM2i7MoQNz3T
	 0HCNrt3AKdRjKPWeUsB77VC4RVpuvm7CBkF+XKhhUv58VUSPlOwRcexuSw1+grXAAM0OJ
	 dvx0KB548oqGIb41Hvg6Xv52AbbDuKxj8JFIPTbs3LsiOO19M73Xd4t90wukZi4G3pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 391F91F00923;
	Sat,  7 Nov 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048548;
	bh=VHTLybPzMLGIsfTFpFBqEVoyacMyVYOjjlRuTV7oaXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DTVJ+wuXfxTPd5WBdWvAfpYQFQTHMYc8j/VhwLdodallkPLf245+tfvkDj+ImOlGx
	 TbwcoWGJymoKvplZ0isE+le80CLlmAWlYSxbLZqy/2vkVOJ3DgNRe4qoHJg6n5dvYy
	 ud8FRCy9tpl8BvuNqopGpeSC30T+qx0KZDsu10c3lfIb8xOauhlpkNydtFrOdBSxoL
	 0fff8Sn0Ky+ue2t+3T0qs8mDIGsaT17DaHh1cDRFGjIAvj0oAMnGPuRyFfkKHG2DYW
	 H9XC+J8rjfQdi1k8EMWraHPC6jHO+ILw5kBS8ZRITTZIq+ffLRjD61+9c+2xqW1ppe
	 vShttRG9ZVjwQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 20CB847B9A;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:58 +1100
Subject: [PATCH v2 11/15] arm64: dts: apple: t603x: Add PMU Device Nodes
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
Message-Id: <20261107-m3-plus-pmu-events-v2-11-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
In-Reply-To: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
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
 bh=Wg6EmXC9czH93hJw3fvp5wMAuJEXQ1vql4D/hklHhyg=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyVpue2KyvvjAVgWtrOLqoKk2i+4+q/Jn3m0jt
 XRnqv/kn24dpSwMYlwMsmKKLPqmadqT2RoulS5z3QIzh5UJZAgDF6cATOS2NCPDgyPzn/1+Yr1q
 gvbDdV97WjKeZYqrHretl7e8J3FKr3xuLSPDrzN8yX8edLyPeOL3dmXRFucn958lHNZ0ckxqF6x
 96yDEBwAYoEt2
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
index d49210572e19..4525d50fe647 100644
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
2.55.0


