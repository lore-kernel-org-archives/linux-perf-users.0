Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501FDC433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17FFE23B46
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhANTR0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbhANTRZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Jan 2021 14:17:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CBEB23B5F;
        Thu, 14 Jan 2021 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610651805;
        bh=7X9U5ZdfFbwBuSKrGL+36qia348201k6vPdFQVshYnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OiUw60bf+6ht2tnFp2BIEKhtpetyoEyV5Oj/lMr3XSlfBuL4kDfm2zze3EAReELPM
         patQ7gA9b3RqdY4YrCmWHzezV1heoWoAeASwAfAZHujwVxc1nu/mKa6iqm+1l9wS5f
         bEvNl6D22O1QJ9vFtJvty+mhDplWnyOppQU6w2qxyElqUs0PTFU6p7F0UjhLZsky1t
         pmy36bR+wmfcdbNtmALjb78qyMW+5f8I/RhZik9lNiZKiw4n7J3AOy0H57DENEtE9m
         X+4y6fd/azJykkjow3jnk/SX6KEC32GNAzvydEb5blCLpnwVo+p9p7FmgKlWiYgNwY
         mizJ1nF+GfP4A==
Received: by mail-ot1-f43.google.com with SMTP id x5so6213269otp.9;
        Thu, 14 Jan 2021 11:16:45 -0800 (PST)
X-Gm-Message-State: AOAM532Hpc4NBwNZGaWeBMiFIdJo4ZYggHh7DkD1QQw+V1+018jaEB7h
        SL737FMSl3p7CvP8eiQ13BDyYWawGlsgSA9EgJA=
X-Google-Smtp-Source: ABdhPJxhZ7tcq6R9DNzyjgjWO5HO89pxMNjzgzAwezUYbmvwDwkXM2DXpE5VBx7We/YUohSV+WAP/33KOpzQHkxlQUA=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr5826034ots.251.1610651804235;
 Thu, 14 Jan 2021 11:16:44 -0800 (PST)
MIME-Version: 1.0
References: <YACPie55ArIHu3mI@ingrassia.epigenesys.com>
In-Reply-To: <YACPie55ArIHu3mI@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 14 Jan 2021 20:16:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
Message-ID: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jan 14, 2021 at 7:38 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
>
> Hi,
>
> When building perf for RISCV 32 bit (v5.10.7) I got the following
>
> | In file included from bench/futex-hash.c:29:
> | bench/futex.h: In function =E2=80=98futex_wait=E2=80=99:
> | bench/futex.h:37:10: error: =E2=80=98SYS_futex=E2=80=99 undeclared (fir=
st use in this function); did you mean =E2=80=98SYS_tee=E2=80=99?
>
> This issue is similar to the one reported in https://lkml.org/lkml/2019/4=
/19/631
>
> I found that patching tools/arch/riscv/include/uapi/asm/unistd.h as follo=
wing:
>
>  #ifdef __LP64__
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SET_GET_RLIMIT
> +#else
> +#define __ARCH_WANT_TIME32_SYSCALLS
>  #endif /* __LP64__ */
>
> solved the problem.
>
> I also found that a similar patch for arch/riscv/include/uapi/asm/unistd.=
h
> was removed in commit d4c08b9776b3, so probably this is not the right way=
(?).

In short, it won't work, as rv32 does not provide the time32 syscalls.
Your patch will make the application build, but it will not be able to
call futex().

You will in fact run into a related problem on any 32-bit architecture
if CONFIG_COMPAT_32BIT_TIME is disabled, or if you pass a non-NULL
timeout parameter and build with a time64-enabled libc.

The fix in the application is to call either __NR_futex or __NR_futex64
depending on the definition of time_t in the C library. I would recommend
doing it like

#ifdef __NR_futex
#define do_futex (sizeof(time_t) =3D=3D sizeof(__kernel_long_t)) ? \
         __NR_futex : __NR_futex_time64
#else
#define do_futex __NR_futex
#done

       Arnd
