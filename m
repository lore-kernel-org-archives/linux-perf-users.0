Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E9C7618D
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Apr 2023 06:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjDFGUp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDFGUn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 02:20:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A398A68
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Apr 2023 23:20:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3e0965f70ecso395721cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Apr 2023 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680762041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNGMbrDwFYJ2bOBmCKlUarMLiXvKBcI+GvaUwNOu/10=;
        b=UwMH43JLsXXYRH1gRLlt3/1i/R+ZeYv0+334jNNi7FkNfTmRyW1BZljCqqhniRgGbg
         EpyouwgfnZ58LQbiubJlvGmTcmtlL/NbHPlEP+e3IK9lqAWUWHHFdb5LCtT872XHZn5M
         vRpFfC23IMtKGdxqDbq9m06QO3yLEVbQAL7FhLQ+ZTHDw72pYEpVnXUoMwe67zkGrkIT
         CADvS5ppGaQKcyzHNDErCXFl6wWmxJBlwKrJM+BowTQqIGDml0rduspUHVTw1crujaqF
         fr/QjMx3kYdC7IODO4Lr4l3wr682sVzV/ahNX1quWL8PbbT2/aAA032FLBRNohVHCw/5
         eJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNGMbrDwFYJ2bOBmCKlUarMLiXvKBcI+GvaUwNOu/10=;
        b=5TPlUL0a0pbHR8px1dGMhNhbDgSLngMDr27ko78hgDR/n1YU/lI6HA3VhwFFZvQRUR
         lQQzk4mkr8FiO/uXSz9T7ncc6q2ptggAR71HjwJlrll3wMxPj4n6AZoPGu1IlxuwGfXN
         BhQ0QoLubTlPYfziH2meWgbnYWlgY4iFGoeKylBT9/zTZJtVDHiLPdrHdnrK3CMP0UXa
         YIZtMPRz1AZd/YIXHZc8wYQ8CR9yKXETerUmVUsxWnw44gQZpywUOA+yiWK6U6OyC828
         RDOLhsoV3kETe5ebD1wVW4i8SBFpD0sGZIDbYyzbUOQWTYswpsBRENzzx0x5ccOUUlYd
         OtEQ==
X-Gm-Message-State: AAQBX9cebDy7ILelN+Gyxp7qn4hgYDK1au7pnH2pw9IfcMChpMsy4GA9
        HZwAyrApC0MuGocHxc0MB/dDPtOTKFjEnAvcSTAfRA==
X-Google-Smtp-Source: AKy350Y55tL3xvY7BT+sgruCRqe/1Q5XoFK5pXPKNuiMse5ClFsCfzotPvwr9sztlZh6EQWtfHnm+l588nbgxfIZz5I=
X-Received: by 2002:ac8:7e96:0:b0:3e6:7702:b87 with SMTP id
 w22-20020ac87e96000000b003e677020b87mr170767qtj.7.1680762041485; Wed, 05 Apr
 2023 23:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230404133630.1985739-1-irogers@google.com> <ZC3mz+Ge9WGG8/t5@krava>
