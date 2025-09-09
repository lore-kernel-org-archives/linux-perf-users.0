Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2231CA54;
	Tue,  9 Sep 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412752; cv=none; b=HAPOFi7+b7Cdr5ReAikJWCPE62+lnkIOFADoWAs0mPu2xQm5nGal0gP8ujI1qsXc1KLhOyEAGTYh1GsOyE//8oBXd/nT39oXDxHDH13AZXsZVy0eK7u3rvvPWecv6t0u2PXz1O01M+PDUMmxg0W+UHtYITOufuaL/nH/9RZLrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412752; c=relaxed/simple;
	bh=KcqNz+oFGlUyIngywh1gkusVO3lZGzNZNpQmz6FCtIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfGXnK3b0XEMm/Ff2XG+M/VGF+uKbinBWVnBH/zZLEw0AV1MoxOR6Wp4h5Fr5LM9eqPF11kyhcvfJkT7rtvmIUYOlwzXvXyPn8UVUb7t48di2JK3QnO70VcPMa7Jcu/46UglB0lrS9xVjMHTgEtVCrtlDWP/tIqgH4NUVp8Qi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6oYsVUC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6oYsVUC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so33094615e9.0;
        Tue, 09 Sep 2025 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412749; x=1758017549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBuh28KbXIrgcfSkQ8KjquzRGwut7m7Az0UK1qF6ohQ=;
        b=f6oYsVUCfl6xO84hJ6qm56ZZjESH20wLz5q6RWSBEKZXUtXYKh3jpOGCBz5UMjupwX
         6NBmXDk85g+87PVpHVT84bFbexorJJw5Qya9JxahYY75NayBud8Eetj1Mxj/O7PAsoSX
         MLMSjie4mE5RLAXfglSlfTTc0nvcjUbsHSPfenk3UwX/JJb95Hwzm9yEYlWhzPoiu7Es
         UHI5bjLEXLjFnnKSgX07DwYHAHzUswEPmQOZeuyWW4DFwWKASDpZuqo+InC8peN8DRCl
         WdlaZE4Mj0oCPXVroytT3tgnQmPZsWW16f5cPw5H1uYj5g8DTISIRs+5Hhl1NeoTqudX
         MxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412749; x=1758017549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBuh28KbXIrgcfSkQ8KjquzRGwut7m7Az0UK1qF6ohQ=;
        b=Hncu4eYLo++7JJJ8cigpckwKM54cnVo4qDykCEP9CxcfoIhVMcW/OyQO2dJPaqHr09
         Tjt3FqVXYDqgomKTGQMN4t4jMCNvVeeXh0W6Z0NEnufBdZ/GiaOkF666yaDTKx20EvM+
         20O0kVzN9tdAtHeA/cnbc5C6S9cGKmDhtSDQ6oG3fT313CrPF26UWIfWCFdbHoXtrbyZ
         z1uUpHw0aAHZs0kOJ7bWYHxwYzvUsf8OHrxzPO74iuSpWbIGFiaXfU1yiw2hp/L/DhM9
         CDxN3tbG07zA0e9y2yZsjknAvG5tYXcnhw7iaEsMqY69Jb55OwS/ky5SQzbna6bEk9OH
         VVWA==
X-Forwarded-Encrypted: i=1; AJvYcCUhZjYaozae6VcwkzB9iKYygwsLQXaDLytEyYjz69v+k5EUfYW0GlfXOZRQkQW6Zu3NaQGGRYqQQL7Z@vger.kernel.org, AJvYcCVSGBP+KZ5Mb1euAguj8jZVIu8Y28JK0+quvIcoJcqxQvf+xsvFV0R4TL2l+2c/r4RjHU5mohr4nilR@vger.kernel.org, AJvYcCWRxzkQyL+uLFekAEqxXCWKy4bXY2mrH6qA+aqPWm9IOuvnlBDavY0qcjuVf72BEvx6cRdIkFgYDoC2EwNW@vger.kernel.org, AJvYcCWz+WvhjUYvQsmfQlrNN/fw3vS/IsOs4QCpaNSk9WvLGHkaGy/AeT1sq1Y8uB39cNhFArpeKl7ou05qpG0zmdbpSQ==@vger.kernel.org, AJvYcCX71BBkfFHlB1cHZWJX79Mq5qDSe2sBe4Q1JVIgpaQr5xVO/n/1CQL0TuoQDWE5GmSBNU0nUctpxGKo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/3eUldRcd1tQ0Nsq7rTPvR2TV3U5wapK7aJ7XGrrkVti8h+x
	WU8+VOCyv3SqU+TwVBH6hhqX+Kw9UA68Bz8J27JmH7ofZN+PRj4VLjo6
X-Gm-Gg: ASbGncvCaaAfgD0KGXU/mzojEFth6OyYuNqfyqeZbLZQS7HA/ud1pABs4yDezQhaW3r
	ZAqKhnZJkpB9LRfOsIiHaGwVWO/bSxBnl0UEMS4IKKFgrCi6SrqjSnQtz/mFYEpEnEM0yJDm9Y2
	tCqUDk8ALZHd3olCf4XrMZ8UyoHf/4km/7Apu0faGfI4j8aOu1WisrFrXy770CIH5H3phTJpPsU
	SskIQTxiYCHjNTRrQ+C9xuz+KGvDhqu1xIWekPeib8POalZ0FgYQh8fwJgdXk1TnFPlKFJjkte/
	/JGnOjyAhjffNM+TPpaT+IZ0F/ZjPLgFDWB7dBZJo73CIhCN/dGuT4cRLbomkdEcjZuEGLPDXG0
	0NPpuehmdFyBtovU0Bn+O9XALoZzh2MAK1mgjfqsFUSC3JPpMenq7Q8aVuU4TC/aRpX9Tr6usvw
	mxKs63EhJzVAnwPYM=
X-Google-Smtp-Source: AGHT+IGKpZNRoMZ6IP/YPEfGuW0EUWhvKOcP7+Jc1iIS/x57GSvJehzCKAQ3NC+/6rTUpYigpfqyQA==
X-Received: by 2002:a05:600c:1c9d:b0:45b:9912:9f30 with SMTP id 5b1f17b1804b1-45de241c015mr86065355e9.6.1757412748701;
        Tue, 09 Sep 2025 03:12:28 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de15de318sm129398365e9.13.2025.09.09.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:28 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:13 +0200
Subject: [PATCH v6 06/20] dt-bindings: memory: introduce DDR4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-6-ce082cc801b5@gmail.com>
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

Introduce JEDEC compliant DDR bindings, that use new memory-props binding.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
new file mode 100644
index 000000000000..bf1dae15b65b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DDR4 SDRAM compliant to JEDEC JESD79-4D
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: jedec,sdram-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,10},[0-9a-f]{2}$"
+      - const: jedec,ddr4
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ddr {
+        compatible = "ddr4-00ff,azaz,ff", "jedec,ddr4";
+        density = <8192>;
+        io-width = <8>;
+    };

-- 
2.43.0

