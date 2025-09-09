Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AE322A22;
	Tue,  9 Sep 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412775; cv=none; b=rXBR/LjGAGSfPXZFHffYB1Rf5Zd1KlR54cNxkxKjA50PVUwPW6dPe6x1LmJi07NWnLUxjkqStQboHlgPxoZwIIvml8+Xg3/pFKlTzSOMbKls1q3sOFRYJi25RM+IyeupAhKZlrPv4fClh202HZV4t3d0Yd0zImkkebnJrWUpzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412775; c=relaxed/simple;
	bh=Veh10dFq34J2Gxp0IcEQ3EDcsXL/4qN9N6MaXWyrB5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAGaZKnjjbUq33fQXfIQggvrstnmOIeWI9DW9/OxOkqqW5RdNGbDMQ+ufwdYdr/6dTQ5RD8J7tQfwKaAjP/TG7KwLMusevYnWnifmkBHKynqnOq8pnvWYlcPi1SS2S44pB826l8L5yGZdc9tq4fsuIx7AVsfG3OHsGYFBvv/XeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUf+PFLz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUf+PFLz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso46175905e9.1;
        Tue, 09 Sep 2025 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412772; x=1758017572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIgb7J1F10HYxfdjdkrY8eTpLG0sHZrvPdCfUXjCXl0=;
        b=TUf+PFLz2FjJJAu+ZbF82d/++UXfYjOj0b/vI6DqaDSZzf2/bCDP9QGsqwRpPKtKNj
         WW7izqW75ku3nthn0codEMl8uXlvvbgEg1PNh+6S2Py+/pVecTVeIO4Lg/WBWlAH7QsZ
         fmb0F8MM4hxWrTT0AyKfC+YKpHgIuuRLiLeGeQ83FxKOHf8zRd+QkmPhqY9xWR5JDxJC
         Lwr9pD5fwQotIkudBwY8jXdBTDpyt8LDnfpM0pqjF5xMw/xrER17MlF6789CRYcQJ/rA
         j9dC0nnaaCCoefOP+3xtg1h11M2gUz0O4jM64WtjmLvOzAYQOPhgIzMFgJR/n0Gi9qI9
         7L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412772; x=1758017572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIgb7J1F10HYxfdjdkrY8eTpLG0sHZrvPdCfUXjCXl0=;
        b=NaTFkQpqfu/IwZ0U9GAmMIi7hcpIO44Xi6xBhT/hY0Yxgdp67sUvLfE7VrH1yE4sFx
         DcQgFd4+jznbwj4N1eHchPL5/Ajos9SqMC0sOaQtzR8wbc486uvvbtm70RBdjtisxJnf
         9g+y58G3MogvzxHt04UANyuCKP2iVfuu2mfMtdEvif/RK3vg+h1o+o7UqALNiBtDCNLK
         rl/jVZPdpJ7ep+iujYwpcAIQ0Zf4XXpyZ+D00Lnj/HJBzU77bq5x5zX3nHvhVqnq5m0Y
         hIeMouPx/X5RBxLi6rpqQ29Xa3daj0yfZoQd7VNquWcX13rDAG2f8T9q71jLNFWb6Y1b
         LcmA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnkJ9PELBBlvLh0JFyx1l3ScJ6wQh63pw89ukfIj9qeC8RmPnr3ov2fSOC1Gk7AP6YzQJfMSZlQ8e@vger.kernel.org, AJvYcCV7BNht4Q94rurxemuRJwIDJHt3eDyUDNMHKc22Z5QUJrhuNZPmWzfYy/t0x2zU/24KcV8HY62zqRNkmu+R@vger.kernel.org, AJvYcCVgE1+KYxaOPIIgR6/zOehpNIRMus1usKcDyaa025gLeXYC6BKJSASgGZYdYsGnP9qFWyCqHOTrpbcT@vger.kernel.org, AJvYcCW7aDZNUCRjXgPkpC2epqcWKjaJ8k98Ch1zfgtFsCyf6K4lhQ8S8qCw2MFIn8JRiFPj4Q5Lw4vApTAenMOqJMHC7g==@vger.kernel.org, AJvYcCWDjDUY0JDCqinLeNsRweHrQTNZbp5OETaZedS3V0QKE8JMfvOwkEyED+mdrdYRmXEAULCfXVITF/XP@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTMA9kmLTFYbYGhZ/KMy2OSD+1fdY87HH/i4xnsXBxKNX5x4o
	tH+jiqFVWbgoL1N+eUdQLiftD1pf90tzmzfaDQNzJe+1SBS9cdGKVQZp
X-Gm-Gg: ASbGncvQ2L1a1QqD37XGDqY3jS7hOh3xjEjOORehwf0wxOiboZRamtCeO2Gkx6EbqTQ
	C2fAfLd96X11NYw/m692r4xjCMjw0t+7XynQeHgQb1yKHLLqPcPwqo+nU56w95q/uPEwNpwgKVJ
	LqZfHZ089KSCGPCKe9t/nmfYGd2yvmSiSXcZ/GYID20DoEvHII7QZ5ekcItKdFz5xNDUkmMONA9
	JkDAYHd0GytClvy3VKLww6A+SDV5nSz+JcIdNNlE6MmTJ1KzIolunqG1JM+e1kLf3/BRtbVTL8Q
	M7jLHBKFYLVCaY2pEWpfp6MNarHofQv0vF4NXUh6oi4MxXZU8pUfkrEL0drsnCZXGUgmf1EcALA
	jy/U9PGleGkrTpYkDimfX6WPlOQ5ZlWWIZnp8TD1Yhhlh+HPrndkOJ17DQ+1GZg+8eNpCTuUqWa
	LaG0+k72MnybQ++edM7RkKXAu7dw==
X-Google-Smtp-Source: AGHT+IFVsl0KBBNudami4eVXse3EwUG6m0w7N65Hz7CHd/3ZnVXJY+5tMMekyix7eYIjIw4+THAIGw==
X-Received: by 2002:a05:600c:1991:b0:45b:5f3d:aa3d with SMTP id 5b1f17b1804b1-45dddeee57cmr87267925e9.21.1757412771663;
        Tue, 09 Sep 2025 03:12:51 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de16b8b58sm130632525e9.4.2025.09.09.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:51 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:27 +0200
Subject: [PATCH v6 20/20] arm64: dts: st: support ddrperfm on
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-20-ce082cc801b5@gmail.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Configure DDRPERFM node on stm32mp257f-ev1 board.
Disable the node as DDRPERFM will produce an error message if it's clock
(shared with the DDRCTRL on STM32MP25x) is secured by common bootloaders.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index c4223f06396a..c685a646a21b 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -130,6 +130,11 @@ csi_source: endpoint {
 	};
 };
 
+&ddrperfm {
+	memory-channel = <&ddr_channel>;
+	status = "disabled";
+};
+
 &dcmipp {
 	status = "okay";
 	port {

-- 
2.43.0