In-Reply-To: <ZC3mz+Ge9WGG8/t5@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 5 Apr 2023 23:20:29 -0700
Message-ID: <CAP-5=fXaDXu+LttGZyWzU0aj__ruc8PLyBTME+dpFNCaRwxprw@mail.gmail.com>
Subject: Re: [PATCH v2] perf pmu: Make parser reentrant
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 5, 2023 at 2:23=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Apr 04, 2023 at 06:36:30AM -0700, Ian Rogers wrote:
> > By default bison uses global state for compatibility with yacc. Make
> > the parser reentrant so that it may be used in asynchronous and
> > multithreaded situations.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 24 ++++++++++++++++++------
> >  tools/perf/util/pmu.h |  2 +-
> >  tools/perf/util/pmu.l | 17 ++++++++++++-----
> >  tools/perf/util/pmu.y |  5 ++++-
> >  4 files changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 78a407b42ad1..f603cdabf797 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -24,6 +24,8 @@
> >  #include "evsel.h"
> >  #include "pmu.h"
> >  #include "pmus.h"
> > +#include "pmu-bison.h"
> > +#include "pmu-flex.h"
> >  #include "parse-events.h"
> >  #include "print-events.h"
> >  #include "header.h"
> > @@ -57,9 +59,6 @@ struct perf_pmu_format {
> >       struct list_head list;
> >  };
> >
> > -int perf_pmu_parse(struct list_head *list, char *name);
> > -extern FILE *perf_pmu_in;
> > -
> >  static bool hybrid_scanned;
> >
> >  static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
> > @@ -81,6 +80,8 @@ int perf_pmu__format_parse(int dirfd, struct list_hea=
d *head)
> >       while (!ret && (evt_ent =3D readdir(format_dir))) {
> >               char *name =3D evt_ent->d_name;
> >               int fd;
> > +             void *scanner;
> > +             FILE *file;
> >
> >               if (!strcmp(name, ".") || !strcmp(name, ".."))
> >                       continue;
> > @@ -91,9 +92,20 @@ int perf_pmu__format_parse(int dirfd, struct list_he=
ad *head)
> >               if (fd < 0)
> >                       break;
> >
> > -             perf_pmu_in =3D fdopen(fd, "r");
> > -             ret =3D perf_pmu_parse(head, name);
> > -             fclose(perf_pmu_in);
> > +             file =3D fdopen(fd, "r");
> > +             if (!file)
> > +                     break;
>
> hum, do we potentially leak fd in here?
>
> jirka

Agreed. Will fix in v3.

Thanks,
Ian

> > +
> > +             ret =3D perf_pmu_lex_init(&scanner);
> > +             if (ret) {
> > +                     fclose(file);
> > +                     break;
> > +             }
> > +
> > +             perf_pmu_set_in(file, scanner);
> > +             ret =3D perf_pmu_parse(head, name, scanner);
> > +             perf_pmu_lex_destroy(scanner);
> > +             fclose(file);
> >       }
> >
> >       closedir(format_dir);
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 32c3a75bca0e..d53618c65c92 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -206,7 +206,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, str=
uct list_head *head_terms,
> >                         struct perf_pmu_info *info);
> >  struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
> >                                 struct list_head *head_terms);
> > -void perf_pmu_error(struct list_head *list, char *name, char const *ms=
g);
> > +void perf_pmu_error(struct list_head *list, char *name, void *scanner,=
 char const *msg);
> >
> >  int perf_pmu__new_format(struct list_head *list, char *name,
> >                        int config, unsigned long *bits);
> > diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
> > index 58b4926cfaca..67b247be693b 100644
> > --- a/tools/perf/util/pmu.l
> > +++ b/tools/perf/util/pmu.l
> > @@ -1,4 +1,6 @@
> >  %option prefix=3D"perf_pmu_"
> > +%option reentrant
> > +%option bison-bridge
> >
> >  %{
> >  #include <stdlib.h>
> > @@ -6,16 +8,21 @@
> >  #include "pmu.h"
> >  #include "pmu-bison.h"
> >
> > -static int value(int base)
> > +char *perf_pmu_get_text(yyscan_t yyscanner);
> > +YYSTYPE *perf_pmu_get_lval(yyscan_t yyscanner);
> > +
> > +static int value(yyscan_t scanner, int base)
> >  {
> > +     YYSTYPE *yylval =3D perf_pmu_get_lval(scanner);
> > +     char *text =3D perf_pmu_get_text(scanner);
> >       long num;
> >
> >       errno =3D 0;
> > -     num =3D strtoul(perf_pmu_text, NULL, base);
> > +     num =3D strtoul(text, NULL, base);
> >       if (errno)
> >               return PP_ERROR;
> >
> > -     perf_pmu_lval.num =3D num;
> > +     yylval->num =3D num;
> >       return PP_VALUE;
> >  }
> >
> > @@ -25,7 +32,7 @@ num_dec         [0-9]+
> >
> >  %%
> >
> > -{num_dec}    { return value(10); }
> > +{num_dec}    { return value(yyscanner, 10); }
> >  config               { return PP_CONFIG; }
> >  -            { return '-'; }
> >  :            { return ':'; }
> > @@ -35,7 +42,7 @@ config              { return PP_CONFIG; }
> >
> >  %%
> >
> > -int perf_pmu_wrap(void)
> > +int perf_pmu_wrap(void *scanner __maybe_unused)
> >  {
> >       return 1;
> >  }
> > diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> > index e675d79a0274..dff4e892ac4d 100644
> > --- a/tools/perf/util/pmu.y
> > +++ b/tools/perf/util/pmu.y
> > @@ -1,6 +1,8 @@
> > -
> > +%define api.pure full
> >  %parse-param {struct list_head *format}
> >  %parse-param {char *name}
> > +%parse-param {void *scanner}
> > +%lex-param {void* scanner}
> >
> >  %{
> >
> > @@ -78,6 +80,7 @@ PP_VALUE
> >
> >  void perf_pmu_error(struct list_head *list __maybe_unused,
> >                   char *name __maybe_unused,
> > +                 void *scanner __maybe_unused,
> >                   char const *msg __maybe_unused)
> >  {
> >  }
> > --
> > 2.40.0.348.gf938b09366-goog
> >
