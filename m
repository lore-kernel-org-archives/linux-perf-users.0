Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FF31B128;
	Tue,  9 Sep 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412749; cv=none; b=V86bJX1e1lfvqEXZpq1wiA9J3FB+fbqgGpaCZ/jC85q8eWCc2yCzIPAglawzyKGpqXiVCkxseCFFk+P3FmLtKDazxkBkxz4z812gK87ER50eB2bT/ksrQa/F4RMmDQTFeL9Pz5p3Q85WQaez2r/acFRBVqOoIWal+rGSB2fye9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412749; c=relaxed/simple;
	bh=jW34m1dVcRktmghJ+wO36JmqpXfoGmyvLM7Vm/SWXcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K16hETFTeWlbzfmy0iUOVeWJa1UMh+KlIShlmWNriIbxT+cikXHH7eE30jHGzWy0A/lxze5nPYBgsh10+J+Fjxb9HiZ2r6gxkqko993v94tp61kpZKwW/X+zvHL13xz78DrR5xueaOTQGDpidfdvUnBxu6Mok1JL3ibB0vkFKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2taosm+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2taosm+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso47908965e9.2;
        Tue, 09 Sep 2025 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412746; x=1758017546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DybTmKrBLOMD6vf+9QLzWDpmjWc+lV91VxrSnOsEhLY=;
        b=c2taosm+J3i047N4I+3PZzQ3+elYkM3TqAWzWzL157IVbhxCTQedNpCclJpX7uOlRS
         V8jc2uWZk0VSNWLAx7JpBYYUR4vuq8QZYt5UX/44St9zQU8ConaF7dKXPGEg/OE6mXFv
         qOs3wtijHqjDfIkupm9yPJrqS1yHwQhzqlVmlMicDFwbf6VbH4tyQnZ2IKSMh9miQjl1
         rS/5iwfndirJLdmB28DeUOHEXtShW3RsxFDbddRdzRxm4LWBhy32hFr26AIItxxM7QCM
         oPxhXk0FOlYgpO4eMuPQMq5Qk2MQZdj61vawuznh6Re+Qn7mcpIGBBNxV8bGcGrDClAr
         RSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412746; x=1758017546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DybTmKrBLOMD6vf+9QLzWDpmjWc+lV91VxrSnOsEhLY=;
        b=Z+AHcJXBFk5YNoBiTjGr++msMKTQxzKb+KKX2JcsAU1OUdHb4MBGmwXlurHyfwtZTl
         CrlsbwvMAuSR54vSbxJtC8eu8aQ4QVcolPkwj5HOqLgVMgRLXBjeGQ93h9sOe05ly3q7
         q58MkkVKsNxwSMKl/agA8PHJ8avU0nyiDvXn0P3W9u4gFqTW8CqqBVP00VGsjala8Tqc
         2ny57n0g95gysq8W8IxVLd1btBkhQjkZ7JaESpRFjljXUqXIBoGUsUDu/Mq0cXCioSLr
         Bpi66YwZOCIrSjtTqMFGdOKdObgVz6+ivqiJoqJut54hdFnDXupDPh0+yWetd1/ul43U
         GwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEVF22Z1PISTQ4fj17l165Asw+/EEV1GcsCVnk4ZieBX/gvCYkdr1hOvs2ho7lX3/ic9Pex+B9IAJr0o2a1trkAw==@vger.kernel.org, AJvYcCVg3wGaygn0xIjjSauGEaprwsizXIjB6h28jtfQS/aMrC9K+KG5L3ML2OVx7m4y2zMxMm+75IIgg/jYNbrF@vger.kernel.org, AJvYcCW7CJHHs/mX2q96nqUafYe7dJN77vGpAmuW2OQlFraaJliMuj2CwqnmpqHbB2AoALi6T223+V97HSl0@vger.kernel.org, AJvYcCW970Fm4fHufQ4qc7imXuoTuNO3+2cS6+s6H0G9gTm4qY7DYm2F7BLrnsb86HQliOBS6lVPETCP/kdc@vger.kernel.org, AJvYcCWm46BiHTguzpi96+PzCzH0ZX0tDpsSOxBA53dNdWuVorJOciz69bnqtswOshCQ1w8D5ZlgOV6grJT1@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtpLYwSCkvEmm4jFFZ9WyltRTgqxHtoo+5s7BHHJoz0kETxtk
	enJeDZLUPlPo3UPWUzfQWeLf9E1ggN5sRhWsuoUaJmF0M/PmFDzYYZke
X-Gm-Gg: ASbGnctQAo9LzEjg1iMfaK4gZ77u4q7X7rf0hgE/Wb9Bff0ZAsDSfpJnSxPU6WZNRew
	tBJTDlzrJzu6+Fux8FWlXTANfBuGNq//K/UkfzIS8tPjUl8nrO7KiebaGa8O1IqF947Hvo43ASS
	vanVzOwX8HtQQr/6CfpJ91THLG/POHBfr4VB5yY4Vd9gedtMxvqu7FvZzoRDwZiMMfGBpfF6u7H
	x9aTaTBpAiHEZltK64X0nfd0duV7sDXqsp8kqenm9QSeAGN+rqw1FLOmc/DDn2KgHVZMFqKDVcb
	giXTe1kgiZM5rX0jBo5rLm81lMZqHHAB1yWSkvsLUOXVkuXPr4OjFNu7aewg3cyQgL38Xx8xc+e
	AZOxDOzbSweadAVvMIr2kdnFHWA2vXqjk3b110sh9teeiRIAp4bFGm3IhUalUNr1fDwTGi27c8v
	9mBFxkqlC0PQ1sd74=
X-Google-Smtp-Source: AGHT+IF3GDagRAyMPN5BSQODUHSp0iGmT0I36aBlmWYUaQ/w665uvtY5Iu4mjHI3U5ucVSesodrKQA==
X-Received: by 2002:a05:600c:4683:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45ddde9764dmr80596335e9.14.1757412745694;
        Tue, 09 Sep 2025 03:12:25 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm334757015e9.21.2025.09.09.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:25 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:11 +0200
Subject: [PATCH v6 04/20] arm64: dts: st: set rcc as an access-controller
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-4-ce082cc801b5@gmail.com>
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

RCC now implements firewall access ops to check the access to
resources. Allow client nodes to query the RCC with one firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 303abf915b8e..fbedf23def52 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1677,6 +1677,7 @@ rcc: clock-controller@44200000 {
 			reg = <0x44200000 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#access-controller-cells = <1>;
 			clocks = <&scmi_clk CK_SCMI_HSE>,
 				<&scmi_clk CK_SCMI_HSI>,
 				<&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0

