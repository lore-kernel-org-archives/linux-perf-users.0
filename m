Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048549;
	b=m2y/gBsWvQvi1kXsYFNDiJHZzAEJODU7iIh/iFrjsBkUvJ738wxtEkaPCv4CCuYrmneu
	 1t//6GDxGzxvS+NxAa3NTUeHVDvttk6G3AYEXmIYMXgL65rukbXswN57u9YhXY09szytz
	 DRKehUR8xcRvlRlD9ilIL+EbmbZ3FkqrlxTK3qHYfCZ4nAj4VN73b/C23BtC9kaP/wh00
	 BIGskA1Whk0f3b4YZGtOuCf9ujvARvibiGvlFbqAXrarToq8vxrvScCvc/jUR9nRx+M2D
	 3cuH4qM/V4/ggnj75M+ai/JpVyu/ckl28pWAbnf+rvTwC6ALcaV6TGdOZ0RmcWPrw6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0SuW41ChieK1ZfiXTpBu+T0MvVfOyp+a8PPKJ6KJOEA=;
	b=kV23yaA0E/uf1j9tmawO4K78pk+XW8F00ke4tNfCI9uHnsoRFIA0Xs3Cl2mnA40Kuedr
	 KaL1NRNQS/eQxFXjczSpLHNTJ4WgM2/itTcehn22ahnkPNct+ScQccICPot7OYG3ckb8B
	 57R9UZiORwYOYRxJ8Qyx5hWFMLRrxFgpHs5ECxYHD3iW1+bTg+7Jyta5fGElyVN+/0V0u
	 oFs5rF77AHFjVcvvnHmyXJ0VMuRlVPLaKRkg+Y4h1n2oeeyvSV2Zxuwwe9byCCfd3irn8
	 7GV91bS/VUUeV2bZKvb3mgISDh7mwMWtrAucmDueCB6ltI3DanV6/WMUbibm8DBMjaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9Rp4w+D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF7606D83A;
	Sat,  7 Nov 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9Rp4w+D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048548;
	b=jLl6WLsXAxcy57MOeO6bN1BBpxtPtj78GgzRIcHx0tUW98ze2TRJpvct6w85YeFGqovY
	 7BVf92n/LP9T2N3vHvQQD1Q0d4lBA/EalsO5P6peWbHhRYxOkUBFZNUT0fD4pDSVpJFMl
	 SwC5yr8vTHHspxO9yyPM907XktdE9aTw2EespohdJ+c2orJq7K6XVSfCf3AAyMS3R/yXx
	 zqSWdQOzvcp6ki/ShUMFESZSk5mzPddFhtkAgOrtNVtga64qPwZqYUIkyzTTXpGzAtmkw
	 WFebBW3J/lUNjFP09fbETI7/xwKovrk76d4T26QXE+3kGYjcNhYfVgWZhZWyfoyqZYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0SuW41ChieK1ZfiXTpBu+T0MvVfOyp+a8PPKJ6KJOEA=;
	b=SeLBNVqblTMhovaGBxvvQaQgEfuZH53pqSsTCB1qZ6R75T0qAYFQlCCuOEx+3UkDz1xH
	 8v+SfTyB2MCvq2DT1w+8V+I1RUxZHOY60e1nhNKKEtRlhPqjeCW0ryRQP+Wkosnf7fZ55
	 dNUKoKMKHW4dT9IJzvM19ttD65mc3YAfB3sigfM5XnUvzWVmZf8FN3QK27bnEOO5PlT39
	 1U9/aNCX2SM+o2y7+0K3scgQfAcx4gGsEhDrz8PfokaPU9F1gdLMYcNr/odU2aWCf+FSu
	 1+Ugvva+SIdb6keU+MNDMK1+570nsS/8/92UKZF/OcnCnesY/RUL6UPQ87dUWJ2bbig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1DC001F00902;
	Sat,  7 Nov 2026 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048548;
	bh=0SuW41ChieK1ZfiXTpBu+T0MvVfOyp+a8PPKJ6KJOEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Y9Rp4w+DlHLS6WEuOWrMBJV+jq0Q2C7lNg3R+hclqUpe65V0ViRdubzbducjLC/Jy
	 0x4uNSygiUMUaWVeouRh9SY1ywjo7M1Y1xJxnXzSnYPkJx6wPZUtPKeMcnnpPvas5O
	 mU51IJD2/2tEmRCsbS2cimbymD6pDpVu78O8/x/N7nOPE4SYXiRvTj/z/5ot92g/Up
	 DSzVuhtwymtLmNs7e7FU0Ek1TQRtM9pQkWgAcYZtpbZbRSd0uxBQDZ7X1fNIs5ArY5
	 5Vjy6sIrvCba7O7c6qBp96uDkON94bvzJSNqhVuiSclcqLxJzEkNyZuYToP4iZKma7
	 2J+zB82VWzGew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62EC447BAA;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:49:02 +1100
Subject: [PATCH v2 15/15] arm64: dts: apple: t8140: Add PMU Device Nodes
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
Message-Id: <20261107-m3-plus-pmu-events-v2-15-acf1e78da039@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=ADJFLFxUOqHDJmF0uWXvDM8Pu3rq+xTOczYNKGGrtjQ=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zye751bpeaN9342JHH9YXiyyEWxe9ZZz5++2qO
 7o9r38+FKnpKGVhEONikBVTZNE3TdOezNZwqXSZ6xaYOaxMIEMYuDgFYCKHjRj++ytNaT+7x0Yy
 bFXdoYizK07knvyZkDF38cm1zrqTbY/KlzD8U2brm624fd69kHqLo08FubYfsC1fVHZoeX+LUM/
 me5fusQAADO5Nkw==
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
index 89a26a1b2364..6fd671d1f088 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -143,6 +143,18 @@ l2_cache_1: l2-cache-1 {
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
2.55.0


