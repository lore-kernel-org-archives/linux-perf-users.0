Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB42C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Feb 2023 05:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHF7G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 00:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBHF7F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Feb 2023 00:59:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56492EB49
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Feb 2023 21:59:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id z13so5074564wmp.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Feb 2023 21:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8oN9MLzU3wEGmWRqNJyRnSlrR9sdEtbSX9/vop1S28=;
        b=BRTRBC/Bg+WXOmrXhXu6+bY4BmKsC+FwM6up81I4n8n8t8+OIoKlsgrFfsvdoYcanC
         U3U5Ktu9HM7eHllGOHnR05dFkY2SIO4VVX7VHCwJFk1Mn74NEdDnhXkslZJaX0zP2pOQ
         ad8Y8uON0Nhfa0Q7bpEh9mI2UQq1AIdTq0dU2BS1gagrKO9F/dtT/tVW2PBtSjS84/sZ
         YN+beCvSry1dcC2oQ9plqII8AdZRKWuVS+Tik+c67E8wbnEds1dc5EZ1VtZ5os7EkrPg
         1LqUi11DXGTnAE78RgSSWPaYwq8FrZujROK16vSDOEq4g5Udzs+VXWmVgi4/M/76QZ0/
         OtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8oN9MLzU3wEGmWRqNJyRnSlrR9sdEtbSX9/vop1S28=;
        b=z3Sqb5Cu+NqyvMQ1koCETJoXc8AQA49G8XUCeNi8Zyddl/G1AH4WdIK5X2jr16gYMt
         BRoz7C6AgCrYNDEOc4NQN9xp0SSwkoTO1OqT9aC5PeaW1yAPovgwefUSCRT72WeTU33H
         z9xkhQ9/cevXrRKH++viyYwJxCxLT051pUhRG0/TTJvHkZ0IseOBzHsVW3MyfvH4g4eV
         8uMbMUvPvynX6LIQ6oRxz8Uy+4a+b0VD6xgYMfOFHN8Mw21M2oL5fZzQGqGGQ97xF1FQ
         EYvZXiMRyvx89YJBvstfkPzmWyyrF4bsi1WmYbHnHh9GjsI9QDDWHTEH+cSCtogA9qRs
         YWkQ==
X-Gm-Message-State: AO0yUKWwle6Fu7bL80bUHY4dvNpYtOcGKoZFZIKl5Z22wkHGKvB9Aeuu
        n5or4hq+Bfr0f+wDBPIaoXFZP3xpDWRADV/lRIWuDg==
X-Google-Smtp-Source: AK7set+H+Sx5l3kuIAhJ4wLueh4sGvHEb87JuXXJ6O3Q6ph+Mjp4NKuWNS1P/vBuV3QlXX3aMBnWWk+nHDfpBkJC/xs=
X-Received: by 2002:a05:600c:1d1e:b0:3dc:4a00:cd6e with SMTP id
 l30-20020a05600c1d1e00b003dc4a00cd6emr123690wms.169.1675835942630; Tue, 07
 Feb 2023 21:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20230207140447.1827741-1-tmricht@linux.ibm.com> <Y+JoGRdML/Ckkwvb@kernel.org>
In-Reply-To: <Y+JoGRdML/Ckkwvb@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Feb 2023 21:58:48 -0800
Message-ID: <CAP-5=fU6vHFp1YeY9RyAUE_rS5PMECcUWdnMhR-QsMnAN0wy7g@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix perf tool build error in util/pfm.c
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 7, 2023 at 7:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Tue, Feb 07, 2023 at 03:04:47PM +0100, Thomas Richter escreveu:
> > I have downloaded linux-next and build the perf tool using
> >
> >  # make LIBPFM4=3D1
> >
> > to have libpfm4 support built into perf. The build fails:
> >
> >  # make LIBPFM4=3D1
>
> Ian,
>
>         Can you please take a look? Should we go this way or have some
> feature test to check how that function signature should look?
>
> - Arnaldo

Tested-by: Ian Rogers <irogers@google.com>

Wrt tests, there is make_with_libpfm4 in tools/perf/tests/make.

Thanks,
Ian

> > ....
> > INSTALL libbpf_headers
> >   CC      util/pfm.o
> > util/pfm.c: In function =E2=80=98print_libpfm_event=E2=80=99:
> > util/pfm.c:189:9: error: too many arguments to function =E2=80=98print_=
cb->print_event=E2=80=99
> >   189 |         print_cb->print_event(print_state,
> >       |         ^~~~~~~~
> > util/pfm.c:220:25: error: too many arguments to function =E2=80=98print=
_cb->print_event=E2=80=99
> >   220 |                         print_cb->print_event(print_state,
> >
> > The build error is caused by
> > commit d9dc8874d6ce ("perf pmu-events: Remove now unused event and metr=
ic variables")
> > which changes the function prototype of
> >   struct print_callbacks {
> >       ...
> >       void (*print_event)(...);  --> last two parameters removed.
> >   };
> >
> > but does not adjust the usage of this function prototype in util/pfm.c.
> > In file util/pfm.c function print_event() is still invoked with 13 para=
meters
> > instead of 11. The compile fails.
> >
> > When I adjust the file util/pfm.c as in this patch, the build works fil=
e.
> > Please check this patch for correctness, I have just fixed the compile
> > issue.
> >
> > Fixes d9dc8874d6ce ("perf pmu-events: Remove now unused event and metri=
c variables")
> > Cc: irogers@google.com
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >  tools/perf/util/pfm.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > index ac3227ba769c..b59ba825ddc9 100644
> > --- a/tools/perf/util/pfm.c
> > +++ b/tools/perf/util/pfm.c
> > @@ -193,8 +193,7 @@ print_libpfm_event(const struct print_callbacks *pr=
int_cb, void *print_state,
> >                       /*scale_unit=3D*/NULL,
> >                       /*deprecated=3D*/NULL, "PFM event",
> >                       info->desc, /*long_desc=3D*/NULL,
> > -                     /*encoding_desc=3D*/buf->buf,
> > -                     /*metric_name=3D*/NULL, /*metric_expr=3D*/NULL);
> > +                     /*encoding_desc=3D*/buf->buf);
> >
> >       pfm_for_each_event_attr(j, info) {
> >               pfm_event_attr_info_t ainfo;
> > @@ -224,8 +223,7 @@ print_libpfm_event(const struct print_callbacks *pr=
int_cb, void *print_state,
> >                                       /*scale_unit=3D*/NULL,
> >                                       /*deprecated=3D*/NULL, "PFM event=
",
> >                                       ainfo.desc, /*long_desc=3D*/NULL,
> > -                                     /*encoding_desc=3D*/buf->buf,
> > -                                     /*metric_name=3D*/NULL, /*metric_=
expr=3D*/NULL);
> > +                                     /*encoding_desc=3D*/buf->buf);
> >               }
> >       }
> >  }
> > --
> > 2.39.1
> >
>
> --
>
> - Arnaldo
