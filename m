Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DFEB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 21:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGJVgz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGJVgy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 17:36:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F0F4;
        Mon, 10 Jul 2023 14:36:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e4c868ee4so3356914a12.0;
        Mon, 10 Jul 2023 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689025012; x=1691617012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPHLwCYSrzehX+poMBnyQydgb702LDDTYd8W73ZnNTE=;
        b=drwfvugvpq5SG1Mzzkv8dvjVvQuxZuyWFoNqKsyLCJyYVJoEeOHFj5Z6qgaZcUcXBi
         Xfb/wgI2+Jf3kQ82qzvmH1ogZMj3Qcyubf1/0LkmpBiH8UXZ63UOumxrcXM1R+C/EnAQ
         DNyzPrk3KEbAkISce+h7Pk7HZMoffBJsArMSEbe0e87t7TsqHZM5nbkQqeLf6S6qzBmO
         mCpsUQu+hmpoS5A2zv4mpMp5hYXAlBGglVT9m8JfnvwwiFCrnYlnwhbQcVs66ADq1j2Q
         JONNGu3OZxa7uZm5ylgsV44zjtjTW8MvGcG/oy+HCGL66MYirwKjShH+9F8MAhFCABrS
         unfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689025012; x=1691617012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPHLwCYSrzehX+poMBnyQydgb702LDDTYd8W73ZnNTE=;
        b=dX9J2btNwilVxz4Nlq+ki3gqrtLzmgcyyLhGMqkFF98aC+Lbw5xIih0U3ebdVGMxHM
         vexQEF1kt35gW/JhQ/Yes+BPXjAtLU4Qlg9byeJBGaRU4GaUtFn9wfC8FMb+6++fbEuA
         TrQ3O6oqJsBK2uFdWMGggchK+Sw0s2JERcM7vf3VpgOPIosNZErg19sGZdtNSuizi6UH
         ItetsYyfViHs8XMH5cVWDW2TKDDYZvJ0vQnJ4K7Ew80NtkR0gFzYToTkwuGpp3fvgL5M
         BIcxW6R6TEzRuwv9hdlGsqXIWNJYSY5T1Qv71wYYrup0thZHK8eX2j9BarTbWnB/KZV2
         0wlw==
X-Gm-Message-State: ABy/qLZ55PFNfvPpAfdtZyPpmkwG7Ln/N2f59ilTgqEhb3//l0rox3QD
        laEctBjSSRQc6jGdYfysQ9hzmYjRX6s93s7R0s4=
X-Google-Smtp-Source: APBJJlE4s1l1x+VII7uSBaO+SFsR7XDvpab0BU22qp+Rpa87o/Qc5GXhXuccu11ijfq6NMJjBjjj2cExjhlHnDRRX70=
X-Received: by 2002:aa7:c654:0:b0:51e:1af0:3a90 with SMTP id
 z20-20020aa7c654000000b0051e1af03a90mr12744434edr.37.1689025011946; Mon, 10
 Jul 2023 14:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com> <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
In-Reply-To: <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Jul 2023 14:36:39 -0700
Message-ID: <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     andrii@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 9, 2023 at 9:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 08-Jul-23 4:46 AM, Andrii Nakryiko wrote:
> > On Wed, Jul 5, 2023 at 9:39=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd=
.com> wrote:
> >>
> >> Hi Andrii,
> >>
> >> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
> >> disassociate section handler on explicit bpf_program__set_type() call"=
).
> >>
> >
> > Yep, this commit would reset catch-all custom handler, which perf is
> > setting. I've just sent a fix upstream ([0]). And once it lands, I'll
> > cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.
> >
> > Can you please double-check that this patch indeed fixes the issue for
> > you? I tried to do this locally, but for me perf test 42 fails both at
> > current bpf-next, with the above commit reverted, and with my fix
> > applied on top. So I can't be 100% sure.
> >
> > Thanks!
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/202307072311=
56.1711948-1-andrii@kernel.org/
>
> Thanks. A quick test seems to be working fine.

Alright, thanks for confirming! I've just released v1.2.1 bug fix
release with just this fix on top of v1.2.

Thanks for reporting!

But given v1.2 was cut on May 1st, and the offending commit landed
some time late March, I wonder how did this slip through the cracks
and go unreported for so long? Is there something we can do to catch
these perf-only regressions a bit sooner?


>
> Ravi
