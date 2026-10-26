Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049124;
	b=BFDIvn3b5kTudfTIf8RBL9pC0JUqFZ2ETrxFLm6kWyROuirAx6qTq7pNNxJB4O6oyi/V
	 hJVNTDkP8JcqK7cOW4zhmwC9pCTFbH3PtReFOGNfSISkl42MVkj5cfvbRcK8P4aoESU4F
	 lIi8aCXCa3B2VkWq0qNcVlL8PSq1c6CXDjmsXhxLsX7/SI6ezzGpuj9tym26q0XwwJGXs
	 FhQalnLeNMGklB9ySF68sxaDrrvc2+CUdrzor0LelNfC5TXW4jezxeqYBDmSiZDMPnuT3
	 SqjrS3WCOy6x8EUG7RZ0JnxWv3GUpwvtDwiF6+PGeZJmtUd4uNmgblBYV1V5rQfB3mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049124;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
	b=oiBWkEfNeMkXeg5OZCjoo7Hjsul8eSh8J2KplppK3+1Q1i7gC0MrIrep0uwnAm3vWlwZ
	 z8yTTnsw1jIQok9p46iLOp2D9f/ZiFyOz9Vu+DWORMXQCBWCSIOqRvZnHlKFmwoWaHWxS
	 j/ADFelXKIddVZL/FAeSbRtQlx/us5U/WGn8GcqMie/A3+AaDozzDioLlNqKtEqLm0adF
	 wG/DUsV0lwEURGOnkyHrQnK1qsb2nstlcndHOpoytdoIPCcPCV2dRMUwmsF0zGDw4WG1W
	 5CKxtA1hZ62jxlWrMpbgsK0z8Oh+FteEQV3zFrcocl4K04A8aW5iZKbnpBXsMxM4UqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NnysnYU7;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EB606A32F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 293EB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NnysnYU7
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ae0852df46so249560a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049123; x=1793653923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
        b=wkmpeB7nez7WqEGT1ZKpJNxLEsylwMCeDuyvHUZTead4SLYu6kaDKJQ/zec0dNfill
         mVzMjRZoXdTxp1jMeZG6LITtNqRbxIVF1JTK6TwABlLFfjaXM60g0YycrY8GKQWYbt/b
         YIan9SEcxCEqILzZxjreoK20J4CBp9/nW4DumnE4cH51H0I01Kosg6vlSZufD628GNxf
         kBAJTVEMmwVyp+8IblriZzTbbqUe5Dhh7WXU+Gh4sRGQPdMkZ/bTlqzvPpk0axHjOD+1
         OPmO6sKdGl8xZYeHShjh1ZELs7vdII1xRl4WydEmlDIf2j1fZBpxXh+x2vRfEQCwSBuM
         jF6A==
X-Forwarded-Encrypted: i=1; AKwUvByxivxgUjeLsKCuas0MO+D6XuKbIcKeGhfWxWN+DB5lTOnIeHM01khaeXLGZ4KFzknGCNhBpFxo30W8JVt6jfvg@vger.kernel.org
X-Gm-Message-State: AFq9FYJWLeKyGfx4f6ETxGebg3Tu9AK6MYRIA0CPKJ57GnR2W0Kdn4C5
	LSjBjh28xohG5Zx9kIGRqhVyVapYl7efwMtShZlAjyvjbl7Y+0gtI32U5Y5T8Bp9g+i7hvEmm2V
	ADg2TKg5x3LYRu7tnD+5FfUv6idJSM+1DKrRkcr1wa6Cmqe/7RrhK48t+/NtLvo/WK24YgwcGH+
	odFAcIFZScEw81QIkVoDoBhrSrN5kF586w483In9Ys3uQ6A7mAK8zUU41RycNJG1HxgslSRFnr9
	mnP7MaRTtfVPkv9CPCdzKfct5N/MOtp
