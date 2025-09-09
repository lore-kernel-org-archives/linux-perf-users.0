Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DC320CC3;
	Tue,  9 Sep 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412761; cv=none; b=X8c7gKs8YAqPhBpK2w3DZM5nt6HE5WgCxS43QEAM1DaLF86XnWPoD5ptFpf7748auWNhJ6F5wo8wKonN6HK+nTtyKWwP1A7nSZNVN6Hj8ko/d06jkXMsz8DOdYjakEOSMQhVzipTBhAWENyXToMXhrvsGYD1/0rqfqq1bxgocC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412761; c=relaxed/simple;
	bh=JE5vzNG6Sy2HEFoz+DBwUg/nv8rP+wKI7N6BxDeuvto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mj8ZodDJ9zctoZ+Daa9tUozfqIDXGoNx8nbdR4CUSFcACgl8Yx4EdE2+J6v4WiYX44gspnekXjjyHv/yAESJuyCUE9AZZRsHbsYNK9IC6AzTBQ8jpxsk0t4Lyx5vndr2mU9cBt9hcv3xIK71lOXIEMjYjHs4BzHzcYztgnlyrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfoSaVeC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfoSaVeC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so48314255e9.1;
        Tue, 09 Sep 2025 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412757; x=1758017557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=UfoSaVeC09hrY6ZXBcRs9aaFGJPKgKbMM5bZrn8A053zuvmrSBS/+XCX+/Na1IrI5F
         bkh0LMKChW8AczzK0l5og9oR0J4Yi/leAssn3EDGGJw0rkj8K2PcnTCIuVKKNCicpFyo
         4cQqs/YUQHUoV9qR3XuSWZWKMb7DqlBAzC3nw+khVfklgoPwTBrZUC6lpXa9rmhsDoq/
         gPNPa3YkYyZxg5H0+kCr/CjqgOTm/bhy0brRzODCy2cDzFUkL2FhpAYsP8MRPEQLQeZC
         ZtgKRsvASbOSOul08r+xCIhWYPKxzf2df6TAP/FcCY0CmvFrZbF8pY478bZB+4TtfFQx
         hOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412757; x=1758017557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQSp6khD66PWakk86QjUyhjTSipaHZaw5SNW0wYKmlw=;
        b=apYh0619VIhMYEnm3WtIZwMQoEe07yyrMfPHAMPKtof0GofOHAmRWhxyWICsloob0u
         j/Ob/hC97MCBslZv3LNoJ/dfcaZe/kXZ11rOmPh0G+vPuJnv5ykVpLFdVoulri8k3kgL
         YjhFE9K4kMh2xU44sM5jJmfLBlXRskCfp3kQSsinSWqA5eV+33G+RfkmsORRneqOav3T
         WG12/q/vqT7F+AJ7FrSeuo8PGaIwALFxmxX1+NoPYVkzMR3/Tu4O/wr7LO2DvUeQhAki
         Dc5W+ZgVpRcvr8Gd7Y7vdZ4VKJJePCSbOH8EeokxVWHayfzpnFT5AS0YiP0F1AhZCKar
         gW5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuNg/64faQvNHrT2C7WODC4dA28hCteiAZJ4m8SZcGg7KSHBPlaX1tGQ8HneADsU08LKV0QpV7z7Ak@vger.kernel.org, AJvYcCUxNHezndYbz5sA9rSI+UIk306KuUrApF1SO/mWL0JPj5D52J6/xgeE0NCLWS1gsHFo7j1rYBAYk1MlNTk7@vger.kernel.org, AJvYcCV1bRapqj3ULft2IRwh3pIxftSHEiaVvCuOrf/nISL0TgPzeI9Il9QgufNdefNBCVuXzgfE925pHdipYxh0S0oRPQ==@vger.kernel.org, AJvYcCVB5eBXqTOZmsI3h+QxM57oatfTUxcwU2ZBOZA1SSQ8XBZa5Ezh3cFVfbs6fpxNjoFqHoO5ONjyBejK@vger.kernel.org, AJvYcCW3PPINovN2KYDtfkqJkhR9j6wrgWbI1QR0F6LybSHlV6OfnCnbRSpGa7tNO5GvPT9EcmJIphD62fp6@vger.kernel.org
X-Gm-Message-State: AOJu0YyVuT2n+AiggXEjRNj2QLUXlGJlEity3k50TtgNTKmay3r5Zp7a
	LimNZ+G5jKEIzFCSj+6NWBB7udF6zpTe6dr4IurQlPbaDa1RdCgdy86h
X-Gm-Gg: ASbGncu0F5OFRh7PjYx5oFgZzCGTW/Ek4T0cXssb4UBXCRIyC36sOWLR2npPfAwItt8
	I2oLplHcwcl8FfJywn4UeEhPmt6oBmOxOspry1aiMjtVxJIgXj06DPrFsEs46RSxA2vn34nDcUI
	JE3dxQXVcxNmpC0zAvbkGg6wfhrwJL8tUgkC+4+3WJ/aCIr4TRabiG4WFW3ig9HZNhGx3DbKDfW
	/UmIaHMcJJUrX8ZWNhqkkRfKqvXBzOT3ipxiODAH80r2MhYEvZI0S8TsTcTLOTEp4Vphh0MIWDR
	gTTBI5UvAM5GbMTYFYIEvHybFDDHxvDJ8Mxh5YksqTtZ6Qi6ypeZrkcHVfn2gxvvhPbGTal9/jO
	wHX6TmQZez+eSVaZBhQi4ZdhzHyrwk+QSjg3h9JZxl1JSpKEWMn9vlkYBBUgeDgAv8uICgtRpjA
	AxuNjcisbyjkLQGs8=
X-Google-Smtp-Source: AGHT+IHKOV/tD2Z3OucLG0PdmljH+LI/bDbmIWYAmtOmyF/7Dm5UNviLw/7AZ2HS1Z+3OaIscmV+Mw==
X-Received: by 2002:a05:600c:154f:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45dec73107dmr27260045e9.25.1757412756628;
        Tue, 09 Sep 2025 03:12:36 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddd47b6easm150506865e9.18.2025.09.09.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:36 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:18 +0200
Subject: [PATCH v6 11/20] arm64: dts: st: add DDR channel to
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-11-ce082cc801b5@gmail.com>
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

Add 32bits DDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 836b1958ce65..c4223f06396a 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -41,6 +41,13 @@ pad_clk: pad-clk {
 		};
 	};
 
+	ddr_channel: sdram-channel-0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "jedec,ddr4-channel";
+		io-width = <32>;
+	};
+
 	imx335_2v9: regulator-2v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "imx335-avdd";

-- 
2.43.0

