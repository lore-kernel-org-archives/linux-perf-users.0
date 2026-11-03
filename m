Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700893;
	b=IBQSNEPqL8UDUOZrgq9HiXnHtgt40SJ4gUWhlwHl+XPCa844TDc9h/7QY7I5V2z1x0N2
	 KAaV5Ika8H32Krx1zSHgm37HT/0t87pCnbaxg5cbdOAWCGr6AQKwCJS4CnpNja8pvMouE
	 DHrsrWcuywQ67oevNh27Jgj2cBChJP4rkviXmE8IXSfdhOIyJ0uuKGv/67SrXPYLwNQSJ
	 +E/cQtfEwjHdj2nihzDlbTjGDBVGQ64TLVzMpQYRD/h0aJVaI8+vsovJf/KZtl9KUUr0e
	 2JbrOB7bJEqaFCkl/dI7gL9+3Gl2FJfQelnrvkpihxZhpK84zM1NpibOvg6njA/65BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700893;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ei3A95BF4awPFlVC4WP8ivhk8EiTl869CD8jHcNY2GM=;
	b=JKiX3zhdlYX2T7DpeEYORm9f6m8DE3rAfV0YtpCyYu9625b5ZBhdsL+vl+cLguGp8R5m
	 Ogo2wa8tFaBjNQHyH41o19u3wKgZuC8xGi0+pERxOljXrWeMvRKQABC19gPo2t6YUScRz
	 ludgZA7OWaQCay0pZaiPuDvcSGzEedZRYzTssFttJgR1691/Z91zK2NdhYv7voRZYPDqO
	 8eRU+1ozmyni+nr6dHorRTgcbXtDwjQ74TbLDtsGZ5MApuvdEzBwzYddrxxfNRNqgL4UR
	 rEt0RiQ88fnyyKKNlEsttJAWi+RuRBOzAZERo5dEtyHlM2OypfkM7TZW1hhaEu9Te8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIbG13i7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC77A60850A9;
	Tue,  3 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIbG13i7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700892;
	b=Dwm/+38P5LxVvb36zxsJN4YcbA67pPhhZ6qzWWlVcDVP209qVSEF6eC6WHywbCM+Meq/
	 iLHSBmk0OtEhBF9Ddtm1cjjSIwkzrrnimh8UZM6oB2EbP0Yi4pHGiTOLRmyjvzwcXHfbr
	 SOaqrXV+QmpsCRKGUqIWIvfdabQDs8VL5loNL9xQh9+fvvg/DeMctXlmaIut81ky1YuVc
	 rtSGZTaeffm391uxCE9fFGonjSZNzREON3+79dkiMQEv4pXuz8oAmSzEkQ9rHssX7MhKK
	 +lZIZtBAPp9tHZo5srD86fH657ZmX4ul7fDAehivfxqL5YF8A2cVmgDutBhD60GNPEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700892;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ei3A95BF4awPFlVC4WP8ivhk8EiTl869CD8jHcNY2GM=;
	b=EEuoP8WT4wn4E6bMapW3fiMmmdplN9raFDyK2XvT2QeZgB+o4pypSTSe4ixNCBeMg7L0
	 MXEIzNiQwAvkSCj5pYf31xBshROTEZRNs5VrLdSOIhq0iG9j6Bc6R0PqqC0OLZzN7AiyK
	 jkhi6VKkZxmQI5Z9n7DCz0tEwZrq5LSKZ9tbAUCXqaS9ZCNhBcKk4l59HrMRj2j0IMnHa
	 h97reoc+pVEDGcLVpsUgGUKwQxXoWOJpTJ4a1XU7MYsU9DOr28kBaY16zdCjv90vOUMqx
	 mUfDZLe7fUG3BmGb2XF/qLYOY0IchZMiKyjkiM/lBzC3qINwZd3puUuQkGOQI0ANaUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 238821F00A16;
	Tue,  3 Nov 2026 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700892;
	bh=ei3A95BF4awPFlVC4WP8ivhk8EiTl869CD8jHcNY2GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OIbG13i7NGKh56BiEKTTCvCufslX4Q/P0KyeiySJCVRpLIJ4Bp1du/YwPdhQbJmJR
	 fS9aOyLJm2RN14YO7RzZgB98MBWl2AdN60voTQEi5RCFe5caVn/EeYgH2uIa2tF0tU
	 tFqeTn7COpQqHmwgd0VA6CuUOnOYQqdU9HoXTfLuEpJzFqnDb0/SEaXYQN1EuJGlmD
	 RLJ0Wsc+90q0lqdtL7pYYOq0e2+tGgooiUIaGPz6NluhGB6M87prdsGjTryNw5JCyZ
	 hm8UFFzsAIzf4VvoLMFf89QMsxVUKpDpKx8SBfQSKYedvqX4QNsqO+qFy85apd8m1v
	 PAKyQS4zleB2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2B305468C1;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:47 +1100
Subject: [PATCH 12/13] arm64: dts: apple: t8132: Add PMU Device Nodes
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
Message-Id: <20261103-m3-plus-pmu-events-v1-12-a8eb6c1139fe@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=SeQT+VS3NIGTbRle0pQmiDq0GYf1YozUCB1/EswjGUI=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEZ0erZPExbPb6eRx7+VCAYZtDotYNj7SPcCze
 FMey845V451lLIwiHExyIopsuibpmlPZmu4VLrMdQvMHFYmkCEMXJwCMJH21YwMdx7fmaS6SnGu
 YcYt+S/r1wtUSSq13JKbvYitX6LHZe/e5YwMZ29wvS7jeVDfXqJ+JVxc5vPxs0Z3pmpr3f5/d2+
 lELsvHwBjPUiE
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Adds the PMU nodes to all t8132 devices.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t8132.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/apple/t8132.dtsi
index afec92a06015..d0f8a40097ee 100644
--- a/arch/arm64/boot/dts/apple/t8132.dtsi
+++ b/arch/arm64/boot/dts/apple/t8132.dtsi
@@ -189,6 +189,18 @@ clkref: clock-ref {
 		clock-output-names = "clkref";
 	};
 
+	pmu-e {
+		compatible = "apple,donan-e-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,donan-p-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.56.0


