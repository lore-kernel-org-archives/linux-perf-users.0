Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048549;
	b=jY2tm19FNtzwwbUJofDKK0U3YnvQ0n5/1V8K5s3X69IkcIiNijqSMYKS5sLflKQw1B1B
	 zv6l6lJAT+8SO6U++O+6Hn2UbPjZySX09voEvLlWp2cEFCaFyLF31A/QKG2LG9GHiKmzy
	 2hxGfrQG1U6vb6KrJvU7EyJrFTzBeYnV8asG63ZdTJpB4B/I9cIOi+8UaDk2w7QagqMSS
	 c+IBl+Ra+N+9GbqCEpY8cPrlRtuQ3vmpHce2zJ8H0f1UmOEO2e99f9rDMAbIKXLhUItyJ
	 hhV+V7ACpLZI/LmgxIomi5Ml9HEylEY9DWgFEgS6Zr7MRdAmAeIZ3Cc+gbD+jr+AKWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nlPg9ddKXEEod8nwyRu9hYUf1pJGT8kRCSzvOSE06q0=;
	b=4Y+l1z9QBY7rVpd/bcavB9S38dF3q3lHzswkHMbwsw+0NPiNHy0RlIr68PifnJ+hCn9b
	 O+ORJLA2m0DeH3f87K72Fbqpduts4d11zCsZb9xKcua4dY9sE2I1k/Uep6p3h3BwRkHJ0
	 ifhiD4Sfhoe5ZltsVI7l8UDDliHhOcL3sIgeHT/4zb90QmoYaqYFcyO44mKbrc3rzWUs3
	 /N3eAwaOzJRm/3QbkdlQgssetheOuC5a6fx5+aLdh6xiS75be7Y5h82bcM+jqqpfrbW0b
	 5zkQ5iqx4SOOdK2FcS+l65SsaP3J80rWm+BrXmz0Bk6feMzk35OPoA0hRMxDL3jRYBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l00nzR/J";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5754606EE92;
	Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l00nzR/J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048549;
	b=eqoLFfGHH443/T+j/oQUNe8E491oysu7ma5EmXo/07TTLZFOjbwS/7cPEvCqajwNrpcQ
	 ZhRJAEZ8TtprYBQ9/LABG6QKUb+/Fj9h0DWg15xs/8hbUyMCTeuEZEpzx/+F2zxUppFob
	 scbEUPVCrNz4876fsVVXCbU5EeSs2XJURk4+c1yAQOoFpXEs97GhF+4lWMs9r+F1DaCc6
	 LZa5UE3SEfr/2ZcwJUilPXpzMS0H3oc8Ct6Vdp8uEMcgvHlOO/dVVbF0wVbU59EjZugrT
	 klBqxK2AKiUcFbeKJYtMfAjbpRZdZvnPPIRVNn5nJMer64ySMT87rpo7LaKhwwJBezw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nlPg9ddKXEEod8nwyRu9hYUf1pJGT8kRCSzvOSE06q0=;
	b=fbuQkAGgWWxHspCf3uHKFLSTWdiHED65J+Q8JRP0Ro7fmQcz2DeAGzhdrMdNC+QTUKoR
	 kjwmr7qsRlukqC4aOXm0K99BB0lVU3luWdkmuCxTrPle/5U9stb1zhjQePsBLRkkE92zC
	 G7U6FJjFBjP7vO40tZOoAQlC0RHCSi4wbVO2H904/J+Jp2Yr5CQEmYIBqOpZdANZHn3Nx
	 ehdN4yZhgdRE6Sw4kCODHmSbv2Dwrw08mKQSJvXL8sT1epm/utsJSFQLH9bxsg1jXKYeO
	 pm0cVIdyu5oizuOAEReDDhfJ6FtM64e9wO/p349ho39XerkswE8jFsMDfr4dQAfKrbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C4E31F00925;
	Sat,  7 Nov 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048549;
	bh=nlPg9ddKXEEod8nwyRu9hYUf1pJGT8kRCSzvOSE06q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l00nzR/JwY+AROfgULSm096zseZoVpxE3GOZUj0DFH1oYoy6pkhAMGiPAyc2xslBz
	 x42cludf+F7bNKRTpuoBdPpBxjs4D6FcAM4eBs5HMG2k+olf7S2DIUOAZY/vpz7Vwo
	 jbWyHZY5b6hgGUAlhsJyyfWxTUMDJOFvBuq5m94BqfSEjKR9+wwFO04A8vLHaAqG1x
	 tN0B0PVbSPSrPCq3G2KJULt4eZyfCoskN8M2UyQ5IytTsAu/n6N2PT2cqsyhZVpFEm
	 4VC17LE2sWrzAGQqYIBYY79m2RXwvsWMYjgS1MsfeMUB23rGsu8t1T1whsakaZzDGL
	 me0lw/G3zT7FA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 302E947B9E;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:59 +1100
Subject: [PATCH v2 12/15] arm64: dts: apple: t8122: Add PMU Device Nodes
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
Message-Id: <20261107-m3-plus-pmu-events-v2-12-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=849;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=w5IT82M4IwAmX8oME3NrIIm5eliGo4HD7lPTyvRMDgk=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyTZc75B5/E38bMBizQt/ZDi+qlqyWSwRYi60Z
 7VdtmdtrWZHKQuDGBeDrJgii75pmvZktoZLpctct8DMYWUCGcLAxSkAEwlcy/C/cor1+SXXWTk3
 PZSXsqs1OHel9vmdsFRNFvY1Cf1Ltt7LZWRYd2QCz7fkfe+k1U+tutnHUMJspyb+at70swL7dGL
 fcefwAQCtHEYP
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t8122 devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t8122.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
index 959ddf36efa1..c9e81a6cc9b7 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -180,6 +180,18 @@ l2_cache_1: l2-cache-1 {
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
 	soc {
 		compatible = "simple-bus";
 		ranges;

-- 
2.55.0


