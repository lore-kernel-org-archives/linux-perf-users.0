Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F77303A1F;
	Mon,  8 Sep 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325743; cv=none; b=n12Npj1MkwXkNynXZfdojVke9dEBnNcoYameIoUjFQJ1AOlh6Rexsu/Y4XBiXtgZuP7zSnarAW2lCD0zgfFN1Kxt/it4cHxvm8UngLrDFXnCeLUvamTNGlggW0LF49ID7F/f4mfYG3VBtDIeQ92zGhUIQBxfZdSn1nxQqNmHLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325743; c=relaxed/simple;
	bh=NgiaadnBWzmQWHLVGXTkghr12q4e2Z2pGwu46CpKaLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfeddLp6cedU+eWyfyW/MOGsp055erqq0IPZxxZNVYkDXSgoqLMbK7nDpinrTVNBNziHIgR6NJI4rzqScr3EdqJ6Sl5AUAQ0/4so68V9A6hcwEGqKMuiujbjIu0Fy1B33QBdCtbYFQ1t4BQXf7z4aBbGT5yuur4UAn+rQVygWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVjvDSrF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVjvDSrF"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso2629591a12.2;
        Mon, 08 Sep 2025 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325741; x=1757930541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj7fG7XAER68na8hgLjfPolxfyD9eQkGEiz9N4R6m0U=;
        b=HVjvDSrFdL/X+lxzvOqmuXGns3mSoQrH3PtVrxFWToE6QCh/gVKqOu8XHWkOuzWj1S
         f4DalBwZyjyLJZYwgFys+7B7qjvfoGFpxPDwnLSbFYx+LMEuKeZClyJrrYWGI2WGDrCe
         LzAIW75amZSacwRYNsrjLU9s6Bk+ec9v9dmTZkKaUWaLyw6IlAFqtx3Q311R2gUcQR17
         Jou47pTiOP39kyUb2RWdPXoDYpeT20vmrFR9EFRxvXn9hmamjz+lc76oK0lppqtmRGn6
         rt+HaEG+r3nWuGktv9BkoluIYy3PXKxeCavnqzWf6BYhf3mbCgahsKrCiQyxI+phatuB
         ZMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325741; x=1757930541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj7fG7XAER68na8hgLjfPolxfyD9eQkGEiz9N4R6m0U=;
        b=oUUz0lWxh4JWRYfbWZq8ZPRr5M169R40G0xW7VSQT58YagFJuyppuS8MbvDvAd+0wZ
         YgspIvNAmUANynkCgfx+mHMOMoHw8DkWZnlEGsJUUsWyItVJNqbWfRcYF9AHvMW7Krx9
         qXp7xdDYIt4b1r1LqHuxY6hLKTztUFrC47KZ/XYsPx2c2VO4SHL2SKOIDpIxvcYxCc7h
         DuaYfkcZ0XsYi4Tl+9PV5fHu+lNsmzPNyORT4xK4RmvbVzhAdhxFe4EcqiiHyx/cqQIp
         VgqrVvNdAvDnc/xiLbSISkp7kyg8JMlBHkgneN0rtvswA/dShf7n6poSBF/qcfFZoNVy
         1YUw==
X-Forwarded-Encrypted: i=1; AJvYcCVyQMb9/0oxZLgym0aUyC4IBqxo/BcDqoJpeKM4EOAb+DrpCd8mKXpK+xKO2cdJcPbotMsIzUAbRp6oPlWpTKTaFQ==@vger.kernel.org, AJvYcCWYl+r7q6Rbn5oE0/chrFZcayhbGpjBhWml6N/tKUc3DFWhT5qr9W2pKZolZ6aifNr4y41gbL3DYpHF@vger.kernel.org, AJvYcCXN0b5ELcbrPdzb/RuD0jWZnkINnsAP+lX1B/Co1yZl6G0zVTYwmvwOd0CVB841N2quvtqAtJobrBGfxkGH@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3j1RQXzMCVbBCMJgSKm6qRBxoKzIiMs0U6NtPujet6uX8LdV
	dbll9/q2luT7TrWEOSzYsuZvnB8SoCbuAytE4ihz27/c8ufyt2oXEkvM
