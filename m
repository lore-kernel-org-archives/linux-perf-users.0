Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE2C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CCA60E09
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhJYUCU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:02:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhJYUAQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 16:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191874; x=1666727874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9rut2p2cIJl+gOrMDwXO7QvojhOGcINHMZCJqud62c=;
  b=fO1/wW0sg+x+Uci+j1CsYBsw6SljQlqtMJuA+AX0tkMDyGZsvRtpFB9O
   jhF1g976U39Em7Rn7lB7d4k6WkfV50Uw0SQE19DtmA+IX5d5Iml93KtrA
   nBk+6VV2h0z6UeFGqjCzEvGwRjaIDgz99l+nCDad7ffLK0cyziv81xH3a
   QlruCdZcBTgUdI9S0qzQoWi/eXg3tVgLhshDukiiZIMljrw8bgi1bQETV
   ii24DwJ+VWibA8oqu5ehKg3dOhPgp3/Fp7pxrjy316K+b8usTQhPW3AHn
   fLsxPlqp9De4FRvsioyBuVs3DAkY07/UFcB+DbKqlGThta0sgW6FcdRyd
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545853"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:53:57 +0800
IronPort-SDR: vASpk3GGv9+UCynKASqOi+fF+x7QUSu8OkjcBP1MGtld+N1qA9myMbB2BPRHTQ2yA3DKH+XhZt
 QliLyGm0pJUzRTO5uNHGL4triaw3mORmOqcT87dMxv+/bz1lsqP958Mhkt2RHbIMSb6jzdQKrV
 LACAc1abORamYk4J3dWHsuFMpM45e3n4rNQodDJ8DnWi4k8zP5+sqScJKVOBELMno7HPH46Mzz
 cOPS/kPdJEFWjQVpQhMeNbu1pGxstGWfh9CoTnkocGGtLeNjwfVVumA0UBH+EzhkQlvERgp3ZQ
 0ga85MVtsCPJka2Y8W1xZOc5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:55 -0700
IronPort-SDR: jLN67SRVfQ+M8+lWYHBkvJyusCdkYeJWN08Daox/eGpo/VDrAkxVzvwHTwfCybR8nuR/tZYPp4
 JmJgABWCz0xAZOxey6qHU60t+vG1WzHC0+21yiIs/mAmmYDnjpmSpez70Ut0VqG1uQ8yImW6bb
 YKLAHOzXWu5cxqZ46dXPImaNjoKNoKf5AKz7P1w0+ybJ1/Ym9X6xcEh+BSI1Ho42yBcGUwTw6u
 psiG/vsL370mzCaA9PsABoDg/AbKi+IYRi3OlnRCsp4jupTcQcNdMMqEDFJBbM/28MXbT3dJfv
 zFM=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:53:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v4 06/11] dt-binding: pmu: Add RISC-V PMU DT bindings
Date:   Mon, 25 Oct 2021 12:53:45 -0700
Message-Id: <20211025195350.242914-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the DT bindings for RISC-V PMU driver. It also defines
the interrupt related properties to allow counter overflow interrupt.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/perf/riscv,pmu.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
new file mode 100644
index 000000000000..497caad63f16
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pmu/riscv,pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V PMU
+
+maintainers:
+  - Atish Patra <atish.patra@wdc.com>
+
+description:
+  The "Sscofpmf" extension allows the RISC-V PMU counters to overflow and
+  generate a local interrupt so that event sampling can be done from user-space.
+  The above said ISA extension is an optional extension to maintain backward
+  compatibility and will be included in privilege specification v1.12 . That's
+  why the interrupt property is marked as optional. The platforms with sscofpmf
+  extension should add this property to enable event sampling.
+  The device tree node with the compatible string is mandatory for any platform
+  that wants to use pmu counter start/stop methods using SBI PMU extension.
+
+properties:
+  compatible:
+    enum:
+      - riscv,pmu
+
+    description:
+      Should be "riscv,pmu".
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - None
+optional:
+  - compatible
+  - interrupts-extended
+
+examples:
+  - |
+    pmu {
+      compatible = "riscv,pmu";
+      interrupts-extended = <&cpu0intc 13>,
+                            <&cpu1intc 13>,
+                            <&cpu2intc 13>,
+                            <&cpu3intc 13>;
+    };
+...
-- 
2.31.1

