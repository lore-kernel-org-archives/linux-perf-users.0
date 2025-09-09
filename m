Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4531E0EF;
	Tue,  9 Sep 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412757; cv=none; b=qJcOUltDCsYmg85Z/cOavKjfq3gy5DMs++4tm9O8LOh2KmD3LA9+KUaIWvfQ1/Zlf5qUvyCGtJfiR/vAgqBfxrhSKWKZ9PahbkXyP8ZTQ1P6MZ98vcl0J5/UIHNnAqb2n2bjMJzGyqptG6vlT845/gA66izbuNNyEnnL2hlc1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412757; c=relaxed/simple;
	bh=p6iwdyUUP5W8+77ExyG+J/4KTfuGbStSzXc5YQJ6uQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7qyLbGL1Cj3KG6XvKckWTn3GbrOYAB5DMX+T+YYTix3c1Ke9jdMx8ND6V1NFG5YzKVqz0/kPq16UiO+yusaAxLGbhj4Gwcb9jQB7Ab+fikYYz4Pr36C4+1/fuB1daDhaQYvJ40UCBCG1zu9AJlvGJ1ipPyfcCwJ2HAXjKcSIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q65xyRJc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q65xyRJc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e751508f21so426746f8f.0;
        Tue, 09 Sep 2025 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412753; x=1758017553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=Q65xyRJc+I1aCUPdFl4hOY71U5yc0UxQj0XznqcNOvc3k0ycN68AGXfphxtQHidh4P
         nJP1kn3K4byBty7OEfvlZAvm/Kg+NPYx7/GIu/Nd9WhRHtko2cfaU/84TZEQml9Zc2Ig
         gWPjULor/j43Pqa0p763Eig/ZchNzbpPY4MWpYaO7irW6Hc0p3cS/Mzo9FxZv4tTD7cp
         TGtZSHfgIqf0wleHdPtiQAgZfozDQOG7QKCnLGsNLCSA1FOkbM9Xd39lknJ8oleBUXBf
         VNa4G9dooY/zfP37TszJtvPhfCjEFFC287hh2A+La4ClcfHmcq4b6GZPNNZNsQmbiPWC
         qoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412753; x=1758017553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=Zsro16DTzm7MGG8AHGqT9VdP3RjogvlgTD4ZolJYJbrUc/Nn4DVnV4SoiLMxfiPFx6
         /3DichcILD+zvIPNuisv2wsY8wY+8UIU0di/ovIHk+ku344dqCNCosvgFoR0wvbz7vW5
         op7dTv31Z069dhj/vWxNKuHPBaHhGO7q6wrSermszhaRhiOGBG61eS2vtG+n6NPSWTJK
         tKJImvOQI8gniR1+0NlqvG7Ers1SAMHv56Pmt7+gwZiba/KBxtTNevgC7+7ugSVVQh9T
         93L0IrL5MgSB8JKAuSy+hxIZbg499zxuK6xdCJz3E4k5n9oD4iIUFx7Iz6OC5aK8JCH+
         pWJw==
X-Forwarded-Encrypted: i=1; AJvYcCUPjfY4EoqF2grgqKPJynichF84gke1LgI2vxg5E0oUSpnazkiMGuxos1fCQBBbAtnh5XQgmGobSyUE@vger.kernel.org, AJvYcCUWH7+zzT3ln1H3FxuoobZlV5eSAEYMnktd+ep33jTcOaUBBRZ39h4acXYEZZ1wOklu08zyMlw1jEuz@vger.kernel.org, AJvYcCUvqwq8wX00/oRtyCx5QWKMD2LGwSZn53PkUdkmxt9aiDPwBxkVTbcoTBKib/aqFTI395KE+QqXfNLlOcPQ@vger.kernel.org, AJvYcCWswe0JpucbF5XI2J1cG4DI00Xq9uFOO/sh0RHfUtiHk1/3Wfq1R1IGmXLz8ZOc1r7BuA4IzOFy5Iwe@vger.kernel.org, AJvYcCXcgZ6xxMky7a8+YCpPaodnjlBpBISDrwZdVF1xGAFA4ePp8LCB6KLyu1E+a7L0lm1D3khK8WO29sa/9eryYfjVrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9mOltqOxRivJf/B1PLRV59RDTfixi0etX79URVqfVNhWolIH
	IdTC1CnZ4LNFj+SWuBlfTN8pHtJHFBwNyZbucjuIuPsPmI+tnHuT1nEv
X-Gm-Gg: ASbGncsJ1qcrRarfZsAfH9UFPVUJzGUaWADYugTliGjkRfv0B+e2DbDa7AE/lx9NOeo
	qFqLu8qTAabHjtxnH0bP3gZhGshFt3x5iPgRhYT3Vn8BNw0CmAIIVTpY7cwRkcFOud7cUUQ6HGT
	rQIq6dDd48wm3nnwZ/DMorIUy5kNWiVeXYB1vbg1nZPHjkRfYtHWi6WntF63n1ZtkM80qqRTyff
	7Si9jExBcc0mPzDaA+5ayW/QvZBVyZ7ncpUCiPNZ2iVh+0cUqYQotR+tf1rz5tmgbblrw8zb+Gl
	KhpV5U4ULAvL4FPevTIb3n1s3kDqEJ80GXv0KkU7BPE4QldN8Jc2u7rZucCWyujzMQvEw/oY5Yu
	xFSErzA/d2Zgam8Tgi7mBjym/JaGQ3tFFnvwZWMYonNwELHcX9vBiRgujwk7ShZm32UZqD9FKzy
	ysqTCOzimwkHuS6s3xD1CUt97GPA==
X-Google-Smtp-Source: AGHT+IH7hqeCncC0SVXTGumU9OSJ/aNPQ9AiaGhyarE4EKX3TbC/TVNGGH8t45lQyiAq41/6hdfmvg==
X-Received: by 2002:a05:6000:2883:b0:3e0:57e1:e3c1 with SMTP id ffacd0b85a97d-3e64d22bbadmr8510036f8f.63.1757412753401;
        Tue, 09 Sep 2025 03:12:33 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f2e5sm1994403f8f.52.2025.09.09.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:33 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:16 +0200
Subject: [PATCH v6 09/20] dt-bindings: memory: SDRAM channel: standardise
 node name
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-9-ce082cc801b5@gmail.com>
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

Add a pattern for sdram channel node name.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 866af40b654d..5cdd8ef45100 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -17,6 +17,9 @@ maintainers:
   - Julius Werner <jwerner@chromium.org>
 
 properties:
+  $nodename:
+    pattern: "sdram-channel-[0-9]+$"
+
   compatible:
     enum:
       - jedec,ddr4-channel
@@ -118,7 +121,7 @@ additionalProperties: false
 
 examples:
   - |
-    lpddr-channel0 {
+    sdram-channel-0 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr3-channel";
@@ -133,7 +136,7 @@ examples:
       };
     };
 
-    lpddr-channel1 {
+    sdram-channel-1 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr4-channel";

-- 
2.43.0

