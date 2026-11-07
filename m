Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048548;
	b=tzbdX4KAduglBBSvKQu99z1TotWXXjOTBcYuIk+Lbedor2TWkSibikbXu0l65zD5LBTj
	 9FAdscEPGY2nZMrkE0n8EQtzQkBmAU+B+XBoJsGOYtBit4qe0/hK0iEMc1e11hkD2FTyO
	 5QLhxFpacbbA7mPNDwcwhmAX9CPbBQqQPrO7njgLEPTXxBsmMwrUnzzW+LidrRbpk0k4F
	 7OLmAbg4gjRBtoJSEE0vAQGBHj1xyDmv2imst1zgHFzkhtVKFYcXtuBLt97BhPPZLHFec
	 RylwJW/08fLuw2d51NPapTgSn2nb5S185jUMUOQQ2n0UeZLlfKsL9KWBSmBSzc4jmOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048548;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7UCcnKNIf1YK72LJjanIkn0/FVXmySqVe1/aphUGt64=;
	b=Hndfews+JwB22kR6IesSPMTcuUhe/LOHyYCFPZnGuy1GEGnPuwgXo9AVPQomYgGKlEc7
	 BwM2i8jrue2AWyMrL+FptNePFAuJaC7ITUhulFBoz2Yth0bQbo2HMUdbgFRGK3VTpUrj3
	 dg2KX5WiVY0ViKKUg5XshTEgVVZ1oxF+OTjE8UCtuHwblxSSAr0xB1jAruK6B9PYqpXhg
	 I95TIw7CB05LpML7S8sOofrGqzhrEIOWBCjncpbVXTQNXsGZilrIjQhb6j+eLT7qi70YU
	 sfhe3y0C2jWeVE2y2E3ccc13hxhAP2+pBHqkVdD24DFZUv+MEa9eDRK6mF8Z6Oeu6cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh8d1Egg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44567606D820;
	Sat,  7 Nov 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh8d1Egg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048548;
	b=y7H6OMYGb+/QC/bBgIC9n6Dua9HRbm3ghmgJK7aqhLCV6XRWb+LMrN0cMCdPU9/up1sl
	 F3KHcnuhgyIMMY9+3JL/rDRt49VG9VnMZYjMOlxfQjiHvWPBlAoMQoEM01weCxav8qX48
	 kYZvd7SZbhyp9sKWUwZ45jcNY1dNAyUEOo26Df/Bg2gGBJ1aNh+XKmz52I+W+kuNGAyQk
	 LSs49bl+YLIeGyx66cuG6oylPk/QZ/oBWY62v1kL4ajnHbEFiteTeIMihONesqd+jsQAs
	 QEzK2TZ9rk9SPMhqJAF608YzJn8vfcwA53qCjhpaAUtnjcLvtVN1yYDgdkcoOLkdzvg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7UCcnKNIf1YK72LJjanIkn0/FVXmySqVe1/aphUGt64=;
	b=uJZqNHHQ5tTSRb4Wcj4VFi4d//sWN2hFjLhwQUCMz6s6bJs50buquWGjDkfKAmdioEe7
	 at1R4cqEpLlM2bK/7zOSKVVxOIPvGfi6Wa0vwbSYrCbQ5mncoVBI0KvJ33lc2WI0VmNk6
	 KzJlbQjXEL1bO7o3koNjkYKdK59CGxFDl2ws8qMNa4uiHIyWjjFW9FOm3aAU/rPjLGqPH
	 ynQg6rBNL+p9Pd7y86azlC3nRhXpIbOWV7Amdc1PqJNMP7cnCkUK8Y7W2v0/gmRRXE9uu
	 dxLaUVX3hERdRb7fKB6d3OVZRIg54fWAE9hXgVZHEnkJlfHD17dQDjKzR6TKpaPB7FQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C25351F00921;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048548;
	bh=7UCcnKNIf1YK72LJjanIkn0/FVXmySqVe1/aphUGt64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yh8d1EggOZAwULZrCPw17gfjzptzHktbaGVAvIDDNiMjj7BXGUmwJnjOFQ/SquoVP
	 k5MMl13VtJQWPz47lxuYzLZC10tG1JmmaCMiqAe+esJB5j1d4+0RrjnAl+j7MuFT2r
	 X/VRdB3DBtAUK6ZnsHpzUvjAenUJTXtwX8HFzzf99KNgiDIa6M+AftPV8lyM3Mg63Z
	 fidjKN5Af8KhpAeP0tqtpSNp6sfVZWVWqmHm2PF4f0J0LVFjRNn58bRt8SuqViO21t
	 6vZdo3aeNAU9GwZbfTdlg91sY5AOIWgNAWf91vuvNV0/2P7EjwP1enelwPFlBukt2n
	 Va2Dq4IMBIBsg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0175147B92;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:56 +1100
