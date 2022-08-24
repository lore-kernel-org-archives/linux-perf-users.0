Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3ACC00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiHXO75 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXO74 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 10:59:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB231D319
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 07:59:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d5so8902569wms.5
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=sbZIaGa4QVmZRTFbraQQZevk8nVhmZ/pbqV32QkN6gU=;
        b=VavZxXcbB/bPsgnzbW8Hx/R60HQE12AcTrw529x+3AMBgTAc5I8aPa58AejE95oWsr
         Ifi10JcJCLSiEr//DMm/XKYjRquRROeQbmQTLEO/eo1BviBTOP/AVQh+C+MEXyAfomEx
         iV3iL8buZoDXJRLTWH+1yIY6MQmp+5MO63rtm56kr2PuBZbmuvcAL36CXuhfYdNrhi2e
         XJ/c/Goo9ooeY2ZbsPhRQWohLFvY+dTrB0udaij8gf7RGRmGSsyWqdkDaaTeuA+ZnQQh
         qHlQNd5WmJt6XPpqq4wJPsHewlVPuyWZfMxKCX2S125yAFfOf16UVv5ihmALI88jjgPa
         TLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=sbZIaGa4QVmZRTFbraQQZevk8nVhmZ/pbqV32QkN6gU=;
        b=TStt+iZiWNTBJk1LLk/MLFjCYJMh3hvWAmbE0fPwZYS+WH+zBx1gIB85iyEMIjzQMJ
         n8g/OOGGdqFRWp8kANefVysVDx3J0BJJ/1Lh6usMn1Y0NQmB/GWIYJEHw4v+U/EHQIOe
         Y0tdyhpsYhALH9VfZgNxm7TLYLUzrV5IpcdU/ow9Xshi1LEo+AB/Y+uzgyk7bWqIzlVE
         PsFAs0Z2FmkX8kMv/8RKEGmWlLAfi9C73Bi+OU+pQ3hKfk4CruQo6lZ5YqTHhu/X8ECf
         zvBhxkyfiUrX17WhK8HLspMRgaPYE3lXJMImSloMYr/pLSpKRoRRuio7VoxcJ97m0D4y
         dJgQ==
X-Gm-Message-State: ACgBeo2WAoIesVIETaCWQmDnuzSq4WwZ6hNJFs/l04i/XRytGY1qoV/B
        OMcGeQkYQvC3b7Rss84hu5epoJ+aPw8ToVELI6awKp4lPBs=
X-Google-Smtp-Source: AA6agR6KMlxmPHZIXHOv/GJkDnT1ChvjMBSHpcTZwphYaN9oZrc+DZ8YxP6haY58K4OSAEutEUfQ5Ao6v8GibTnqLCQ=
X-Received: by 2002:a05:600c:1d89:b0:3a5:c1db:21c6 with SMTP id
 p9-20020a05600c1d8900b003a5c1db21c6mr5290057wms.174.1661353193783; Wed, 24
 Aug 2022 07:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220824043825.322827-1-irogers@google.com> <YwYpiuN3VlzVyCiw@kernel.org>
In-Reply-To: <YwYpiuN3VlzVyCiw@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 07:59:42 -0700
Message-ID: <CAP-5=fUp5Cf+yfid70OzOAPOm2CJh84RN_NvW9aRhUAX5RPMGg@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Fix memory leaks in __cmd_record
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 24, 2022 at 6:37 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 23, 2022 at 09:38:25PM -0700, Ian Rogers escreveu:
> > An array of strings is passed to cmd_record but not freed. As
> > cmd_record modifies the array, add another array as a copy that can be
> > mutated allowing the original array contents to all be freed.
> >
> > Detected with -fsanitize=3Daddress.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-sched.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 2f6cd1b8b662..59ba14d2321c 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -3355,7 +3355,8 @@ static bool schedstat_events_exposed(void)
> >  static int __cmd_record(int argc, const char **argv)
> >  {
> >       unsigned int rec_argc, i, j;
> > -     const char **rec_argv;
> > +     char **rec_argv;
> > +     const char **rec_argv_copy;
> >       const char * const record_args[] =3D {
> >               "record",
> >               "-a",
> > @@ -3384,6 +3385,7 @@ static int __cmd_record(int argc, const char **ar=
gv)
> >               ARRAY_SIZE(schedstat_args) : 0;
> >
> >       struct tep_event *waking_event;
> > +     int ret;
> >
> >       /*
> >        * +2 for either "-e", "sched:sched_wakeup" or
> > @@ -3391,14 +3393,15 @@ static int __cmd_record(int argc, const char **=
argv)
> >        */
> >       rec_argc =3D ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc =
- 1;
> >       rec_argv =3D calloc(rec_argc + 1, sizeof(char *));
> > +     rec_argv_copy =3D calloc(rec_argc + 1, sizeof(char *));
> >
> > -     if (rec_argv =3D=3D NULL)
> > +     if (rec_argv =3D=3D NULL || rec_argv_copy =3D=3D NULL)
> >               return -ENOMEM;
>
> Here you=C2=B4re leaking rec_argv if rec_argv_copy fails to be allocated,=
 no?

Done in v2.

Thanks,
Ian

> - Arnaldo
>
> >
> >       for (i =3D 0; i < ARRAY_SIZE(record_args); i++)
> >               rec_argv[i] =3D strdup(record_args[i]);
> >
> > -     rec_argv[i++] =3D "-e";
> > +     rec_argv[i++] =3D strdup("-e");
> >       waking_event =3D trace_event__tp_format("sched", "sched_waking");
> >       if (!IS_ERR(waking_event))
> >               rec_argv[i++] =3D strdup("sched:sched_waking");
> > @@ -3409,11 +3412,19 @@ static int __cmd_record(int argc, const char **=
argv)
> >               rec_argv[i++] =3D strdup(schedstat_args[j]);
> >
> >       for (j =3D 1; j < (unsigned int)argc; j++, i++)
> > -             rec_argv[i] =3D argv[j];
> > +             rec_argv[i] =3D strdup(argv[j]);
> >
> >       BUG_ON(i !=3D rec_argc);
> >
> > -     return cmd_record(i, rec_argv);
> > +     memcpy(rec_argv_copy, rec_argv, sizeof(char*) * rec_argc);
> > +     ret =3D cmd_record(rec_argc, rec_argv_copy);
> > +
> > +     for (i =3D 0; i < rec_argc; i++)
> > +             free(rec_argv[i]);
> > +     free(rec_argv);
> > +     free(rec_argv_copy);
> > +
> > +     return ret;
> >  }
> >
> >  int cmd_sched(int argc, const char **argv)
> > --
> > 2.37.2.609.g9ff673ca1a-goog
>
> --
>
> - Arnaldo
