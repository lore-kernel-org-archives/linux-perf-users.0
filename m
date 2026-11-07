Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048549;
	b=Zv3cwVzDwEwQSHGm7G5D8O5t5IqBQG1qwyM+0+2ZHUqHdRsTt0+RKd42P5CdziCeVSkx
	 /+78+TgCokLGEyzV8j7GGeA+IO2nIEQDEszATBvwrjrZEMlUFUjWz7XK1BE5CfflDjbLE
	 dUoUvaoF3cLoWqwGWf9zJUDiCLr3l7lzeY7u+hyf1nYdCAA5j3T89IBia6+dm//ClsEVO
	 gD0ri8zv3tVqT19bJTGJ9SlNaE+4wCHywJ9jbRVUT7DKAmLo6DZBWOJclp5D6zLU5mmly
	 zguwJYQ82bLIjflub3FlYuJACdWx2HH/GpIv4ymAfiLHgAcANDkojkj+f+BWYbOKTCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yNswxtZ81Zq4k/yFcNT1xtCIcoPyg8yyYeZaCb9JfQQ=;
	b=rwfHaIlZivFFi4VAOOtvk78vH//EEcxGqhA2Y8c/8ltz9lkIk4ssGgJTmQfJvzl+L+1V
	 F4jEN6TeiQNHwIZOnPwE5zIHG8Z3xIVgWrR8YJ0zlxjhudKbb4xUI1W4zYlabC+Qeg+YE
	 vbBP1S56DODJaO50He+RUiX70OPhj7w5UkRwkQZ1F5hYDuyFriv/b/I0+ItcI6iDsBUE9
	 04M9y8K7Nc7V9nLFwKJnOGPc/CoFALVEXlbgr+y4o1BmEOZwN/7f5el43kXR2vhnPBN9T
	 D/NvCFb/arV/MW/Jbedbt2io4Vbn/5riPIrfwjzzgXRliEpPcRmabwzL9Zn8xxb61QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOHSvOJs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB4606EE80;
	Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOHSvOJs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048549;
	b=1l0ZAqMN4cBsPifAPu1xiKqMVUUVhRx/9nqsbnQ/nHkazpBZhz4fP0iY9DKPvkEGkRz5
	 TTAugDT1KUIPJLfXQ0a2UtuUrd2sOPeH3F1N7UH0YW2yGooAAWHns/JckXcShWd3XQ6ku
	 vKp9fxr2TukKcdUvtO/D0+ZE7yVkkqemiwxH9frUw83bsMYsS8eItpbpPCagiHcbQtEK4
	 dPLAr37thsi3ovYfyTeNG0FO+r/kKfp6ixz5uXJORozVZFZ0IUa5+NUOIRsH1zEI1LhAs
	 gGHaB+W4r/MvgNDszZoAl4VDIGeFf9tbs9DsK+rx3PTrCgHsuT88MXlY4I6MS9fqE1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yNswxtZ81Zq4k/yFcNT1xtCIcoPyg8yyYeZaCb9JfQQ=;
	b=ttTPoBsyDZfa9jbckqjGDNhO6tiWNGpQKb95/gB5iFnmsh4a52dcYUy4X050jPMC4zyl
	 fjv/JYIbnwGZaBXyTm602a9LLmpkpqytd83OosHLGzdy2HXr3F9RjDObUCj+x0GeS8W2X
	 IrIgy2JZb0LjcEpaPDe7UxYm4ONvKmqSUmkSUzqzBKBVmBrKHgDMB2GeWm4/mhiNDGgKi
	 HHvR7N0zaRiQoG5uBckZAd3GzvvDiF08WRkgDDDAVmK14FU1KfQpcRftolyTF2Tj1z65p
	 J4edYLnm2aFzJSjgW/PS8IDtiKVNR8fhlJPb5MdW66mx44wft76Gqo9oZ7gFn6Ejagw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA4691F00906;
	Sat,  7 Nov 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048549;
	bh=yNswxtZ81Zq4k/yFcNT1xtCIcoPyg8yyYeZaCb9JfQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iOHSvOJsQOdDoim2ZyAkdv0GaPFGrwU+HwxE5VmWbHJVIYDWTuAJnO4IhfgOhDery
	 ygsciYlOtxw2+o+l2kDH1KGgKp6swFbj+W0B10qc14llAQLxfM6Y98M6tyX2YFQGIh
	 oFQEmq8jjhh00uV6X2rTmXbuCUysMTr8t54ufOrVyLlyVyhnn5W5XUrBNOWMSLnj6Z
	 IEY3Y1/OOlZPu+UJHa4KNDN21hV7OEgbdxtNfp1h6/t9pmXaG/daJLU0jQdx+sM5x0
	 zaSPJuGfLN4rIOYQ0HsMbqvWtpDmFILwkMxh80kGB5j1M7IMviiW5SH1TIEaiXK0xe
	 Z5wFr0aNz31vQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4EAF147BA6;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:49:01 +1100
Subject: [PATCH v2 14/15] arm64: dts: apple: t8132: Add PMU Device Nodes
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
Message-Id: <20261107-m3-plus-pmu-events-v2-14-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=3BrxbOYqTLNeyKHRZvsGvB9dy6HUAnTkRir0SxA2U9k=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zyZ7OiDOQDNK9237x7IW7s5Pa7zM8UpQ/5rJy+
 6StHyK+vU7tKGFhEONikBVTZNE3TdOezNZwqXSZ6xaYOaxMIEMYuDgFYCLKQQyf2f3f/VI7fX3R
 vy1exd/159YsjZk4Ldu31eCLtbxRhjQrI8OBOzYqbUW8d/995o7S+Na9lf20dsCFX3f5DWM73ns
 VMnADAGOFSaQ=
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
index e2e79c7e7fd0..767e622136c3 100644
--- a/arch/arm64/boot/dts/apple/t8132.dtsi
+++ b/arch/arm64/boot/dts/apple/t8132.dtsi
@@ -197,6 +197,18 @@ l2_cache_1: l2-cache-1 {
 		};
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
 

-- 
2.55.0


