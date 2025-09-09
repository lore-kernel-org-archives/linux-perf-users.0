Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61BA31A564;
	Tue,  9 Sep 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412773; cv=none; b=A2BN7nwvhNNQz6+JTPrYyZ5e1eRNhyESOnaiMDhcwEpNqsmUhJ7/74ZAc13Fg9h99r5a0ZrM62ZW3iVLRD2wjS7PxFCgB2izd4Da7jeJTarcWPIFg0Qr2GFL2yvFP0KB1VEXgMKuXJshJ7paFwJC0tEAMAUM6aRMy0EtduuFB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412773; c=relaxed/simple;
	bh=obnUKXEV34x38ZapSXN3pII61fMG/MHJIkw0EhSWfh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrgsoFrQpw1cHFzgorylxzR+cPvIGfa3aX6FMhxphPIk16qqXqJxntK4e0hqFVMS/VVqUzGr4fYoU2XfRRiH/l3gCqnvjesO1TqHTDJXUx9Tz0qCMitljXHlUCUUKFssnCp5xzGotgRpdIz7YZipWRB4fmwIYFsfaLOuRmXCpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyBoVBzK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyBoVBzK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dea538b826so4642702f8f.2;
        Tue, 09 Sep 2025 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412770; x=1758017570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqkLiWItq44+h/R1+EtYWkRm5AyzksHBQoJeAh9biR8=;
        b=eyBoVBzKQJWFHz/Ssr1461fGg5lSNccd7AI0niFGz29MEgSnGkJXGmot6Zpm794LTr
         l3nR1vts2rgOdIrASw2gRTL3KOKdQ//Zk3L8eESokZOu7Y2NaeoM/5Ralx0X3DaqYyb0
         qT+l+pys7LsPBbUNUwvtEEY/rzT2RkC8wHZESBFNNJKTOIYA5niU8n/TpZpGe63+GpCP
         EsMwNClUzuo3Zj59iGEqEpymKwhmv/dJcqmtaUjtMEIRS8OJwnVcSnsn4o3jwWO7+5gA
         Rb8hIwyJLzmRvBnRdTqMfUyPwNEZX5EhMK4nK+DI54JV4Ng2ekl/11zQCQyuaEFtKb8R
         4pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412770; x=1758017570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqkLiWItq44+h/R1+EtYWkRm5AyzksHBQoJeAh9biR8=;
        b=k/GXSlIAPVt7Mq86oA66lVt8BKR+lJZKnCM9hO1jLcFEe6LXfG8WdIpJZQCZsKIsKu
         xKNX+khgP50r2BFaJ2AVdl+9//7JHkM+ac4bJnidneh2tsuVCi+fFLr/ROR8rjrAgqmP
         t9tHowMcf2yXxAwuFa1TwLr6zmFbVzIUqjPWtba1Ccc4gjSUdrVfOhHKX5OWVxqSYxte
         8/wVvn/zIBqfUgT7tWRiiwIt/r/54vpXORLshUJMPPbrn50/B9oB4Tu3l3FTwrNJ6E3C
         /Tw0HhM5jhVImPix5CO5l8kOs6U5/M8R3BN8b6DjZwZ6jvxVaTRzoIHfKT7t4zVaBvQZ
         Ctuw==
X-Forwarded-Encrypted: i=1; AJvYcCU4UFW67wOcoKcxhnBbPXpmBoySfOx7kU67wGtZP+gbY1NR++NOcQx0tVck2tYnsBXd66L/boxHzpUB@vger.kernel.org, AJvYcCUAU0LeL3F4Py5ZiCAdiNR62msiaeZB2dUrrekpbJHtt0gBcvKrtG9upc4XpHy+cmHVgTBm9v02IG5b@vger.kernel.org, AJvYcCV+6zCmIYbAwhj8bQI+OD/Vya9KheYDZVSOjp3JBYHgs8fSjIiuleU2FON6NRFDOW+QcKnGp9Xm7wL5B2hrF2Yzvg==@vger.kernel.org, AJvYcCWEugXdJT20NZP9aXHBZ69gvvwTNayxs7R9FEbhJa9eod9Z8lO8EeCLYFuAiYL4QszWAU+EE9JgsYQ8@vger.kernel.org, AJvYcCWq7itShB3U76tqlisfn3CFBa/QUqOLb1r4tyVpvC/2rJp9AS6xHTrReMOaARaowZAQPygCqYq1FZ5UNRpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bh4/qBelKIvnfjL+1n8FY9rJ4ZnVIsNqIeXvPaMGFNd3pV8n
	bjlQKvbQH07IqabRTk+jV8dzFH49fuIJW/xJcDP+G6j099vVfgaG0GZ4989+Ml2y
X-Gm-Gg: ASbGncsdkH57HaWKE+rX4VgV5bzeH39LhjyQRbFBLUK02FEz+OKJMDo025MSlNYywBv
	1ZECX94CForV00AA4q+0M86gtU9iXXyArvt7qM0KTtFltcoMMzJcFPkC7LnGNB2x3Xx/Z4ylN4u
	g9IIAvc7dlSc4KhFHNctwzPB8KgADYaDC+l3tgfVI5PW0ZPFvpzrXLx6uurEl1U+90aI6UBYKOm
	x4OBSjWTNy/ntoDmnXDCkmMRQOg7CGT5lFSCBF9aSd5xdwGiUnOMFj/33E0Cnyko+bZaB6ZH5sG
	mg9ar17Cxe/iaqPEwGEpp4a67neQ8+3/h2reJBjEfxkFIEDjOlyhXsE7XvVim0QzW0N37oihOB2
	/gdL9xLsvZr2l5qHvXrFtWOHmaxBh3GhCgzTCxeDQWDJcUOPMmNNBWSkn8fWOwmWUMPcfrWVmFV
	9/OOYwqLWsN6zRQ1g1S9OHs6r0ag==
X-Google-Smtp-Source: AGHT+IEb/Uh0bOqYUD5CpTPjyWpptnA7lRTRp1bQevh63jpbLTzKsCg28IzONQcxTOeXGoqoY9SRmQ==
X-Received: by 2002:a5d:5f92:0:b0:3e1:4d93:5580 with SMTP id ffacd0b85a97d-3e643ff64ecmr6456919f8f.37.1757412770106;
        Tue, 09 Sep 2025 03:12:50 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfdbbsm2111014f8f.10.2025.09.09.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:49 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:26 +0200
Subject: [PATCH v6 19/20] arm64: dts: st: support ddrperfm on
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-19-ce082cc801b5@gmail.com>
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

Configure DDRPERFM node on stm32mp257f-dk board.
Disable the node as DDRPERFM will produce an error message if it's clock
(shared with the DDRCTRL on STM32MP25x) is secured by common bootloaders.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index 45ffa358c800..81b115280bd4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -84,6 +84,11 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ddrperfm {
+	memory-channel = <&lpddr_channel>;
+	status = "disabled";
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.43.0

