Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55F3C1D76
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963880; cv=none; b=n3U1H1f7rzRd0XaEVI/sPjEwqhjoQI/NmNLaPycWz/xVn2XvKJ851kAmbtwcPBjAxWLGG+GmjalnwSV2PQE69s6Iw1pLNdnnyOOnCgP+gNUmHbeO5lGPfieZvOs2E1SSs77wHPl+Sww/dqRjfth6BWP928ptmINt7wvIAclhROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963880; c=relaxed/simple;
	bh=vSGvVU3Fup5xL7ThAfUCg/NGOb9EnT80QaJ6xyE8k4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmQ+w1KVpZv2yKq9hsF5B2pPMGuKV+gHydMzTvDm8dlHSiE3MEWphAjAfSM4gRrnsC4BifZa1NgnbgfO+QdYVXA/XV8TUFuyJ5/7S1Dt4fIfXD0SCs9nmPd1nuEIm1PWZRIYUZiWZeLM9sJacYyHUAhn6DIpM5mmzxNhirPxJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=To91Uspq; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="To91Uspq"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso8647062c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790963875; x=1791568675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFiozDtXbElFjY52A4C+mnOyigQ9AyYGm8ni+YdlmxI=;
        b=To91UspqAdHr5clAXAvKNkfAtC0Ndfp1c2VIfDEvgT0F5YsXHVGh9JkZ3F+PtJOG8l
         P62LOvkpY86HGv8mq3KLr92q2k74IazN+y2+NtT2irzfHWyKwg8+vcEGWMAHScJU4Tca
         XqVLHWT/1WEtYIx2rXgXrkgpwexF8sZ4RAFakd60IgSA2WLyfVOevN/nNZZypj4DiNDT
         ErYtX5ZdohHwYYDBgUDKMtxNo/P0w9C8FCMUo1FwMqmM0gzhRn9MuxEcQTq7kToXTzuK
         O645ntlwqtMt00TzGcqHzllFyJIa+dfvEi6jScychfbVLsmRk+ugTNDCROSJ2Fmdv6ii
         w0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963875; x=1791568675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFiozDtXbElFjY52A4C+mnOyigQ9AyYGm8ni+YdlmxI=;
        b=GqhaIDUGqejf/z9gay+XbTKZb5YjXLNvfxQ9a5oUKrsXnn/U49JiF5Eoz3BtPHZK/f
         +GpRTHtQPPzZ28Gmgj59xgOO/skB32URYGuJCGsxRVRvKnltTlFvQZ7CgiyyhqN3ihyR
         btcHtNMToSyx6LOAgIq5fhl2HgE+8ynAeWkKmO3JmRAdiZwYkkkm1ovto8IN/vnsi2DC
         /bN+mFuR69+9012+k0q1WqKosP+AJV1F1zdNKicRajMeuHaWgrtyPB4g46PUwuQQC4PG
         sOZ8w+AIiLph+Tz23xDjq/zd+B32VjJ/Kkr8TEJngMIqK3Cf71+48DmvDFwz0qDGs+O9
         dkUA==
X-Forwarded-Encrypted: i=1; AKwUvBzZADezxAjTjsZg6JULGe8xuR+Eo+1jMbZyJzite4x/BmFaD22hFhzRpz7W9NvLQyzGvyQj2QeE/EMYELcfp9SM@vger.kernel.org
X-Gm-Message-State: AFuF++mQs11oQLub5oTba4+XGCMgpbj4X+PbkLPbpMvoEq2CtCf053WI
	TvHtJfFQ8RkOebOuXD3O8fRtIHWZUvpVMkg6Oq6mvyRGxxHuvZNE4g0/otj8C2OqAOZSSGxiTJx
	mC2+8qTW67g==
X-Received: from dlbrj21.prod.google.com ([2002:a05:7022:f415:b0:146:40d5:dd5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b045:20b0:14e:516f:441f
 with SMTP id a92af1059eb24-151c30ed59emr226133c88.20.1790963874830; Fri, 02
 Oct 2026 10:57:54 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:57:34 -0700
In-Reply-To: <20261002175738.3242646-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002175738.3242646-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002175738.3242646-2-irogers@google.com>
Subject: [PATCH v14 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kernel Maintenance <kernel-list@raspberrypi.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
found on BCM2835, BCM2711, and BCM2712 SoCs.

Depending on the SoC and security configuration, these PMUs support
either direct MMIO access for the System monitor or routing via the
Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
new file mode 100644
index 000000000000..fcffa5fc6c02
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
@@ -0,0 +1,71 @@
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
+  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+
+description: |
+  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features hardware
+  performance monitors on the AXI bus for evaluating memory bandwidth and
+  system traffic. Depending on the SoC architecture, multiple monitors exist.
+  The primary monitor evaluates the System fabric, while the secondary monitor
+  evaluates the VideoCore VPU hardware.
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
+    items:
+      - description: System monitor MMIO surface
+      - description: VPU monitor MMIO surface
+    description: |
+      Memory-mapped I/O resource regions for the AXI PMU endpoints.
+      Typically ordered as System monitor, followed by VPU monitor if directly
+      mapped.
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
+              - brcm,bcm2712-axiperf
+    then:
+      properties:
+        reg:
+          maxItems: 1
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
+        reg = <0x7c012800 0x100>;
+    };
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