X-Gm-Gg: ASbGncvWKe+hMZEbCpviaZ70OH16N3KnWG0ZpVVYtF3Xybd9/Wu05TsFn66VEXQtIf8
	I/Ol7GpXEADHQsO07HLwZhaH6ASsSiJo3cNHLUfcd0aQjzQbk1qAS43WHNg/mPNG8VQ01UY/Q3v
	4CTINqd6OW4ed9q1ElRbj2vQ2IfwyMG84wBoZHNlf2w+p8Z1rk7r2EmfbHqZ4oX6VbCI6PANClN
	8dwvs8G6YyGCqqvWbgEZgYXM4/FHRG5MLQ+x0V3c/d3VlQXqYa1BlVVMQsSiMTlGByMvIhqwVbp
	LQPZEmhqqtIMxvd90dYnxVyXah5f4g14kyupY+PnmETsxGawbc+UW9PjSWUCD3I74Kro5U+IKYj
	Sp1sXqrjzHzPzXrA+cnhzV1LklD9bqXdYuZRrqd8EtYA3KO1v
X-Google-Smtp-Source: AGHT+IFzBnyCeoSUT4/jKqak6Ru0Kvj/hbUWjk5gn0379Y2ihPn96fH4hCkaATJ2yH9Os2NuxascEQ==
X-Received: by 2002:a17:903:1a26:b0:24d:4a96:7b30 with SMTP id d9443c01a7336-25170e41046mr103171265ad.35.1757325740700;
        Mon, 08 Sep 2025 03:02:20 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:02:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:45 +0800
Subject: [PATCH RESEND v8 21/21] arm64: dts: apple: t8015: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-21-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=NgiaadnBWzmQWHLVGXTkghr12q4e2Z2pGwu46CpKaLI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlFI+V4GoFFzmg6iekYjO3wUQsQ2NoToVu02
 /eVS2sSy3OJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRQAKCRABygi3psUI
 JAaID/9rrnrkkgZNvzI0FIXkGSX4gBtvI+S+ZUhZpHoHLNx5mYa6SzSgxgGtFVh/RB3Ws6QCf2v
 QGDci6rsLtSmWAjeQ+uCoaMJcuSXbGTSiTxM2apn/N3Qa4oRhy96wHLRUCOq+zCdg9ST0POvKGD
 MU2QrOVTS/xAzulU2W6Veml9cV05aLbPnSgAdmlom+gXmZqWsicFUuun1bQzeP4YNj3tYfN85gL
 Kofv7w0kuwRAr6gePgu0je9RzyJZGzY8PhjJho1XYqKM2sboHNKtJOwjHQaOu9zKp1YysVomMA7
 a7x3EwE1STEqEZK3KFwIHFQvYNzVPSSbZJX2thGtvHTmjmdfgEJN3RoO+6YFRclhBoR3YY5l+Ez
 10S/GLNWdQ7MVEbO4C8mBHFrrc370ZfIoqyP3UgvZZFP5itHr/ByW8ENdblvZRvHL1WeCQKZGQE
 3UdpaW3pj2RP417YZdpur7CQmv8YdTxdj0v6EXOxqE+e+IZMp3Jda2PHs2jWOpFfT2QCRfFeQ/7
 RajECtYAJvCdQpNmkemfRYw+APevsJeyXEQhKifsPYISo2NkHZXg/lBZB7UQDBY5v2KPjf54Jk5
 a6R8wk8dredST8Wb+UBF5e028+i6SkVwrsnKOjn/zcu/fu42nEfKXCQJ4bEBlHwf6eIcMY4iqzH
 DF9ti+Uugiot7DA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..9bf5157f0e504b7394ef5354411d3d37e8d5760a 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -284,6 +284,18 @@ aic: interrupt-controller@232100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1>;
+				};
+			};
 		};
 
 		pmgr: power-management@232000000 {
@@ -412,6 +424,18 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu-e {
+		compatible = "apple,mistral-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,monsoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 #include "t8015-pmgr.dtsi"

-- 
2.51.0

