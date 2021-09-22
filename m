Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0926C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9486112F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhIVL2E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:28:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbhIVL2D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:28:03 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDy9C-1mcwXs3dhs-009yuP; Wed, 22 Sep 2021 13:26:32 +0200
Received: by mail-wr1-f48.google.com with SMTP id t8so5826332wri.1;
        Wed, 22 Sep 2021 04:26:32 -0700 (PDT)
X-Gm-Message-State: AOAM533LsjKHRHjlQInwTX0j/HGbg1arUoToMliProsOZ4IaDiP4Ba5y
        A+QjtfANgq8mEYZNS9SHXc+ZUSGRDXxN9UU6l3M=
X-Google-Smtp-Source: ABdhPJx7Vx8CgVkbie6rTHzp0NlK8qWjQiWBbJyQ5+YpxWx+wv3QwjZDGoYajJ4SkwfdROeT/MWSc2i1Jl2U7JktY+8=
X-Received: by 2002:adf:f481:: with SMTP id l1mr10119089wro.411.1632309992502;
 Wed, 22 Sep 2021 04:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
 <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com> <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
 <9db8c79a-f704-84ce-360b-84335f926a48@collabora.com>
In-Reply-To: <9db8c79a-f704-84ce-360b-84335f926a48@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 13:26:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LsxOTYeM-o=Ee=XFD6zN7ESV_dhGmAOFSj_zJ8pBDgA@mail.gmail.com>
Message-ID: <CAK8P3a0LsxOTYeM-o=Ee=XFD6zN7ESV_dhGmAOFSj_zJ8pBDgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:DVyMJu3EjIwLUe2Ypw4bUMl+M9UBYlSLH1ODjKc+u1OVi8dNV3I
 kbbbC9VP6r4vZtTTWHqIDwdWO7JNYK9H670FzpUoE/w3NeTEM9Ti/rJtzeAyBnA90h1J8Yn
 kghcVpILj3m4u71GMidgvFcvY48nDvIBv5u3d3eddAPbgIJjvhHHileEtP4kGagBoRPOW8t
 AQty/39s9A2PfUir+ei0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOi8kqRnCCs=:2721ZEHrD0X0Fgqt5mARlB
 W6J86hPyLugTT5k1p6aporsqWgKsvXJs9w6qhcylhVjoq+K8yO0xDX4PaC91R+Zks3wgCEzI1
 sbbVPtaIKtN/UxopsXstSI5yGt2cwOxO+M+R7eIb2HcLA52zVYxCRCXIaStNO6PK1tO4Jayqy
 lVMGSIGviD0nPgOTOJxB7krLyc8FYeasKUl0ljSLrvMi+XMKe1wk0ThBICCWTlRq4MPkM+TrI
 Q9sZ20e//alhXLPMU0nz9Jjd5mdp4gpflQLHuVnAe5+T9Ln++mO2TezvxvT/xJ7n0RWa1eRMH
 AeylAbm+AIcRKEe7r2tZ+EUtqI0XPKBworlqQ0P7leKO+agsyAeNsmFNSyH1tTw3c5bbGWWZZ
 d/1qrtYxW7bc42d3Xr8dNQf9bWj6cmah6ON/eUHn2utJCYL8ygE4s3mywSRaTxN7aNMjZQhsW
 0qCBCSB5JloXpH+xiDpNIa8b9evDt8unBQLKLCavxYsxkM0mPhE6MklUw43exAF3NQzu1rXp9
 xtEY6kV6MN2urO26jCF+Z6tTodNEgDUNIyKfh+apgxodtt83lN+p7zgb08KOsfy8fth1O7MGe
 jRm2b1UT52MZ1uLRBncflHOO4zh+So5re8VLHaQWPCdNMqYMWQmrVwNBdhH1MWCwzeSDvVyDa
 4FdJ/C8RuGfBNwOy+SBYsX7wuAT40D4bU/k9cjYOTVdQ5tOQnjScnY03R+atergTgzyVedLk6
 F3gnwXBl7tMnmfujV5rd3LwYTjsIN1BPYVvYTgzTULsoHtBvcgcfNxg3agzpzCjAdoIZA7b/u
 965eCYwiiZHSwSD3behe75QcQoXuQb2hvxLZqG/D1ar8Huw7whPk5kfP1wRR1u2NoL6TIEFlW
 aT1K0txkQQlSkwhVjoEg==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 1:06 AM André Almeida <andrealmeid@collabora.com> wrote:
> Às 05:08 de 21/09/21, Arnd Bergmann escreveu:
> > I would love to see the wrapper that Alistair wrote as part of some kernel
> > uapi header provided to user space. futex is used by tons of applications,
> > and we never had a library abstraction for it, so everyone has to do these
> > by hand, and they all get them slightly wrong in different ways.
>
> Why we don't have a futex() wrapper at glibc as we do have for others
> syscalls?

I think mainly because there was no agreement on what the calling
conventions should be:

The raw syscall is awkward because of the argument overloading that cannot
easily be expressed in standard C in a typesafe way. Having a per-operation
interface would avoid that problem but requires specifying what that
particular interface has to be, and there is no standard to fall back on for
this syscall.

       Arnd
