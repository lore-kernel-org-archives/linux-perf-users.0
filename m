Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EB320CD3;
	Tue,  9 Sep 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412762; cv=none; b=Lq7O13pZj4mEHS++OBnnZemmu8Mw5ETqa6rCZEjzWsuuputbMU6IiK/JM4tD2xVtPk6i4d+Xte4SxhBxZw57rIxji3+KrmpMMoDmdF/fxuzw3vibgEsyf4NLQK7W7pO0hySsk9j5NW+Ozic8T+QI6WpWqX/aq47NoyeKYcWAULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412762; c=relaxed/simple;
	bh=GyiTXqXxhJBrIubXOWXlnPPZTxpoJtU++ZhWb6rU9nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/eHoL0RYBjtdEc7FogMjk0DeER2DQKg9lRlPCJLzAlpaCvguqi6JgoeBFYnxz+JB3seXdOpAIiiwFyfR2VbeLVwVpFvxPkBDxCPJTy738grr3j5n4S3Z/1ryPGzHcaSSqZNaYp4hd7V8eDJYq32YgJ2Jm54NIReN9ReZpL/oBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF39mDDJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF39mDDJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso6109535e9.1;
        Tue, 09 Sep 2025 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412759; x=1758017559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hrS+gNEMWDxV0mKXtkhOcJ6h8ajN29VXW/74N9mIiM=;
        b=SF39mDDJnSnLRRrwRSFKvn/MVZ7LBja16RTb4shzaUMKU9t1/A9s7Ih422Y9SkaxQs
         tijCaAgRlaB+hYZotZwBFqt6wqyFUJzH+gPfq+kWL9jLOxvmXlV6KBZRSEzTjVVguQKT
         gCs5GlveyHMs7xIgJ+zlZyFSXXQ90CGVxBqBhYvxcj3N6NA5KDu181+aRbvRDK8esgEs
         6JaHUpdtE4w7KPQMFSbWxHaU+6WM9P/jswRR3gPZrt/O5acwALKg7tMvZMOYkXK2sC8v
         3bIRS8ucNlh9ij4v/ifrU/HnmNERItmN48WFVA5dj7fhSnneTzG59TqJiP6WC+/0BDLH
         Vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412759; x=1758017559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hrS+gNEMWDxV0mKXtkhOcJ6h8ajN29VXW/74N9mIiM=;
        b=bZ0V20UTlRntmQiiOCpTdDPfITcHweeOVhUaH8onolvhakDbgXM6vzSfYnsuiHVzDE
         fOaguFv2K6FPFuT8yEU9m11ZMlSis6bpZI6w4DaQ/FiLIMjS3BnISbEcza+5yzulpKin
         V5V2E6GZusCXu66+K7RIvMQuIUnweN/M86I5ObPfgYordGhKBdjQmUa29iT6K7VFrZin
         cDT6dr+5Zmjk+TIpM5K3B6sYhdXrYiuQE7MqWt/BNPpVDCx6xtrXCFcRd+c7SIQFbltA
         moggnO9QAsI2Ec0Rv6pgL3uX7UMOIGbWzdhn6TE1VrbNH31ykbmZ0fxHkVbwO+KVj4/h
         5WUw==
X-Forwarded-Encrypted: i=1; AJvYcCUMMaw26hEpDgX0q6FLyvWnnTa4kceH+8AXvNLOudIvsd17wzk+4EI6XnyDF/j/+1Ilype3mgP0qobR/XXlP/GJkw==@vger.kernel.org, AJvYcCV0GqTgGOJK6WamgFUJcH/lZiaSR3tP4zliZ1WAFDEnttvUZKi5tA5f3FwS0MejLAODWrKDEgKa9cgO@vger.kernel.org, AJvYcCWsr49UTAFNhKV6vftEpA62Dvr/8iyDVmNXQhR6hahJVsqDvS2nkf4jp52ixqpZ8cWX8Iz8uMS6IsOa@vger.kernel.org, AJvYcCWu7+LJukmEIuDs/2QBTVzqTaIgFECXoPFJkudjxmqlOO9AXuDAk0t5LkCL5ZwQA62H3RCKwlHnYuqp@vger.kernel.org, AJvYcCX8XvVtaJ/7syJ/i9j5iqbX5V22mcVps6i4HDmQjoIpo3W2SrmQ+aBVozU9f7KD29xf9IAzkWUIj/7KmC4d@vger.kernel.org
X-Gm-Message-State: AOJu0YyxROrcuuss3uKc9EkHf2Y80D5BVz7hFhZ1FIqLrc9HDTz09INa
	ah7eprNQPdManHPtq09udp+Fphtqk5dAyVY267lVPSLkd/4gVCovYeDs
