Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700894;
	b=CtTWjz9Uw2DH1okmmg4aLs7GQ126W2GD+hFAeZ2T+vR9dPMIWA/75Pi2qo8IxRxhWhbJ
	 wW4wWfhqJZwmWOpyZzJrpaODAlRakYIfquW0J+JyFnDI2I9CqBvHzzQGsMAfyh7ZjtiRY
	 lXj0I3syQnvJYQUDsB+Py8yRArExOIgrGA6OJKWytoD5OTwetkKIrfzffd6XPzhTwN3Y7
	 9VPCqOqu9mG4BcwtyuyhErjddDrcX6IvfCpAxWIJJYDLyUTme9ZnipZ0oQjTULdTq01ya
	 a/MW7TDKYWnA2gYb9c9c0MsCz7G7SlqZttrZCOR8a+skWxQON1TBjDidZfjVQU5Ij+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700894;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nWYjwJnesi109nR4qBmGS5QUAHWH0kyW1v6rv1/kzzQ=;
	b=GceRvx5/6dllAK7xDjz8iy66bwkXB9YRqmOqnMWfno7vNwfGiz0HX5wf0MSS5UPn8b0Z
	 zukgCYL/CCDtZTjnpWEp7HQZkkGN28BnGv9G4gvbR/+ZT5bQPmFxdKqXwQk5ioObt1+jl
	 csqP6IjEkVh2g8TwGTpx7x+OmxQz5JVivu5VW9AC2CD4sMndJqHsdWuQRtrYXPSkAcSB1
	 Nm8TTCaGRS8FcbiKzipKMYh50a9kY9dfBi4NqfTbzhBcquEoWvcD813vdcSyTqfPTf8Cr
	 6k5WTSi7n17q+5hbqgQrwc3G4ekGQ8GG52DA2pc4rXv/mr5WVu8X6T7D+1QNeYO2Agw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQQQU0j+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6E60A261C;
	Tue,  3 Nov 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQQQU0j+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700893;
	b=2ZG1bob04Xw53YQSWBPg5q1lb1c4vTCWaplnJhL8yFlMOhFZIWoOeYP57UpfXgPTL0iM
	 27TXFSPWo0SQTBAJ8PN6DT61Cj8tBX5pSQgN6HkSRj4jH5GEtPdOpNq4AGZBJxHRgdC0Q
	 SPipYdHfD0r0VPMWjMoUdBpFS2oomIkc8ogxH27Vaqb12pmPoq4bmyHaF+DBsg0IzaNaz
	 sE97lK/ky5wsiuRGkf98MjC+pCuWwCwbJ3xcWtTYjTehwWw6z+IaG7YyCfg4c9aDNtdJU
	 8z4LBO6Oh1IdhnlvZgwDBsfpw07WxlQRQn89GBY7nhErkGN1GOFJCUXNziPxJaQ6yrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700893;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nWYjwJnesi109nR4qBmGS5QUAHWH0kyW1v6rv1/kzzQ=;
	b=DQcRnnMtUiSf1AfpXNYI0yJhbNVs6jUGW+B94aKI7+feGz5mgb/ULtNtAZQac7xbBExU
	 U190a8xDIM58HZkxADq9j6uko3dlourkTIAGQ822X6IizCd8+R8M4Tuvozzrlbfwr0v6z
	 XsLZIRvAIbkLIo1yYdVNGm+v+mFG+Fc1+dYkAR4aPYhxV3Kpr2Y3TPOzwKumxrAP8jkrT
	 XsUL0gger53ienFS0D5BGnzFYe8AMcXbLn8bP/5goUPuYEGXKzHZumJy+ZdmyUX7jMCUb
	 w5kP1NOpPrF4TDMSkOHRIguezGxM9DZRu1U6jlMelCkPicenfFEtqWVCKg7WvAWKY8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5B4091F00A21;
	Tue,  3 Nov 2026 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700893;
	bh=nWYjwJnesi109nR4qBmGS5QUAHWH0kyW1v6rv1/kzzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dQQQU0j+ZgpPmDou54Zq0Aopsmg8gsQWqu6n5dPiaPcfw5exGxaKbOZS7Aa0je/rS
	 fDpor0mdEVzye3/CLTx7Fjkho1XnwuNfM+itMBuQ3tHYqKeV5+ezjHfuHxvM8AlihF
	 JUxOhBfNEyDS17Uh4nP7SrqWyucXZ/FEubfopD0CovlA/ChUDh1w+P5DCvt/LbqmSk
	 xkZ8CCVxACE2WpcQ55NWCV2AGOUEgd/aGvP5rgF85K2R4cHPLtz4yuJiOPCFQHgSrN
	 INFgwL9qG4p/vJWjBVnBaOEdLy4dmA2/m3uOJEyf+a/i7dgnkmKNJNU76L9cXJnJaB
	 ImUNxWYl3ZsAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 394C0468C5;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:48 +1100
Subject: [PATCH 13/13] arm64: dts: apple: t8140: Add PMU Device Nodes
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
Message-Id: <20261103-m3-plus-pmu-events-v1-13-a8eb6c1139fe@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=HmrCqgh4Krnz4um2UxQsOgO7E1EqWRunv36sceKf0O0=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEbWbf2eZttg2Kf6Vk8J3tq1qkWi0nn1o/k21Q
 CNh37z1ogYdpSwMYlwMsmKKLPqmadqT2RoulS5z3QIzh5UJZAgDF6cATIRDi5Hh1ook83DWKZFu
 iSFitnueCYi8WsvRpXb/f8MOtg9R2urHGf5XTdTlZMkO8hN/u/eJ1e6CR7q9d5lFdkatONXxV+z
 Zz0kcAG5TRfI=
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t8140 devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t8140.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 150d91bdf6fc..6e6fd5754406 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -136,6 +136,18 @@ l2_cache_1: l2-cache-1 {
 		};
 	};
 
+	pmu-e {
+		compatible = "apple,tahiti-e-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,tahiti-p-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		ranges;

-- 
2.56.0


