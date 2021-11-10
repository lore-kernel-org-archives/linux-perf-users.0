Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A6C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 08:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AD06124D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 08:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhKJIsj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230393AbhKJIsi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 03:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Ho5EXRGYh8IyL3hxtihj/uWe5GBsevOzHdhzQOn+II=;
        b=bRkPSp5HZtOTVKxD98gBWy/0c3sF9zf5+oNNOVnZnA5FOMjs4gf3UxWTGJZN/0ECir2Xal
        xIZxoYpOB7IECCzqa8gcUX9clQNUZ7WEguqolyTJNs9iRgxOOLmYeh+iiIRwnOfnwO73XK
        fHOW39GilXq0FV/tlgvPUkSOFJ/yIQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-YotPOgk6NACsyukriNWHwA-1; Wed, 10 Nov 2021 03:45:50 -0500
X-MC-Unique: YotPOgk6NACsyukriNWHwA-1
Received: by mail-wm1-f72.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so792144wmj.7
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 00:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Ho5EXRGYh8IyL3hxtihj/uWe5GBsevOzHdhzQOn+II=;
        b=0NnwNHeFNSB69e9e5i/OOP/exAXiFr1jqJKY8wyMrzKXkj5/tpYYpnQWJrLf1SZDhU
         lUMzSX+Wfh+fTMgmPQrWsqy4V5T6wC9yvvbex1PzV1eUI3PGY6rnBYGlS7+AWhpb5fIo
         1ZjUC+/OH61aVdu+tIHI2k3DCkPMC13sxEBxo2tEsklhADY6AVRqaRvCIAx1O3v2yTWF
         TdxWVueZJgKwfypZYHr8/uGJYThyi8DBYYegvbhgMvSz8PCvk3Vyy06BaPYfx5J5hoiQ
         HWURBPWdwsk7oYQmlDvrNdIYa+mjLaxw2KcAzlUUs6VsEH5NfMLxzEpEBowIp+7k2ZTs
         5HCQ==
X-Gm-Message-State: AOAM5303BB/B7TMaT0mhIstBz9XW8Q9Ak85jE8YEyf8jvf14tWUXeytL
        FFbuPgD4HC/Dg/O83rFzDvvBzFamXJYhsWl3MQnQIzwfpunhecc66IFiQJ5hmMumn1e0psjlP6j
        9V6j/Cbav1r5PF2owVQrmAViZqeeWZw==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr14797992wmj.120.1636533948854;
        Wed, 10 Nov 2021 00:45:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwGlCYdC0IIag21+f5cwGkK7+HvhjYZ6HSS2si7iy6/HgYKKEBJOCk3lHgQqzHxshIq23W1A==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr14797972wmj.120.1636533948663;
        Wed, 10 Nov 2021 00:45:48 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l4sm21365520wrv.94.2021.11.10.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:45:48 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:45:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
Message-ID: <YYuGu+bhjSs3syGl@krava>
References: <20211109140707.1689940-1-jolsa@kernel.org>
 <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
 <CAEf4BzYXD57UDMW_scUdHUs=jgmR6f1-pt5JROwr5LYTh1vejw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYXD57UDMW_scUdHUs=jgmR6f1-pt5JROwr5LYTh1vejw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 09, 2021 at 03:33:04PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 9, 2021 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > We hit the window where perf uses libbpf functions, that did not
> > > make it to the official libbpf release yet and it's breaking perf
> > > build with dynamicly linked libbpf.
> > >
> > > Fixing this by providing the new interface as weak functions which
> > > calls the original libbpf functions. Fortunatelly the changes were
> > > just renames.
> >
> > Could we just provide these functions behind a libbpf version #if ?
> > Weak symbols break things in subtle ways, under certain circumstances
> > the weak symbol is preferred over the strong due to lazy object file
> > resolution:
> > https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> > This bit me last week, but in general you get away with it as the lazy
> > object file will get processed in an archive exposing the strong
> > symbol. With an #if you either get a linker error for 2 definitions or
> > 0 definitions, and it's clear what is broken.
> >
> > In the past we had problems due to constant propagation from weak
> > const variables, where #if was the solution:
> > https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
> >
> > There was some recent conversation on libbpf version for pahole here:
> > https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> > https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/
> >
> > Thanks,
> > Ian
> >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > > index 4d3b4cdce176..ceb96360fd12 100644
> > > --- a/tools/perf/util/bpf-event.c
> > > +++ b/tools/perf/util/bpf-event.c
> > > @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > >         return err ? ERR_PTR(err) : btf;
> > >  }
> > >
> > > +struct bpf_program * __weak
> > > +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > > +{
> > > +#pragma GCC diagnostic push
> > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > +       return bpf_program__next(prev, obj);
> > > +#pragma GCC diagnostic pop
> > > +}
> > > +
> > > +struct bpf_map * __weak
> > > +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > > +{
> > > +#pragma GCC diagnostic push
> > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > +       return bpf_map__next(prev, obj);
> > > +#pragma GCC diagnostic pop
> > > +}
> > > +
> > > +const void * __weak
> > > +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > +{
> > > +#pragma GCC diagnostic push
> > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > +       return btf__get_raw_data(btf_ro, size);
> 
> you can still use old variants for the time being, if you want. Were
> new APIs used accidentally? Libbpf maintains a guarantee that if some
> API is deprecated in favor of the new one, there will be at least one
> full libbpf release where both APIs are available and not marked as
> deprecated.

we could use old api instead of btf__raw_data, we could just revert
the perf change

but bpf_object__next_program and bpf_object__next_map are used through
macros like bpf_object__for_each_map or bpf_object__for_each_program,
so we'd need to define 'old versions' of them

jirka

> 
> 
> > > +#pragma GCC diagnostic pop
> > > +}
> > > +
> > >  static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
> > >  {
> > >         int ret = 0;
> > > --
> > > 2.31.1
> > >
> 

