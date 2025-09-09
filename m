Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815503191CE;
	Tue,  9 Sep 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412746; cv=none; b=fgAGFqP43BstmtOv2vs0B/TixS+n+qDmeqTGwD/KnJlZ/9+B8Wzmnbvqdvv60SL+WG/BlklNAT92Ll98j9elUnU+ylRu+R9syaogDQAB0VLVfRYwH54IS19vRLisJJxwJUGdxIBXHpiEQ50GDONm2Yxiu8jPyUVM+YYLB72Gzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412746; c=relaxed/simple;
	bh=2cljBbctUpov7EPp9dHLO/NTrzVDPxTc08Ag9XJ0xdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pt0ybwiAH9E65mUtqGx/lAdz+kSWSk1yFVxhezzeAhZO5ed1u1QkG21H/fRhNUiq362S9rEng7kbi+YV/WgukQwcIfFlKe9O9m4xs2BrxvOnv5Uwv+xo3pcbGrlR6T5LoSGBTEKeYn+pwiqGXG4rW+RSeiuKM+l9CJupQSuPzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7Z6Wwix; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Z6Wwix"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so12357445e9.1;
        Tue, 09 Sep 2025 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412743; x=1758017543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=A7Z6WwixZ+JAIgVmMKkYtTXPr7klNPCELDXF++dWtiJCSlf3B+ADisVELMZGmpZNlW
         2JTOcQcUfbYxrTQ+XDu1kqx2Sc42jawh4CNkizlALJkMM10eq+cfMx4wLu1M5ir8Zsx0
         iig9GrWlDrjg6ZHD6+KL4JBHubyAB6zfr6nVltPwlQqhwVmbWR9ml9/h0nJ+5QjTytaz
         Y8RQiV65Yjv5eTkoz5u1bM61LlroWAvorUwaKeTSW+cwf6mghWkEvQTkBNXjT4QtjjGQ
         /K+lG5jE7CdMXVgo70pNoxfINpMc8IdlAUz+Zy6U7M9d4zxMsD5gu/UAg7uiOfF0h+fc
         Bi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412743; x=1758017543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=W8TGDIvMtuvwor6zHzhd31HppiruAX4fy9Wr866mjA/tmCIcYTpFpVSr5lnhtVBXmb
         VHqPmFPYY09Q9vfs56nXRPwPnGH0kzap9gsi84Ey6iuCWPt7hxaN180a/mA8b/1HieiP
         pJvRnDibJB8YawiFAgNtkoZcQlph8YvVTdlGNxY3OPtVQyZUDZG55IF/89iDuoMxWK/p
         GdCvl3flALm1MI+c3wcz6vGI9HCDNMKR4nI0l0yPgiqFpTRs0QWccnmDdwR+/kPeiY/K
         AW/yMtzTDXyuIiEOyBQ9HuummdaLPUyAeuGAwfT33Zy6/fzDTlYoLiJawTrBGYf7RBvw
         +64w==
X-Forwarded-Encrypted: i=1; AJvYcCUNF4he4ZSonYb1EQ+2iwbx3TJSjgBXuJmwD2Ul30ZVnQPtZbcEnqSr2+ObEOoTvqxLyl88MqID4qFkT1Cfi4c1yg==@vger.kernel.org, AJvYcCUXrNwGDpScbZ+zOe4c0mAroq0fuxD0LFW6ykkeyo2/i9HrosaHXMz0xrh0L7EAQZr3MhnHkMv0/qGi@vger.kernel.org, AJvYcCVKqnjbuHDNx9D60+x/8FeWLpocOC1bCqf/68lGw7WkH2ro9Dpu4E52+SqULP9kayfIILAa04z8nsrV@vger.kernel.org, AJvYcCWCB99r6PXbxA9dSmBeuEm/wEL6Bg01bSF1NPpU302GjBtsnAaid+N83jnF53wY/DqHDOXuNiXiO7qYlwH3@vger.kernel.org, AJvYcCWT2eJwvLNakMXV53HpdcmrcomPoZTcHYahM/Mg3pEvPjcBDyFiEDeUDQObZ1xej9Oj3T0cSAjHqtf6@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSDHZMraB8CQCnAACOZNeboqaXpvnV5iCVoegxgkCn63XSe40
	EbNog/eJz90cmWzfWiuVLrbE3Klv5JlGFhF6/KgnCli/ibkRPcv2ZqwW
X-Gm-Gg: ASbGncuC+yNWG63DYSJ3OIKo1ybIbiywE+ib+4YLrEuv5FObPE536h1lPuilr0gb96F
	EDB/mLdbzJ02+lMhwFYeiaw07l6LfUFfZcNGnqgMIq/deFDT/GcD1/sMlr8xn9DPU8EDzLMvYXm
	Mx0G2VEzGlnOehb75WYqm/phNhUm9pqpB0K5R8OlvbhGgtmL8+lIDHdz3P2UvvhaCOgM5Qr41Gn
	up1brzQAW/gsBmDQuGEmYP0ydCsZ6HUZ/VBQSu6w14kUOF68UkelvaejZ83n4VB5s2IUpbbOLfx
	Pf0UtKToq5Ugsn01ZxXWcrWD0rleVxzpHjntIor6MEyz7AwpuRYA93PfM+FN8GiE3KolcFOikJs
	l0XezI7jcR4Pnz528xltkhIO+hgbEhDvRXqPeYSwuQweKJM/ZqIvQiWPuvPFPNOd2XoLi6sUtbm
	QlVVE5yUnPfF9qpyGrPqjBHMdGaA==
X-Google-Smtp-Source: AGHT+IFNpcDqm5syw25D09i7ExBBWVEcooFgL+UUg7LLOjlL1pEopNlXuqGDOd1C5bTyB3d6ZXQWuA==
X-Received: by 2002:a5d:5f46:0:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3e642da5119mr7865674f8f.21.1757412742627;
        Tue, 09 Sep 2025 03:12:22 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm229761215e9.7.2025.09.09.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:22 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:09 +0200
Subject: [PATCH v6 02/20] dt-bindings: stm32: stm32mp25: add
 `#access-controller-cells` property
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-2-ce082cc801b5@gmail.com>
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

RCC is able to check the availability of a clock.
Allow to query the RCC with a firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
index 88e52f10d1ec..4d471e3d89bc 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
@@ -31,6 +31,11 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#access-controller-cells':
+    const: 1
+    description:
+      Contains the firewall ID associated to the peripheral.
+
   clocks:
     items:
       - description: CK_SCMI_HSE High Speed External oscillator (8 to 48 MHz)
@@ -123,6 +128,7 @@ required:
   - reg
   - '#clock-cells'
   - '#reset-cells'
+  - '#access-controller-cells'
   - clocks
 
 additionalProperties: false
@@ -136,6 +142,7 @@ examples:
         reg = <0x44200000 0x10000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+        #access-controller-cells = <1>;
         clocks =  <&scmi_clk CK_SCMI_HSE>,
                   <&scmi_clk CK_SCMI_HSI>,
                   <&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0

