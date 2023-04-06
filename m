Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B31C77B6C
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Apr 2023 21:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjDFVdZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjDFVdY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 17:33:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E954900C
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Apr 2023 14:33:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e390e23f83so528051cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2023 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680816798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IObMk8A+yB7kzQzd06qcvUQD4B00Pzu5PtnbgiCc0Qc=;
        b=rfBYLWluQ0/Pd7dFpjwZXmRk6uGk/xeFl3oqLaePqw0xeERch2oiY4AxHT9EJaZ+Jc
         O2rdydCfeZvAvtDwiWqxVd3/d/p0jeE4MPlQfO1ys6QZYNdkjk0BoGwyaiXbuLfrzOpw
         hVz0mhcXBPMnkBJyP/9ttJOIr7Mq0Xa3/ladg15pyMqEcH14NjzwzXsgPW7giOlNLX3H
         n+lVKYjoIidbNWXSHuRgz/yB8zRV60SnGZaT2P2Jc7NJ/lvAbVwxwTihErJQddtq4Mwu
         in+uqz8l9G9gPh72cka0drTL5o7FJC9HEME2XPBvqESwcdMnMdvOTqYzlaUpeUfZUzUV
         ecDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IObMk8A+yB7kzQzd06qcvUQD4B00Pzu5PtnbgiCc0Qc=;
        b=wsb+UGe/4XCHFk4A7JlAKa3wVw42FbjzYIunzr+euhtzD6lfg0fWNc7Iu0uutvDDXB
         E8P+7PZCt7ufB6zN+z9CqLuksjGGnp36QTj0w3lGknT1SExcReVZul4DnoCbK4HoUcbw
         x2wKkj34D+Om7l91YZjHj9rOfTdULfS2zXWPo/arQk80d6yCwGUF7IJHdmGFedl8CE4z
         7HvLIIv4HLI4GMd18MWMgyIBCeQlIMnf45LbVAefmZvVSt2s6rbW2iCPfUSTgu2T7k7W
         b0R1rZ6zw10Wwc0GTKbXJy1KqgthOLEOgO+m1HS0G5P5Ot/uRIXAmRZDwyRDcrOWhQo6
         Y8qQ==
X-Gm-Message-State: AAQBX9dgSyDK0tidWNAySgraEPSuEIY9+FB7+a3aXNu+DR2OXKg9x1fV
        E+7ahoQ0IBUAy3+vgYv2AOHDDIKQf1aoOq54uWKYpg==
X-Google-Smtp-Source: AKy350bIgdrkwnd6flj3ApzpuX9+RTf+JBOiuXuCCaLVjYUzp6sOfzzSf5eGUkHLXfL+yiLEoDUFxhrrGiyBNDn8G9E=
X-Received: by 2002:ac8:5bd2:0:b0:3bd:17d6:e04c with SMTP id
 b18-20020ac85bd2000000b003bd17d6e04cmr138867qtb.2.1680816798405; Thu, 06 Apr
 2023 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230406065224.2553640-1-irogers@google.com> <20230406065224.2553640-2-irogers@google.com>
 <ZC81CTH/VayirB5z@kernel.org>
In-Reply-To: <ZC81CTH/VayirB5z@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Apr 2023 14:33:07 -0700
Message-ID: <CAP-5=fXeuhYBDvRmu6vQLQFfW=0qBTH9EGmMrFb1sfGsJhGLFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Apr 05, 2023 at 11:52:24PM -0700, Ian Rogers escreveu:
> > Ensure fd is closed on error paths.
>
> Was this reported by Jiri?

Jiri's one was in the code I modified, whereas these were from
Namhyung's previous openat change. It is the same issue, I'm agnostic
on whether it needs a tag or not.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 96ef317bac41..9eedbfc9e863 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct lis=
t_head *head)
> >                       continue;
> >
> >               fd =3D openat(dirfd, name, O_RDONLY);
> > +             if (fd =3D=3D -1) {
> > +                     pr_debug("Cannot open %s\n", name);
> > +                     continue;
> > +             }
> >               file =3D fdopen(fd, "r");
> >               if (!file) {
> > -                     pr_debug("Cannot open %s\n", name);
> > +                     close(fd);
> >                       continue;
> >               }
> >
> > @@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
> >                       continue;
> >
> >               fd =3D openat(caps_fd, name, O_RDONLY);
> > +             if (fd =3D=3D -1)
> > +                     continue;
> >               file =3D fdopen(fd, "r");
> > -             if (!file)
> > +             if (!file) {
> > +                     close(fd);
> >                       continue;
> > +             }
> >
> >               if (!fgets(value, sizeof(value), file) ||
> >                   (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
> --
>
> - Arnaldo
