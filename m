Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063DD31D722;
	Tue,  9 Sep 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412753; cv=none; b=D5H/GhPQQC2hwp5EBgqWX1XBiZZHaI93Go2yt0eSwhkoPhPTpr+9ok0+7paE7fIfJV3qJE+GtClPxy5CjUpaYKdcR965dwbKlKAys9mN7GbHDoEMhdsAToNI4Kcz4MO9s0+HWraWhEityvswiQQaBESsV6Uxkni9TcFJif634h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412753; c=relaxed/simple;
	bh=1Mdzq/652LBGyytQuIr/+WYxsQX1eeyePN4MTPuKWTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qb+AQXfNPhKF/phGs+RHCMQL5n9tJ7CdIxdgOFWXAid3HzoWqgTl/qb+NSAA2QX71O8qxUr6vzqBlckt39J0fDpCEVapWpuXj453KMOclCb/hrMXu9zbQg+ztE4MvA0OeN3UNHMrR7tF+Kmo7hBdrcINVtc5Q8v+BtRqwcsS1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL/gAsfp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL/gAsfp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so34095725e9.0;
        Tue, 09 Sep 2025 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412750; x=1758017550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFM4fgZANGXRwrvQV4wSC81b8D8h+yUyMHAkucbMQWo=;
        b=UL/gAsfpJbOzpt6/RUwobS1SXzoeh4ITr5hW0iOJUN9Icg3or+zNkUAM2WmnNiyvsl
         n2UzjweH6+voet5BbvQJqUZVk27uY4+LALxl63wOc4KXla/QGO8TYgDuhLYZp50fEomu
         ZXNDrPcY4LaRHIhmLrD/XM/zJ5frhHuQ6cJounL4kGp765Ksop8vO1BAoLJ+ClT4d7Pc
         KXd8IFr1gbTLMZ77d61vFa41XTjm1STlA69oADbUgCP/ZJKyGyjK8uJbwHaADGx8Ldfl
         psxDisBBfbtMYBGi8ATez0oVk+42gslJ2PI4qxQxlC1Pm6TUSQWERLt/YjMwnKqUC9b4
         WAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412750; x=1758017550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFM4fgZANGXRwrvQV4wSC81b8D8h+yUyMHAkucbMQWo=;
        b=vbZswbF6wP8m4HzOLS/N/G/kc7wDHJOPTwl1hY/LnGYVOlQ+irzR4qWCEMhOgQfrmH
         /Pc4VpovWymrAxSSge4vAZFSdndlbnSDeJFLngOfSK/P4OEGJVfzaMfu1/QmjETclq39
         HppQRfyLQPFzgXKb1syYFz298epw23siSMShoS+hgkCC0HWR16OZqbqXvVCdpZCZJGYX
         Aq+pInksVDk5Oz1ajCHDrWiBMuTk88vfs/Aq71JNerVfHdVVblzqsL/++4S6leIGTprv
         WxU/XYthozOEO0Dcw1aZAgHIPGq38GzZLG1UROkmnzsKWc8AQtzeMPqZ4kRbNsUcyIK+
         Lyfw==
X-Forwarded-Encrypted: i=1; AJvYcCUc1YbFI6mXZHRBf7CrV9QsXEIQylyzs80IjB8psJ4D4lNy9nnwmsNQzLO96Rl9WWHnhh2zFlBMic0X@vger.kernel.org, AJvYcCVJkwOC09GEnkIWixthIFspNs8uIkrd4O10N5B864jKzYiKPTk8TphOnptmzMMDlrqh9p6zJN8Ibkot@vger.kernel.org, AJvYcCVvAKQ1QqUmalIr2kJ+a49lu06l/nbPH91Eb1iAm1Bcwug5DjxWLcMffK4AfcoFbYkzV4EJAhUPp54ymnHP@vger.kernel.org, AJvYcCWN+0dBPZfDDDgo+1Te32PfC9gR6NBF81BTS9e11ZGxbQB9c3ciLhVyPrJzH9ZcZI/nNNo4erq4LZij@vger.kernel.org, AJvYcCXht+/i1IhtyCW+Mj/k8FtTVCukjbEx2dL0yCSQEyPPa6tuBFQ1Ut4/SiCptW/Gn573wEAX7ixCwkNWIgJFtpR58g==@vger.kernel.org
X-Gm-Message-State: AOJu0YylL0VI2c9/KS0KnPkLS1TKj/Dgvu43NFwuT8UbAN2Xg0Q7GqX4
	vBFnL8/EzfCAZ0VDDDV6XTVpUTXyxnl5k7yxcGSO9wdg57WnrU2jhdzvGR7eSn9c
