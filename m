Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF99CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA66D610C7
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhIJT3l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:29:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29545 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhIJT3e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631302102; x=1662838102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9rut2p2cIJl+gOrMDwXO7QvojhOGcINHMZCJqud62c=;
  b=OaTrLuOmXWeqUB+fKO0ArbPAZsVT11x4D+r2EZP01kmKc92knB9oLaA1
   kDFak5o5Tm/B+dZ5Y+h24tcExwPh0orHdc4XNjZeamNmZXOU0Se9iU7nL
   e3nUUS75e7iPRJiCYVoG5wEJMB+NtVGBwPhKU8gyY+8C+9F6QcidKlbKs
   CieBgCFFYMw5qsmDmIvwokfgFyqW9MC3R3PhbMnJKc5e60JzxP8fqKquZ
   Ul7n8GyNprM1sgYqGrBenYQPtJ8yrZFJ9rZwMkiVOjEzkrJMqy9lC7Wk8
   PMo7ecjIZ26enKPWNRrttJYN0zIWyLiP8lO9UJKW23/l0aYh3o/+2thZw
   A==;
X-IronPort-AV: E=Sophos;i="5.85,283,1624291200"; 
   d="scan'208";a="179706175"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2021 03:28:22 +0800
IronPort-SDR: UbumN/TvgdlCLxod/Mpmq66H5I3eogW8inHackzxqlbtMyvI2tSef8Un+k48T+bFhkHBUSGNLr
 ni1c+Y6I6Tt/fP0mO/B7eWBgzIvh/FtH/29MC0ia25w4+79oise60YJYzPueCgmyODtHikXiZw
 a4SpFQyJRUGDg+8sVMKJss6dFtYyOYCqv4JxcpNatnyXu159HkQwoyTRzmFuVM5av4Ls3T/UZ5
 LLLiW7ne+9Ms1BifKG7vDqjhy6fXqCKMR8urodeOug8/mdc653dxquxwaZB7gu3r3fIZNC8msG
 RgTHzciAYU84BgPzaM4zTM8r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 12:03:17 -0700
IronPort-SDR: SllFO2XYLXRp7dP6K2yczVZza3pYVg3Q1IWrDiHd2rH/A2Xe+SCVxsIrXeBwO0bIqBNWpyeXS+
 j8ZDWXZ6eAmZBacGZxQHywh9FAwb0qkjCKIgUJMGMSJrZyGWDH7poiJ5YRxRy2ee7k5aXJuSJf
 c7RBmNx0CzIsq7fiM/SwUrTZlX6d26vN/FtosvVv03Rq8mE35vo3cu+ueZj4BQJ2V4QkL4w5AH
 +TQB5S2xN03lcLhUqo2uAbyQTEH0A+RPeWpSJI1TEAOUtYx1n0J92dIBvMcDfKM6wTN5Lv+zSc
 mOQ=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2021 12:28:23 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v3 06/10] dt-binding: pmu: Add RISC-V PMU DT bindings
Date:   Fri, 10 Sep 2021 12:27:53 -0700
Message-Id: <20210910192757.2309100-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
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