X-Gm-Gg: ASbGnctCJsxGAP3OkSbh9vmLIaCMVuNj07+a1gbEqCcmS1IQJrPcUYoWwGAJSEk1mG4
	iU8wMQ9CNE5XmiBqfHA/V4f1fFKQ2oXeycOTkuhKTG6n3Ip2GsAXfXPqq9tXzRuw+eetyc5seZf
	D+pICereTraXshWm3opmlUHeHISHR7GP5vNL+FCAE4ceI+j4SLaN44s7/WObCqkotHJycEMDp+J
	juheF2IrbDg+4BxcNfSGLPTQD1Oa22/J5hJu7fPfpMd27qjhvVXHdyBlTU3CrfGLHAT9d9XbnS1
	NLYXVPw3oPQ0FA1OigbGv73Nw1LYKZhNMRlyUacSmT2yc8G4KSSbUr+Qrw4UdCsy3JnLQb5qBxF
	My5aChWB1lHbWDCrBHhBJOIUaSOC85zjhExJeJmjP/p0evdXxkOFBUgisidwbeXLp2Jog1jT0YO
	qOMknQdXShvF5SFxxxmIHJphihDQ==
X-Google-Smtp-Source: AGHT+IF6kdfD0zGsjMmnAtNgzzWv37+IjLvZ504xPGjikiuj3U4fWnzlKF5W2UHoTYqJemkuMoORFg==
X-Received: by 2002:a05:600c:4ecd:b0:45d:d5fb:1858 with SMTP id 5b1f17b1804b1-45dddee8e80mr91947355e9.21.1757412758646;
        Tue, 09 Sep 2025 03:12:38 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea47sm1973272f8f.46.2025.09.09.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:37 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:19 +0200
Subject: [PATCH v6 12/20] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-12-ce082cc801b5@gmail.com>
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

DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
It allows to monitor DDR events that come from the DDR Controller
such as read or write events.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
new file mode 100644
index 000000000000..1d97861e3d44
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Clément Le Goffic <legoffic.clement@gmail.com>
+
+title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: st,stm32mp131-ddr-pmu
+      - items:
+          - enum:
+              - st,stm32mp151-ddr-pmu
+          - const: st,stm32mp131-ddr-pmu
+      - items:
+          - const: st,stm32mp251-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
+  memory-channel:
+    description:
+      The memory channel this DDRPERFM is attached to.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp131-ddr-pmu
+    then:
+      required:
+        - clocks
+        - resets
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp251-ddr-pmu
+    then:
+      required:
+        - access-controllers
+        - memory-channel
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+
+    perf@5a007000 {
+        compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp131-ddr-pmu";
+        reg = <0x5a007000 0x400>;
+        clocks = <&rcc DDRPERFM>;
+        resets = <&rcc DDRPERFM_R>;
+    };
+
+  - |
+    ddr_channel: sdram-channel-0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "jedec,ddr4-channel";
+        io-width = <16>;
+    };
+
+    perf@48041000 {
+      compatible = "st,stm32mp251-ddr-pmu";
+      reg = <0x48041000 0x400>;
+      access-controllers = <&rcc 104>;
+      memory-channel = <&ddr_channel>;
+    };

-- 
2.43.0