Subject: [PATCH v2 09/15] arm64: dts: apple: t603*: Add core interrupt
 affinities
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
Message-Id: <20261107-m3-plus-pmu-events-v2-9-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=SZxjnnpiAPlBmETm50YHBvKw+Yyj82CoILY577jql1M=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyfzUbnvhuLJuflbhzknTfj3MmiYc0i+4beGK3
 VG5ubWLmlZ1lLIwiHExyIopsuibpmlPZmu4VLrMdQvMHFYmkCEMXJwCMBENIYa/4keYJyVoPOP2
 tFdn03+01fh6k35+VGVJwL3oHPGtBz6EMTLMvXvPIufUqccvO/doqXteVD6/hb3U6uvTEtY304S
 ufbjNAAAay0pP
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Add the cpu interrupt affinities for M3 Pro/Max SoCs

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t6030.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi | 18 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t6032.dtsi | 20 ++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index 85a16d03e22f..d49210572e19 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -451,6 +451,20 @@ aic: interrupt-controller@351000000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					cpus = <&cpu_e00 &cpu_e01 &cpu_e02
+						&cpu_e03 &cpu_e04 &cpu_e05>;
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+				};
+
+				p-core-pmu-affinity {
+					cpus = <&cpu_p00 &cpu_p01 &cpu_p02
+						&cpu_p03 &cpu_p04 &cpu_p05>;
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+				};
+			};
 		};
 
 		pinctrl_nub: pinctrl@3641f0000 {
diff --git a/arch/arm64/boot/dts/apple/t6031.dtsi b/arch/arm64/boot/dts/apple/t6031.dtsi
index 30a91c1a47d2..e226a45fe530 100644
--- a/arch/arm64/boot/dts/apple/t6031.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031.dtsi
@@ -45,3 +45,21 @@ soc: soc {
 #undef DIE
 #undef DIE_NO
 #undef SOC_NODE
+
+&aic {
+	affinities {
+		e-core-pmu-affinity {
+			cpus = <&cpu_e00 &cpu_e01
+				&cpu_e02 &cpu_e03>;
+			apple,fiq-index = <AIC_CPU_PMU_E>;
+		};
+
+		p-core-pmu-affinity {
+			cpus = <&cpu_p00 &cpu_p01 &cpu_p02
+				&cpu_p03 &cpu_p04 &cpu_p05
+				&cpu_p10 &cpu_p11 &cpu_p12
+				&cpu_p13 &cpu_p14 &cpu_p15>;
+			apple,fiq-index = <AIC_CPU_PMU_P>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t6032.dtsi b/arch/arm64/boot/dts/apple/t6032.dtsi
index 2a3a1fed59df..627027f8cd14 100644
--- a/arch/arm64/boot/dts/apple/t6032.dtsi
+++ b/arch/arm64/boot/dts/apple/t6032.dtsi
@@ -371,6 +371,26 @@ die1: soc@2200000000 {
 #undef DIE_NO
 #undef SOC_NODE
 
+&aic {
+	affinities {
+		e-core-pmu-affinity {
+			cpus = <&cpu_e00 &cpu_e01 &cpu_e02 &cpu_e03
+				&cpu_e10 &cpu_e11 &cpu_e12 &cpu_e13>;
+			apple,fiq-index = <AIC_CPU_PMU_E>;
+		};
+
+		p-core-pmu-affinity {
+			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
+				&cpu_p04 &cpu_p05 &cpu_p10 &cpu_p11
+				&cpu_p12 &cpu_p13 &cpu_p14 &cpu_p15
+				&cpu_p20 &cpu_p21 &cpu_p22 &cpu_p23
+				&cpu_p24 &cpu_p25 &cpu_p30 &cpu_p31
+				&cpu_p32 &cpu_p33 &cpu_p34 &cpu_p35>;
+			apple,fiq-index = <AIC_CPU_PMU_P>;
+		};
+	};
+};
+
 /* delete non-present DISP power-states */
 /delete-node/ &ps_disp_cpu;
 /delete-node/ &ps_disp_cpu_die1;

-- 
2.55.0


