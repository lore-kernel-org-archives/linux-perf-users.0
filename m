Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA1C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB6611B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhIJT3g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:29:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29545 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhIJT3b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631302099; x=1662838099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M6ASK3pxzTzUEWfr0bWd/gQjwbvnSl8KehAgnRUs/7c=;
  b=BPfXc+zeFi+4XrMHzWFnAXofFwan9znzMbwgfKo9/PepFMKq8sNV6aEg
   zCjIgKxfiHQFyNx+ZdqP8f04zQ0t/cXLb+/1tR8eLKvbEW2vYX7kqAalx
   A2Z13VRcB+cg6/EsshvtlztVJAGscsGDoqnqruSFtyaH71wjZwhtOK9FT
   VVT8SPKnDDBc0tD869CmVNn7iDzYOok2aRDI1393Hd8JNpbK8gHcGirm4
   PyJZ6Mz6ymAtKddkW9YnSLja0veCfnQh0+YqcVNc1leUN5bWBCex5qaiM
   NsG64UaT1ptaHR7JXQA2V1OJsXAgFbbHPFbsJHTbTyy6HH/nUE67NcTPQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,283,1624291200"; 
   d="scan'208";a="179706168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2021 03:28:18 +0800
IronPort-SDR: kDQ/494TAIi0Id6yjVxCmKanlIG4LHBhWnrWTR4riPxaIIcrsK71Wziwk9YkhDMcRCFILsXbkP
 CzWzkf7WPSjmvqXSbkCn49TzLAyBEX3fiIFvt167OHNjOAbDhc6HwzDpmOsTUkx+Kryx4MtncK
 DeJgu7v30hSBCiza7h2wXqQNePFSUGfMVATXzR6GQm/B3wGbQ84fx4VKuFC2Qkf7dwd5ASSuQJ
 R/cLly7vEGHTUcWtXpveCxBA72I8DFNTAxXpSX75F/XVZyrOjsp+zT4EtC4TPiBSptDo0BLTi6
 aNpOexRddIoAr3gFReXnqMfG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 12:03:13 -0700
IronPort-SDR: h8rmJk7aJGl1DQ4xvXmYn2Ft9W/zWNGDt3UqKP+wySzYpCanclmM/1AbUHR+fzsnOGiRLz4bbv
 Zl00Q0yl8i2pl4nzC51vYeNN76Ct6hZzj0C7mhwdLVQTvQKjHK5BJHIS9L4rbkUTcvTwebwWKR
 CUhlZgJDQdrDONliJ+Z7tbVpsXTJnbRp8wwucn7gYy4EtcSC80P5UCbgGjEfu0mSi15aZKVkwe
 dnJm1lYVqXlnTNUxsjbO2wjhAj6zZa050futMhvxaheAvJ6L4/ryQuaG8NtSaIVYY0nf0Ht7DS
 E34=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2021 12:28:18 -0700
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
Subject: [v3 00/10] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
Date:   Fri, 10 Sep 2021 12:27:47 -0700
Message-Id: <20210910192757.2309100-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
If nobody really uses perf currently, I will be happy to drop PATCH 4.

This series has been tested in Qemu on both RV64 & RV32. Qemu[5] & OpenSBI [3]
patches are required to test it. Qemu changes are not backward compatible.
That means, you can not use perf anymore on older Qemu versions with latest
OpenSBI and/or Kernel. However, newer kernel will just use legacy pmu driver if
old OpenSBI is detected or hardware doesn't implement mcountinhibit.

Here is an output of perf stat/report while running hackbench with OpenSBI & Linux
kernel patches applied [3].

Perf stat:
=========

