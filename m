Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB93C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567DE610E6
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhJFS3c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhJFS3b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 14:29:31 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF7C061760
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Oct 2021 11:27:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q189so7600495ybq.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Oct 2021 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+skB1HbPSAUXUVGPBTXTTzBDV28QLRW6pLRxEsII1I=;
        b=XRaOmyhpTkYI2RNEZjrVdOZFE24IBvyG0AwZo+gC8CvTKCZZpHlStkZ3/VzgVf4a+c
         5oamGtKVoPxKx/kyEpHBPTRpcc9zAJEmncyYDGvFfaTe7BzFi5MupxT1jxXYZR18iaO8
         MxU3QlNTTtLIGmCoB7kvuSVziK/lFf7Tq45Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+skB1HbPSAUXUVGPBTXTTzBDV28QLRW6pLRxEsII1I=;
        b=i4QpkpHcDHFyGb9gsRh2hmNH+qW3nVE0zgs3ZwLLpOnMKvQrCP14F6X7AaMxgsdzWk
         NkAmtM0HtVY9jjETQT830Km9iBp0m2HPl0YmHzUTOqGpwLNgkqPFM3DQ/yZ7lIesix/3
         Bp8HguIkp+/NE3eFEg15BmlFtI0GC2C9EKDVewFcl9izIhnNf2etjrbKlATP7jSF7i7X
         zly9NPxrdYCOjv2hLMtpvBxA7YUkp1YNiKwbgFxgD7WUsiMYHsVCT9ZgiSU/2LaZ8uqz
         4Ys7aUCeUdpuOqNJvD7dJK4L+iLU2Y/DYu+BAe+/PSeFGy2as0vCBdvYRFPwmIt1OnDV
         1MYw==
X-Gm-Message-State: AOAM531KId4GwJ8pAjXuqyUqheKS0JD8GslHhMqjEYJR4W1O5iv1TnFO
        R4bBVhFuWhXsZs/YCaE7GS4sYSzWiBXyDkAN7s7A
X-Google-Smtp-Source: ABdhPJyp/2YLRyXJo6+aWq4mpFiZsUtJsZlQfWTMIcq9NiqSxw30dtz063tTJ00RXPrb5oBYG6dUzbJMOdXUMYea800=
X-Received: by 2002:a5b:2d2:: with SMTP id h18mr32560878ybp.526.1633544858074;
 Wed, 06 Oct 2021 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210910192757.2309100-1-atish.patra@wdc.com> <mhng-62d18ad4-0547-42bb-87a0-5e96e5354650@palmerdabbelt-glaptop>
In-Reply-To: <mhng-62d18ad4-0547-42bb-87a0-5e96e5354650@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 6 Oct 2021 11:27:26 -0700
Message-ID: <CAOnJCUK4rbM5ouAfd-ZsfMBiGg1uxjV4EW1iu7-fkwf3Ztk1iA@mail.gmail.com>
Subject: Re: [v3 00/10] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        alexander.shishkin@linux.intel.com,
        Anup Patel <Anup.Patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, djwong@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, jolsa@redhat.com,
        john.garry@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 4, 2021 at 11:21 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 10 Sep 2021 12:27:47 PDT (-0700), Atish Patra wrote:
> > This series adds improved perf support for RISC-V based system using
> > SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension a=
llows
>
> Last we talked the SBI-0.3 stuff was in an uncertain state and I'm not
> sure we ever got to a point of agreement there.  I've decided to just
> stop worrying about the state of extensions, so if you guys want the
> SBI-0.3 stuff merged then just go say it's frozen and that'll be good
> enough for me.
>

Now, there is a freeze/ratification process[1] and DoD policy[2] in
place for non-ISA specifications.
Thus, we are following the process to get it approved by the TSC.

