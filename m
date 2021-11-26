Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C562C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbhKZHmN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:42:13 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353785AbhKZHkM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:40:12 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDhth-1mjfNE1AfP-00Aldj; Fri, 26 Nov 2021 08:36:59 +0100
Received: by mail-wr1-f50.google.com with SMTP id d24so16767234wra.0;
        Thu, 25 Nov 2021 23:36:59 -0800 (PST)
X-Gm-Message-State: AOAM532uLvDwSqnJJPhm3IpzqjnOI19vTLKJc3EPUtZ4+UrFqTyLTQ3p
        CweDxlMhJs4wRj35qzhrL4EHNhVNwHn8YhycXu0=
X-Google-Smtp-Source: ABdhPJxSj0rezcz4IfyWjfYsOWvMXGXNMnkGvFoWgiLLP3fW4pdm3tA67p68pITqojNXldDVfKE4N/+eM/LzDnTfLeI=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr12328335wrw.32.1637912218852;
 Thu, 25 Nov 2021 23:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com> <20211126060024.3290177-4-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211126060024.3290177-4-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 08:36:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QT+hu-nPBn=nBMYO50Tn4qenLNox7qEAg33KUPtAXSg@mail.gmail.com>
Message-ID: <CAK8P3a3QT+hu-nPBn=nBMYO50Tn4qenLNox7qEAg33KUPtAXSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] selftests: futex: Add support for 32-bit systems
 with 64-bit time_t
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
X-Provags-ID: V03:K1:yidijYki8m7Z5c3Wmn5yuCSxsj1OTWmNgnOXelDww7nBoWyNem2
 FQ5IXshkLlMQMsm+FAtacU/KYIBSSeJj9JUj65fxuJecGn1VW/LxCkQAaOTsLkrUs36dq+0
 eVRWnb7Z7Kz86LhtJDpJhxJLUuub68p05qtyKpd8EYN7HpUBK6OjHqgf5/AHOIUmCOSD2+V
 /Vc6ExNlhSSofIe+XOlDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBRD5kkSWDw=:U0uUcwd592I2duZ3ubroZr
 +9cZDbnW1PaUD8W5JXci4rhmiDe1ySlAw1gdeFNkWkDfqCDYYQZtQ2N3XZ+DQEqyCY6+nngRV
 MqrFuFIs0nW9KbzaiIrUdwshupiqd2Vowk5QHnXj7LdZfG6N1+wMpwTV5fofJezXPA/c/WTlr
 M/CFdxr5kj6MT22LBGFPHkecVMS3UZFfV7yxxZlJYYOJFzgyUK2CbaePLMlcnIkY2lDO6eZI1
 hLhpO+5h9s/ngq+oz1Ou2HA1KgpTC4mZbKaBn6/BBBWI/vW4zVJgdcpWdz0xplksPiYPWUD4Q
 eq6mQn6yW5pIECsKe7nYX8g5UOIfZ9IN8/M8pwy2XIzR9+ql6KK1ezLQPFLezT7qgr5sUDFhv
 LYclgcATyTAwhqeHKIX9clqGujOkwqGUAxmI8YSFlHtMP2ZYg1YOGDGEE4z41htK5HZw9gJLn
 flxtQx3A6vg8k7qmrpksncQpi84Cyi7ghVr0LnsjQbt80wcTgklNfLCIxdwBKGxRfVuH7pd0Z
 RtLLwf8cN0tYVXvCEBKuRwTEDS8OniPsWSNaBXSYT6G0Ij0w0PKuOpk8TW2XhPCiV5RSnUDij
 CatFFLEa+WzmorKtUaweezEMX30EM+62VJ/dY9PaHR1NW7/e3fS1MI7+2a+yZ/g/joG4kp/iF
 YBqaY0So/m+IcH4PwRazuvliW7mzL5ViMPKSixtlFSf7SarGtqCPNgShI6169HbQ9gZU45ssh
 Z5ZqxUXyNWpgjG/3NnJ9Vki83RJKfOJKTghPqYWmu268PcmvA3Qhsrz9dHvFwvGS1X9EOsp6i
 8wX5+GB0DLhZJiqKaFRvRaRqijjVSKwJavVtwsq2L0NopPalvU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Using the new __kernel_futex_syscall*() functions let's add support for
> 32-bit systems with a 64-bit time_t. We can just direclty call the
> publically exposed __kernel_futex_syscall_timeout() and
> __kernel_futex_syscall_nr_requeue() functions to do this.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
>  tools/testing/selftests/futex/include/futextest.h           | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 1ee5518ee6b7..d3673996fed4 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
>                 secs = (ts.tv_nsec + timeout_ns) / 1000000000;
>                 ts.tv_nsec = ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
>                 ts.tv_sec += secs;
> -               info("ts.tv_sec  = %ld\n", ts.tv_sec);
> +               info("ts.tv_sec  = %lld\n", ts.tv_sec);
>                 info("ts.tv_nsec = %ld\n", ts.tv_nsec);
>                 tsp = &ts;
>         }

I think this causes a warning on 64-bit builds now, you have to add a
cast to 'long long'
to make it work everywhere.

         Arnd
