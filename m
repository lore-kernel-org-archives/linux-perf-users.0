Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DB302CAB;
	Mon,  8 Sep 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325734; cv=none; b=pW8jGcQbIwctF6QpbbTvo46KLptap6zRKc7DEg0YjgHWUMaoKI7SuPxWDwnI4QP/rxVDpQvyddseJEIqPSMTCUkQ1OGid7lZLuXd/QQJHEn4Lo5RtXOt1lRlw1x4VA+Z8dJ5t1Dx8rmbJlH9N+EzMytRn3cVf0wEOaw8qmC9tOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325734; c=relaxed/simple;
	bh=K4a8tKqeVL9BaqFzY33bqex26zqvwpxkE6HkJdl3Qlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7rY/63wkHKeFtAuXUCCWmc+/J24+4PcXqweImXIrM+Nm60OydybumWXGuBdwZaUARGkkuDPhdiSJy5mqCZrrX6mXW/Z8E735Lu69SN059fvu+hO4Fl3fTYx1iv0GHjHTIHMCdqAPkCI1zIDEdlqSSzVkNAgeHa332Wx297dpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYa821GS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYa821GS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244582738b5so34082535ad.3;
        Mon, 08 Sep 2025 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325732; x=1757930532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7llkAP8rKH/Oo92VHhR1v/h5PxCOy9CRKJV3/2nzc+0=;
        b=jYa821GSUrVJzf3FCXS4HJawshuBsK0byXikDwN+CgnjSTTMPjPmaUXFa2dRUSOz9s
         2K9x++hMeALAyFLwlW89EYRqo/tBxN7hUwm/WpE0eu+N9WZc+oC6xQrmcbjHDjzrrYJ9
         knznYXVVpmy7s+Sb8zDq4aB1EiGkYqtyMCvRjXU9zrMe7zKLyMoDhOVPHmRxDj8XXx2L
         QkPGXAp9C2ZG70pSqy/pLpatfzJk4ofCmFFOYUcO6ucOB4/k/NUmOhovAl80U+I1HtHi
         XDkSuwyxVSEKmTMVNh7R0lT4Hp9F51i2Q1uWFsJKyVj8fXyzgvdjh5Pm7wRFe5Gtm72b
         hYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325732; x=1757930532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7llkAP8rKH/Oo92VHhR1v/h5PxCOy9CRKJV3/2nzc+0=;
        b=OJ1X2HLGgeSyoRxXDk9uIwmnTcifZdvTOLmeVNxVujF6Kp6pLJGK1UhLgRL8iZ1beN
         M6K+F+Pi0iu1zQq6MPBTWoQRT8rNrxbw2PtoaaszGeCbJQrRTpm2lPeu9VPRX9OXbaPp
         hRvdaq3ahrSwY4lsPgrCN8DpYAaOMsVJfNaESDnCD2z3ZCUaalhMmFZx8xcUh9avzgcO
         YPrEezkCr0kjYh0g0HYJDQAoYs7F+xgRcEyGo3YXocW5ADKP6ZqCZc8brkVmlH1a1mFc
         Wft6GYoJ1qwzvqZasjy8iO/KWx+0stCDOfo6+FFQRuSQ1I/Axsiz6wFCEiVN97FOG0x0
         05rg==
X-Forwarded-Encrypted: i=1; AJvYcCVxDtRVyk4idOT5gCCLgm7fx1lxUC5ZDPAzCjUSaSO6SWdZwVEbzXW1xBMZVTWobaBRQrh75fQj5X7Y@vger.kernel.org, AJvYcCW1tpyul1AQ6py2nBx5l58thDEWUvu+MLpGEuo81qsS0aS2zvej72lXj1Lp6Ig+qorJSQGXWqK0vH1zdUzHi3Wsvw==@vger.kernel.org, AJvYcCWHTkAdXZJTJCwiwWIOk4agqlPBeCSAqWS3xqBFoI4hlzNhOHTiQL0SgdtB+v7TkNIp+IEZgnQ/QTEc3jUH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5IYfn06bnKUZVtev5JVbt9scb9Sj3mB1yCuFKBlTX0UQLorT
	5+7gDc/8sdtga+x0iLRUuE43Ly7gz4fRkj8kwjWdio3u+bg2MOiolJyV