[1] https://docs.google.com/document/d/1KkTmcPuor3DipS2JIUeR3DJhIN5i51bj3VF=
-L7QQShw/edit#heading=3Dh.hym1mtuc89he
[2] https://docs.google.com/document/d/1A4gZlXXFT_a9QGzlc9g2RHg853e6ZDB59co=
ANEYN3Aw/edit

There will be another release v0.3.1 which will be approved by the TSC
and will be called frozen officially.
There are no functional changes between v0.3 and v0.3.1. It is created
just to follow the newly defined process.
I will update the mailing list as soon as it is submitted for approval.

> > the kernel to program the counters for different events and start/stop =
counters
> > while the sscofpmf extension allows the counter overflow interrupt and =
privilege
> > mode filtering. An hardware platform can leverage SBI PMU extension wit=
hout
> > the sscofpmf extension if it supports mcountinhibit and mcounteren. How=
ever,
> > the reverse is not true. With both of these extension enabled, a platfo=
rm can
> > take advantage of all both event counting and sampling using perf tool.
> >
> > This series introduces a platform perf driver instead of a existing arc=
h
> > specific implementation. The new perf implementation has adopted a modu=
lar
> > approach where most of the generic event handling is done in the core l=
ibrary
> > while individual PMUs need to only implement necessary features specifi=
c to
> > the PMU. This is easily extensible and any future RISC-V PMU implementa=
tion
> > can leverage this. Currently, SBI PMU driver & legacy PMU driver are im=
plemented
> > as a part of this series.
> >
> > The legacy driver tries to reimplement the existing minimal perf under =
a new
> > config to maintain backward compatibility. This implementation only all=
ows
> > monitoring of always running cycle/instruction counters. Moreover, they=
 can
> > not be started or stopped. In general, this is very limited and not ver=
y useful.
> > That's why, I am not very keen to carry the support into the new driver=
.
> > However, I don't want to break perf for any existing hardware platforms=
.
> > If nobody really uses perf currently, I will be happy to drop PATCH 4.
> >
> > This series has been tested in Qemu on both RV64 & RV32. Qemu[5] & Open=
SBI [3]
> > patches are required to test it. Qemu changes are not backward compatib=
le.
> > That means, you can not use perf anymore on older Qemu versions with la=
test
> > OpenSBI and/or Kernel. However, newer kernel will just use legacy pmu d=
river if
> > old OpenSBI is detected or hardware doesn't implement mcountinhibit.
> >
> > Here is an output of perf stat/report while running hackbench with Open=
SBI & Linux
> > kernel patches applied [3].
> >
> > Perf stat:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r800000000=
0000007
> > -e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branc=
h-misses
> > -e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-m=
isses
> > -e cycles -e instructions ./hackbench -pipe 15 process
> > Running with 15*40 (=3D=3D 600) tasks.
> > Time: 6.578
> >
> >  Performance counter stats for './hackbench -pipe 15 process':
> >
> >              6,491      r8000000000000005      (52.59%) --> SBI_PMU_FW_=
SET_TIMER
> >             20,433      r8000000000000007      (60.74%) --> SBI_PMU_FW_=
IPI_RECVD
> >             21,271      r8000000000000006      (68.71%) --> SBI_PMU_FW_=
IPI_SENT
> >                  0      r0000000000020002      (76.55%)
> >      <not counted>      r0000000000020004      (0.00%)
> >      <not counted>      branch-misses          (0.00%)
> >      <not counted>      cache-misses           (0.00%)
> >         57,537,853      dTLB-load-misses       (9.49%)
> >          2,821,147      dTLB-store-misses      (18.64%)
> >         52,928,130      iTLB-load-misses       (27.53%)
> >     89,521,791,110      cycles                 (36.08%)
> >     90,678,132,464      instructions #    1.01  insn per cycle (44.44%)
> >
> >        6.975908032 seconds time elapsed
> >
> >        3.130950000 seconds user
> >       24.353310000 seconds sys
> >
> > The patches can also be found in the github[4].
> >
> > Perf record:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [root@fedora-riscv riscv]# perf record -e cycles -e instructions -e \
> > dTLB-load-misses -e dTLB-store-misses -c 1000 ./hackbench -pipe 15 proc=
ess 15
> > Running with 15*40 (=3D=3D 600) tasks.
> > Time: 1.238
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.106 MB perf.data (1020 samples) ]
> >
> > [root@fedora-riscv riscv]# perf report
> > Available samples
> > 372 cycles                                                             =
        =E2=97=86
