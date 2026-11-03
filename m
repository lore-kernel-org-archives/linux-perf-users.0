Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700892;
	b=vlZiq7VcwqQxuyQQJbwLn6roVwpfQtmboR1MUSkyPAFwSTyc+0WCoiH231c3rWLGhNeZ
	 F8GbeY4Qg5BPgPCJxLzADYUxRPJ1vdPWT9FYgV6Cu25tTfDzdKnVVmQ0RLdYyTkvhNtAn
	 NmXtH97vbJyo9arNsKOHDgNEyEKDrRml9csLXtXT7IM/gQTMVoiWredJuAnZvyuQi9C/i
	 hZ5E7OJPH9jl+3nAufzTRKbRgy6BTJWdrk71DGHnNTWBgJZEWh5UVYfDr9Y0FFxEJ7Hxz
	 WgVBFe7vKEoUBN95RqDUeWnSCQOt4RZQndXwrf6czmtd1surb9KeNd8dP7fu38V46hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700892;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=82BvmWOY3UHYSQatbXCiejLma5rEulIN7cYz5EX3x0I=;
	b=MzBDGe3P1llMZY2gLqnKz03fmCoaSOQDNrD3BpCrcrZTTBnjvdDHE+ahImYPJLk5r1vF
	 BRlVau20Lp/RB+PnM0slm8IiCFp7P3LvrHTqK2nGy573/fOCfk0T1Btt6vPjl1/jSFWRB
	 YgUizwyYqynvWvp5nfhch+S+/1skutQ3y7IA7CZUVu2FZcStWJRfXWOBni2FUK/LF+9Hi
	 ez/ANpywSRhGtl3erzAN03F80bnae3MWrNJ7Y/obVaKQw+WKPZTf/kDoK9nKsJf3nPCKc
	 c73faPsbQEG2PtLWg/2Nc04pKpJ911lPky4nfIjn1ZZp26XDpx8XB40IBflVSY8o5jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La+wt0O4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBA608509F;
	Tue,  3 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La+wt0O4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700892;
	b=PS2iwRo6sf+SWiw7/VDelacHBZcKb3tXW2UA58/NUJiqdRv8TBliLvmRvWMdpGCt0GwR
	 +czSNCO0STVjOesBPc0msmNbIMjZS5uwUzcLag2XabUFMcyTP/xv6FB5Ub4R8CfLzrVHL
	 TMVVzj3NJRTtsAORdx2/rvALg2HGC9lX1fs0OyXwG4ZCsZxlA1Y/m9F2XqjS16m5JG5lU
	 zTNv5s33Zc6Am+s81RuADIdVV5eC62B+MwrXkpSHEtH5Ldx0LM7D4tFEo93WcUGxcd9D+
	 Gp8IP28meeBTVHM9rAlmKW7c8POFMj0rB5PJA6Woydnc57f2/2w89VsQKNedgHxIm+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700892;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=82BvmWOY3UHYSQatbXCiejLma5rEulIN7cYz5EX3x0I=;
	b=Sy/kPYW25WXgw8ZLj2KDw7cbvTLeColNmCRfUMIhFkonKEJUsUElZuAeU3Rd/t/M1D3G
	 8hdgD2JJn/zVevi1hUAD8Mtwa64iB+UW/j7AKu9CJaCAZiFcE3k7UNyB5RKiFC2M5KHxQ
	 asBlzC7Jif056eejFUDMCJ/eXEK9JBNtB5Yo71fiy2Qf+2uLld/K0s52iBJwg7WCrlwgx
	 ap9EtkXF5LeU7Hae5ayACgRUOWrAnvLoyaUbTZGXBFvU0JnmrH/X7x/9+Y90K89oSnjmp
	 UCDQe2ic+84G9Q1PK3ohyqyZkPfb+/KaZiUGIZtG/V2liwJjMJcmiMZJ7pU1TQxWCkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0320E1F00A29;
	Tue,  3 Nov 2026 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700892;
	bh=82BvmWOY3UHYSQatbXCiejLma5rEulIN7cYz5EX3x0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=La+wt0O4grbU+kfOx4qaeZwiq7H4TeH15xpP6nYzn5/jz9LSjzTqKIwKuHQAT2wnA
	 zDxl0mKSGBMAXc2O0dDOi+6ED6ZtuVJ2wfogolPbe/YCpsdDiT+7+PwF2dBmvIRFYt
	 fkrqsLUmiE3E3VGbuUsg0Wlu7jwuBZ7IV2bGyQRpizbXXCHliCDayR4XftrErZx7OV
	 /uXu4QYxjxB5tuasJqidkicX3ZbXz1sGlZycfQ5awm5vsEEO4OB9AwiOSkSoIF0N/Z
	 Brci6FfgzEIITBzR57BwT6CGFQIFy/143GuHmxzUJrYDy5igz1y5slMnWr38GaGBHJ
	 Q3uEeX/FizEaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0F477468B9;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:45 +1100
Subject: [PATCH 10/13] arm64: dts: apple: t8122: Add PMU Device Nodes
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
Message-Id: <20261103-m3-plus-pmu-events-v1-10-a8eb6c1139fe@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=849;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=rNa2BkUs4YYaDGXSrrZeznuk/MnM9Ng1trURn1MGr4U=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEb16urq0R9FsThrb09xdr40Xu/WpFJstOdzOp
 lvWtudNuW5HKQuDGBeDrJgii75pmvZktoZLpctct8DMYWUCGcLAxSkAEwl5zfBX+O3Lz38XXelm
 Pm+XKvxsLWPDjNk+Kzi5zxg6SJ488/xLL8P/TEureyEhnVIt4k9es8aUWD/j2LWc/e/11Z4Omz/
 NN7/KDgCApkwq
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
2.56.0


