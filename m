Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8BC001DF
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jul 2023 00:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjG0Agk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjG0Agj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2023 20:36:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CE268B
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jul 2023 17:36:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40550136e54so138651cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jul 2023 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690418196; x=1691022996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amy0eD2LrrlzU6N3hjR3QwTAzIiyiWPIAr1XXg/QRho=;
        b=r1sqXfSYhbXgayFfHf5wcXBny1G7caytTfpjPv/QN+nT+HOpio6WedtmcvOIwJ46C2
         p21II5pjVkJikuu3ko4x6RUyjGrAKMEbVsfGlxCwoeL6jLK8XuO34a9HX3CbJWQ3MgcG
         7HEAt5575SROrijzh8Q+StWIPInzZ2O/dIviH78BTSRuJdFTmBn6zezl+xxcTFZupJ+2
         avtWNnX4w+TmIU0t+TuD1WOz6Dz8+yXH9vC+Nyc4TU8C1oldfi99YEvV91GGvzURccTL
         OIESWAbo6tjoCfNJHYy2asW3bjLzOgc1fqE9fWZxyoUQWDoD85K3o9k2vzDXxNDVwCFx
         jagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690418196; x=1691022996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amy0eD2LrrlzU6N3hjR3QwTAzIiyiWPIAr1XXg/QRho=;
        b=YbhEqgBOVV+pe2w4J1KcThoGOhPiTPyCdXK7spiwah7eVZcYt658fvQMt8bg77lLzM
         oJW6H7kqsR6nr/0j4z4vBM1ASmfXtROUJ+/l4EmaA6wTKq0UHmXUSiVSSj5gOHXd+of4
         c8iHc4tGQv15vpACahj9c2prUQIW2GGBQ7sXHpKMP3D5xjdgd1i1yMZ2eAKYEZDm4Ug8
         C6Sdw1RrbJzlW7I2LEmWSFYAnnopvarN2SIMIl03xWPXPfJN5uuSLAc0r7yrPnHHgFiY
         hdwtPK3/VFQNDnLkruxvAsLRNX0M79L272rO2ykmCs5hVu/anCrP+xRWguDKzVjpFLCi
         6X1g==
X-Gm-Message-State: ABy/qLZwyLIkZPV1Vqp9hjq0Z42si1otuoACVrM54QLicIC2niC29cv+
        Oc8typ/Xh0wqS8N7TbWeQKpx7C6iV0ZzwrHwOHsdHg==
X-Google-Smtp-Source: APBJJlG/XjuTAh5W6aOfGDPHr2RC3h3gUwu78ey/G5POFF3pAUocagsjlzvSx05Y7ZrlOiwIHV3Vmy9p45i0q3kWr7I=
X-Received: by 2002:a05:622a:14:b0:403:ac17:c18a with SMTP id
 x20-20020a05622a001400b00403ac17c18amr107946qtw.14.1690418195645; Wed, 26 Jul
 2023 17:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org> <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
 <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
In-Reply-To: <CAM9d7citVc4ad65MLBWxvE-_AbwxO1DQWHf5w+ofSgWnWSx=Fw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 17:36:24 -0700
Message-ID: <CAP-5=fVbwf9=ZFszgFpb_6Qb003WpZC3_vtO7fB1pL_vH-OhQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 26, 2023 at 3:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Jul 26, 2023 at 8:48=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Jul 26, 2023 at 6:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The bison and flex generate C files from the source (.y and .l)
> > > files.  When O=3D option is used, they are saved in a separate direct=
ory
> > > but the default build rule assumes the .C files are in the source
> > > directory.  So it might read invalid file if there are generated file=
s
> > > from an old version.  The same is true for the pmu-events files.
> > >
> > > For example, the following command would cause a build failure:
> > >
> > >   $ git checkout v6.3
> > >   $ make -C tools/perf  # build in the same directory
> > >
> > >   $ git checkout v6.5-rc2
> > >   $ mkdir build  # create a build directory
> > >   $ make -C tools/perf O=3Dbuild  # build in a different directory bu=
t it
> > >                                 # refers files in the source director=
y
> > >
> > > Let's update the build rule to specify those cases explicitly to depe=
nd
> > > on the files in the output directory.
> > >
> > > Note that it's not a complete fix and it needs the next patch for the
> > > include path too.
> > >
> > > Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/build/Makefile.build  | 8 ++++++++
> > >  tools/perf/pmu-events/Build | 4 ++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > > index 89430338a3d9..f9396696fcbf 100644
> > > --- a/tools/build/Makefile.build
> > > +++ b/tools/build/Makefile.build
> > > @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
> > >         $(call rule_mkdir)
> > >         $(call if_changed_dep,cc_s_c)
> > >
> > > +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> > > +       $(call rule_mkdir)
> > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > +
> > > +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> > > +       $(call rule_mkdir)
> > > +       $(call if_changed_dep,$(host)cc_o_c)
> > > +
> >
> > Hi Namhyung,
> >
> > as we have:
> > ```
> > $(OUTPUT)%.o: %.c FORCE
> >        $(call rule_mkdir)
> >        $(call if_changed_dep,$(host)cc_o_c)
> > ```
> > I'm not sure what the 2 additional rules achieve.
>
> The above rule assumes the .c files are in the source directory
> (without $(OUTPUT) prefix).  It caused a trouble when the
> flex and bison files are generated in the output directory and
> you have an old version of them in the source directory.
>
>
> >
> > >  # Gather build data:
> > >  #   obj-y        - list of build objects
> > >  #   subdir-y     - list of directories to nest
> > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Buil=
d
> > > index 150765f2baee..f38a27765604 100644
> > > --- a/tools/perf/pmu-events/Build
> > > +++ b/tools/perf/pmu-events/Build
> > > @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY)=
 $(METRIC_PY) $(METRIC_TEST_L
> > >         $(call rule_mkdir)
> > >         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARC=
H) $(JEVENTS_MODEL) pmu-events/arch $@
> > >  endif
> > > +
> > > +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> > > +       $(call rule_mkdir)
> > > +       $(call if_changed_dep,$(host)cc_o_c)
> >
> > If we add this, do the Makefile.build changes still need to happen?
>
> The Makefile.build changes are specific to flex and bison files.
> So yes, we need this for pmu-events.c to work properly with O=3D
> option.

Got it, you are right I was confusing the flex/bison with the jevents
case. Can we get away with a single rule then:
```
 $(OUTPUT)%.o:  $(OUTPUT)%.c FORCE
        $(call rule_mkdir)
        $(call if_changed_dep,$(host)cc_o_c)
```

Thanks,
Ian

> Thanks,
> Namhyung
