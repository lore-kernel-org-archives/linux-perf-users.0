Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BCFC43219
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BF961076
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhJYT7T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:59:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbhJYT4S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 15:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191636; x=1666727636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ra5cHQjoFPKLRZBOzWvo0QPRgs19DUjfkgJ7ryBlKZA=;
  b=V97VeQp1mRx65qIM/mGsndqW4pQtb15rmAydjga4jVhcGXDeZIW2gXDJ
   gYO2Ucgu/6hMQTPnAVZDDDQAX8NLgmll8DVlJNsuolvC8EK4XXrM3eFfH
   dEQn1bF9uPoiYzP9LRBmDXMpsqnb8/9Za1YD5NZDz22Pdefv54vEK5Mln
   x0K7r1yCNNBAhYatcQPvmkHKzTWp9nLLzmy8sVjhpVdqAfRpYRu9kChgL
   xGA7eXahSr/5AaXFjhWOs0S91jMQ4dF2dYfPAiupJDiAQcWkwGgjSQ2NX
   FJfNoQmmxc/F2Zznhs/kbXoewrRA5TxM5VBeSFHnACvgUpiIlKG37YgmF
   g==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545841"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:53:54 +0800
IronPort-SDR: fOT1yPSiBiIbY64We5Dxk8Ta7/7ktRM8DfE5mcFJwEtoRobo9GuhBVXyltUINMBvdwShNou/P9
 eZKq/qn+0ClcMMDQlS5pkabbNO4yyHa0oR33dlcy/0z5nmjRz3YY/eq70WeC0Grf8suQ+KHhSE
 aUTBGgklsM3bZPOs3V5HUyNMxXG4nWBhKJmQ0mRyDJuWZwfTUJGnNpRSMewpxsAfFVD7g+ezvh
 Gl0bkz5wOHMLNZuDtKikL3wZyLHC6Yctj6Rf73wb3ehsqwxAyNf/BSAuzkpAdG5yJzZHtBUFHC
 AbVDsTGvqZuOBOz8t9VJHZAp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:52 -0700
IronPort-SDR: 7wb65s50StrG+Zvc4UY2LXG7YFZXSdHtiL3Tof2hdRS+IP4IdNXFPTnF4uex7cAxmkIMBFPzab
 8rXP4QYsU/fUJO1ywB3SRuMuD4LTZeluPMv9o6718jS3JiYgTUc+myKk9ED4lq9OTeUEVaIZ1Q
 bbPoiry319MQnb6RYihD9moUgK8ZJCryUa6mMAaIJQP2cd0sp20bEEOca8kDBqciza9NK+R186
 SqtFFS7Jf+246AkFsE/L6Zc2rGHt4ZiyRC1ktPkWPcYlnTb9+ZSF8/pvn004H5QPoklJ0CsQvs
 cGo=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:53:55 -0700
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
Subject: [v4 00/11] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
Date:   Mon, 25 Oct 2021 12:53:39 -0700
Message-Id: <20211025195350.242914-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series adds improved perf support for RISC-V based system using
SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension allows
the kernel to program the counters for different events and start/stop counters
while the sscofpmf extension allows the counter overflow interrupt and privilege
mode filtering. An hardware platform can leverage SBI PMU extension without
the sscofpmf extension if it supports mcountinhibit and mcounteren. However,
the reverse is not true. With both of these extension enabled, a platform can
take advantage of all both event counting and sampling using perf tool. 

This series introduces a platform perf driver instead of a existing arch
specific implementation. The new perf implementation has adopted a modular
approach where most of the generic event handling is done in the core library
while individual PMUs need to only implement necessary features specific to
the PMU. This is easily extensible and any future RISC-V PMU implementation
can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
as a part of this series.

The legacy driver tries to reimplement the existing minimal perf under a new
config to maintain backward compatibility. This implementation only allows
monitoring of always running cycle/instruction counters. Moreover, they can
not be started or stopped. In general, this is very limited and not very useful.
That's why, I am not very keen to carry the support into the new driver.
However, I don't want to break perf for any existing hardware platforms.
If everybody agrees that we don't need legacy perf implementation for older
implementation, I will be happy to drop PATCH 4.

This series has been tested in Qemu (RV64 & RV32) and HiFive Unmatched.
Qemu[5] & OpenSBI [3] patches are required to test it on Qemu and a dt patch
required in U-Boot[6] for HiFive Unmatched. Qemu changes are not
backward compatible. That means, you can not use perf anymore on older Qemu
versions with latest OpenSBI and/or Kernel. However, newer kernel will
just use legacy pmu driver if old OpenSBI is detected.

The U-Boot patch is just an example that encodes few of the events defined
in fu740 documentation [7] in the DT. We can update the DT to include all the
events defined if required.

Here is an output of perf stat/report while running perf benchmark with OpenSBI, 
Linux kernel and U-Boot patches applied.

HiFive Unmatched:
=================
perf stat -e cycles -e instructions -e L1-icache-load-misses -e branches -e branch-misses \
-e r0000000000000200 -e r0000000000000400 \
-e r0000000000000800 perf bench sched messaging -g 25 -l 15

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 25 groups == 1000 processes run

     Total time: 0.826 [sec]

 Performance counter stats for 'perf bench sched messaging -g 25 -l 15':

        3426710073      cycles                (65.92%)
        1348772808      instructions          #0.39  insn per cycle  (75.44%)
                 0      L1-icache-load-misses (72.28%)
         201133996      branches              (67.88%)
          44663584      branch-misses         #22.21% of all branches (35.01%)
         248194747      r0000000000000200     (41.94%) --> Integer load instruction retired
         156879950      r0000000000000400     (43.58%) --> Integer store instruction retired
           6988678      r0000000000000800     (47.91%) --> Atomic memory operation retired

       1.931335000 seconds time elapsed

       1.100415000 seconds user
       3.755176000 seconds sys