> > 372 instructions                                                       =
        =E2=96=92
> > 262 dTLB-load-misses                                                   =
        =E2=96=92
> > 14 dTLB-store-misses
> >
> > The patches can also be found in the github[4].
> >
> > [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sb=
i.adoc
> > [2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/e=
dit
> > [3] https://github.com/atishp04/opensbi/tree/pmu_sscofpmf
> > [4] https://github.com/atishp04/linux/tree/riscv_pmu_v3
> > [5] https://github.com/atishp04/qemu/tree/riscv_pmu_v2
> >
> > Changes from v3->v4:
> > 1. Added interrupt overflow support.
> > 2. Cleaned up legacy driver initialization.
> > 3. Supports perf record now.
> > 4. Added the DT binding and maintainers file.
> > 5. Changed cpu hotplug notifier to be multi-state.
> > 6. OpenSBI doesn't disable cycle/instret counter during boot. Update th=
e
> >    perf code to disable all the counter during the boot.
> >
> > Changes from v1->v2
> > 1. Implemented the latest SBI PMU extension specification.
> > 2. The core platform driver was changed to operate as a library while o=
nly
> >    sbi based PMU is built as a driver. The legacy one is just a fallbac=
k if
> >    SBI PMU extension is not available.
> >
> > Atish Patra (10):
> > RISC-V: Remove the current perf implementation
> > RISC-V: Add CSR encodings for all HPMCOUNTERS
> > RISC-V: Add a perf core library for pmu drivers
> > RISC-V: Add a simple platform driver for RISC-V legacy perf
> > RISC-V: Add RISC-V SBI PMU extension definitions
> > dt-binding: pmu: Add RISC-V PMU DT bindings
> > RISC-V: Add perf platform driver based on SBI PMU extension
> > RISC-V: Add interrupt support for perf
> > Documentation: riscv: Remove the old documentation
> > MAINTAINERS: Add entry for RISC-V PMU drivers
> >
> > .../devicetree/bindings/perf/riscv,pmu.yaml   |  51 ++
> > Documentation/riscv/pmu.rst                   | 255 ------
> > MAINTAINERS                                   |  10 +
> > arch/riscv/Kconfig                            |  13 -
> > arch/riscv/include/asm/csr.h                  |  66 +-
> > arch/riscv/include/asm/perf_event.h           |  72 --
> > arch/riscv/include/asm/sbi.h                  |  97 +++
> > arch/riscv/kernel/Makefile                    |   1 -
> > arch/riscv/kernel/perf_event.c                | 485 ------------
> > drivers/perf/Kconfig                          |  25 +
> > drivers/perf/Makefile                         |   5 +
> > drivers/perf/riscv_pmu.c                      | 331 ++++++++
> > drivers/perf/riscv_pmu_legacy.c               | 143 ++++
> > drivers/perf/riscv_pmu_sbi.c                  | 731 ++++++++++++++++++
> > include/linux/cpuhotplug.h                    |   1 +
> > include/linux/perf/riscv_pmu.h                |  69 ++
> > 16 files changed, 1528 insertions(+), 827 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yam=
l
> > delete mode 100644 Documentation/riscv/pmu.rst
> > delete mode 100644 arch/riscv/kernel/perf_event.c
> > create mode 100644 drivers/perf/riscv_pmu.c
> > create mode 100644 drivers/perf/riscv_pmu_legacy.c
> > create mode 100644 drivers/perf/riscv_pmu_sbi.c
> > create mode 100644 include/linux/perf/riscv_pmu.h
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
