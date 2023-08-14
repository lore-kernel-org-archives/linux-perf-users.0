Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95EEB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHNR2y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjHNR2p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493F10D5
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso24631cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0ynxCVxUsDM8eCCK8zGMWKVxYfhvsg5eu7n+GQoFuQ=;
        b=a7KJAsBue20iQVGuNyvMysMBgKWMtOWTM6XzXiDvi/muAuOej2tlwrMQrCD3oyr1DB
         cV2ns+a8bqwUH+TUCAmi9NlLG2Klmv2cqPYYhX0eEzz8/Us/rkhd7DOIawTP+y50PlId
         rsgIjlJ0WIvZJ8gamfhVHRmmhBWXjDMVt2rS/w/P7kdgMTWckIt63EL0bEqpEQmwZvEz
         RiArh0Dj/1xSTv9YERC7CsBos76mhcl1FHMJ/Mmnnq8Ry2W6qtRA7CggnNGn/PXk9ws7
         57pS14UA5b3R+0YbgPi56ZdMJGKScyM1DbucoyphXeBrpnrO7Ev139227jZ2HO9tJVdS
         5NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0ynxCVxUsDM8eCCK8zGMWKVxYfhvsg5eu7n+GQoFuQ=;
        b=gyDE6LYU4HTaviEWp7t1I8pWQ56b46BcJTR9HqA5cioKBRstDBXtXIuFG8VuaQtqjz
         kHKbFoXuWi/UpiOFvBXOzxGrDgedbSHDgYkXBtSa89AoTw3Q4xSKhBNcW5ugYPFW3yPv
         OjMAQN8gen9BYfkylk4cYLFdR4DrgCSmVQlJJGXIA+W1vUFC4yPxDB993C3QAxmVj5oQ
         Wl0HJqL9IxZhGgZ3MtchbCSOn+dB78YjebBBSjKXDq0jF7qevTnlWKv0HmYYsQ3BSTdZ
         aI1SMk27yXaPOUDXJSPL+VZnaW4XfgiDlBzVsxDdDXFqNfs43FYcmQ30Ycu+mIw2pRZY
         R+4Q==
X-Gm-Message-State: AOJu0YwBHovpjhBAegfpsf/3rl7DfjftG3Zxs0XJW3FzMA6nS/bnXGHQ
        teEOvGOh5P/zeUhYfl/qE5Mg6VvIwbaIY+m9BxrW2Vsk7S4ns5VTuKvOhA==
X-Google-Smtp-Source: AGHT+IGIS3JZ+2r/EEnDwIFyidh6lYHE1I0NcfM4xWHTNBXg77WSE7GmnjFls0IJH/XfCefVDf0IfUs+JAfNBepKA8k=
X-Received: by 2002:ac8:4e55:0:b0:40f:ec54:973 with SMTP id
 e21-20020ac84e55000000b0040fec540973mr695644qtw.22.1692034123260; Mon, 14 Aug
 2023 10:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091857.10681-1-adrian.hunter@intel.com> <ZMwTYsh8KIwphOR5@kernel.org>
In-Reply-To: <ZMwTYsh8KIwphOR5@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 10:28:29 -0700
Message-ID: <CAP-5=fW+Y+4dk_TL2RuOJWwnqd3cvhVARoRVSdmhiiVaNwEnfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf dlfilter: Add a test for resolve_address()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 3, 2023 at 1:51=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Mon, Jul 31, 2023 at 12:18:55PM +0300, Adrian Hunter escreveu:
> > Extend the "dlfilter C API" test to test
> > perf_dlfilter_fns.resolve_address(). The test currently fails, but pass=
es
> > after a subsequent patch.
>
> Ian,
>
>         I think this is ok now, can you please take a look and perhaps
> provide an Acked-by or Reviewed-by?

Sorry, found this in my backlog. I'm a little confused over which
patch series is current but they all lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/dlfilters/dlfilter-test-api-v0.c | 26 ++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/d=
lfilters/dlfilter-test-api-v0.c
> > index b1f51efd67d6..72f263d49121 100644
> > --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > @@ -254,6 +254,30 @@ static int check_addr_al(void *ctx)
> >       return 0;
> >  }
> >
> > +static int check_address_al(void *ctx, const struct perf_dlfilter_samp=
le *sample)
> > +{
> > +     struct perf_dlfilter_al address_al;
> > +     const struct perf_dlfilter_al *al;
> > +
> > +     al =3D perf_dlfilter_fns.resolve_ip(ctx);
> > +     if (!al)
> > +             return test_fail("resolve_ip() failed");
> > +
> > +     address_al.size =3D sizeof(address_al);
> > +     if (perf_dlfilter_fns.resolve_address(ctx, sample->ip, &address_a=
l))
> > +             return test_fail("resolve_address() failed");
> > +
> > +     CHECK(address_al.sym && al->sym);
> > +     CHECK(!strcmp(address_al.sym, al->sym));
> > +     CHECK(address_al.addr =3D=3D al->addr);
> > +     CHECK(address_al.sym_start =3D=3D al->sym_start);
> > +     CHECK(address_al.sym_end =3D=3D al->sym_end);
> > +     CHECK(address_al.dso && al->dso);
> > +     CHECK(!strcmp(address_al.dso, al->dso));
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_attr(void *ctx)
> >  {
> >       struct perf_event_attr *attr =3D perf_dlfilter_fns.attr(ctx);
> > @@ -290,7 +314,7 @@ static int do_checks(void *data, const struct perf_=
dlfilter_sample *sample, void
> >       if (early && !d->do_early)
> >               return 0;
> >
> > -     if (check_al(ctx) || check_addr_al(ctx))
> > +     if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample))
> >               return -1;
> >
> >       if (early)
> > --
> > 2.34.1
> >
>
> --
>
> - Arnaldo
