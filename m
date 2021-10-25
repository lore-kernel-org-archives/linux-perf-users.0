Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A1C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0B60E8B
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhJYUFT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:05:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9214 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbhJYUCT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 16:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191997; x=1666727997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DAp64paU3TCuJOhu7apCE+cFKSV+lH5b3Cp62qoHD/M=;
  b=WEejXtC3tGLDcPQCHge//twq0zOlM5vUwHA1mKDDEf4i/dw7bnh9wEFX
   6w99HqGcMBh/xHEcOFdznaJ7GeeW2SIBzipNuvtesoEF6UMdU3c5aGEmr
   IIT5tIdV/bAGJtZcoUELhCxlJzm+lAubXQmTvQ9tcneqO8srISRHCdEC/
   O+ygaaQBEKsPZY3ILiIQ1elC3gSShkhecE24JHxznpDhvEYdVMJr7oRgG
   kOEKD8KjrvSbMzr/Zqn1xRPADYeBosBrcB0lBDwHaMLS7BAXft7GZlY3H
   KnALm+hVzMbLE5YG4QvJpM3SsdxzwZtcCCD2MwrZhdYJRYGkcF70fmblW
   w==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545867"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:54:00 +0800
IronPort-SDR: KH8Oxg4bRlzZPNdlF8Vq36pxf3jgqd0QKW8q9IxvVWJ4j+sXef9Etyw+7cZjRheVS75CjpGavr
 WN8pieHDNLCrFQuJCJy6ur7A3XDU9r3ond7SyG2M77o4o37lvtsfrUZjUwkXEfZY+/HtLxfpY1
 COol8wAQ2G7sV3eK5fmiMv14lFYxr41Sw0AFTUedurbE19R4fvsCYZTWvEX+TqKoVGrDUbCOni
 tCXcOYniL8kz2fvh3LvLn08uAt/cMal+UFUi6gyHmzFz0IAYeYS0mwbREMKRoEnwQq6W/xZhnP
 BoeCb7y5i7YsIDZFfKXzwSui
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:58 -0700
IronPort-SDR: YhsfOcm7t5ZjUT2XWJ2dKLP9rQUY8bpvIdSwSlepuo+dw5pfP4Jjpr1dWnNabwZcsQ0PSc3VDZ
 qSqCXA4eG3rOesSHot/1r1IC25460Ko/uRSv+jPQgXGzz25iXCwXRraa3fkrS3UfOfsyxHfMz9
 pX2UTRfMTKKps882CEusquX8tgFN73mHPurk/oBAxkYU76olCsk5eddZNukU6vsBdasmYIA5Na
 gp1MZnvhu6nRCnPTpR02qE55EkgLgNpShhtqWyI5TKH2zKHYDLm8U/Z8KkNOI/t3ZkomcmlQme
 zsc=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:54:00 -0700
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
Subject: [v4 11/11] MAINTAINERS: Add entry for RISC-V PMU drivers
Date:   Mon, 25 Oct 2021 12:53:50 -0700
Message-Id: <20211025195350.242914-12-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add myself and Anup as maintainer for RISC-V PMU drivers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9af529acb6a6..6a184a4162b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16056,6 +16056,16 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V PMU DRIVERS
+M:	Atish Patra <atish.patra@wdc.com>
+M:	Anup Patel <anup.patel@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pmu/riscv,pmu.yaml
+F:	drivers/perf/riscv_pmu.c
+F:	drivers/perf/riscv_pmu_legacy.c
+F:	drivers/perf/riscv_pmu_sbi.c
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.31.1