QEMU:
=========
Perf stat:
=========

[root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r8000000000000007 \
-e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-misses \
-e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
-e cycles -e instructions perf bench sched messaging -g 15 -l 10 \
Running with 15*40 (== 600) tasks.
Time: 6.578

 Performance counter stats for './hackbench -pipe 15 process':

             1,794      r8000000000000005      (52.59%) --> SBI_PMU_FW_SET_TIMER
             2,859      r8000000000000007      (60.74%) --> SBI_PMU_FW_IPI_RECVD
             4,205      r8000000000000006      (68.71%) --> SBI_PMU_FW_IPI_SENT
                 0      r0000000000020002      (81.69%)
     <not counted>      r0000000000020004      (0.00%)
     <not counted>      branch-misses          (0.00%)
     <not counted>      cache-misses           (0.00%)
         7,878,328      dTLB-load-misses       (15.60%)
           680,270      dTLB-store-misses      (28.45%)
         8,287,931      iTLB-load-misses       (39.24%)
    20,008,506,675      cycles                 (48.60%)
    21,484,427,932      instructions   # 1.07  insn per cycle (56.60%)

       1.681344735 seconds time elapsed

       0.614460000 seconds user
       8.313254000 seconds sys


Perf record:
============
[root@fedora-riscv riscv]# perf record -e cycles -e instructions \
-e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses -c 10000 \
perf bench sched messaging -g 15 -l 10
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 15 groups == 600 processes run

     Total time: 1.261 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.101 MB perf.data (845 samples) ]

[root@fedora-riscv riscv]# perf report
Available samples                                                               
407 cycles                                                                     _
407 instructions                                                               _
18 dTLB-load-misses                                                            _
2 dTLB-store-misses                                                            _
11 iTLB-load-misses                                                            _
                           
[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
[3] https://github.com/atishp04/opensbi/tree/pmu_sscofpmf_v2 
[4] https://github.com/atishp04/linux/tree/riscv_pmu_v4
[5] https://github.com/atishp04/qemu/tree/riscv_pmu_v3
[6] https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu
[7] https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57337d_fu740-c000-manual-v1p3.pdf

Changes from v3->v4:
1. Do not proceed overflow handler if event doesn't set for sampling.
2. overflow status register is only read after counters are stopped.
3. Added the PMU DT node for HiFive Unmatched.

Changes from v2->v3:
1. Added interrupt overflow support.
2. Cleaned up legacy driver initialization.
3. Supports perf record now.
4. Added the DT binding and maintainers file.
5. Changed cpu hotplug notifier to be multi-state.
6. OpenSBI doesn't disable cycle/instret counter during boot. Update the
   perf code to disable all the counter during the boot.

Changes from v1->v2
1. Implemented the latest SBI PMU extension specification.
2. The core platform driver was changed to operate as a library while only
   sbi based PMU is built as a driver. The legacy one is just a fallback if
   SBI PMU extension is not available.

Atish Patra (11):
RISC-V: Remove the current perf implementation
RISC-V: Add CSR encodings for all HPMCOUNTERS
RISC-V: Add a perf core library for pmu drivers
RISC-V: Add a simple platform driver for RISC-V legacy perf
RISC-V: Add RISC-V SBI PMU extension definitions
dt-binding: pmu: Add RISC-V PMU DT bindings
RISC-V: Add perf platform driver based on SBI PMU extension
RISC-V: Add interrupt support for perf
Documentation: riscv: Remove the old documentation
riscv: dts: fu740: Add pmu node
MAINTAINERS: Add entry for RISC-V PMU drivers

.../devicetree/bindings/perf/riscv,pmu.yaml   |  51 ++
Documentation/riscv/pmu.rst                   | 255 ------
MAINTAINERS                                   |  10 +
arch/riscv/Kconfig                            |  13 -
arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |   3 +
arch/riscv/include/asm/csr.h                  |  66 +-
arch/riscv/include/asm/perf_event.h           |  72 --
arch/riscv/include/asm/sbi.h                  |  97 +++
arch/riscv/kernel/Makefile                    |   1 -
arch/riscv/kernel/perf_event.c                | 485 ------------
drivers/perf/Kconfig                          |  25 +
drivers/perf/Makefile                         |   5 +
drivers/perf/riscv_pmu.c                      | 331 ++++++++
drivers/perf/riscv_pmu_legacy.c               | 143 ++++
drivers/perf/riscv_pmu_sbi.c                  | 732 ++++++++++++++++++
include/linux/cpuhotplug.h                    |   1 +
include/linux/perf/riscv_pmu.h                |  69 ++
17 files changed, 1532 insertions(+), 827 deletions(-)
create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
delete mode 100644 Documentation/riscv/pmu.rst
delete mode 100644 arch/riscv/kernel/perf_event.c
create mode 100644 drivers/perf/riscv_pmu.c
create mode 100644 drivers/perf/riscv_pmu_legacy.c
create mode 100644 drivers/perf/riscv_pmu_sbi.c
create mode 100644 include/linux/perf/riscv_pmu.h

--
2.31.1

