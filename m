Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5FEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF3POg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3POe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 11:14:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E5270E
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:14:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40345bf4875so128281cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138073; x=1690730073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw9avx0m53SPC30989wgboQS41fm+M9rVBtayN1Wox4=;
        b=Jcg2Bpzw/EGo9HfiWvoTEB48KERlG4HJYuqzVxspDXav7xPLhiRKbn0SYpjZsewSyK
         lEkdy+63MvzVzEeGYjlP27CoD34+iYvOXrfu9o5fhn+2XlcVahkHj+paQ814jFUUI/1a
         wlBfkcEAHPbVvGSNHvC0tkswjJHYXLI+mHAv1ZdBR7XV9wZlhTyEZsT3+ufWN+abJTQI
         NNUmN2sFIqToNxwi9N2ekz+1pwBIABNouB6PMHKMHpD+nMah0n6N9NSIYmDCWwPT54PJ
         WNSJ7GwBiDtBt1bGQqCdSOa313WUIG/tj+NrLRiyF0BXCt5/3mVpOYVL6lcPiWT29mIM
         s8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138073; x=1690730073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw9avx0m53SPC30989wgboQS41fm+M9rVBtayN1Wox4=;
        b=kmLyKOYVeb7+QusAg6+J2peAfI8qgiaZaXON2Y/Qjd1wZorF7MB4KnnkoGs6sxWrVw
         05Fr+/u4CN7vr7TUsTpq2WDNEi2rx9rk28V77GSXGrnycZrkMl1YxlbOjfaYyOHpqlwR
         9+ljFKZgE5mKnS01XhZVe+QlEYhkoFubzcSSRbwGFWC1k3ZfGlDxptjhKk24WJt20f46
         OllvGut2OHFyKmG1ie31aPWzf2EgDY7GZ4RsMC2pWkn3Pmlbmvm1NvxtIimq6Bx6uaAF
         Q+JipGeRZieyOGbDEco942inuzckn3FznRTGLg9/lu0vRND5gIPRdWjrQn+0PnuH3OAq
         Dmiw==
X-Gm-Message-State: AC+VfDy0198JPYaTKxuz5Q+/DyCIgNj/6zSNtVNhJToJGe1qxz53ty29
        a55ZF95GPTj6OfCTolAj8BVgZdda5jNCDOPkxWZ1k3SzOCw27UTbQYVaYw==
X-Google-Smtp-Source: ACHHUZ4zPe27zyWgd/5U1NkX6t4oTOuhio4Wy84VbtKh0Z5g7w/PHoKHS6cJWmihyWEeijk6RpQLegsJIntOju+VNng=
X-Received: by 2002:a05:622a:1756:b0:3f9:a770:7279 with SMTP id
 l22-20020a05622a175600b003f9a7707279mr787518qtk.9.1688138072603; Fri, 30 Jun
 2023 08:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com> <20230627181030.95608-14-irogers@google.com>
 <CAM9d7cjxrNTOUGxmTAycko_Gn_uY5aX8cBWTa-jrhLoc-Bur1g@mail.gmail.com>
In-Reply-To: <CAM9d7cjxrNTOUGxmTAycko_Gn_uY5aX8cBWTa-jrhLoc-Bur1g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:14:21 -0700
Message-ID: <CAP-5=fWdOQR0MvpJM2aW5Cc=GS86h2Kmh9zD2k5--K=8BNyVgw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 29, 2023 at 2:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jun 27, 2023 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Prefer informative messages rather than none with ABORT_ON. Document
> > one failure mode and add an error message for another.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.y | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 844646752462..454577f7aff6 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -22,12 +22,6 @@
> >
> >  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner=
, char const *msg);
> >
> > -#define ABORT_ON(val) \
> > -do { \
> > -       if (val) \
> > -               YYABORT; \
> > -} while (0)
> > -
> >  #define PE_ABORT(val) \
> >  do { \
> >         if (val =3D=3D -ENOMEM) \
> > @@ -618,7 +612,9 @@ PE_RAW opt_event_config
> >                 YYNOMEM;
> >         errno =3D 0;
> >         num =3D strtoull($1 + 1, NULL, 16);
> > -       ABORT_ON(errno);
> > +       /* Given the lexer will only give [a-fA-F0-9]+ a failure here s=
hould be impossible. */
> > +       if (errno)
> > +               YYABORT;
> >         free($1);
> >         err =3D parse_events_add_numeric(_parse_state, list, PERF_TYPE_=
RAW, num, $2,
> >                                        /*wildcard=3D*/false);
> > @@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
> >  {
> >         struct parse_events_array array;
> >
> > -       ABORT_ON($3 < $1);
> > +       if ($3 < $1) {
> > +               struct parse_events_state *parse_state =3D _parse_state=
;
> > +               struct parse_events_error *error =3D parse_state->error=
;
> > +               char *err_str;
> > +
> > +               if (asprintf(&err_str, "Expected '%ld' to be less-than =
'%ld'", $3, $1) < 0)
>
> Isn't it to be "greater-than or equal" ?

I think the order is right. From the man page:

       When  successful,  these  functions return the number of bytes print=
ed,
       just like sprintf(3).  If memory allocation wasn't  possible,  or  s=
ome
       other error occurs, these functions will return -1, and the contents=
 of
       strp are undefined.

So here we need to catch -1 and ensure strp (&err_str) is NULL before
passing it to parse_events_error__handle.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                       err_str =3D NULL;
> > +
> > +               parse_events_error__handle(error, @1.first_column, err_=
str, NULL);
> > +               YYABORT;
> > +       }
> >         array.nr_ranges =3D 1;
> >         array.ranges =3D malloc(sizeof(array.ranges[0]));
> >         if (!array.ranges)
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
