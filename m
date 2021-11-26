Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A357C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359169AbhKZHjb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:39:31 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359172AbhKZHha (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:37:30 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqJyX-1mDeXq0eKx-00nQTh; Fri, 26 Nov 2021 08:34:17 +0100
Received: by mail-wm1-f46.google.com with SMTP id p18so7327402wmq.5;
        Thu, 25 Nov 2021 23:34:09 -0800 (PST)
X-Gm-Message-State: AOAM5336bNQOlvzMTg304JaftQFOXdMh7m01kbJrjHCd+xpAL6hNuQAf
        3l556sZuvdNmFVlF6wTe90WxzMkk74wE7R3vhCg=
X-Google-Smtp-Source: ABdhPJxp5EqM4wHfXdz4pLs9xKz8Rq2xZ+tJjDPCTW21MFnsGEjZ2KLKdyfGZGKrZ542uGzfxCDQaVNpVpxwzTgooeI=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr13827477wmn.98.1637912049389;
 Thu, 25 Nov 2021 23:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com> <20211126060024.3290177-6-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211126060024.3290177-6-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 08:33:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3EMyg5SuKnbjnUvUhRkoqNuWoEPh_hoTU4abjR4a8PgQ@mail.gmail.com>
Message-ID: <CAK8P3a3EMyg5SuKnbjnUvUhRkoqNuWoEPh_hoTU4abjR4a8PgQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] selftests: futex: Use futex_waitv helper function
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Francis <alistair23@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/7avdmX9M783BFe12nqah47RZPB2F9uEmjOg/9l2em/jqCDP6LP
 FPfAbKDopfoMGkWA3H+e3pKw95T7ZgiJZPBU7ak2B8cWPu7dN3MM1BKbLbwsaro7u3IgmS1
 U2iUKsLEqMXtOSSXXyxPq+79nGlbxUWrnbQ3kRGL46yrZcwc8047dEKUv3jO55YIl/mwskH
 /mlOlYny4YWt62IUDsRjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sUiUVFMQWn4=:qKtIAB3wMHU+hlGi+V4NAC
 23LbHUyMjqHOXt/FZrzjiuLw5Y8WJQlVmOs84CY2oXmPIUzEmy4q4Lb0HYNzF6GhAeOB2ngB/
 /bEkKWOnTReyb5mOz9E7qas/K1mDIhPrLHIzuQLqnhLnYspE77DC6iaIbMld22YaLDZOAOPf9
 dCa8RyHqZy3sauNMkgxS6BfWhv/EBv8/QOmOncolUCvGaBIEYVPTq4/CX3Fu308aLV+UuxWx2
 jP/iUKOq+a4BJeSJcENmrie5+OfZQdRHKHBl15x3JU4rKiZg+XQxHV+UFzw8gXc4PQUESwhYr
 RuR+WWcJ/zALv6TveltpjbCPaAS0JGnO4DShW3esEu4GW39/WsSR71+zj8N4+cWlrhN8clJJC
 ZxyZC6Mikun4sXoh0qmBc4Yhmeqj+h8Z2CCgX6x9evEFlMMFGuDrqjCf2imQppK+d5tKaNw5j
 HYTvl4DOx3kZ3mMeX+CMX4PvsXQmSOQDMi0ctFXnTONkUOeKLSf6JcEg53hy+QZYbTyWpKbUk
 EDHmzMjeEFsR0al8RQlweH4WimBegNmnxA8o4mrzp3fHNnLGErKk9Oz9LXeE4wUQkdgEGPzRc
 l2tTJtOCfm8h89gYQZRIlMdFHMdrIkpWsSnHiafKzvUR+9HQyCVzYPMUIgTM34nCTARW+I5RD
 PpZkMLYNjRaZOEjwmYaiuvEdes8Lkc7niSGikSLgLOTu38c9SlH5dhqXELZ34oP22anW1Qkl8
 epCCAxw+ux/DE2lkgOhuXd7+7F+iSo835fw++IxSswbutb2ukiV/5bbydEKgl6LwZ9v9iXzw7
 oHjL8ljlGc/+57VaDUt405z+GwAZmGh3JWn+ctIUSDv9ExecHk=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Use the publically exposed __kernel_futex_syscall_waitv() helper
> function for the futex_waitv tests.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I think it would be nicer to wrap __kernel_futex_syscall_waitv() here

> -static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
> -                             unsigned long flags, struct timespec *timo, clockid_t clockid)
> -{
> -       return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> -}

Basically just changing this part to call the new function

         Arnd
