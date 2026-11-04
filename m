Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761389;
	b=VS0wr51NL7p4gTf5LjwKmZcghJ7CQq+WHv35ztoLw/ABDw6XrV7JWoDooLZWwup8EciQ
	 X0mIVROOZqrIETrP59232AVnRPd9jsuzmMmhC66aR8VdeRNTAGWiaBTWNzOR8tZCqbLPe
	 EZo2Jw/U/eLtH0h+oQnH8Ou8c8Pw8YTmCxoF4pBtESe6ev18cziwrSh2gB8e49Tg7iTES
	 jk2EZixgvS8KW0wJfma6nLRzlKosw5rJ+9aYyFhWMwzriKWOm8ahCnN3nYt07mkv1jENP
	 JkY5J1+vdq3W81et0qLojmc21BtyhQGUN/QOtgYMx85RJxtcDB6YB8CdjzycG+u5wRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JODTwBcTg5LnDv4KmwCkQfqEz0wC3Hbmzw/64fppHts=;
	b=Llvndk0HSQFyhkDNDDIRlGOHYXBdmv1J4Ibwxw/6aQY4TeU/QOt0Sd+f+/hTRK0kGATf
	 VwGMXNQZNW7cpSMzZkVtOKJgTArcyxeG/oT9Z18tox/qu7PIWqWy1XDlmlTM2yKoc2je+
	 sHQsqyTIr+aBM3gbBOu4brCB59IG2/vZs2TSMei9X9ARsgFMhVvYL8sv7u/Y+654gUjHA
	 Ovpo5tCVol2WJKp0TuFFVpr8ZDT0ImdXr1OlikN/Kefxjl9XCU/IinOL+xVdK2ZcIM+/b
	 A0s0hq2bR154AQe7vd8TLhMmnaWKQj3UHdzZ9U0fxvCow2Gcge0ytudWAim8TM6tlPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A6IMNBE5;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E22606D80F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E22606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A6IMNBE5
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3662e7a9299so826566eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 19:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793761388; x=1794366188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JODTwBcTg5LnDv4KmwCkQfqEz0wC3Hbmzw/64fppHts=;
        b=A6IMNBE5Z+EgwzrT94tR+g0zbZnUHBITCVZiYh3zom4ly75wPSYGMAHjKvvPhx+cdQ
         6PvGJipCnxydSQ4ScbNKTPJPlTu/XT/qvC4B9OaiqZUwk/SjZncp1jxRU2ye9pY5QV2f
         CYD51/G4uUSts2Zng+UL61Fqz17W2iWko+RXgNrhnOk/EeufSYk0KH80EUQfKndpiYHA
         FM2GHQNmmmaKOqNlyzZw/eyT66azUNnDY8Jvbpq94hoiuzQuCB7ISKDRFqZ6z5F07TR8
         ixbarNY7FSfLJiv81Y4223bClYOAid0yFXRLdwk6fDnOFu7IB211qY66GtiH9fd399cG
         fmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793761388; x=1794366188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JODTwBcTg5LnDv4KmwCkQfqEz0wC3Hbmzw/64fppHts=;
        b=ug8+6SRp5kKJ721epp6RcSAEHutzQRe9j2beSUuJmAXnbaPMBQZescYrk07fmTIKtO
         MHcxPfECsvgnY1eP/NQ6PN2NKsX2jcTbvvC7yPU+ERpH1e+gIxI0jzzGCebUzLuOvII7
         AMnx71QNzYnTpViOvyu4KSWdmvl5Vs4w+MQLZ3lhNkf3GIBKLMbyPkB4jMgQNkqKi8kN
         tjN3EnN46Q8lFEzm7bBT3IpZWojG1KVopcX1bg6VbBkmySUNlFkgIUU4Yi95B4mGDwOw
         cMLZGfdSztPlUagBgsKlhucfdrj15IxZpfVXs0NbQL0LVEQ740UJKzMxRbi1moCBYEfv
         NFrA==
X-Forwarded-Encrypted: i=1; AKwUvBydYgLQzyQ+dpGJ9zh95vMZ40rI8pWvYylDaArfLwMuYF6zUZaOcShYIU4BQAIBeOT8zmaRzj/9LoUAxIXT4F1A@vger.kernel.org
X-Gm-Message-State: APuU4Z96BobZlgcQl+9mr6zaoCamF/qWqMZ4dEoHqUmK8utMyqPN1jWZ
	tou1zymWLHsgmENx5FNqWQLfh3f6OoJFktlmr+TEqgl18TxVFJjRXAp6K625AVXPbLbFOAO/kLI
	WUVCFELD5Kw==
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:185:5973:326c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4512:20b0:193:9aa3:474c
 with SMTP id a92af1059eb24-1ac5ac4efa0mr21972153c88.21.1793761387538; Tue, 03
 Nov 2026 19:03:07 -0800 (PST)
Date: Tue,  3 Nov 2026 19:02:58 -0800
In-Reply-To: <20261104030300.1140180-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104030300.1140180-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104030300.1140180-2-irogers@google.com>
Subject: [PATCH v17 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
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

The hardware exposes two MMIO register blocks: the primary monitor
evaluates the System fabric and the secondary monitor evaluates the
VideoCore VPU fabric.

Co-developed-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 44 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
new file mode 100644
index 000000000000..2f1f4f286ab5
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
@@ -0,0 +1,44 @@
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
+description:
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

