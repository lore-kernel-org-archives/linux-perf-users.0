Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C47C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7172C6154B
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhJEJ0B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:26:01 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:59362 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhJEJ0B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 05:26:01 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 05:25:59 EDT
Received: from myt5-6c0659e8c6cb.qloud-c.yandex.net (myt5-6c0659e8c6cb.qloud-c.yandex.net [IPv6:2a02:6b8:c12:271e:0:640:6c06:59e8])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id A206F941E36;
        Tue,  5 Oct 2021 12:17:48 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (2a02:6b8:c12:2514:0:640:ca5e:c8fa [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt5-6c0659e8c6cb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id IyV6tEzelD-HkDqMhNI;
        Tue, 05 Oct 2021 12:17:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1633425468;
        bh=CrnGMerQ4LBYjjGbgeqFgGHVtZrQ+QTtn5a0VX0cO1Y=;
        h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
        b=dehZ7uZt+fO6YaaLE03MQykhBGAWbnTmJAz787q5v+kP+tnjCX9x7H9RnogO2XnQp
         o2LRZpnAlGHdRWJteqIyL14dh5xgLy2vRi3CnyXYsauaUBuFMzC+aXli5//Spgpk63
         AQfi00eYfDiMTtzwMWrmEkxl0sCLVfek9C7+wa9k=
Authentication-Results: myt5-6c0659e8c6cb.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id 43frcM9OPL-HjPCRD6R;
        Tue, 05 Oct 2021 12:17:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Tue, 5 Oct 2021 12:17:44 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [v3 00/10] Improve RISC-V Perf support using SBI PMU and
 sscofpmf extension
Message-ID: <20211005121744.728385be@redslave.neermore.group>
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 10 Sep 2021 12:27:47 -0700
Atish Patra <atish.patra@wdc.com> wrote:

Hello Atish,

> Perf stat:
> =========
> 
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e
> r8000000000000007 -e r8000000000000006 -e r0000000000020002 -e
> r0000000000020004 -e branch-misses -e cache-misses -e
> dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses -e cycles
> -e instructions ./hackbench -pipe 15 process Running with 15*40 (==
> 600) tasks. Time: 6.578
> 
>  Performance counter stats for './hackbench -pipe 15 process':
> 
>              6,491      r8000000000000005      (52.59%) -->
> SBI_PMU_FW_SET_TIMER 20,433      r8000000000000007      (60.74%) -->
> SBI_PMU_FW_IPI_RECVD 21,271      r8000000000000006      (68.71%) -->
> SBI_PMU_FW_IPI_SENT 0      r0000000000020002      (76.55%)
>      <not counted>      r0000000000020004      (0.00%)
>      <not counted>      branch-misses          (0.00%)
>      <not counted>      cache-misses           (0.00%)
>         57,537,853      dTLB-load-misses       (9.49%)
>          2,821,147      dTLB-store-misses      (18.64%)
>         52,928,130      iTLB-load-misses       (27.53%)
>     89,521,791,110      cycles                 (36.08%)
>     90,678,132,464      instructions #    1.01  insn per cycle
> (44.44%)
> 
>        6.975908032 seconds time elapsed
> 
>        3.130950000 seconds user
>       24.353310000 seconds sys
> 

Tested your patch series with qemu and got results as expected:

perf stat -e r8000000000000005 -e r8000000000000007 \
-e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e
branch-misses \ -e cache-misses -e dTLB-load-misses -e
dTLB-store-misses -e iTLB-load-misses \ -e cycles -e instructions
./hackbench -pipe 15 process

Running with 15*40 (== 600) tasks.nch -pipe 15 process
Time: 20.027

 Performance counter stats for './hackbench -pipe 15 process':

              4896      r8000000000000005
                            (53.34%) 0      r8000000000000007
                                                (61.20%) 0
              r8000000000000006
                  (68.88%) 0      r0000000000020002
                                      (76.53%) <not counted>
              r0000000000020004
                  (0.00%) <not counted>      branch-misses
                                                 (0.00%) <not counted>
                  cache-misses
                      (0.00%) 48414917      dTLB-load-misses
                                                (9.87%) 2427413
              dTLB-store-misses
                  (19.43%) 46958092      iTLB-load-misses
                                             (28.58%) 69245163600
              cycles
                  (37.09%) 70334279943      instructions              #
                 1.02  insn per cycle           (45.24%)

      20.895871900 seconds time elapsed

       2.724942000 seconds user
      18.126277000 seconds sys

perf top/record also works.

Tested-by: Nikita Shubin <n.shubin@yadro.com>

Yours,
Nikita Shubin


