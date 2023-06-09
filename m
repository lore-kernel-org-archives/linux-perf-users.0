Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FCC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 23:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFIX6i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIX6i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 19:58:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040963594
        for <linux-perf-users@vger.kernel.org>; Fri,  9 Jun 2023 16:58:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9d619103dso33191cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jun 2023 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686355116; x=1688947116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG+l7S0lT2DdlK4X8NsVJWxVQsk8ZZV0CX3smb3kA7I=;
        b=RG3aSSxqo4fPy2tdK8HUKyxo97jG9KlauybfddDx4EjeKd/+YOuqH3MWKdERTpZW0X
         6QtvxQuPCOHlr74+Vw2Rt2vvAXjr77/rc6XIUGCOhw9hUFIN6jIvSKMCvfygyF38iQ3R
         l9BiKU05Q61RFqJEP94cO54p2iw3nMtqAoPLdO9HgnoRniXoO3UMAcP7+/JmEXdOZ4tN
         qTbL+HNtSIvY3xV7oUDJiEDR1bELo4ioSc0kqQ7/OtfkCPNn78IeqYll5o96658w1y36
         Hrk2+jM5O9CMvMmBZVlUehcQ+q5xk9U0QN0io3h12PbxqsuJEUwJUxkpvi76UgkCAoqn
         Ahqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686355116; x=1688947116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG+l7S0lT2DdlK4X8NsVJWxVQsk8ZZV0CX3smb3kA7I=;
        b=PoG9wNiKNbvu0BRNrsIeBIcsJ0Jq119TUXeGNfM+BmMEpHy9jptgqG4tk5jaItogTO
         QU4Rpb0k2BrlSI0QBsNO5y/jFrO/TFwJLdd7dtgeryRmN6biL/h2GxXuqL1UEw1/Jt6/
         LBadFt0cacHTiTg1kxD7SmGU0Q8j04GCCBMASZ4rV7tdw6OEvkGYeQU/rIugXmyDVdKb
         mF851Ujt5sf56CdNoy1APee8/iTkgoimMd1LwJmHjI/M3hQno4x1htnZdrgugnmNrgxC
         jd+/KaoX9muMdIwKVF3RBcAcWD910+HnJh+GVlGm6sW3dddvMKkXn1YhkOC3jdjbYQiN
         jnwA==
X-Gm-Message-State: AC+VfDxnBOIGyoF1utY/kGiPqVBvWnCEXaOb474zEKQcr4l4pUhQC4VC
        xWZ4SyanTWdduiczIO+t1oE3apo0IlV7GHdMjCT/H7VHWAfWO6pcBPyqXg==
X-Google-Smtp-Source: ACHHUZ5HMe/H+kpS49Xk82F0DTAqyjUWIVE8QUP4Qk+/JDA79GYl79LotU5kgv0Zo52HORYiY6IW+mguyK22om1UHRw=
X-Received: by 2002:ac8:7fc3:0:b0:3f8:8c06:c53b with SMTP id
 b3-20020ac87fc3000000b003f88c06c53bmr59755qtk.0.1686355116057; Fri, 09 Jun
 2023 16:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t> <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
In-Reply-To: <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 9 Jun 2023 16:58:24 -0700
Message-ID: <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
To:     Changbin Du <changbin.du@huawei.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 8, 2023 at 10:13=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jun 8, 2023 at 8:31=E2=80=AFPM Changbin Du <changbin.du@huawei.co=
m> wrote:
> >
> > Hello,
> > I tried perf of mainline built on Ubuntu 20.04 and it gets stuck when r=
eporting.
> >
> > $ sudo lsb_release -d
> > Description:    Ubuntu 20.04.6 LTS
> > $ sudo perf record -g ls
> > $ perf report --stdio
> > [stuck]
> >
> > It seems this addr2line binary was't working as perf expected. I found =
below
> > error:
> > addr2line: addr2line configuration failed
> >
> > Then I ran addr2line manually:
> >
> > $ addr2line -v
> > GNU addr2line (GNU Binutils for Ubuntu) 2.34
> > Copyright (C) 2020 Free Software Foundation, Inc.
> > ...
> > $ addr2line -e .debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b=
54/elf -i -f
> > ,
> > __per_cpu_start
> > ??:?
> >
> > The addr2line_configure() expects a '?' but we got '_'.
> >
> > I am not sure whether this is related to Ian's change but it works on v=
6.3.
>
> Thanks Changbin,
>
> I see this too:
> ```
> $ addr2line -e vmlinux -f -i
> ,
> __per_cpu_start
> ./arch/x86/kernel/cpu/common.c:1850
> ^C
> $ llvm-addr2line -e vmlinux -f -i
> ,
> ,
> $ addr2line -e `which true` -f -i
> ,
> ??
> ??:0
> $ nm vmlinux|grep __per_cpu_start
> 0000000000000000 D __per_cpu_start
> ```
> 6.3 was largely the same as 6.2 as Linus asked we let patches bake on
> linux-next. So the llvm-addr2line support may not have been there in
> 6.3. Presumably this is 6.4 you are testing. I think this is a
> separate issue to:
> https://lore.kernel.org/lkml/20230608061812.3715566-1-irogers@google.com/
>
> We could change the configure for vmlinux, reading it say from
> a2l->argv. Perhaps we can use a different sentinel value, but some
> experiments there:
> ```
> $ addr2line -e vmlinux -f -i
> FFFFFFFFFFFFFFFF
> ??
> ??:0
> ^C
> $ llvm-addr2line -e vmlinux -f -i
> FFFFFFFFFFFFFFFF
> __init_scratch_end
> ??:0
> ```
> Part of the problem is we need a sentinel value that gives the same
> number of lines of output whether it is llvm or binutils.
>
> We could have broken and binutils be the same, but this is still going
> to cause issues. The problem is we send ',' to addr2line to detect
> when it has finished sending output by it writing out question marks.
> binutils addr2line is now not writing the ?s as it looks to turn any
> invalid input to 0 and dump the symbol for that. This behavior is
> unchanged by my patches, so I suspect the problem has happened from a
> kernel change.

Hi Changbin,

I think I found a way around the problem by enabling address dumping
from addr2line. I've sent the patches here:
https://lore.kernel.org/lkml/20230609235419.204624-1-irogers@google.com/
but only lightly tested them. Could you please take a look and send a
Tested-by ?

It is probably too late to get this into 6.4.0, but we can add a Fixes
tag so that it gets picked into 6.4.1. The patches here are on the
perf-tools-next tree targeting Linux 6.5.

Thanks,
Ian


> Thanks,
> Ian
>
> > --
> > Cheers,
> > Changbin Du
