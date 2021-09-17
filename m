Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0943EC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 07:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D498C60F48
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 07:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhIQHew (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:34:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60185 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhIQHew (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 03:34:52 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHFwM-1meNvl0hlY-00DI7N; Fri, 17 Sep 2021 09:33:29 +0200
Received: by mail-wr1-f52.google.com with SMTP id g16so13587060wrb.3;
        Fri, 17 Sep 2021 00:33:29 -0700 (PDT)
X-Gm-Message-State: AOAM533+KkC9S8cHZhyyQr/Gcws3Pv+QbrR6nhr9ElMZ5xHXmGbUF81h
        JdUrzaBkhYxpXPotrZF4WqH+Mo3QpMgV6vbUIAg=
X-Google-Smtp-Source: ABdhPJyPtoZ/mG7bWsWHsydawMEYKJ4E3ECfqsk8lnBKNgqIVX5W2m+pElPlgj2gMjbI3079PSZ95Swtj4MIyk84lH8=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr10471636wre.336.1631864008841;
 Fri, 17 Sep 2021 00:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com> <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
In-Reply-To: <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 09:33:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2kAvrKvCUOhVouHUmY661OZHVAm9sefgXuZpLHMQg7Ow@mail.gmail.com>
Message-ID: <CAK8P3a2kAvrKvCUOhVouHUmY661OZHVAm9sefgXuZpLHMQg7Ow@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
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
X-Provags-ID: V03:K1:i1tPDOPsEkIXWl6o8lvaOVSXFg/bAWXldhifz9hNemIOJCFTnx/
 zZVhz0YkzYzan4TSQY8NlIUxLVIZhqZ2Sx+jIItl5UTtY38hQ8g0UpoGXpsbG+PIIFLVE3A
 SKaYGAmda4GZvCHcy4UwYGUm9AcW/Fg2vZRCDrKeTOTj2tbKgMzSBS98PlVAwM4PL5PX7DU
 MrucBauAQlLixBt8ly4Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FbgTo1ML4rc=:Fj5i0kgHwvY0JXikCXS7cJ
 PJ62OAK1WCPrbNjI278U8xy+5UY2i5p6jf7QnkrS7qzd6afnJA7d5GB+0cId+p5e7/4pogpIF
 bzZ5Fs99rB5nb6mlqa0/0/7ByEHwB4EiGtC5Juzj+ToM4/qUWwvuTRLFFFoFuRoaf2fRtF4Si
 oCY9NfprJjOeRJe+L3qWp+en4PW2pHlV8XLFStlfdUqbD0JXt0YGvOz7MrxCbbUQxiyBVAJSK
 fmiShXA4z+pU1JkF88/QqfypI69pid+yz8LtIxcpu170fdygCEXTwx/9C5l4xcoTXfBaNfh1/
 f8EDfhkvXu4U6eu2UABIa4aBYZDBJrMmG0TSgEcr4skqyIiWr6kqa3co4iC7ECG+BBexpLvyR
 QRJ4ICH5zFa1tGtERCmFUhySJrSNYlofkVkxLX/xzc47/SZ3wVLsOHJzBaUBhxuuS5EJajG1K
 CErqW3GjO5C7dhSzAtRnpzUUJ0M8ujL1D73o4lveVjA6LYWqe7leOwEkZNb1xIwWSvPSeftqH
 kzoVvsgRnUNt7GV1OCABGfM4BvB/DfyAgVFUhbjIUkVn0aGwWWOgv4l03WljeHpL1cIYjng/I
 ZWjAGlll0LPeaz23eG4iN1ui6GdFJ6v2HprjPE4AiAZXXOOkdui67gdE37yFuJmVRNk9YSQdx
 doDMaIqBi49FikX3S/9uDVLTW6ZK/0p3ELCdG/7f+RCviyMli6rCbSHFVUyHl3jZSNG+DqL0C
 ZhqZs/PybRWZ5AFl1sSJZeOag/Lxb4X/ly/Q7Spmaf/ZwZvCcUYatD2H7C/CMBCdDtamUaiDA
 5qxYwrm0JGLqD8n5q/W2udrUuHm3gYoja0zDnmrqBGjbyX578ud5IGjVN7/zNHKmwFE8pJIGn
 Npk89ZGaXQeskJOR8uzg==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 17, 2021 at 8:10 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the follow-up!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