[root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r8000000000000007
-e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-misses
-e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses
-e cycles -e instructions ./hackbench -pipe 15 process
Running with 15*40 (== 600) tasks.
Time: 6.578

 Performance counter stats for './hackbench -pipe 15 process':

             6,491      r8000000000000005      (52.59%) --> SBI_PMU_FW_SET_TIMER
            20,433      r8000000000000007      (60.74%) --> SBI_PMU_FW_IPI_RECVD
            21,271      r8000000000000006      (68.71%) --> SBI_PMU_FW_IPI_SENT
                 0      r0000000000020002      (76.55%)
     <not counted>      r0000000000020004      (0.00%)
     <not counted>      branch-misses          (0.00%)
     <not counted>      cache-misses           (0.00%)
        57,537,853      dTLB-load-misses       (9.49%)
         2,821,147      dTLB-store-misses      (18.64%)
        52,928,130      iTLB-load-misses       (27.53%)
    89,521,791,110      cycles                 (36.08%)
    90,678,132,464      instructions #    1.01  insn per cycle (44.44%)

       6.975908032 seconds time elapsed

       3.130950000 seconds user
      24.353310000 seconds sys

The patches can also be found in the github[4].

Perf record:
============
[root@fedora-riscv riscv]# perf record -e cycles -e instructions -e \
dTLB-load-misses -e dTLB-store-misses -c 1000 ./hackbench -pipe 15 process 15
Running with 15*40 (== 600) tasks.
Time: 1.238
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.106 MB perf.data (1020 samples) ]

[root@fedora-riscv riscv]# perf report  
Available samples                                                               
372 cycles                                                                     ◆
372 instructions                                                               ▒
262 dTLB-load-misses                                                           ▒
14 dTLB-store-misses      

The patches can also be found in the github[4].

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
[3] https://github.com/atishp04/opensbi/tree/pmu_sscofpmf 
[4] https://github.com/atishp04/linux/tree/riscv_pmu_v3
[5] https://github.com/atishp04/qemu/tree/riscv_pmu_v2

Changes from v3->v4:
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

Atish Patra (10):
RISC-V: Remove the current perf implementation
RISC-V: Add CSR encodings for all HPMCOUNTERS
RISC-V: Add a perf core library for pmu drivers
RISC-V: Add a simple platform driver for RISC-V legacy perf
RISC-V: Add RISC-V SBI PMU extension definitions
dt-binding: pmu: Add RISC-V PMU DT bindings
RISC-V: Add perf platform driver based on SBI PMU extension
RISC-V: Add interrupt support for perf
Documentation: riscv: Remove the old documentation
MAINTAINERS: Add entry for RISC-V PMU drivers

.../devicetree/bindings/perf/riscv,pmu.yaml   |  51 ++
Documentation/riscv/pmu.rst                   | 255 ------
MAINTAINERS                                   |  10 +
arch/riscv/Kconfig                            |  13 -
arch/riscv/include/asm/csr.h                  |  66 +-
arch/riscv/include/asm/perf_event.h           |  72 --
arch/riscv/include/asm/sbi.h                  |  97 +++
arch/riscv/kernel/Makefile                    |   1 -
arch/riscv/kernel/perf_event.c                | 485 ------------
drivers/perf/Kconfig                          |  25 +
drivers/perf/Makefile                         |   5 +
drivers/perf/riscv_pmu.c                      | 331 ++++++++
drivers/perf/riscv_pmu_legacy.c               | 143 ++++
drivers/perf/riscv_pmu_sbi.c                  | 731 ++++++++++++++++++
include/linux/cpuhotplug.h                    |   1 +
include/linux/perf/riscv_pmu.h                |  69 ++
16 files changed, 1528 insertions(+), 827 deletions(-)
create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
delete mode 100644 Documentation/riscv/pmu.rst
delete mode 100644 arch/riscv/kernel/perf_event.c
create mode 100644 drivers/perf/riscv_pmu.c
create mode 100644 drivers/perf/riscv_pmu_legacy.c
create mode 100644 drivers/perf/riscv_pmu_sbi.c
create mode 100644 include/linux/perf/riscv_pmu.h

--
2.31.1

