Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC6C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243E06139F
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhJDSWF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhJDSWF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Oct 2021 14:22:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5292C061745
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Oct 2021 11:20:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk10so2891815pjb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Oct 2021 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pEjTxCQKuPkdzyQQSESkdNKEWA1LvyzgE120tyKjY/k=;
        b=rGnHyMlngVZkVwcemVB84QoJgkH1XLR0Hg7szuZRrfBs+vpJHEce6HZlQJyes1QbVm
         SbpROkR94JhvXXXC5WkOwInC9p0RM1G5uqrOOUv2b9BVFzJo16pY2Bd/+UJFUEpH+gMm
         hZfXJdrboGH78IJt6C83lbLsW71NNip/Op9Rcr2O1vMhYiFYF4oxzQVGHxYNd6Vd3Wcg
         817+jvBFq+t5osSy8FUpDwF8Rt4paPtwvELMG6/seyy/AsVlXzD0QUshhKcKVgpuM3b1
         EM9MLqKWPIQA8hZ6vVSDG3YG3ZAOq6OHjrZ2xU7jufjBDvNJjlH70KxyuJT6nd2+5ZwM
         0ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pEjTxCQKuPkdzyQQSESkdNKEWA1LvyzgE120tyKjY/k=;
        b=j1q8xAcQiUiorF+9Jt3S2rkvHdmHmgZzFFiJs+XfUrbNXz6dZEX4/vMYsTypY2AgH1
         HP+7uqbq0+zNamLirIoyz7lAL2W/ODRGxAc/MCATvnMpUNfYZMeKva8+y+G8WkndVP69
         eBsvTpByNBWwAuBNr77B4RIFw0Mi3K+sYbJQspAHiKV/QEk2Wj4ihycrQV6TFCrTv0Nj
         HfQc0B+Am/ArxZYnEbPHtL5qD7CjjHqglvE5mU1glkzolQeF1k1Kw4yK8Rlm25ZeIrqb
         xAk7mVaU3pnuE+R/Zcznnyc5tTC7M/LUvUnHZSiRXyqOmK2p7zD8oMGVMQnErtWnQwk6
         Xr9Q==
X-Gm-Message-State: AOAM532mJ+h7YTMQGFlNtlrzluVOMoZ+eIuIQbl2t8q0YHz3I5qtDXkc
        2wj+1NENgf+9zSxuFg4RY4WxZg==
X-Google-Smtp-Source: ABdhPJzK5iZkh9VfvvOe8LwLx7+UekY7XK1kf6LgOA8CSZG1sCV/38BCb5MgWXDwf85wkTC4ZS3fHA==
X-Received: by 2002:a17:90a:5d11:: with SMTP id s17mr22510232pji.230.1633371614886;
        Mon, 04 Oct 2021 11:20:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x13sm699826pgt.80.2021.10.04.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:20:14 -0700 (PDT)
Date:   Mon, 04 Oct 2021 11:20:14 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 11:20:12 PDT (-0700)
Subject:     Re: [v3 00/10] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        alexander.shishkin@linux.intel.com,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        djwong@kernel.org, devicetree@vger.kernel.org,
        guoren@linux.alibaba.com, xypron.glpk@gmx.de, jolsa@redhat.com,
        john.garry@huawei.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        robh+dt@kernel.org, vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-62d18ad4-0547-42bb-87a0-5e96e5354650@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 10 Sep 2021 12:27:47 PDT (-0700), Atish Patra wrote:
> This series adds improved perf support for RISC-V based system using
> SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension allows

Last we talked the SBI-0.3 stuff was in an uncertain state and I'm not 
sure we ever got to a point of agreement there.  I've decided to just 
stop worrying about the state of extensions, so if you guys want the 
SBI-0.3 stuff merged then just go say it's frozen and that'll be good 
enough for me.

