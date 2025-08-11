Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9D2E1720;
	Mon, 11 Aug 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920607; cv=none; b=CTUwTY6li1Aj2QxJr/L45cCICLcy8nI+GBSJO+LJJupx9SMhY6foaBUQqP1IyBP1hP3SIIga/c4Uh8cy5MXVpBAJCQCc1NO34AfodbuwX0z4/TO1xEmFPpZYf5gLtYoiKdIlyB2TSRTxGHUpQnB8IMqTzxtY40I2PEx8BQULPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920607; c=relaxed/simple;
	bh=q+65zojFG1TGAHucNLr5jhX152q/m6db3+pGwZ+9s8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCSWvj+fLkpbXGdANWnUzhylVkUTT2GJ9iHCwUOWTDMjm4jFZIpe+oZIMi8O445XPiMJq0eWDznthsfn/fOrJgU425Hc0qSo6wcAE0ajLb3SXZSVCHqjH91HBcSPLDBLMnHZ4sz5E8klQQ5ENYOrj5xiAauf6jU2Ju9O7UjT6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHXs43lI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHXs43lI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76c3607d960so4564544b3a.1;
        Mon, 11 Aug 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920605; x=1755525405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STrbsxYWItkqEzAymOvwmHkPYbP8QDJrOdPBgIyV3j8=;
        b=DHXs43lIKqbX3oQmeywGpWo6Wzo1DM+jP2LggMaZJrZCUmZ2arTEJPUiiOoYXvMS9M
         FfAgDi+vE61d/YDGl/WF8CIGFPgmetddY7JU4PqYXjzTGgFTg1A3LAJx2ydWs/I8BeeT
         1tnatLwSgluzwSHafdGEhwrM6DJhEHZBvnu4Vvsu9Woa5U53lyZfmudxRA1IQN7d85wR
         KPfZjZpTxxVnChqsjAbasBTKsJwI5SV8TziAfPB+TCl6lhfb9lYsTg+b6To3xn+Yw+/b
         cUqI6QWANElMCbVmQEhq7HVjkqNWSSZ6+sjwiJOxYPa3WpJ/rSUpSrqmhNClENq+jMdI
         AHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920605; x=1755525405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STrbsxYWItkqEzAymOvwmHkPYbP8QDJrOdPBgIyV3j8=;
        b=T8qF0eLs68g28JD/9F3UxyUjZZa1wMBF/H5Em1fI46cwIQN0GnLylJbTAJvyVoo6i0
         KxPQLiT0pBV89zW9JLLfpOHks5Xnqb6cyomkSaLqzx/LWtJYRq9ZGN9zYxjOnmk28X39
         thYUvC1yiFQ/v+6pQxXx7PN7F0ddR2gn/U0/7wq8ej2ju82y5txjiuznVJ+4UgOFJl5J
         3M72gUXT7rB6+D5CmnwYl/GKH0gj0wc8wju58U5DyP6D0yzgiyEc2U5jj6BDM5fZIrzj
         r8YQXfsjGI222uzsSGSJllbIzo27IQlmLhMmmuQWolzrnXGxFGwakx/p7Q6NXV+yOdaQ
         dHlg==
X-Forwarded-Encrypted: i=1; AJvYcCUfFnLr7wbs5TyIDPsNJmmhyyPeTxEO1kB3bEZoNKcJUL9hElHM6KRpkt3kC89BupcLh9ygkgMIfRkxaoaK6s4mPA==@vger.kernel.org, AJvYcCVvDeTZOGutvgLr8p/24zbro8r9Tv8QHFN6XzxKupnEhAc6tBN59/UIl4bxMo9+7/izV1WYnNZ/jlap3yKh@vger.kernel.org, AJvYcCXXnNof3oxH9+vxOb3V1V34OlDZJ31/SfE1E7jW4epD7CNAmy/pmoBJuyxGLMqo/fzUVhT2fAg7DVHl@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCNzuk5OKl/fjGg6IX3doVUpHFVXzaD3mvLQIrPh1115zw6Fi
	lMOP2i5S+Fkkmnpm3GH58Tf3XVYGeOvUfT22nja49nUrldSyVhgQF5lx
