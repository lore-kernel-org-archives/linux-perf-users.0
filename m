Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FBC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 22:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DF7611C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhKJWkx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhKJWkx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 17:40:53 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D893C061766;
        Wed, 10 Nov 2021 14:38:05 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id q74so10171816ybq.11;
        Wed, 10 Nov 2021 14:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y68f68GkpKbGs02dcDP/2bnR8VHfpzVy2NEqVOcq5Sw=;
        b=HEByGRC9IlEwErlf+aVe3R+l555XmuFjWk9HdtCe50uxLMGmigzRVPVOsn0lRY/8Ih
         +hrBp6ukAoWwIhxKFPMJHJxxvnOEcG0RkMRp69KTZpPVvA9uMe4uzwRcxEVz06XLdn8k
         a9spkOlW6+MPDcEpV+SJUQeCxxm16ETvJeLbAM4QRJNzDkpMfgsxdifNbaajub56bHjh
         bDyrCq3dT8IBXsodyoRY0rsJdePvnSbuHuLLwsQSu/dsth1pz97avVhIsFQ2dcIlpKdC
         WC+y0jDlgDRnHVSZ+32olubi8dFAZpQVb8CYyFJ5mwegTLrq0foHar1NpTslCRUbdl4l
         U42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y68f68GkpKbGs02dcDP/2bnR8VHfpzVy2NEqVOcq5Sw=;
        b=e2Ggc8bfLnB2lmnS9g2zlFpFbudAp4HKpT4u1rF+Oo616bRVp6FW+XdZFGteE40Nyx
         MakXofHbGskwzBDyZjDJuD2MPE3KZ4czM0Dv9AVBYPRltxeGcPgkpAjQk0sTR/8B15R9
         9UEFKx6ZvUTrbNH4Uht2AozNKBauh3MVZn9BjFdtJ4h6YdYqDWiB2KIcNpqSoqfkpf4D
         vruMYY5KSM15cyO8TpNh5Pl4UyLAX+smzMxrIDUqrbadDfYk5pn3Su+70v1vynxbWYGU
         CJ6i5HwtVx7VL6BQ84PEHsAuZ6f7PhaIlRe1RW0OnMgHDsiv5H2b79+c1eS/BqKhV92/
         YaVg==
X-Gm-Message-State: AOAM5316i0swNfkLqeE3OxlPqJHKnCyicPHDg+ypSrs31n4aeuS0UiIj
        ZVVhHlChe3dqznqInDYyIuUtAJHGxUNEVuOeaB8=
X-Google-Smtp-Source: ABdhPJyw/oyOE2TdumLq/bn+2Bzy8z9UqiS4UEa62U68KeHdHHBrPPUTccFhnQRO/DE9uQ6E8jkCnQMqEQfyDQPqUuI=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr3059012ybt.267.1636583884356;
 Wed, 10 Nov 2021 14:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20211109140707.1689940-1-jolsa@kernel.org> <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
 <CAEf4BzYXD57UDMW_scUdHUs=jgmR6f1-pt5JROwr5LYTh1vejw@mail.gmail.com> <YYuGu+bhjSs3syGl@krava>
In-Reply-To: <YYuGu+bhjSs3syGl@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Nov 2021 14:37:53 -0800
Message-ID: <CAEf4Bza+wxyRgTRN_vXL7SGqSBaBG5tWmwhyH6b7o3tsEjyauw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
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

On Wed, Nov 10, 2021 at 12:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Nov 09, 2021 at 03:33:04PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 9, 2021 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > We hit the window where perf uses libbpf functions, that did not
> > > > make it to the official libbpf release yet and it's breaking perf
> > > > build with dynamicly linked libbpf.
> > > >
> > > > Fixing this by providing the new interface as weak functions which
> > > > calls the original libbpf functions. Fortunatelly the changes were
> > > > just renames.
> > >
> > > Could we just provide these functions behind a libbpf version #if ?
> > > Weak symbols break things in subtle ways, under certain circumstances
> > > the weak symbol is preferred over the strong due to lazy object file
> > > resolution:
> > > https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> > > This bit me last week, but in general you get away with it as the lazy
> > > object file will get processed in an archive exposing the strong
> > > symbol. With an #if you either get a linker error for 2 definitions or
> > > 0 definitions, and it's clear what is broken.
> > >
> > > In the past we had problems due to constant propagation from weak
> > > const variables, where #if was the solution:
> > > https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
> > >
> > > There was some recent conversation on libbpf version for pahole here:
> > > https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> > > https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
> > > >  1 file changed, 27 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > > > index 4d3b4cdce176..ceb96360fd12 100644
> > > > --- a/tools/perf/util/bpf-event.c
> > > > +++ b/tools/perf/util/bpf-event.c
> > > > @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > >         return err ? ERR_PTR(err) : btf;
> > > >  }
> > > >
> > > > +struct bpf_program * __weak
> > > > +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > > > +{
> > > > +#pragma GCC diagnostic push
> > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > +       return bpf_program__next(prev, obj);
> > > > +#pragma GCC diagnostic pop
> > > > +}
> > > > +
> > > > +struct bpf_map * __weak
> > > > +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > > > +{
> > > > +#pragma GCC diagnostic push
> > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > +       return bpf_map__next(prev, obj);
> > > > +#pragma GCC diagnostic pop
> > > > +}
> > > > +
> > > > +const void * __weak
> > > > +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > > +{
> > > > +#pragma GCC diagnostic push
> > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > +       return btf__get_raw_data(btf_ro, size);
> >
> > you can still use old variants for the time being, if you want. Were
> > new APIs used accidentally? Libbpf maintains a guarantee that if some
> > API is deprecated in favor of the new one, there will be at least one
> > full libbpf release where both APIs are available and not marked as
> > deprecated.
>
> we could use old api instead of btf__raw_data, we could just revert
> the perf change
>
> but bpf_object__next_program and bpf_object__next_map are used through
> macros like bpf_object__for_each_map or bpf_object__for_each_program,
> so we'd need to define 'old versions' of them

There is nothing magical about bpf_object__for_each_map(). If it's
causing problems, just implement your own iteration logic. You'll be
suffering like this because you are trying to support both shared
library mode and static library mode with libbpf. I'm sorry for your
pain, but you are trying to compile against the latest unreleased
headers, yet work properly with older released libbpf shared library.
It's painful and you know what I think about using shared libraries,
right?

>
> jirka
>
> >
> >
> > > > +#pragma GCC diagnostic pop
> > > > +}
> > > > +
> > > >  static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
> > > >  {
> > > >         int ret = 0;
> > > > --
> > > > 2.31.1
> > > >
> >
>