> the kernel to program the counters for different events and start/stop counters
> while the sscofpmf extension allows the counter overflow interrupt and privilege
> mode filtering. An hardware platform can leverage SBI PMU extension without
> the sscofpmf extension if it supports mcountinhibit and mcounteren. However,
> the reverse is not true. With both of these extension enabled, a platform can
> take advantage of all both event counting and sampling using perf tool.
>
> This series introduces a platform perf driver instead of a existing arch
> specific implementation. The new perf implementation has adopted a modular
> approach where most of the generic event handling is done in the core library
> while individual PMUs need to only implement necessary features specific to
> the PMU. This is easily extensible and any future RISC-V PMU implementation
> can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
> as a part of this series.
>
> The legacy driver tries to reimplement the existing minimal perf under a new
> config to maintain backward compatibility. This implementation only allows
> monitoring of always running cycle/instruction counters. Moreover, they can
> not be started or stopped. In general, this is very limited and not very useful.
> That's why, I am not very keen to carry the support into the new driver.
> However, I don't want to break perf for any existing hardware platforms.
> If nobody really uses perf currently, I will be happy to drop PATCH 4.
>
> This series has been tested in Qemu on both RV64 & RV32. Qemu[5] & OpenSBI [3]
> patches are required to test it. Qemu changes are not backward compatible.
> That means, you can not use perf anymore on older Qemu versions with latest
> OpenSBI and/or Kernel. However, newer kernel will just use legacy pmu driver if
> old OpenSBI is detected or hardware doesn't implement mcountinhibit.
>
> Here is an output of perf stat/report while running hackbench with OpenSBI & Linux
> kernel patches applied [3].
>
> Perf stat:
> =========
>
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r8000000000000007
> -e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-misses
> -e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses
> -e cycles -e instructions ./hackbench -pipe 15 process
> Running with 15*40 (== 600) tasks.
> Time: 6.578
>
>  Performance counter stats for './hackbench -pipe 15 process':
>
>              6,491      r8000000000000005      (52.59%) --> SBI_PMU_FW_SET_TIMER
>             20,433      r8000000000000007      (60.74%) --> SBI_PMU_FW_IPI_RECVD
>             21,271      r8000000000000006      (68.71%) --> SBI_PMU_FW_IPI_SENT
>                  0      r0000000000020002      (76.55%)
>      <not counted>      r0000000000020004      (0.00%)
>      <not counted>      branch-misses          (0.00%)
>      <not counted>      cache-misses           (0.00%)
>         57,537,853      dTLB-load-misses       (9.49%)
>          2,821,147      dTLB-store-misses      (18.64%)
>         52,928,130      iTLB-load-misses       (27.53%)
>     89,521,791,110      cycles                 (36.08%)
>     90,678,132,464      instructions #    1.01  insn per cycle (44.44%)
>
>        6.975908032 seconds time elapsed
>
>        3.130950000 seconds user
>       24.353310000 seconds sys
>
> The patches can also be found in the github[4].
>
> Perf record:
> ============
> [root@fedora-riscv riscv]# perf record -e cycles -e instructions -e \
> dTLB-load-misses -e dTLB-store-misses -c 1000 ./hackbench -pipe 15 process 15
> Running with 15*40 (== 600) tasks.
> Time: 1.238
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.106 MB perf.data (1020 samples) ]
>
> [root@fedora-riscv riscv]# perf report
> Available samples
> 372 cycles                                                                     ◆
> 372 instructions                                                               ▒
> 262 dTLB-load-misses                                                           ▒
> 14 dTLB-store-misses
>
> The patches can also be found in the github[4].
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
> [3] https://github.com/atishp04/opensbi/tree/pmu_sscofpmf
> [4] https://github.com/atishp04/linux/tree/riscv_pmu_v3
> [5] https://github.com/atishp04/qemu/tree/riscv_pmu_v2
>
> Changes from v3->v4:
> 1. Added interrupt overflow support.
> 2. Cleaned up legacy driver initialization.
> 3. Supports perf record now.
> 4. Added the DT binding and maintainers file.
> 5. Changed cpu hotplug notifier to be multi-state.
> 6. OpenSBI doesn't disable cycle/instret counter during boot. Update the
>    perf code to disable all the counter during the boot.
>
> Changes from v1->v2
> 1. Implemented the latest SBI PMU extension specification.
> 2. The core platform driver was changed to operate as a library while only
>    sbi based PMU is built as a driver. The legacy one is just a fallback if
>    SBI PMU extension is not available.
>
> Atish Patra (10):
> RISC-V: Remove the current perf implementation
> RISC-V: Add CSR encodings for all HPMCOUNTERS
> RISC-V: Add a perf core library for pmu drivers
> RISC-V: Add a simple platform driver for RISC-V legacy perf
> RISC-V: Add RISC-V SBI PMU extension definitions
> dt-binding: pmu: Add RISC-V PMU DT bindings
> RISC-V: Add perf platform driver based on SBI PMU extension
> RISC-V: Add interrupt support for perf
> Documentation: riscv: Remove the old documentation
> MAINTAINERS: Add entry for RISC-V PMU drivers
>
> .../devicetree/bindings/perf/riscv,pmu.yaml   |  51 ++
> Documentation/riscv/pmu.rst                   | 255 ------
> MAINTAINERS                                   |  10 +
> arch/riscv/Kconfig                            |  13 -
> arch/riscv/include/asm/csr.h                  |  66 +-
> arch/riscv/include/asm/perf_event.h           |  72 --
> arch/riscv/include/asm/sbi.h                  |  97 +++
> arch/riscv/kernel/Makefile                    |   1 -
> arch/riscv/kernel/perf_event.c                | 485 ------------
> drivers/perf/Kconfig                          |  25 +
> drivers/perf/Makefile                         |   5 +
> drivers/perf/riscv_pmu.c                      | 331 ++++++++
> drivers/perf/riscv_pmu_legacy.c               | 143 ++++
> drivers/perf/riscv_pmu_sbi.c                  | 731 ++++++++++++++++++
> include/linux/cpuhotplug.h                    |   1 +
> include/linux/perf/riscv_pmu.h                |  69 ++
> 16 files changed, 1528 insertions(+), 827 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> delete mode 100644 Documentation/riscv/pmu.rst
> delete mode 100644 arch/riscv/kernel/perf_event.c
> create mode 100644 drivers/perf/riscv_pmu.c
> create mode 100644 drivers/perf/riscv_pmu_legacy.c
> create mode 100644 drivers/perf/riscv_pmu_sbi.c
> create mode 100644 include/linux/perf/riscv_pmu.h
