Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662997;
	b=j0CUMZr5bgU5ejY6I5kSmWRxjVViJ9sESRsSwKk22kGABgEX8FJsZHCyKnb7LLt/eZz0
	 msUy4vt8AJdMPy3zFrcl5tEQzGIwEK4E4DWvu1KC4f+rsyEgHT9gXWB1hQGkTUoIGX9r1
	 1dDDtllZigetUc7QLc8W9tcFD+43+S3ysn3MI31WgA1cr6zDujgMphcQLw+GMVOCiQ60o
	 cVUPY4xjdvnjGzh241qyQUco4AsMQvY9WDfKAt5toLmqoy76wuWM+I8HXM19gNCzE5viB
	 Pv7+8YzayI1fyId5i9pyG3PaURcuFFNs0B4mJRSZOpwKsuoEaRjRtg/7v9SInjNDTyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RCDzNKPwpp/Q/HkSclv5Zusf499nja7ZNvT3ZXN5ATk=;
	b=Uj74ZMAvj//cWiUCZBZsvgbqR5qldopQrDMHbpxMiaWmTOwLRrqbMVUy6h7zy5hEwjZp
	 mY15wuhp/cY9o9GBqd35bpJBrEJ2E79WCEynKsyfn+J/i6qpNHAjxNe5DKtfk1fxSx+c9
	 sFF6j8qOm2/APgj3O0RGEP0KgRTd2bTkTVIrlZRCeCPvMsHt/ESpxlENh+njQt19wcZ0b
	 /bh7z8pwZAEV0sYNaUJQFTzTmQmIDgZrSLRTHxerCHNiTFKnNgRgq0RbzVOYStAZkB89r
	 qWz+rScJ4zUdkIDX0QzhbmRdG2BJOrCSbE7ffX0H3QVDdr+tPHirNG3/wclHwCLdJ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6V6RDuF;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159C606A33B
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7159C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6V6RDuF
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so6849342eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793662996; x=1794267796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCDzNKPwpp/Q/HkSclv5Zusf499nja7ZNvT3ZXN5ATk=;
        b=f6V6RDuFAv+WlspbK0jUKd9ykn98XIEc5qKjAYKp5AELMfxzAXdvJuC1eaeC7ODgiW
         J+CIPIE/T7NUTZPdC68wG1YT/XGLkJ6EVw5SgV3yy0lNf8SWwUWDTJ0VzEwQN0v5DOAQ
         MaVzAXe7L1dRYfv7JYt09wG2qcxB0CJM8dWOJqe8TpNTMReMbgqBPM/2sXrWYmmiFYSF
         DoLrOT4gRSVnPcCpufrnXITNDBEwDD6WepjE5VQAKA4vr31bXt8QaMOnoRNcnq0RJVB8
         zu9Hd48YjaEztGdG2OAbqpjKC5wj9nnkOIG0S/cZB+03EWgATet3kh2lzJhCrdew39mj
         2DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662996; x=1794267796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCDzNKPwpp/Q/HkSclv5Zusf499nja7ZNvT3ZXN5ATk=;
        b=B40Negd0oK9RlGEIJ6v8TeoX05HxnTyDBkTR4AaElCzn8kZAfvvc2NssPo3lJvts2b
         2C087KRBKf+MFZ2z11wnabjFdkVgFCnvGSpw/zr2MkPcE0KLJ81r/WuI+LARTAf8Zjth
         fKlgWVGq+tn8/Swg9LF9PkOVrVxQ5t3bXfYYlMDuUeX6yWs1xXRJTFcJfb6CDwwX57pk
         7uVVYYmVP7n7itIUUmD70slFwtMMWSqdEwrBOxpG8WhjT75qB/Tc1NuWjFFaA4lmSogs
         KK9Fm0npSFHsUsXdCfV5W7ju2f5DHlLpZxauwbF9Bewnr1AUHFS3GA2Mqplj1dG6XqxG
         F9hA==
X-Forwarded-Encrypted: i=1; AKwUvBzrqwMOU/bf6XI9qdYtoNPdWUJgsInr8dakZvBpS4nuu586oUPWy5RqDn9J450i9DGljjYowjasfjBtZ4SCNVj0@vger.kernel.org
X-Gm-Message-State: AFq9FYLINcOHklKFck5z7zptcbPGcC1CPqobRkmyCG+D+jl+Kn3Pq8Jl
	gfw/0X7kCQy29r+GZCE30VnEzbkFtrMsdESoueZbdpJEhEUfUuejHSHsB0Rdqhr88NK8xCcC2dI
	ziSR4rTocHw==
X-Received: from dlep8-n1.prod.google.com ([2002:a05:701b:4588:10b0:168:3bc7:9e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4213:10b0:1a4:fac9:aeee
 with SMTP id a92af1059eb24-1ac56d95c0amr16914327c88.4.1793662996134; Mon, 02
 Nov 2026 15:43:16 -0800 (PST)
Date: Mon,  2 Nov 2026 15:42:59 -0800
In-Reply-To: <20261102234301.2242242-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102234301.2242242-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102234301.2242242-2-irogers@google.com>
Subject: [PATCH v15 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Dom Cobley <popcornmix@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <u.kleine-koenig@baylibre.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
found on BCM2835, BCM2711, and BCM2712 SoCs.

Depending on the SoC and security configuration, these PMUs support
either direct MMIO access for the System monitor or routing via the
Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.

Co-developed-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 50 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
new file mode 100644
index 000000000000..08d8c7c7e476
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/brcm,bcm2835-axiperf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835/2711/2712 AXI Performance Monitor
+
+maintainers:
+  - Ian Rogers <irogers@google.com>
+
+description: |
+  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features hardware
+  performance monitors on the AXI bus for evaluating memory bandwidth and
+  system traffic. Two monitor register blocks are present: the primary monitor
+  evaluates the System fabric, while the secondary monitor evaluates the
+  VideoCore VPU fabric. This block is distinct from the BCM5301X AXI Trace
+  Module.
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2711-axiperf
+      - brcm,bcm2712-axiperf
+      - brcm,bcm2835-axiperf
+
+  reg:
+    items:
+      - description: System monitor registers
+      - description: VPU monitor registers
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu@7e009800 {
+        compatible = "brcm,bcm2835-axiperf";
+        reg = <0x7e009800 0x100>,
+              <0x7ee08000 0x100>;
+    };
+  - |
+    pmu@7c012800 {
+        compatible = "brcm,bcm2712-axiperf";
+        reg = <0x7c012800 0x100>,
+              <0x7ee00000 0x100>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..b8a3cb005c91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5338,6 +5338,13 @@ N:	bcm113*
 N:	bcm216*
 N:	kona
 
+BROADCOM BCM2835 AXI PMU DRIVER
+M:	Ian Rogers <irogers@google.com>
+L:	linux-perf-users@vger.kernel.org
+L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
+
 BROADCOM BCM2835 CAMERA DRIVERS
 M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 L:	linux-media@vger.kernel.org
-- 
2.56.0.385.gac671c819a-goog

