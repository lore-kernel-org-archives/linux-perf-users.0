Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC0EEAA78
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjINVys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVys (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 17:54:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37551BFA
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:54:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41761e9181eso50821cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694728483; x=1695333283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWifFkh7uyX7E3FA970wycjrJ/Mq5BVRB3q9a/8zjds=;
        b=u75QzEQnxR3F8bElmSrKPoxPL/d6Zn2LU8Ehxbo6szNeddjCNkMc32DJMnO2H1EOkZ
         FusTcBwa/hLCFK3KeFlkkD03nyr/jt8+Po6Hc+uwN0P7Ld65+HdOgcUKGrTZYchN9PBu
         6GzZdQb63EBW40Ku8nKW94Ch76EgO1VWe5j1g4IG+Nu7AV1KDOe/FlUBiwYB1uXNgB4g
         nvnBJPHN4vSgRo3Xle4bmaCxlP9qa2HyHeXt/Yga5NdlluSEFifuFB/ikmCZ5kIzeyBn
         euu5uCAmhxesinuO90GRHHaS81nWdMHIe9bYUBDwZXsctgpmjMXVBS97zjhe+y4sL5Hp
         g85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728483; x=1695333283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWifFkh7uyX7E3FA970wycjrJ/Mq5BVRB3q9a/8zjds=;
        b=KUoW1jxeTupnRVhJFx4djUP43PULKMtfdkg03CwPXQEArw8goXIPjAffTQ4kTKFYty
         6hr+TX0kfB2eVe5rSXyDiVI/slD7vhYBiqUPBxHjfCUkHMNVmFovlZSmi3Rq/nD/qFXy
         dHFcxBEZ9y3u2l51+mNvX4rgcXU43duYG24JN3dT17b2CQy/PfkC6wS8EQQbYVhuRMdj
         69lbci2mZHUknoHq28CQIdQexPDoeU01e91vjBhqnK7TkiXaUNEu2ULsub5tKgKtTSsK
         bdfxymRjJiK4et+4T9BNcGGnfOUShvvgZ2VCk7tCzP06sB4VXff+OTVEYgpzjl6PTs4v
         kFGQ==
X-Gm-Message-State: AOJu0YyHU5+JlYnRTB72EfHFGBbbn7N1vunRI0gaf0aA1nEVGJOy8mPB
        L/bvAJNN5dzpQJA+sng+ejluCoaWhfcDivmEfvyplw==
X-Google-Smtp-Source: AGHT+IHHyhzqxkcKQGjhi4l8skCqBQSD/w275tcDWgwOk1AcdgDAP7LS+/t1owjqr6gAO0TvS/vl+IHBgGrs61s/pyA=
X-Received: by 2002:a05:622a:15c9:b0:412:16f:c44f with SMTP id
 d9-20020a05622a15c900b00412016fc44fmr111564qty.6.1694728483005; Thu, 14 Sep
 2023 14:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com> <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com> <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com> <ZK7JMjN9LXTFEOvT@kernel.org>
 <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
 <ZLBlUXDxRqzNRup3@kernel.org> <87FAA9FD-C64E-4199-9F77-8671FF19EEE1@fb.com> <SA1PR15MB46099ABDC08009096019B5B4CBF7A@SA1PR15MB4609.namprd15.prod.outlook.com>
In-Reply-To: <SA1PR15MB46099ABDC08009096019B5B4CBF7A@SA1PR15MB4609.namprd15.prod.outlook.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Sep 2023 14:54:31 -0700
Message-ID: <CAP-5=fX5Jk=37gr-hpe-RizDsVkOw1UZmC7hU5gTEU6KLvR1aA@mail.gmail.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To:     Manu Bretelle <chantra@meta.com>
Cc:     Mykola Lysenko <mykolal@meta.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 14, 2023 at 2:43=E2=80=AFPM Manu Bretelle <chantra@meta.com> wr=
ote:
>
> Hi Arnaldo,
>
>
>
> Checking back here to see if there is anything you need help in order to =
add perf support to BPF CI. Were you able to make progress and are hitting =
some issues along the way?
>

Separate from the CI issue there were some updates on perf:
 - we're looking to re-enable BPF skeletons by default for 6.7:
https://lore.kernel.org/lkml/20230914211948.814999-1-irogers@google.com/
 - Ravi's original failure can no longer fail as we removed the BPF
filter events in favor of a BPF skeleton based --filter option:
https://lore.kernel.org/lkml/20230810184853.2860737-1-irogers@google.com/
As such these tests no longer exist. Other tests like kernel lock
contention analysis implicitly use BPF and so we are still testing
BPF.

Thanks,
Ian

>
> Thanks,
>
>
>
> Manu
>
>
>
> From: Mykola Lysenko <mykolal@meta.com>
> Date: Friday, July 14, 2023 at 11:15 AM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov <alexei.starovo=
itov@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Andrii Nakryiko <an=
drii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <j=
olsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@g=
oogle.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, bpf <bpf@v=
ger.kernel.org>, Manu Bretelle <chantra@meta.com>, Daniel M=C3=BCller <deso=
@posteo.net>, Mykola Lysenko <mykolal@meta.com>
> Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
>
> Hey Arnaldo,
>
> > On Jul 13, 2023, at 1:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
> >
> >
> >
> > Em Wed, Jul 12, 2023 at 11:20:27AM -0700, Alexei Starovoitov escreveu:
> >> On Wed, Jul 12, 2023 at 8:39=E2=80=AFAM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> Right, perhaps the libbpf CI could try building perf, preferably with
> >>> BUILD_BPF_SKEL=3D1, to enable these tools:
> >>
> >>
> >> That would be great.
> >> perf experts probably should do pull-req to bpf CI to enable that.
> >> See slides:
> >> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> >>
> >> "How to contribute?
> >> Depending on what part of CI you are changing, you can create a pull r=
equest to
> >> https://github.com/kernel-patches/vmtest/
> >> https://github.com/libbpf/ci
> >> "
> >
> > Sure, I still recall Quentin's talk about CI, etc in Dublin, will come
> > up with something and submit.
>
> Thanks for looking at this!
>
> If you will have any questions on how CI works, do not hesitate to join B=
PF office hours and we will do our best to answer.
>
> Mykola
>
> >
> > - Arnaldo
>