X-Gm-Gg: AYBFou1vO5n6+frsIYT9aIgZ0coh6I3W8tfDUJPFGCbt0cvrlK3lgoQkPGdffSbkHlv
	hHHaTKy45Nx7AnoHOwaNM2cDPgzQcj8MBCMKQRwGi0zBSZBy1Fk/3tq6JWG7uodoTaXV0wfxptI
	5T4ICPJj7NXu504H0PVOuapJM/Nn0zREntmFYwYI/UqYK7S9o5upBvciZxW6CjCLJ5NSkNvawkV
	IrCTzKeB8N1zM7j7PyBPVFPhR4Xnjk6m/IO8Yb1wVevAO4kBLwr9+DkaKgkomB85We/n/pnFuWR
	n8fUUVX/7+jpYUdbbmSNK5hsjGqm32TW1ihtcFuoRME3+TYMcz0Fn7IvtkBvdpauwr/2X1tSMfg
	3Wp8Wlh2//AA8HgHJY1AWQWR15B+n0+0LQD7MUWekMzKzPJLoWwL+VINvId8bXmgFBzADs0fRZB
	4GsFglpeo0obH7gCdgipONt7LlqkcK88VAbpCN37vYP7g=
X-Received: by 2002:a17:90b:2885:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3ae4029973fmr317874a91.20.1793049123418;
        Mon, 26 Oct 2026 14:12:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeb83c4besm3070797a91.0.2026.10.26.14.12.02
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:12:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a2b6fab7a6so380727c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793049121; x=1793653921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
        b=NnysnYU79YnMhg6jBSRtE+Fl4SdFXflwUjWH0sCUcG7gUl7ebUhnf3ZwNUCXCAF9VP
         jxtfuO5z99UZUwaeAM7SVNyvAPkFb8Q1uHbiSN4Gxl44r+eZz0fD3E+5EBEjPK5eVgOA
         rT+ZXQTw6PMvAANqPbelwSi4jlqjcLxNRVa+g=
X-Forwarded-Encrypted: i=1; AKwUvByEMAcAWX47t6g7OZUhi2evX9dxI4gXZVBUxJ/l+mvWteAObJtiAccsUbfow6lVuL//nN6XnOWh8xEIiTIBerPQ@vger.kernel.org
X-Received: by 2002:a05:701b:42d1:20b0:158:b944:b15 with SMTP id a92af1059eb24-1a3c6150260mr1039941c88.22.1793049121315;
        Mon, 26 Oct 2026 14:12:01 -0700 (PDT)
X-Received: by 2002:a05:701b:42d1:20b0:158:b944:b15 with SMTP id a92af1059eb24-1a3c6150260mr1039903c88.22.1793049120586;
        Mon, 26 Oct 2026 14:12:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm31915678c88.11.2026.10.26.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:11:59 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM5301X ARM ARCHITECTURE),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH 1/3] dt-bindings: perf: Describe the Broadcom BCM5301X AXI PMU
Date: Mon, 26 Oct 2026 14:11:49 -0700
Message-ID: <20261026211151.3212237-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Describe one APB register window per AXI Trace Module. The counters are
have no overflow IRQ.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/perf/brcm,bcm5301x-axi-pmu.yaml  | 43 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
new file mode 100644
index 000000000000..686b20d4cd29
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/brcm,bcm5301x-axi-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM5301X AXI Trace Module performance monitor
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+
+description: |
+  The BCM5301X ARM subsystem contains three AXI Trace Modules, monitoring the
+  two PL310 AXI master interfaces and the Accelerator Coherency Port (ACP).
+  Each module has its own APB register window and fixed performance counters
+  for commands, data beats, channel activity and stalls, latency, and cycles
+  with outstanding commands. Counters support local start, stop, and clear
+  commands. No counter overflow interrupt is provided.
+
+  Each node describes one module. The separate ATB trace output and its
+  CoreSight connections are outside the scope of this binding. This block
+  is distinct from the BCM2835 family AXI bus-watcher performance monitor.
+
+properties:
+  compatible:
+    const: brcm,bcm5301x-axi-pmu
+
+  reg:
+    maxItems: 1
+    description: APB register window of one AXI Trace Module.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu@19003000 {
+        compatible = "brcm,bcm5301x-axi-pmu";
+        reg = <0x19003000 0x1000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..b97f22107fbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5220,6 +5220,7 @@ M:	Rafał Miłecki <zajec5@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
 F:	arch/arm/boot/dts/broadcom/bcm-ns.dtsi
 F:	arch/arm/boot/dts/broadcom/bcm470*
 F:	arch/arm/boot/dts/broadcom/bcm5301*
-- 
2.53.0

