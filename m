Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18EAC7EE29
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 05:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFIFOI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 01:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIFOG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 01:14:06 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A92D63
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 22:14:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so236875ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686287645; x=1688879645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/duuqEnRiW7EZ5movk05YglizCx19lbfSPUuvDqWp/8=;
        b=HXonJLbDz4QI6JXYr6pubAg7/cJDzjBQ1IpX9xhdHPIL5VeWGQd9PlL3fFweRCwKEh
         OPB/7pjArNhncEwJNgFDiTWBxl16o9u62ofDi2TadbHFia3ZT/3YxfBEGL5VKx3LUvUT
         pHYYBdKEbkLf0yDtDNjNooFzzXQtRuNqwTaUPpwxFxqaCV29Mw5IKWZc8hrByKxaeZyy
         j4Ii7QtleUrm6FDL2YWnFZUoxySK+Mo4iY2rMSlqH04GTOILEjxDuYLMSoJuEZiVjzos
         PAOD24GYW5NIYBM/MEdTDFcsLjBgTSYbv9158Lp5gtL10ij3VNrGc3jmkv+MeRDR/+uf
         oGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686287645; x=1688879645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/duuqEnRiW7EZ5movk05YglizCx19lbfSPUuvDqWp/8=;
        b=hjSL8CkJESgnf4ZecjZTovQ4GTaQJIEBX+55xAzm0ZUjFaxq+NUmFlVg0A2PZNrIMW
         ir5tbYmO1N+jFI4pqx63Tyr8ezGOexO9zn9+ym8VJcsaul4cHdglPhL4sCDDhtsjC4fE
         PzHug9kY/TNEPAc3COQau4fSeajdVb7gaExdu4uQwTqv7c7y5WWXIkkFhwnAHPKLB3cZ
         hsd/v4Xj5MrcptsQheCM5sp0B2Rk491VHX3+rGWu5rJaIiERyuc8EcCMoouGvf4Dni2A
         Nl9b8PVbjPEbBxCoNSpswT7LXBqrL8KFr2WRvO0wCGarAPYc0okEpje0l5NCOUtNviQL
         dMlg==
X-Gm-Message-State: AC+VfDy3V2KkefV4BLxtftdrDh7n/obnWD0x1VhmnstYHrfQn6VZhVeE
        V7L9WSBb0ozrN95qnZ469Tgy0Y9QP0pyOGtrZeqNel1Dv5vS4bDcU7TQHA==
X-Google-Smtp-Source: ACHHUZ6xYDLQdeRLGpVGHBi8kc/yNX4C4fnJ7YL6s9Vjc7UFEQJffTkQLrNxz+tIPGjf4KSmFutgTcNhwNLk1ofPlT4=
X-Received: by 2002:a05:6e02:12e4:b0:33b:71e6:d6b4 with SMTP id
 l4-20020a056e0212e400b0033b71e6d6b4mr423961iln.14.1686287645015; Thu, 08 Jun
 2023 22:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t>
In-Reply-To: <20230609033128.ujodex56vkha2ifr@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Jun 2023 22:13:53 -0700
Message-ID: <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
To:     Changbin Du <changbin.du@huawei.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 8, 2023 at 8:31=E2=80=AFPM Changbin Du <changbin.du@huawei.com>=
 wrote:
>
> Hello,
> I tried perf of mainline built on Ubuntu 20.04 and it gets stuck when rep=
orting.
>
> $ sudo lsb_release -d
> Description:    Ubuntu 20.04.6 LTS
> $ sudo perf record -g ls
> $ perf report --stdio
> [stuck]
>
> It seems this addr2line binary was't working as perf expected. I found be=
low
> error:
> addr2line: addr2line configuration failed
>
> Then I ran addr2line manually:
>
> $ addr2line -v
> GNU addr2line (GNU Binutils for Ubuntu) 2.34
> Copyright (C) 2020 Free Software Foundation, Inc.
> ...
> $ addr2line -e .debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54=
/elf -i -f
> ,
> __per_cpu_start
> ??:?
>
> The addr2line_configure() expects a '?' but we got '_'.
>
> I am not sure whether this is related to Ian's change but it works on v6.=
3.

Thanks Changbin,

I see this too:
```
$ addr2line -e vmlinux -f -i
,
__per_cpu_start
./arch/x86/kernel/cpu/common.c:1850
^C
$ llvm-addr2line -e vmlinux -f -i
,
,
$ addr2line -e `which true` -f -i
,
??
??:0
$ nm vmlinux|grep __per_cpu_start
0000000000000000 D __per_cpu_start
```
6.3 was largely the same as 6.2 as Linus asked we let patches bake on
linux-next. So the llvm-addr2line support may not have been there in
6.3. Presumably this is 6.4 you are testing. I think this is a
separate issue to:
https://lore.kernel.org/lkml/20230608061812.3715566-1-irogers@google.com/

We could change the configure for vmlinux, reading it say from
a2l->argv. Perhaps we can use a different sentinel value, but some
experiments there:
```
$ addr2line -e vmlinux -f -i
FFFFFFFFFFFFFFFF
??
??:0
^C
$ llvm-addr2line -e vmlinux -f -i
FFFFFFFFFFFFFFFF
__init_scratch_end
??:0
```
Part of the problem is we need a sentinel value that gives the same
number of lines of output whether it is llvm or binutils.

We could have broken and binutils be the same, but this is still going
to cause issues. The problem is we send ',' to addr2line to detect
when it has finished sending output by it writing out question marks.
binutils addr2line is now not writing the ?s as it looks to turn any
invalid input to 0 and dump the symbol for that. This behavior is
unchanged by my patches, so I suspect the problem has happened from a
kernel change.

Thanks,
Ian

> --
> Cheers,
> Changbin Du
