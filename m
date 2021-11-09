Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D52C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 23:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A42C611CA
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 23:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhKIXgE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKIXgD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 18:36:03 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E4C061764;
        Tue,  9 Nov 2021 15:33:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so1532764ybe.13;
        Tue, 09 Nov 2021 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYebiZkSqfk+SEyJR1FyCrAiQ21EGEQnskwkiymG0qo=;
        b=Wi8B15wZj4cc+h6CBGFJUarrPgW7jwmN7+G3E5tTlOgfIPxGwnD7zY/SrSiJ8TVdkb
         quBMKPwJIp5s7CF64Vlz+4bv97K4YHTo3Hj1ywfqlDENr+irvzqXXzhW5U2HNUUnCpl/
         P3GhTadjyFHFAM9lYJAPfHr38HlGJ7QYDDapCa9IQ00+OUl7mi32FCaPGitGIgz3C8O3
         0pryorpjVu5D/p7XNPSFQPR3GSOK/PWK8d47qJuMSvGhOyO2NnQX0rCvdQwg18S4ETtb
         wckiZts4oOHw3rmzyCNtmcRCHhcQ2fGu7u50gFoBQz7a7fdSb7Vn1VyJqPZYusK2FvT+
         Pu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYebiZkSqfk+SEyJR1FyCrAiQ21EGEQnskwkiymG0qo=;
        b=Qf0MIOVOoP6b+iFHXCO4Q4NNYpgpdfpupmsUe3vzWI9At/StAuZbO4WWkDcSwUHL8w
         hh0kZufm9GMYZP7+FzrZvxzkuBk1hNfnvCPlg5wqDvOnGKDC/A2DGEj0c0o4eAgufV0e
         Z2HnDc5ZlYobyawNRMuLKc4U+Q54FHC+AwMYJQp1s4FY+OwrQu8nxErcnlB/Gath5OZ9
         BCVNp/9mVFUkFtGgiRcIb+Bx4oZZEDJhZFSfOZ2U6nrHMn+dKalKc+YgYC16Y+9YwYVQ
         51/WZbH4rjQ3FPMMeT1GKxacge0nEDMqAqb8nTAJ9StXiQsPyUjv9DAyKRdsCdtanzId
         nL1g==
X-Gm-Message-State: AOAM5321NPSolrMVXAwDrUN6wjir17K3Fz6/mFW1z8HTqYukyMoZs7Dc
        N+i6KGsSM+jtAQBTEhevQLjzWjK2HctPGZQ7r+g=
X-Google-Smtp-Source: ABdhPJyl9e2HbT3PJbfsdL79UoJYgXrIeAb41W6oYZFEG/9Iy0OCoFz2rnJ6Y1g+V0kcUCGhQ7Epr8+ClRbMBfIKGtg=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr12837122ybt.267.1636500795508;
 Tue, 09 Nov 2021 15:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20211109140707.1689940-1-jolsa@kernel.org> <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
In-Reply-To: <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 15:33:04 -0800
Message-ID: <CAEf4BzYXD57UDMW_scUdHUs=jgmR6f1-pt5JROwr5LYTh1vejw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 9, 2021 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > We hit the window where perf uses libbpf functions, that did not
> > make it to the official libbpf release yet and it's breaking perf
> > build with dynamicly linked libbpf.
> >
> > Fixing this by providing the new interface as weak functions which
> > calls the original libbpf functions. Fortunatelly the changes were
> > just renames.
>
> Could we just provide these functions behind a libbpf version #if ?
> Weak symbols break things in subtle ways, under certain circumstances
> the weak symbol is preferred over the strong due to lazy object file
> resolution:
> https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> This bit me last week, but in general you get away with it as the lazy
> object file will get processed in an archive exposing the strong
> symbol. With an #if you either get a linker error for 2 definitions or
> 0 definitions, and it's clear what is broken.
>
> In the past we had problems due to constant propagation from weak
> const variables, where #if was the solution:
> https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
>
> There was some recent conversation on libbpf version for pahole here:
> https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/
>
> Thanks,
> Ian
>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 4d3b4cdce176..ceb96360fd12 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> >         return err ? ERR_PTR(err) : btf;
> >  }
> >
> > +struct bpf_program * __weak
> > +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return bpf_program__next(prev, obj);
> > +#pragma GCC diagnostic pop
> > +}
> > +
> > +struct bpf_map * __weak
> > +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return bpf_map__next(prev, obj);
> > +#pragma GCC diagnostic pop
> > +}
> > +
> > +const void * __weak
> > +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return btf__get_raw_data(btf_ro, size);

you can still use old variants for the time being, if you want. Were
new APIs used accidentally? Libbpf maintains a guarantee that if some
API is deprecated in favor of the new one, there will be at least one
full libbpf release where both APIs are available and not marked as
deprecated.


> > +#pragma GCC diagnostic pop
> > +}
> > +
> >  static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
> >  {
> >         int ret = 0;
> > --
> > 2.31.1
> >
