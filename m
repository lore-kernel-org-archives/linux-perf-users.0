Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58B321F27;
	Tue,  9 Sep 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412769; cv=none; b=pjO+Lx9bx3R96K7i3ABkwOmRp35BJ5jlDnH4FYKvEfcMYgHelXmjQOaPEQAePFa2psxeJAPDkQeo3jbQ4g9vy9dVhXTUfo9ByASf3VfGV4FIKmrZG34DP8hKDtXKVDqFXE6SlAJZG+P5/zo7Dc2plaOg7DXLJLmbonpaQpBJ2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412769; c=relaxed/simple;
	bh=JGiWFqL5ns7Q8jtxQNAPPRyPGZdYu3dQUdhzXyDoyhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXWgMPj1JdwoAjZlDV2cGIwhjrojuzNFVi7RIPLGoe7m3jLNCzh2atXA1euOngOgbnS+8YjPa1QmZ5TxMuH2mRUFrK6JC/6iot5hFpNPIqDOdhJPZ3hIkCnpKwxZXR9XYZM0MwzgwImdxo8V64YPud34F/DIeStleDWqpNm2jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWsEbCT0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWsEbCT0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso4665905e9.0;
        Tue, 09 Sep 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412765; x=1758017565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz+B+CL4iaScWz0taGfrGQauvYCWLu7diA57jxmU9w0=;
        b=RWsEbCT01NtXJ3Pe3iorfC0hrMqvLvZR9UePTz2NB1vejJuXIYpFYdrNL32p/L+Sm6
         iDPqqghBLDIfZlWLRUMmBHinSNtU/nR6UEoitpb3RSAqFuDBtI7BbXZjrrxaq+m0rB1C
         VKwKbfTtfjdPdK9w04E1e9+FrZT/3nXQnDt/f+teXrvx1fYEJNngKETPwVGdtsDLOyRC
         eUk6T93Y1uAq3bQrgxBhyXHKYvj3n2WzSOhb7zo+/oqXQq1v4yPU2DQo82gCetIWPa07
         4ZfIGWe01i9n91Mv2wdIupIQhnAJkYz6ieoowanMUZKQx7W+RDfgVZdPqmHDSlp9fc+v
         3Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412765; x=1758017565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz+B+CL4iaScWz0taGfrGQauvYCWLu7diA57jxmU9w0=;
        b=JSiMEZQSVr6Wv+NN959h0FmJnjn7aCRdIQpMM7sU1bUjByfhC8ItaPB8Z59QO6yaer
         PGafqwVtM42GXh4p8EpVdawrtcUPXsqocNuy7JEgkzdyVm68ObkCxg8SC/SGcC4V6FFk
         X/Gs6uLUQp/Sc4UbWd1WYQlWCRauzlX3ekDho37zGm7gWtkUTHGCfWQqtl4PCSZJbfDJ
         r2Lfc+3HKQMHTm8M74NvHTNqk/h1m7gcBpDYgVZ59X7JTlvLMgMepLxwy1Ovk0IMSxc7
         qy6OgnRTOHg23pG1Haz7bEfjU8Zynk1COi6qM297omsof0Y+vUgzHQFkmnfYRPcLMRTe
         gCjA==
X-Forwarded-Encrypted: i=1; AJvYcCUOeiGRMIi9Es0chY2wnx4B/Fl7ax4hE6MIfAc4pRUvEqEkQZEnFfkbyUEn0nk7FUmmdvsPWhfrkf7WFnuR98k45w==@vger.kernel.org, AJvYcCVGkL/nU1VKKZi5avcqTGvwP6OKG0GPbZfFgKIWtDEhdWdU4jluBcldKZrycZfBVFu0LXQe9pSLGIqo@vger.kernel.org, AJvYcCW/+c2Vr9zn1fH5uo5EH41SuMRypY2h6Ki3kCgkACB+QARRG8+sz6FGchOfddTVHKuBroLOiqeasU71@vger.kernel.org, AJvYcCWqLWyJYw/nHKda2ZWysgga9teU6Czo7g7agJriWFpg8DNGfhkCgO0pBIoaWIjlqOALieUF+zQs2M5j@vger.kernel.org, AJvYcCXg/NzvoXau0r8DzKpAAbEl1i6L6VMy9rBIDA58ueGRIDse7M6cc9EsMKbzWSrNKh9qbBYvrQt7f6AXRuhg@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyxNIvs9naywmoPbPL7cMdVHTS8Pr5d9yzSk2R7W8h1vdoZf8
	VidsSKLnxK/WC4lflda7ms2tFZ8bVmvUg6W06cY2nhOe3f5gDwTSRjQn
X-Gm-Gg: ASbGncsVgAwzhAezC4dcAPpx6q1G8SaoqCfWVX1fLT0I9VpZCOqyMBTCWJ7q+L9QG2f
	W0ElOdaeeVSEH8ljCkO80ps6MfrcsIuUwHl/9mvLTipvYATyxbxBra1dC4RaKnHG6HuT8klDmJ4
	I2RtwmZB/ZWO5cEvA49jIIcgloNgTyip/yHT7VyvMiF3mDYCtPzYUQRsSN3y2pDwEKsjqB6ujao
	KnJhWcXY6S2d45xVeIrxcoVhdfmCjIbN+o7jXdJcFV1kStD6f3FYYCoHMRhCT/f9GP0oymEthHW
	sNbGLlKjhIEon/D7MeENprwWMM+T2MhtCiynV9Ky5Ze/BXEJm5fAV7nKRU3lGLGNsyU5RpqQqSt
	RmOgvxG46+9YIqIewm/GyxRUy4lRzlM3nqzMEo3pnKQnlyvQ0W5/Y0ig2IA0kEvpsnhfpsqkakH
	ewLJz5FV8Ea/EccFk=
X-Google-Smtp-Source: AGHT+IGIpwds5m1f99DmZYWHr5hx00ReCcHO4qawO0+yYPkO3AH5Qzc/5zzp8Hi+Au0bjFxBpPBAkg==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr98436055e9.24.1757412765321;
        Tue, 09 Sep 2025 03:12:45 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df15e4f44sm13157475e9.6.2025.09.09.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:45 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:23 +0200
Subject: [PATCH v6 16/20] ARM: dts: stm32: add ddrperfm on stm32mp131
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-16-ce082cc801b5@gmail.com>
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

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP131 SoC.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index ace9495b9b06..7ef3931fd6c5 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -998,6 +998,13 @@ iwdg2: watchdog@5a002000 {
 			status = "disabled";
 		};
 
+		ddrperfm: perf@5a007000 {
+			compatible = "st,stm32mp131-ddr-pmu";
+			reg = <0x5a007000 0x400>;
+			clocks = <&rcc DDRPERFM>;
+			resets = <&rcc DDRPERFM_R>;
+		};
+
 		rtc: rtc@5c004000 {
 			compatible = "st,stm32mp1-rtc";
 			reg = <0x5c004000 0x400>;

-- 
2.43.0

