Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB028BAB9
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258212; cv=none; b=AR2FxyyUr3AwFtmJNzReH0qHj/d1c22+4Srkz5Xf/ZAihO35/OIjCzTqtGbnLUXhYe2SPxZUlPbyQBBGphlJ1ysBWuRhB3Y1pNVDiiOqdBdgrJmqbZ2an+gdNNfVeYNDiE9hrIZrl8cDUNXYb9Y6YHW6jPad+BhoMUe1sU/xK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258212; c=relaxed/simple;
	bh=3omd0YVrSktNDZ3RXrP0xc/+wVtkaIIz0927w9SxlCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWciKhGry4c53KJzZFupvOiEK3zpig1NUiiC5rFKU4rR7/UYaV5mHcApalsHgNij+3zDOhOQmjtKQW7mZvEKQgA96QEgwcYJOjZLpRwRVyAZjlMY4GtYkMg7mKjlRiH+f4l5I7/Jj0mBshzUuo/OO7gNK4kpcjl8CIvaWRb3uNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/jMK+PW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/jMK+PW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9387df58cso18289789b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258209; x=1767863009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOOkO0Y8d9P2yswmxe69xUL0YHF0SsjJE29vdXLnWdM=;
        b=T/jMK+PWuax2WcEWW6kiP6c6qKjAw8Zf4TM4XUhxHW7fi56hr42iD/lBCAqPZS3yZz
         RT0HXha48XGyXwcniZwO4qYrIiP5I3J6AZwl1kGmgsITeiTLYb+w6Sv8bJeulMKdGEo5
         Vm3vhWba0pjyzY//T9AwrPK1qGcTNBx2dTqfVgicEJuPiXN3tvyRarrpJSRX4kuWxPPR
         99zBNjggzMIFag528u06v3mLBeh0K5SVuhSx3tXAbYqSL+98ZOtEWHIX0qV1Qu1i1Nr9
         SYH4UBTlRdaj52nLA8/SdQ54IyeC/h5CG1GzhctigW+wSysPD7zdcj1nkioeOWXeoE/E
         ffvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258209; x=1767863009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VOOkO0Y8d9P2yswmxe69xUL0YHF0SsjJE29vdXLnWdM=;
        b=IcM6VBLlm5iUdx1P03ZuAIT2bzXGCvrgl4zp1WHX937ZxsiJanSwefqmFhDP4YQXr3
         Unq5DiZgyGiid+IxmXKZGIyU2SouYQkbopr1zMN1CXtZmBoN1FI9Apc4qdXPO7g1sOM3
         lIxmC740lHmQBErBeN71b+bKTzCxBSrcJ8+uwpPgQJU1JNvEN7DKjdtLPQRzqvDlTzIc
         ySy4dJpVt6SROEOJl0g7p86q3jE+Yirw+G1wN43/rcmQaY2C1p8LZ/RPYNXXm5nCDGb1
         6nDAl/sdSi7dTJYgK5pRSFC6OHL/cGVmcIWFnVbZ2tWRA5qBFGodBhBTiMT4j0gOoT+4
         sW4A==
X-Forwarded-Encrypted: i=1; AJvYcCUHEmBQSt0AmJIOUvWAYVOP34NutSdVVqwRofBvoZUvsCJkv+s+hOa9PadEHKKVs4CJJI2D8uQHP/xb0TlLTaXv@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNFjc5lnmqz7Ogw7sMDVhMImvK1co3NrEEsMdKwYOfAtMGbfw
	nCGjrxflVG9hFqpTeboMSy9w12I9OGTGI9PfN7maKVPin7HOhSOnUh+w
X-Gm-Gg: AY/fxX7Bcy+Y5U1h3kjAk2qaXv3+OJe4y1S46/9jUGO1aR7ZPjrviJmhdaGVT9g2V2P
	jQDvMR3SkmJDg/TOd7/7sHGCC05cmotCZikEQR8qJM0W8TcD1tkLgk1tXyCTTjzX3ncx5C7363A
	oNSwLVt5zw7wbqYxclYTfNGsb/7J4ITtlYonEMgDeAJ2Xylki8dn5PW4alas9gJjnLV99cBDH+m
	a2bh2CdxbnAwM86h4lt8P3XWDJJLaMNNNlCAmuQJk/Xs2v+UbrA9JkZukOZzs8HjpN1Mlifrv3N
	fUHIe21derXbnho2YY6nJY1odhX2Am/2bBJ/31dAzd9yq2l+PkKxru9qAqWEmiew3cpK4/zf6JX
	DBu0Q6hov7TTWoZSwU8nV4SfcIvBIvRjoNW4FbhpoO1T3fAbaAc0c2h65YfILiphfGPheAY1npK
	5aut6jW8EXcbQm9GcrVIrffq8=
X-Google-Smtp-Source: AGHT+IFJBtSUfejTWgpNgQSoCDlIJLnAMjrQe0TebRz/JH0wlhP4fBgImgpnBrH6nBpvWNt011OSOg==
X-Received: by 2002:a05:6a00:ab0d:b0:7e8:450c:6195 with SMTP id d2e1a72fcca58-7ff66479a6bmr31930739b3a.44.1767258209581;
        Thu, 01 Jan 2026 01:03:29 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:29 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:52 +0800
Subject: [PATCH v10 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-16-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=3omd0YVrSktNDZ3RXrP0xc/+wVtkaIIz0927w9SxlCU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgo4L8d5gWvdBUOBCVVb6ebQ4I+hDv/E1SUb
 kvSMq5z9Z+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KAAKCRABygi3psUI
 JOOpD/9oAMq0s34OmmAP01oVZU/WNedqAtueSymjOF5mohXEQuodSPtHLp4na/8PBkTnsdMaBk5
 qYq22cNUmGaW0tNNKzXYdJ5CHX3frqpUae8fhwpg2obo9CbMNAlxz0PbtaPxsJP/ZYmdb5EZnEV
 etlvvIBY9R6eWxQGZTZrH3TPf5gG724fi4G2AhurxVHs9c+O7M0NC51r7ElhxVuqEosrOERL8Gc
 s9DW7iZplLGl6hwLnS9hc/rJnoHP74o+IzBGy+1lQYWh99+8ReDPnFqJChy6+HkE7XyIVi6Wupv
 J7qy43MqWnYX0ZIPBrC29fru1OVTw3N00lcG8Zd72IkY5Rbjqtv9HFrF199MFT5UpK69u+8Ztul
 qghCVlwmGf5eH6uoI4A1O+K0u4RGx402evKOyJo8Ufdog+1cHk5ynjqX1GlQ7hxccCpmngmh4nv
 srzdvYX1pJ+LENySSHC506nt65L6cmeXIISvgVCBIzqpuz3boXCFsJrA3dVJb+uar1KQtimpf9F
 5HbO1vGr2G0kZFSjSchXVQkhoSgRG1TDLYRvcpMo44X0qpJ6peXtVlVaHJtNAP5I3Jq0OPuBPGf
 sKm8N0K3G1DhDcQHIX0DtjumbJPoo3NCybrEF25MHdxgw+f/vjL49Bp8/DesqujNDl882sNYrC/
 yo4itq/blz0kR1A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index bb38662b7d2e0b70e18b6870b706789b1cb242af..aa372aefc995334b1489953c16251c8ff9b94d98 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -237,6 +237,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s800-0-3-pmgr.dtsi"

-- 
2.52.0

