Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB1EB64D8
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjFMTy0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFMTyZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 15:54:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEFB3
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:54:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f98276f89cso55501cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686686063; x=1689278063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kaFNmrqlXNHl6myJJQwEsOqHgyEX905kiiiOT//v0E=;
        b=Qo/exQHT36cb+zXUyJ2uhsj50qlk6woHq8nmHeIhTvlhuqtByy5ah0TJKBKiPmMZw8
         H2iwmNk5t5tm//j1J2U+E17Kr4Yio8o/y/N5sC/oMc4Q08pJJbfqKNiwLzYQImpTt51x
         d1zaTvuJ3T8Et1qV8VtPe/FWyGMjwtuztRCOjAraJSmhM8+ljMKKqtpxSa7IeRl6q+lD
         vGOVxeoh8FUxtegF+KqR2qQcJdt7HO3vBB12OZXjdI+uHj0qu9a3R6CrMeXESML6CKGN
         uOcbHiLLcbb7ZU2T4XZ/3I9rSrt7XvCCjn8xgUHCC3+L4O4/mbvryDWU5rAypGD3P8TV
         nZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686686063; x=1689278063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kaFNmrqlXNHl6myJJQwEsOqHgyEX905kiiiOT//v0E=;
        b=CERQiiRSqZ66/ydVrO8/9bnG4w7MwaVj+vE1vSgkJqq/FcMjcfypleaRo5EN0ApdIP
         qGR1yi9YO+iDzF/Q3sfyKaHqApKjUC5PrlWJbKGMNERf+vmPrBhwP2zE1pBs1W1ExhoQ
         KrB5sWB9FrRg2JIZ4DXZq8dj2jn1DMQJ7D+9h5hfSXpQpUEY7SCOM5aPTrtOlnyL/GQh
         X18iNSqzKis3ZGwLhornhyrBVvxE3fUp+w0GnnKqex8feILtk2EK1X87XOGqSHGjDkrb
         RsQIFsg0tV4RD8gDjqy8LVGMYjIbi2Odx9Rkx4nY10MAkFQWIaUI1s4pGlNgk9v19wpr
         Sirw==
X-Gm-Message-State: AC+VfDyu0O9elfr0Tx/wII1eVj7u4r4tj7BzgOdEM3gN/7q/vLcybIdd
        HM5Mmj7H2jh5+CF/UtZ4wSAXBvbWyDSeeul3jpwviA==
X-Google-Smtp-Source: ACHHUZ4YzZm7OoifKmmJgSwGRdJRZJ56jjZluRQ/w5pW4YLVSsvKxL4+BJJ8N/hAR1JJWv7rUSdIr6Nw8YumyN+B67g=
X-Received: by 2002:ac8:7d84:0:b0:3ef:343b:fe7e with SMTP id
 c4-20020ac87d84000000b003ef343bfe7emr56480qtd.2.1686686063049; Tue, 13 Jun
 2023 12:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230613191639.1547925-1-irogers@google.com> <ZIjIiPAfTwL/P1dt@kernel.org>
In-Reply-To: <ZIjIiPAfTwL/P1dt@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:54:11 -0700
Message-ID: <CAP-5=fUQC2homPem0C4gsmiTMhwnNA0Jau8ehg=WG_oXRq0-8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] perf util: asprintf helper for leak sanitizer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 13, 2023 at 12:16:38PM -0700, Ian Rogers escreveu:
> > asprintf is a source of memory leaks but produces bad stack traces on
> > my Debian linux. This patch adds a simple asprintf implementation to
> > util.c that works around it.
>
> So is this something to report to the glibc maintainers or debian?

*shrug* Folks appear to have been complaining about no option for
nearly 10 years, motivated by profiling more than sanitizers. Perhaps
I need to convince my employer to switch to Fedora.

Thanks,
Ian

> - Arnaldo
>
> > Before output:
> > ```
> > =3D=3D1541752=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 10 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f90c76b89cf in __interceptor_malloc ../../../../src/libsaniti=
zer/asan/asan_malloc_linux.cpp:69
> >     #1 0x7f90c649d2c7 in __vasprintf_internal libio/vasprintf.c:71
> >     #2 0x55ad9b79afbf  (/tmp/perf/perf+0x850fbf)
> >
> > SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> > ```
> >
> > After output:
> > ```
> > =3D=3D1545918=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 10 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f2755a7077b in __interceptor_strdup ../../../../src/libsaniti=
zer/asan/asan_interceptors.cpp:439
> >     #1 0x564986a8df31 in asprintf util/util.c:566
> >     #2 0x5649869b5901 in metricgroup__lookup_default_metricgroup util/m=
etricgroup.c:1520
> >     #3 0x5649869b5e57 in metricgroup__lookup_create util/metricgroup.c:=
1579
> >     #4 0x5649869b6ddc in parse_groups util/metricgroup.c:1698
> >     #5 0x5649869b7714 in metricgroup__parse_groups util/metricgroup.c:1=
771
> >     #6 0x5649867da9d5 in add_default_attributes tools/perf/builtin-stat=
.c:2164
> >     #7 0x5649867ddbfb in cmd_stat tools/perf/builtin-stat.c:2707
> >     #8 0x5649868fa5a2 in run_builtin tools/perf/perf.c:323
> >     #9 0x5649868fab13 in handle_internal_command tools/perf/perf.c:377
> >     #10 0x5649868faedb in run_argv tools/perf/perf.c:421
> >     #11 0x5649868fb443 in main tools/perf/perf.c:537
> >     #12 0x7f2754846189 in __libc_start_call_main ../sysdeps/nptl/libc_s=
tart_call_main.h:58
> >
> > SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> > ```
> >
> > RFC: is this useful for others? Should we have a build flag for it?
> > ---
> >  tools/perf/util/util.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index c1fd9ba6d697..57eb528c5fed 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -552,3 +552,22 @@ int sched_getcpu(void)
> >       return -1;
> >  }
> >  #endif
> > +
> > +int asprintf(char **restrict strp, const char *restrict fmt, ...)
> > +{
> > +     char buf[1024];
> > +     va_list ap;
> > +     int size;
> > +     char *result;
> > +
> > +     va_start(ap, fmt);
> > +     size =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> > +     if (size < (int)sizeof(buf))
> > +             result =3D strdup(buf);
> > +     else
> > +             size =3D vasprintf(&result, fmt, ap);
> > +
> > +     *strp =3D result;
> > +     va_end(ap);
> > +     return size;
> > +}
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> --
>
> - Arnaldo