X-Gm-Gg: ASbGncvwGkIUZ6XU3D1O6W5726VfOLcdNYWu4N7KMRzGGWki0BcNyX5UECof8V1Zl1/
	Q7c8x+vBmmpizOmZ4AlkaF9YDiJfqmCVTcVRz2pvgmQAMoNWDADmcgK/FR+macztrWKC6313uB9
	YA1J+LadonQ+RLAnzUxpp2ZzGpo5PKIoJYrPDskDcXUmPf/V8LYUOIC/6HjfDqnpsTvW2MTAoDm
	2vq3D+WbInjzGLULsuDFv63fBcbF2LtMEQHo1ExghJzHLzEw8MFgQ2sbCW5BtBxyeqaJbnHH7xj
	bp6IYFb/eqMK76bQZT6/Dio8V9JTrG9sJ5Kq6r3J4yOStVXAEix1awkSsL1cviIGT01P0QT5oTb
	MSe6SASxcE22rMpiDipCF+L6e9Mc=
X-Google-Smtp-Source: AGHT+IEaOR8JabCaDSqwAtyIemGzOsc6AZgodUmn0wckrYMNjPfuK9mL35dB35gjVYmM5JcfKOQZtg==
X-Received: by 2002:a17:902:ebd2:b0:248:fbc1:daf6 with SMTP id d9443c01a7336-25174c1a946mr104229935ad.43.1757325731677;
        Mon, 08 Sep 2025 03:02:11 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:02:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:43 +0800
Subject: [PATCH RESEND v8 19/21] arm64: dts: apple: t8011: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-19-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=K4a8tKqeVL9BaqFzY33bqex26zqvwpxkE6HkJdl3Qlk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlFIgN7AzA3zsULl1lyuey9+Dz2gDXqJtM3h
 icR5/bhIDmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRQAKCRABygi3psUI
 JBapEACWJrARmkX9DGZE/hI8fBIDDVdvy5/7k0/9TyFg3XAvBnwIfD4gBCmipg1RtK2chXwzIYd
 YaTCB+YhIraduDc4zMHrItEUQrBaX33oRcsQDoHpIpl+8jFgMvZYejumwotCnhMhIyaGh9XWMth
 BoHK0bf5iUzW+nPz0CB21tD0NAJo79uOC7JFpW4fwteovhN3wvW3fglcBEIfI8jbBmIuuK2IGA3
 5qVD20iehJRzt2M4du+V7HurBDPtyUX2KaFAEjRe1wogOD0xhM4/9VGyawrteSzOkox4xiO2sKF
 PoTkTaVQfpzdtElEXr1iGzHF/OtV0aPdX0fDk2fe8+HmjyFQOWp+0uRAatJZgITH1FzVgnFzh4p
 WylgpiQe1iQFUAK5mTk0C97CgyZPvwGMVMediKAgqMHe8X2p+G0ksahTxNQsObrXk7yAjRrH4o/
 luaaOaUh8cdD+0eICfl46QSRNKDF8+t0sqodYZ5xflNgYde0ZQDYQTAdNqa5ZQKJF9vZmz7Hegz
 +FNTK20rIVVj7M1ry228bt13K/mJLu5scrNfRCxkxjUEUoQYodkQQwtTh9p4VN/+I/yEc8+BMVz
 xrJOcOQTAyDnPoU+Lu9BfP/B+3Zg+TjRBqSukK5GxA6VDVQp1t9ONrJWGHUjr+zI32iNzeIY0gM
 IP7d0vzBi+hNEvw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 974f78cc77cfe28d3c26a52a292b643172d8f5bd..ac203ac4d6eca75655cd590deba5c361accf2375 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -253,6 +253,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t8011-pmgr.dtsi"

-- 
2.51.0

