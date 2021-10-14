Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44EDC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 06:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D3E61029
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 06:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJNGsy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 02:48:54 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhJNGsu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Oct 2021 02:48:50 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1ZQT-1mcIDw2zXf-0037bo; Thu, 14 Oct 2021 08:46:43 +0200
Received: by mail-wr1-f43.google.com with SMTP id r10so15952991wra.12;
        Wed, 13 Oct 2021 23:46:43 -0700 (PDT)
X-Gm-Message-State: AOAM533+14jmyh7HBi/1RPkRKqMNYM11sEK+ZUtbCNBDZc0Zh+iVOaG5
        Zp3d9HtBnuxgpivw+/N46UGm5HaEysZHAlemEQQ=
X-Google-Smtp-Source: ABdhPJwTCqhgxuA96DHGSSbNGZIt9ZH4cn9+BGQQWxFLDpCZuMZM/OdQF3b7gnabA4uMj57NtL173grRBisB/S/Xr9s=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr4432597wrb.336.1634194003365;
 Wed, 13 Oct 2021 23:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Oct 2021 08:46:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3YKrbFnKpy34dJE+ZjycqUgUhvp5gEvSBC1tRXz4LR7g@mail.gmail.com>
Message-ID: <CAK8P3a3YKrbFnKpy34dJE+ZjycqUgUhvp5gEvSBC1tRXz4LR7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf bench futex: Use a 64-bit time_t
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jY/vf4de9a+HDsnX+v1mH/H1FvPuiaj5+UPiAa14/6b9BRyoyyY
 mOLMPGG24OAh/CbWlgKyYy47lAchVF1Y5Qyl2fyg09NZ9Uxm4ohg8hCd70hXoHiq4VLFyiX
 wTPleLHe7g5lCFDZ1/lEMBipdb3n2PSrZp5IuxLYWN+klrPq1NR0S8oFbQ3pxv0K9yErlGJ
 QCS5o3i9yC+xTygMWe1HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nf/KJ9hfdCI=:tpMI/dZxWDox9zwReKyNyb
 cSOwr+DS22pyoFhCh7Ys8g+sdsTNgiRLw7FjDMggU6N0P3a68gNLbZd3Y39X7SFx0jOH3XKTa
 4MyNEb6rF24thsAXE5G6Fbhu+R1ubASXHlo+GVq9Eyx9yIJThlRcZazEXStNOIt3QFZ58SbVI
 w3XKBMPqLBc2Ec9KUOPogtu9iBKfjyosFaGPUPntE2SmoAyv4QdmdvypJ7RQYytvFc3KMDs0A
 zNieYsozHRNTXZ4XM2m3tgGsaYNdlZJ69XhWB6qdhct4JjI0ADJFEs1MhshB5eKEeMOPyWisc
 uKdNZ6ByJfWXGv9HCcKpeTQ01fqTWoHsy4I9rbfma44grdHrhRTXRQ5HMgJsHRI2eaF84lU8t
 PQu63FUmvvJwPTEt2c1GOaTECwarI+PKVHntbNtEw+w1CntePiJwxCOx7jzrcDt4qsM2BJ5oc
 opgVDXaukDYy+QRZBqBX85UE2wu5plXUrRrzrjfPcsWMv58AsSSAmlnI2Fgqz2Ecu/DnsLQEo
 nhsgZShTPdtDdRt+MIvKMde4vN5xvmqNeJwRl5+jtwpBexuEb1zF7aD8ZPJOEnjInyb8GC27m
 nrgAekkvD1FW9+tkx0ieT9KIETqyauwgFfBwaMFgcfnEY3Q/GNGQAad/I2dRbQbeWePzs4lGs
 sfOoINwiz0BMZTwTThYEwVP9KmoBL0K7dbB6RT0P6Qld45jJ8Yl63XF/QwyORVLau82ODfNFy
 3COpSH3hheqCrEp0KEg+2aw2vWN0R8aT+bAAfpc+QeIHi6cplwM23HcWeko/quvAE9nPhcyQb
 sVMxvtBmJQX5BLM/ebNUT2YfIB3nrXZg2j21ylLNAkZQdlclQn0lHhckv2xr8uAk8xPhMg/ey
 /Spt5MUfe5bw00uWf9ZA==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 14, 2021 at 7:55 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:

> +/**
> + * We only support 64-bit time_t for the timeout.
> + * On 64-bit architectures we can use __NR_futex
> + * On 32-bit architectures we use __NR_futex_time64. This only works on kernel
> + * versions 5.1+.
> + */
> +#if __BITS_PER_LONG == 64 || defined(__i386__)
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +       syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#else
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +       syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#endif

That __i386__ check looks wrong, was this meant to check for x32 instead?

In that case, I wouldn't bother, as x32 can also just use the futex_time64 call
like the normal 32-bit architectures.

       Arnd
