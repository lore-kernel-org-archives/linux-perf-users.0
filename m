Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048548;
	b=eqdR1k6Urkwf12cQY8GOO5JkP6al7hg3Elay7Ucb6IcRm/XFW/Snm6aEfh1voDbg1Cpj
	 b4IR1nLuREkEt/XCDMcXgNrlfKhdbymLJbwsIw1rrp8/VYbKaaj81ZwFDd5Uj3Md1LLdq
	 inNv53WURLeEUWPoyFN8Vk+cXZkKVYQA8MhshlhkPMlHC5SXfc7pXoz99EuEEBF4AXzwP
	 cLrLkkztBufPFqHXfDVDingHHp0dpY6FLF5bpMryl5WvRjwFV3VNJWx01W8KbwPX79TSk
	 9UhMEr7loTr7wy1bCmWj/dqqwGnhIuSXOFQODyUZHJg5LbRcG2f0clhKf5ljp3GBGeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048548;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=svVBiyJx8/hNOpm/7fsC22CcUTwK0mkVZ2d7kI7haZs=;
	b=HzWZA0DZ+gWh0PBLrLRkI4mzqXu8IoOTT91NGm3LZvtDWBbI7dXTshMsRRqSotUf8AfL
	 VJKHtjvBcldWubnDNVSAEdIMSduznG70lg+hxy7Fu+sq0oQ1DCSlPYU+vlydFVR+PMfKm
	 wSYRHnjPfHO4iPztqGAiIr+UozEGIt4pkbT+3WuBW4ugDyK39JU+qPE1Q5aQ79DOm5j/K
	 cjyuASmvCq8Z2iUfDfYBeoTox0rz2ctAuU04d4BK49rXsUIPEHoC7X3q+VEJFYak/XLyn
	 QNUGAY78hqZrMEdzxABzivCyEzbDIFLTyMo01zFCx4ikDhVh3AthREGEYyD05GoCEYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEvWqS+3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B9606D81A;
	Sat,  7 Nov 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEvWqS+3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048548;
	b=y1yXN7P7W1GidxSJ6078srihm5FM4BIdukwp/wbPrDyK1aJf7dHyZwtSr3AGutZMb8Ap
	 Y3vgdDpNAbzd5ohOzQj5bAh2PidjsQF4bwvb7fcYONWy2PXfg3LHTiENcOSXfxa1s3J+y
	 AfYoz8je6Z2U+QTb6iF1D8zRHdehtC+xNnVyrSQc7Fsg3XjovfObP7sQihI8ORNmqIu3D
	 5VR/pBqobVny1xJuvjnwCUrmY9KIe52WdIfuN1N297GuT1Zm7cLbGcwsoVeEYktMaxPKb
	 mlQCA6IylhAyO/+pa/bdHx6r0Y6q26skxMKkr9Bjj8IHxrFoIP8ueYFHYaJXue5UK0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=svVBiyJx8/hNOpm/7fsC22CcUTwK0mkVZ2d7kI7haZs=;
	b=M0KVdq0eABlfBTexuyaDVORCLj0Ut9g2FENaYi8il5QyIFpqGKB5btxAE0S1X0V+UOVA
	 NDqQGu+gPS0AwqhKfct1yIbRzlQilvqOG4PsssqvQzY2s0MmJU5pqDB/j/mVOab7bcwyw
	 vTsJF7HC65J4osSUxTBWVh/OGfdCvQWZOIHTR70tsVgAEWZlIuWoH2x0odJwVwTzGMc1R
	 wcg3e5Nuziwy7Tq6oHJkNmjaFCZm9BrKonCtwuuzFI8Nj3ZwmOrnDu9vr6/yaOhPm+FpR
	 SFq95T0SJ6s5EuDLblwxKo5wvQGHTWVmS+FkhZf+2HYHl1Vw9uEseAMsGDc3P7/xVfQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C6C321F00922;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048547;
	bh=svVBiyJx8/hNOpm/7fsC22CcUTwK0mkVZ2d7kI7haZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SEvWqS+3GEakWuV+0GLRuNWmiWpLghuyRDpZ3Y3wjA35cK5do4b41cImyntzrqnGJ
	 MKOVsGloFQXcGQ7Fr2I5M6OdR1MpSnDS6hZOzrnjNsilgFKCkNAC9B5FwTiH9SdOLj
	 3/lGDpTE2g4bJ4vUec8e/mOKr+dtDAim8nrHVCHI+7t9ZkSirRsyzTps+8naAhHSZ0
	 QL28Q0hjzueMzcTvklIvV8eTsbmFgCY0O/3NSyM/o1ci5e8/WFIrVd6PR6goyAZ1tp
	 UxMHcIRQPjwmXrmcZSPsqcYg8oZ+//ws4dBGWrxMJHYsBrt47FTyXrqlwbDXgMMrW7
	 FFlkCZC94i08w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 10FB447B96;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:57 +1100
Subject: [PATCH v2 10/15] arm64: dts: apple: t8140: Add core interrupt
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
Message-Id: <20261107-m3-plus-pmu-events-v2-10-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=d9exJCOstCv3xbTb3W263KlRtQt0JJIMHplbVx1DCmc=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyXzZMyEgov1LIcf2Qpa/dVddui7fmxPJui1KY
 fHVwgfKZREdpSwMYlwMsmKKLPqmadqT2RoulS5z3QIzh5UJZAgDF6cATCS9lJHhzPS2jl8rNRuT
 /lywCZ684s+breoepWZBW1hXTDjYb2r7nOEPz1GrPKODqn3Bffezn9f/+W01WecttyxHuZ6p6IT
 0zcFsAGxqSbc=
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

Add the cpu interrupt affinities for the A18 Pro SoC

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 arch/arm64/boot/dts/apple/t8140.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 3b4f7695552b..89a26a1b2364 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -167,6 +167,19 @@ aic: interrupt-controller@301000000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1
+						&cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1>;
+				};
+			};
 		};
 
 		pinctrl_nub: pinctrl@3081f0000 {

-- 
2.55.0


