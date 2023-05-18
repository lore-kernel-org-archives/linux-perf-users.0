Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50043C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 May 2023 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjERIqr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 May 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjERIqq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2023 04:46:46 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9041107
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 01:46:45 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4360bef3283so516433137.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684399605; x=1686991605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7ewcVJ8ISOfeb+KpfuhQ6AeIHogwRgTzugd0nWPdnU=;
        b=h2ciERUagWk0JlNb//ZlnDpn4X9iHUtBfUjbwz3pvZPzgMV9FKObm58H3mmiWfgXzE
         E7XEsJxRkKc/MSsO4MF96k+knklhn0XAHYagtUhALntYWsNN3u0gEJWWzgTJezgun+bh
         o9odSUAGDalMDzsVT9NN2jBoLOJ7ZwIiuCeflchy2gA6knHkpl0fNnGUs7nIKA1VnSL6
         TuRALolEkweQX1nznc4RBRlLOIUstWDYBOLcX32lDCTpM6gryEaYOJ4pVmG/xtrg2kgi
         sZz8KCbXa5ldZFIzk4G1TasEtAYdw1RvE0BFiTDijz98woMqP4OZHhuli5sR4WnxHUQj
         QDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399605; x=1686991605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7ewcVJ8ISOfeb+KpfuhQ6AeIHogwRgTzugd0nWPdnU=;
        b=DAaQC93bqdFuwG2Iafjyzvud4IKztk9C+FHoE+0FJS7qRSYCbLv/qJBIRzTFHBMied
         paOKfMoJBGqrcWpGUqbHko4H3xipk0k33ninKQYDaNKmbzz/iPZzOy9nDhXlm7F1YybF
         Dqw83VGFtb6ZiNHoINoMaobzWL9yVsYjSNZs8NWSghzIOdaHBkknSH/chaWx9uIk5Bkh
         q4CH+tDIScoiB2nHMudcZVSxXAt+8qAfcZi7EB79rKcUHONyvZ5riixnEu5NOGmwnPvV
         5U4g97PqNaNEJgiY1Ib/XJPQG/q+fyPaK1yzW08sZVTxvWvG39nmKQpK5tfasX1dD8Nl
         mvZg==
X-Gm-Message-State: AC+VfDzaR1dHYF+RkMmunCVpNRnvoqkBIxssUMkDcu/uV9sUVQ3vSAxz
        MF5TGbyWPV32SwIMMkgXo/XwapybypLpNiYr94roww==
X-Google-Smtp-Source: ACHHUZ4fCNj+bGYt3HAQex+FVnJC/1RnptY69fAvJezRQq5T3f1oewFRzo6OZ6pUPcfeOr8qkTj/iWY9HO7fuZ6izCk=
X-Received: by 2002:a05:6102:245:b0:436:18b:6a31 with SMTP id
 a5-20020a056102024500b00436018b6a31mr216763vsq.26.1684399604549; Thu, 18 May
 2023 01:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvgBR1iB0CorM8OC4AM_w_tFzyQKHc+rF6qPzJL=TbfDQ@mail.gmail.com>
 <b28dc2c4-6694-1699-b4a2-a8e71d179073@loongson.cn>
In-Reply-To: <b28dc2c4-6694-1699-b4a2-a8e71d179073@loongson.cn>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 May 2023 14:16:33 +0530
Message-ID: <CA+G9fYtcW9AU_OiQJSbKTdYBsW1naO=MnqDJowTLpP7ygqbjMA@mail.gmail.com>
Subject: Re: next: perf: i386: bench/syscall.c:101:22: error: '__NR_execve'
 undeclared (first use in this function)
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 18 May 2023 at 12:17, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 05/17/2023 11:04 PM, Naresh Kamboju wrote:
> > Linux next perf build failing for i386 architecture.
> >  - build/gcc-11-lkftconfig-perf
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build log:
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/syscall.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/parse-events.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/build-id.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/cacheline.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/config.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/copyfile.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/mem-functions.o
> > bench/syscall.c: In function 'bench_syscall_common':
> > bench/syscall.c:101:22: error: '__NR_execve' undeclared (first use in
> > this function)
>
> Hi Naresh,
>
> Sorry for that, the __NR_execve definition for i386 was deleted
> by mistake in the commit ece7f7c0507c ("perf bench syscall: Add
> fork syscall benchmark").
>
> Could you please help to check whether the build error can be
> fixed with the following changes? If yes, I will send a formal
> patch as soon as possible, thank you.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Build tested this patch and perf build pass on i386 now.

Thanks for the quick fix patch.

>
> $ git diff tools/arch/x86/include/uapi/asm/unistd_32.h
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h
> b/tools/arch/x86/include/uapi/asm/unistd_32.h
> index b8ddfc4..bc48a4d 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -2,6 +2,9 @@
>   #ifndef __NR_fork
>   #define __NR_fork 2
>   #endif
> +#ifndef __NR_execve
> +#define __NR_execve 11
> +#endif
>   #ifndef __NR_getppid
>   #define __NR_getppid 64
>   #endif
>
> Thanks,
> Tiezhu

- Naresh
