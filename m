Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5D29898F
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782056; cv=none; b=F/IwqKj4Gw9y1/sQAx2lFSMWLNds8UYb3x0jFQKzQtkPLf3wWnGs2qLEGkDTrTrEHUf0UkBcxXZjExKCjq87MwFWf7OO9xWmHZQ6Qm9nqkLoBCRbQad/d/hoAWABve4NZoMxE7xFHesvK+PKZeBmJr1bmKeiSoDJaNqcvuAL6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782056; c=relaxed/simple;
	bh=vrI40E/Ms/vPd/wWV7KFBBB0zzHgTqy9wJtZ/LzBk3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mXOLHpHaGboS+KuylVO61Ocd+bZH86Gejw31TsfiM9aiWFoqS++CGl4FkJH6RDjdAP74tynsjRATOQ9bhaAwKlpSOTu2rS04wG0Q2dw8IxFb8Otqh8KrE3qN0Cj+7b6aFv0ihZmP4zH/G7cPD4lxWiEWFaWIwKFnj2LXh1RkhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMTfcKyK; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMTfcKyK"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so1230871a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786782054; x=1787386854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6KgjyY8PrTJFFkciS7ilG7nrDbtEQyBC0oLhg67UQQ=;
        b=dMTfcKyKV+JUOcaRr2TAboZ18Pj+R/01XrqsRc85/VX+k5gDT00YWyFgu1PpzQRe+e
         wfn6AfTAVQcgvjIqVrvz7vM2y8CbIebl5gJrjBCkDYanebn+hmOk3rfnN5ylpoHLN38S
         cd6ethK6dJjMl8lUHdMwHRWRoNqwnaUK9+tLl7+25kVf2eVoK4sSQ1OfRrCPaPbwcyRF
         Jx5DP3T/lBXwGiEobLrqNvSQ1kREdqfA1zLPkLPypuQMso57iDQNR6qKuyMZ6+yI65+N
         Ek5Ll3oBP3rpxzekIrgNilET8x2SJQG5QoLhzcXk/WeZ4qJ8miiXtE4pPYj2k5RQtAL4
         gZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786782054; x=1787386854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6KgjyY8PrTJFFkciS7ilG7nrDbtEQyBC0oLhg67UQQ=;
        b=FT5knxCpDRmtKOqVYZg20aOMD/jrNT+9I1O0Ei4R3V61WT6RJnc/Hdos/pI2vLGpom
         b8kfbQZlR0Rb/euPREpiVA/2BxJN0WGzZeVsqosp9k0OuW0SeDmBS5f/B+GtgxthVqI6
         EQ00zQbi6tKVAjDODhUJtIVMFykMK8o+PekF/Sh98dKjz6RhcI6phlb5kBGQzLjmgVXV
         wT4+3Z29IDb5KEKH0nqXTi73YGr3f3Ooi+wHDYGj5vkyZNJ+Ap6Ti0ILVyl7AzFO21S8
         EPpvfQoXCIIec3DFLP2EZzHuaP4pCcC8spEEpnubYhkWTCccn2iutT90UncOOP2b6Ux6
         bOVg==
X-Forwarded-Encrypted: i=1; AHgh+RqWEVqWABai4vlrHck4OcHTP/QkkNjMySuw0+hyephn+/xtmlKmASdli7AIadINr2gQ0ZM0/Sj7iy9lr3l3z1Mz@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrA6djePr0VDESXByYCzn/KML7aDaXEUMsK+Qty24Tc46aWcv
	kZyoSHJKPO2annsLiTx0k8ixWVdFUdrZ3sZXM76bDkTlgHURDMRmUx4y8rS/T6DN1ttQBR2TV56
	SZwJJoP75lQ==
X-Received: from dlj31.prod.google.com ([2002:a05:7022:51f:b0:13b:848c:abaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c3:b0:387:d9cc:7dc3
 with SMTP id 98e67ed59e1d1-3931f61cca5mr15778918a91.21.1786782053769; Sat, 15
 Aug 2026 01:20:53 -0700 (PDT)
Date: Sat, 15 Aug 2026 01:20:46 -0700
In-Reply-To: <20260815082048.4043217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1691900000.git.irogers@google.com> <20260815082048.4043217-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815082048.4043217-2-irogers@google.com>
Subject: [PATCH v12 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add Device Tree bindings for the Broadcom AXI PMU hardware blocks present
in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).

Depending on the SoC and security configuration, these PMUs support either
direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC.
The bindings support defining 1 or 2 backing MMIO regions natively map
the system and VPU control surfaces.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
new file mode 100644
index 000000000000..8f8686f67337
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
@@ -0,0 +1,64 @@
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
+additionalProperties: false
+
+examples:
+  - |
+    pmu@7e00a000 {
+        compatible = "brcm,bcm2835-axiperf";
+        reg = <0x7e00a000 0x100>;
+    };
+  - |
+    pmu@7d620000 {
+        compatible = "brcm,bcm2712-axiperf";
+        reg = <0x7d620000 0x100>,
+              <0x7d630000 0x100>;
+    };
-- 
2.55.0.691.gc56d675ccc-goog

