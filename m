Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBA41D114
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814855; cv=none; b=J6pUNKjk59qtTA+MoKmuUn+PBmpxcZZgDSQo9tGLWCArL2sNe1himbVehtV9bKv9yBVeQrvwl7zVnyinhYHcv2+/sbns3HKVWGsmrp6cpSPn+e0UpH2Y9k+QXicAG0qpetHM46SVtYK56vhofmfqBh9RvPzyz2pwRqrpIVQWCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814855; c=relaxed/simple;
	bh=Q+AZIBhHLV68z+t+m/NbNTznOkhCJUUF9N2JkDpQd9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TF/BnIJUSG+wvubmghAUWWAS+IUeE3xjvqFGkNAhUqGkqEtaOoI/iF72TxdwbJS6/47HviSqpTxwEH/6TkxdypW6RM6Ob+xAAfmD2nFDCq7Wm0Jq57qEVKIMOZXcAIDZcJyI9OsCmOggo8wV0fDxoJfxgHCxnywiHT1EiV+uCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZRNJZRF; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZRNJZRF"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso2390271a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786814854; x=1787419654; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bxun1+XcUQPkfOWhYiSaIea5dLp4q6zAXzjsMiENZc=;
        b=nZRNJZRF6uIxZu3/fIaX0PQ98Q3dBkoWZsY6B7VXua/6uBYdYZfaVQQP73Xe2pLXY/
         aRjL8OxwRgpoXCv2aYWGNYDXTzmGUYOfd9tHWzIA7svC9ATy9ZfHLvHRpK5iy938GXI9
         pWSJlra3CPkB8xChyyC/Wtx2ZSQCPamBDMDq0Ma4gCeMXoZsFr0q6UCPuKii+Qw1kzFM
         go3HBrQIn8A9chYK2hOV9e9cy5KUI+GRbUrugpfNquCOHMLHu2OV/75SBoWPhEODWQEN
         AyTa6AnFxdaK5eXmLCwOmPfL1rqPvz4zjaqMI025Z9jbZJfKmS1qxuyuIeWFdoYwMGk0
         mxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786814854; x=1787419654;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bxun1+XcUQPkfOWhYiSaIea5dLp4q6zAXzjsMiENZc=;
        b=GvIvuB9HoEC80Ak6kmDhyIMZ1gDHw7nFMeRDig87VufEi4aGXebaSvziWy2RRR8qX0
         STsC2n9HI6zXuIpgY6Y0MbC20Iir4W1smYLOY/9heozqHrWzicGW1Yd4n0Texaj6Nufo
         3NLpXwM4u66uOTPmBRU760AWOrXXBQPCHYhcWLx2tIJcIDv514s8TNdyP3jF1uHej6dR
         8W7svC2xfBwBG0YWN+R0E+vp6G4kKSCF9ETf2KFeVL0LKPAYc2aBwqldCY1JIQZVOtlx
         0Q1zqfnvx3FJH3qzU6CdNahWAG+x9mSDHVaJvkySRr3Eour4fIkdWYh0ei5+J/xdpS+u
         lZQg==
X-Forwarded-Encrypted: i=1; AHgh+Rohgqk0y/x/nvSedr8ZgO9D2SQNKgyZefukySK+YblxUtY0G6YLpoh1TX+8h27hTKWcCv+v/hM5cxsKw/1rG9Kw@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqKiKKg745fxPGjlK4SgO3iPA8IvKCkW5u9iiJ87d0cK29ZOe
	CgZLWcbb+G9/kmINMVEY5AfjmKljRzz/XeSv/tcPqT5cE1nRRkWemZpJWYEDRlCNrBJhIhttBt5
	nNbRI9ppYjw==
X-Received: from dlam8-n2.prod.google.com ([2002:a05:701b:2088:20b0:141:3391:9814])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5884:b0:38f:efed:5445
 with SMTP id 98e67ed59e1d1-3933b7c3b7cmr16272330a91.4.1786814853706; Sat, 15
 Aug 2026 10:27:33 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:27:10 -0700
In-Reply-To: <20260815172712.50119-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815172712.50119-2-irogers@google.com>
Subject: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, florian.fainelli@broadcom.com, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"

Add Device Tree bindings for the Broadcom AXI PMU hardware blocks present
in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).

Depending on the SoC and security configuration, these PMUs support either
direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC.
The bindings support defining 1 or 2 backing MMIO regions natively map
the system and VPU control surfaces.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
new file mode 100644
index 000000000000..8a4857aa448c
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
@@ -0,0 +1,77 @@
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
+  system traffic. Depending on the SoC architecture, multiple monitors exist.
+  The primary
+  monitor evaluates the System fabric, while the secondary monitor evaluates the
+  VideoCore VPU hardware.
+
+  Older silicon generally restricts direct MMIO access to the VPU endpoints,
+  requiring them to be accessed over the Raspberry Pi firmware mailbox
+  interface. If the VPU endpoints are memory-mapped, they are supplied as
+  secondary resources.
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-axiperf
+      - brcm,bcm2711-axiperf
+      - brcm,bcm2712-axiperf
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Memory-mapped I/O resource regions for the AXI PMU endpoints.
+      Typically ordered as System monitor, followed by VPU monitor if directly
+      mapped.
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the Raspberry Pi firmware node. Required on older silicon
+      (BCM2835-BCM2711) where VideoCore VPU endpoints are exclusively accessed
+      via firmware mailbox IPC.
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
+            enum:
+              - brcm,bcm2835-axiperf
+              - brcm,bcm2711-axiperf
+    then:
+      required:
+        - firmware
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu@7e00a000 {
+        compatible = "brcm,bcm2835-axiperf";
+        reg = <0x7e00a000 0x100>;
+        firmware = <&firmware>;
+    };
+  - |
+    pmu@7d620000 {
+        compatible = "brcm,bcm2712-axiperf";
+        reg = <0x7d620000 0x100>,
+              <0x7d630000 0x100>;
+    };
-- 
2.55.0.691.gc56d675ccc-goog

