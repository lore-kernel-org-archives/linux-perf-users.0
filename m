Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123495;
	b=BEV2lGgn+DNYdC1fgU9XutzteJCJMpM76dZjU8SVF9QPV9fV9g0u7vASjsoe+RfMUljY
	 UJXPKxu/rHDY01ZgNNoxHB5SPBVLEHs12VI5taSvDyV/ZnQ3bmGyI1KP0w0xG89N4tPFs
	 EL0yufOwpThMVouZVjaIhlmUdrLLChO9xB6anfwmhWeBXBxU7qxWpWgA4HLdiwplwFHVC
	 31Sa+MzOOVsv5aIP/NwGkVVaCHl7lqbOlU1OIuczeQ/b+DUh8wJ3Egl17ZbvxkGBJuG8d
	 x786dALsJiPhYulN/Sf9RKMWaw379CD2GlW90w7KvhFaOrIocYkE8XFVVEWGz50YUpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123495;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
	b=Nrf4mUh/lKmZCMRrK3kmYBtFp4MOLDmcc01gXnFzuGRDby+Gljyw5ylmDgJDcwTi64xT
	 T3KadhVmV3I1v8oszF/PuNelKlX2Fs4hrPinqXeE3bpdTeAtO5u0soLKJ0brnsE0r2CC3
	 WlnRVFJC0vOaQZP/1BNzFPbQFnuHuTYWLXCT4F4Xd/pLD5mpiZKZLaSnsxNISDqUCSL2M
	 pryudK8JMYkfA7+HUUBDFZBpMmi58wmFMoSvW1xD4MV8ECS8D9KLiOJCIsr6UUedon0Xt
	 HoE9XQMV169MhEBURHjHaVmEmC/dBgP+dXW+GzfU8QsZZznOSpPIlaCThoWDrNIP0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fIArgy0H;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC12606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC12606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fIArgy0H
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso118371a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123495; x=1793728295;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
        b=a56Aq5u7NS9Wk4y0e6k8J9WWIu8tt8YnphuVzbOtBux3fBwk+w/zpMDHNf+Mo37D+o
         uU0L74vkA4YUR8zCyU2Gk9ci76FvW0a+pTRa7NuIZY26L9Ipvz82Zb4qVSQKhihq8EXt
         U1GuC/kO2JVyFvAxonMKCqm1K1P/3eqyK+LF3yDTzM+xw1mVXmT/FnnYFUlukehV6KhE
         lRo8TWFLQQBvEQ8+OVNIUSPpV/+p43LX4xzueVBk+JYYDUSXJ2FFhZdVkSmiTPfQZDOu
         wZQsXKmuufYcujLUGGK4+KwkZ0j4o4mb9ZwA/VWZDo6LIR5VRbGPksfUb6fZkOU1FzIr
         otpA==
X-Forwarded-Encrypted: i=1; AKwUvBw7KheeBGuoXvTatHoxssWYvlFAjYrjyExD+gQAihWaJYK9Y+4y0FFtqgJbgHTHjDIUEOU90fTv3NeXjzEEpRNN@vger.kernel.org
X-Gm-Message-State: AFq9FYJhJKKD5HWqwW6U07DGY8FaON5bEo7igwiqiit6QVy5j6u0rMkP
	lJfE1QyMkO5CZRb122l6GfNfLymCpPIsfL+2QtHWLT4z08MwC/A9OMX7bhDl9Y4gqXvPqHMf9Wi
	w8V68U7JPEFik7qig3Xno9/lGlNdI53FDAa6uQW5DrjM0R0XLYDa9F5Msaly4EMNcJq58swc/bC
	JKbzCXf4dWg8qGM4hWV4HyDIYzSvkjQDLYnQnQXm0ZUkutrX87ZQBWklnq3apMlanbKTXgQQB6d
	YQUk79sPyciyw8lzh4fJwhSdle7+ZdX
X-Gm-Gg: AYBFou1cjkj4RLlV0+PJDe9799gWuMJedkLJq/BhxCKo5yRSyq9zgyl8E5qGLwpYoeS
	t7LiDYNBPZhH2TDCtKXNY/iEuNxxjkCaDJ9WJvRPsvnfJ4pGRJasHYX3kXelhnXgbdIr67jLwEz
	pT+ZNXcFu+6L+HdV3AO8BR6Qv77/03vq/2nBZVV9RcUg+bU7wr4cAbyieGBs+CVHFGqAqbXrIjp
	HhZbwg4GKw5QpCANIUTRblrDc87cxx6BnF4Gohfb8V0jFW+/FY8+Rhauy3bFrG0xDqnXftIPnnj
	B81VSr0EMYH5a9lHCFSqkQiMLdF/qfgdLNRiXUmin6n3dqdvZLncUwod9YOLVq/Oj4l7CWQZHci
	hZC/IwgKEl5+bzzFPtL1I78yvbc416P5HO7FTZ22OMRJSQLcAMlT+Ym0qSsUAC0/c/qdfzzyRP0
	6KqqlRfHpVQ20GbzpDDGTxmarBzx7o9KCOGl9OEaoJs7g=
X-Received: by 2002:a17:90b:52cd:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3adead4c285mr7173080a91.33.1793123494675;
        Tue, 27 Oct 2026 10:51:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae4063da67sm2639033a91.8.2026.10.27.10.51.34
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:51:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337ed1ba44so4869401cf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793123493; x=1793728293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6OnP1vGWmb9YnZS8P9AwgUEc+BdAnjPfL2XGArdBN4=;
        b=fIArgy0H+v0gsmzP3Dh2wg3Vs5PuRfD54J0bLaAVAXK09gO2ulOnu85NK2V+BWpXVX
         U2ZD7AtClFrxDfiAeQMnYtM6ca8QfafDHndMef8fPHVWoVl/e7nt872rs8ziOF6HA0w2
         aMed9tDVBngkJxtDk+2nVV8tF98GM0VsPXRPk=
X-Forwarded-Encrypted: i=1; AKwUvBxtRlDKSOI+1SsI24LYdRQK7CioBne+t8w/A+rp8oHgVF6+6GCjRJgFRyRbiRiahGCQ27lOmQwXg54zY316MM6U@vger.kernel.org
X-Received: by 2002:ac8:5712:0:b0:535:36d:dd97 with SMTP id d75a77b69052e-53fcc9bfcbdmr22081cf.48.1793123493315;
        Tue, 27 Oct 2026 10:51:33 -0700 (PDT)
X-Received: by 2002:ac8:5712:0:b0:535:36d:dd97 with SMTP id d75a77b69052e-53fcc9bfcbdmr21461cf.48.1793123492818;
        Tue, 27 Oct 2026 10:51:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970ab61sm83164511cf.17.2026.10.27.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:51:31 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: perf: Describe the Broadcom BCM5301X AXI PMU
Date: Tue, 27 Oct 2026 10:51:22 -0700
Message-ID: <20261027175124.3518239-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
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