X-Gm-Gg: ASbGncu5u80t+HOV1mk/SjN1ole7uA93wfbDxSjUszLFz24RMSrH5Jknr5YyRXH7eLm
	nsurh9bkKoB9316VdAbUkFaCjUCdk2LezpwWM9SYlco1xSY5p8Hs2I0M7bUAy9HdVhrJHnS2PnW
	CgQJXoKhDDv9xdW2LjWHDXlyk87EncglB0RYAExeE4R+KaY9PW1XxLpsw17Azm6C8TDbd2B5qZ3
	QxvvNL8e5jGIYUosTKC6APFKY9ElTpUrcReoyT2B/Qv9ToDRXHzrScWXXHOwY+GzqJAV9AYL9V0
	TDOT5aEZHcUsgqQV5C3yjSALAwMTb1ZyuWDtFxShg+Ht1pB4+iLuJwo6/6xsouxHVm+ERnW0MZr
	LFZQjEp49IVyrkghi/3AaCicKR+42zL8qhyRKx3ktV6toWNMzt1TOnjWVuA==
X-Google-Smtp-Source: AGHT+IHBD2IYxmueKQyOcCYzWNBHtwL3jKLlI0OgxIqBd6mjfZItD3c3k99yQtX3GF1PY8NI7NniFg==
X-Received: by 2002:a05:6a20:9389:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-24054d84f37mr17824995637.0.1754920605437;
        Mon, 11 Aug 2025 06:56:45 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:45 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:50 +0800
Subject: [PATCH v8 18/21] arm64: dts: apple: t8010: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-18-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=q+65zojFG1TGAHucNLr5jhX152q/m6db3+pGwZ+9s8E=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZDWavEb9dp72TKegs9MzgJCqQuluiaAYYYK
 25PHqyXvMOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QwAKCRABygi3psUI
 JGe/D/4+2TtPJxUdQMwe6Rx0KfNo3BxF4xi01/ODm0qd/4YMWc4Wk3g5FY7fiHbSmurf3T0uO9N
 T/6P6vFc49AerjPlmWzR2hq65X9QTq6PY9uom5cQTp8R2vc/vbg3ZhzWL/2m9O66imp8jsvz/Pi
 x9eTivGP5M7JVpUBqJ9LoTMl7AF/nGy1RqMaiD03iFaJhKjuu3/W/L3NvrXAkU39V/a424tks5E
 cWQYFJ4gz+XpEa3Osfp4PKRjqxlOxfHYLMRMLbpwsHAogQ0Z8k64jr6mMGlnyKOdfkn2EV3aOxW
 s18L8MWW5S9JggQoyWcbhloriXjVsN26+i1+cFTADNZo8/1xRbOdNEeZvJ5taWuyeYTZ2b3h1KU
 QBXsNb8prJIG4LCSLCIllDIsAzTNPkaNtaq+pMWZJOTt9nO0HpMDC/eZQ8tTD+cpoucPp6Q7o+e
 ED2ucW+2gAjmbiWm+HCmJ8DfXMll0rBgy/f/9B3u3ccDaduTz/CTgKK42CWMpQXi2GKdiO7Nxse
 uUQRsN6gkvsmvDBJHQPck10E77oNcK7BquLod1zMRCxqRswJTY3QbhBMc5XVkIG03seXm71w6T2
 lYs5Q/+sTtzmZRkYPE7pHyEj7kW6bKCmfD36y7cmX+OezPXuGNRUF5fzt0l6zW6bZ0dVL/6pgFY
 DM5T++v71Ulj5yg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b961d4f65bc379da3b215ca76d5f68691df06f4d..d187fbf7e7a214cbbc1027034efd0724ef7f8b83 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -256,6 +256,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8010-pmgr.dtsi"

-- 
2.50.1

