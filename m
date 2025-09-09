Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6A24DD0E;
	Tue,  9 Sep 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412745; cv=none; b=WL7YmTrGYQs6QcUgpwrTipXpawjH7UanCvasaI7qTnr6np54WX2QLRd86lObb2ryD6H5wjOXtjUYtLFVvgtN/lSvZCLzEZwUOAsQR4P1Ewpu6AchJD4UYS13eauyG704TelJhQFBZFuFas2lThGV+Fq8PKqBqJ8ikZV/kqt9JVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412745; c=relaxed/simple;
	bh=MWx2AfrpKTR83//q16/EyVPq3FEVEkF04/Uc/WS+RSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUaFG8ndfPi0hEBr66E/nqHEiXBnr5uTEymj2M6SWa7LCeGYJJ0bExveNjOqmsZlHIsIi6SgOvhYp+Cv5NH3bhaQ3V2aTGQdotljdADEGnvHjb9VSnoJ2T/iGcDvMUGalrok61RbbyMY7vB7bZnT9unF+sqZtNKHQv6n/e9WlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCYurqzd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCYurqzd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso4662795e9.0;
        Tue, 09 Sep 2025 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412741; x=1758017541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI2ZZStM3cXWCSi8KK5fyFVb5U1Xw6ZX1EuBWF2OM9M=;
        b=jCYurqzdvAAaMnKXdrtzw2zRZShXCLhfQBZHdwjQB8RqvejL1W3gezz9aj3wf+HwIb
         nXBsClgjQigXc8uyoH533NgwCt0cpXyPHbIlLUf3T1dr94lMyLuHU8lNY+mVPp+emNPL
         HxSLecI6NjPjs15SQG4m+DVF+H7xyR9pkhaniX4hxGIOOJvdff8cOkAQEYILTKMFvN9q
         ztZ4bxVjSv+Ele7W+DTJnEUPk0mUbYbzQCC50P02Po1uj/OoFI9NqENK03stJuhRKQ/E
         htmCjyDLlCQbWUt6riQkeMSbtSvs4Gcr1hRGCBMegovdk/IuZLo+NYTWU9A6Mv2IqtZP
         TBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412741; x=1758017541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI2ZZStM3cXWCSi8KK5fyFVb5U1Xw6ZX1EuBWF2OM9M=;
        b=SARwcbGK+Ci7JCOEk+e+eaaUDQmSpUjNU1mA5Ho8NSzlaaJcM37/fOffj1zJV5YWsm
         15GRj2o2Gt8xS5DmXVNbJiDFLMhVe2RHKSmkvvKgQrUzpreyJjfnbgjwetGxmJCZpzpR
         7gO+o2qrPHJLAB4oUTNLCpJjJYDfPwBmUa19t4peEyuWLJTHxemSGG95coXG6zx6502D
         JzmS/ikp2OS+T4H5x97fNTISA8tTkbYg3Z71vr3DQs8JexCKECNaosQ6K90a3cjlCWbi
         SjLWAUTAXFyHrrJNbRfrfBQMPwviFjSk3T9teev3gDOIj8WbQQMn7KGXeZOchAmsZzw4
         FlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQT4REny1zO78r0Zn28I6Bm7tYhNiy7R41jfrSWaHqQuUJbwRf384US+YFAWo7WMrYeokZL4P3fWuY@vger.kernel.org, AJvYcCV+r0E9jiT1P2F9/Y6yq2m1q+WHnteuUAh0TxEulM+t5Pd83HnCaLizpm1vDfPTwpr7jZwydy3nLxBOkiCTennciA==@vger.kernel.org, AJvYcCVuq0kqv8fjK/2jAd2rG60e5U7OCrCSZXNQvnwSLxFQ+0xbisTjt6lgcH5TSch3m3EuIFB8Ep4mq3G0@vger.kernel.org, AJvYcCVvg4YCUPCJph7ur8PTC96Zyp/WcUSfotQkgUBXZMKvZhYB0e3ZtXgYszAtS8lD9Vm0av1g8aU63w5Dq2JD@vger.kernel.org, AJvYcCW1tvz7VAFQwAzA5m/7R5DTsMc0xlw7nSUYyCcVMrCC1/W8fBaRw9w8v86NUEiNWxXyqSoy3zuXgkJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzReOqofFSJ3CX6IFOjgb3neo93pZf4rZ8DbqmEfSbpk/KBQo9Y
	fyXFs0CPvLBvzywF+uvbKyYG8pYbhNVunFScaBFrZ9W4V/KrTBRzFKmR
X-Gm-Gg: ASbGncuUY9Plk0m3w7DDuXhGGr+ql3tWkJaZBQR/Pj6KFB2IahKjH+ZWT3mYbuKnVHh
	8Be2t2LwuVJ43JS1rsh1Zu6l9xbsqmvAWSYQqnqdUBUeyQIh3DV257GvgVWorR8Uyvj7V7WqypW
	3SRUsZYMXvGayQ/WX27m62xVopoDsfhTYiI4xhB1F+9P12LKUh3q7Hs6+xbm3qC4MgUQGYk8Fh5
	8gncjhoGsT8k7Iuv05Xp7KqOmAIJj/PDxXAtq7S2zXtJbUfk1S4FxHJmhMmeTxgytWZr3nKdp4H
	bWre4dAKDb5r0NOpaaOLdIZgQwGU92bpps3fzzXVBSCMWJY3kTRb9rnn2X6+TDSlswcaHRNpkgz
	vZMznRAFEIEBL6WPbtklkXUdmfKipB1OTPejxE0iVqtYmEzxF4ZjzzIx2X08q3tqdZDexb3C+2c
	PuXmYMNYp+KBfHaRSaoE3BK2R3gA==
X-Google-Smtp-Source: AGHT+IGMq3YRNccUPXUDuQKWqwTrrYGimoWd2y4QrCx0yTnHMLewx8Uj16eSzaAZy993XHeIO/nPgA==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr98422505e9.24.1757412741076;
        Tue, 09 Sep 2025 03:12:21 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm304908725e9.0.2025.09.09.03.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:20 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:08 +0200
Subject: [PATCH v6 01/20] bus: firewall: move stm32_firewall header file in
 include folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
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

Other driver than rifsc and etzpc can implement firewall ops, such as
rcc.
In order for them to have access to the ops and type of this framework,
we need to get the `stm32_firewall.h` file in the include/ folder.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 drivers/bus/stm32_etzpc.c                       | 3 +--
 drivers/bus/stm32_firewall.c                    | 3 +--
 drivers/bus/stm32_rifsc.c                       | 3 +--
 {drivers => include/linux}/bus/stm32_firewall.h | 0
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
index 7fc0f16960be..4918a14e507e 100644
--- a/drivers/bus/stm32_etzpc.c
+++ b/drivers/bus/stm32_etzpc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * ETZPC registers
  */
diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
index 2fc9761dadec..ef4988054b44 100644
--- a/drivers/bus/stm32_firewall.c
+++ b/drivers/bus/stm32_firewall.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/bus/stm32_firewall_device.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,8 +19,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-#include "stm32_firewall.h"
-
 /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
 #define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
 
diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..643ddd0a5f54 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * RIFSC offset register
  */
diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/stm32_firewall.h
similarity index 100%
rename from drivers/bus/stm32_firewall.h
rename to include/linux/bus/stm32_firewall.h

-- 
2.43.0