X-Gm-Gg: ASbGncsKiBNBgDstnpEg/RBdG8Vq3h27O/24nGxGgmdYnFUkENtXVxEFJFFBQgS3Tcz
	UQvtXN7+Gq4ma9AGH338vw1fvBqBuHw1zZq3Gbh3NMTs4QjeIq04uzaOVYdgVyMADR17RJZkVrw
	ku+XvGaxvtscCmIixq24NJhfleLbtrx4lkOTNIoRh9OHhZe1iWzIjsYllUa3s7ob1AVmRe8Uny+
	Bs3F0Q3tucgmQUo31qug6lO5zTElbPC40bZGqio6W5KwIbQEfd9Mr/mIP8kof9HtpSY/IoYsz8+
	ZkuAO+8JXUw7pWcYnmOPYfwJQbt9kphyi28N11Bhp3oQ6Du4YaEglpTdQ3gcDOUMlNswukm/kS7
	fHpBsZZNBoco+c8+GtYD4Jt3kbFN9/xina6OFVVRFLzensApKGn9axU6377kYUKTp3q/nUSfY74
	xY7ZaJhUaajYNj9tYqoMsnIlL1Hw==
X-Google-Smtp-Source: AGHT+IEtJ8wCuXdfIRpbS1GqIUUwZYEUFHZ7uVwR4/jyRcbOv5MLRiubr67nXFdjDm1kpxBCCCy3hA==
X-Received: by 2002:a05:600c:1ca8:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45de285c69bmr86525185e9.4.1757412750223;
        Tue, 09 Sep 2025 03:12:30 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm483992105e9.12.2025.09.09.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:29 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:14 +0200
Subject: [PATCH v6 07/20] dt-bindings: memory: factorise LPDDR channel
 binding into SDRAM channel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-7-ce082cc801b5@gmail.com>
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

LPDDR, DDR and so SDRAM channels exist and share the same properties, they
have a compatible, ranks, and an io-width.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 ...lpddr-channel.yaml => jedec,sdram-channel.yaml} | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
rename to Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 34b5bd153f63..9892da520fe4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -1,16 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-channel.yaml#
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,sdram-channel.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: LPDDR channel with chip/rank topology description
+title: SDRAM channel with chip/rank topology description
 
 description:
-  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
-  CK, etc.) that connect one or more LPDDR chips to a host system. The main
-  purpose of this node is to overall LPDDR topology of the system, including the
-  amount of individual LPDDR chips and the ranks per chip.
+  A memory channel of SDRAM memory like DDR SDRAM or LPDDR SDRAM is a completely
+  independent set of pins (DQ, CA, CS, CK, etc.) that connect one or more memory
+  chips to a host system. The main purpose of this node is to overall memory
+  topology of the system, including the amount of individual memory chips and
+  the ranks per chip.
 
 maintainers:
   - Julius Werner <jwerner@chromium.org>
@@ -26,14 +27,14 @@ properties:
   io-width:
     description:
       The number of DQ pins in the channel. If this number is different
-      from (a multiple of) the io-width of the LPDDR chip, that means that
+      from (a multiple of) the io-width of the SDRAM chip, that means that
       multiple instances of that type of chip are wired in parallel on this
       channel (with the channel's DQ pins split up between the different
       chips, and the CA, CS, etc. pins of the different chips all shorted
       together).  This means that the total physical memory controlled by a
       channel is equal to the sum of the densities of each rank on the
-      connected LPDDR chip, times the io-width of the channel divided by
-      the io-width of the LPDDR chip.
+      connected SDRAM chip, times the io-width of the channel divided by
+      the io-width of the SDRAM chip.
     enum:
       - 8
       - 16
@@ -51,8 +52,8 @@ patternProperties:
   "^rank@[0-9]+$":
     type: object
     description:
-      Each physical LPDDR chip may have one or more ranks. Ranks are
-      internal but fully independent sub-units of the chip. Each LPDDR bus
+      Each physical SDRAM chip may have one or more ranks. Ranks are
+      internal but fully independent sub-units of the chip. Each SDRAM bus
       transaction on the channel targets exactly one rank, based on the
       state of the CS pins. Different ranks may have different densities and
       timing requirements.

-- 
2.43.0

