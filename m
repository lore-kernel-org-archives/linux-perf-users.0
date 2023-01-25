Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE89C54E94
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Jan 2023 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjAYTEm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 14:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYTEl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 14:04:41 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3622D70
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 11:04:40 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-142b72a728fso22511942fac.9
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 11:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAm8oFJIN+njE4D1eVlT36zKC60roHSvUUiYhJwShb0=;
        b=H6XLnE/uYvmsEf/bjVZ2AnKOAzdssOPFnLizxMGHUrk87CuGLsvppKiIOiUVeawD3z
         IAAb61rTFhplFMiUvFrgnB0jD3bgGExbkHoYZfa3K4qOmd74W0u3MT2EBIcZ46rmH4mA
         s4cIwZU/X+0uhsqaVMFIs5zuQPT7Spp13f9DpBj0Q48GJJrzkqk8eSzyaPbU4Ke2MWu+
         uaE4ImhZVp7NPy/Haq08Jd54pLpOmixOKB398yi0FiZXEr8IPFQB+qX50f8FI70OFkdV
         cXI+PM45yCzlHBAZpOKCffMztEm8cbE+iVhoZkX2F1yWbf4OqhR0oeqCrrdmEVuUi4ZY
         olzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAm8oFJIN+njE4D1eVlT36zKC60roHSvUUiYhJwShb0=;
        b=q1i8SnF4gmiRQqV/fST4ZNz1re1cy6Fs+DisRdfCZT/LfFCg8TRx7HpFSuCcBmGPfN
         hqrvNA/FVqWJa2qDdC4j9DNFBRdFGGezeoQCuEYkm34Fpxe/q9KX7Wk/gHpXZWJzwe+g
         Qd5+OY2WL7cfSv31KHNaY9hda00wjLT6DONXvBabJSeyBmBSAHqXjsQzqFqBbOll2VPt
         H9YWcoMOwp3hfN0qZjsJ+lkT26IFchxNgNlrWgtzt2vpPH1Xn/rIXh5hapGBu+YWflC5
         SwH+AhtqQihLPg+xuk/OleOK5x1+nHR+9iz4brEb8f5orKwmqP9DdCXsKG/IlW0L7Jzf
         fX8g==
X-Gm-Message-State: AO0yUKXQXjitm4F2PnWbNTqMFXhhO0+1xgMmAZgqcbyPK0Li4MZsOG3A
        KkAX9PaooNe2WCWwh+cej/4OMq6IfI8/O7Yveu+caMizzt8=
X-Google-Smtp-Source: AK7set8R4hpbp3+DqFVqW1vCtWsjljiFWnWmnUJKE+iEjppTSTI6ywQ6x9sUXU5t0iVs4LK5Dpp3acdemo48tF7u/cM=
X-Received: by 2002:a05:6870:5253:b0:163:35c5:e085 with SMTP id
 o19-20020a056870525300b0016335c5e085mr205115oai.55.1674673479876; Wed, 25 Jan
 2023 11:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20230123211310.127532-1-raj.khem@gmail.com> <CAP-5=fWoQrn3i-Vpec0w8y4djq=PLhbR6TTeQ4XxKaR-bBDZAw@mail.gmail.com>
In-Reply-To: <CAP-5=fWoQrn3i-Vpec0w8y4djq=PLhbR6TTeQ4XxKaR-bBDZAw@mail.gmail.com>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Wed, 25 Jan 2023 11:04:13 -0800
Message-ID: <CAMKF1soqvBXcGUjpkN6wuxV8kZbFmqYBwB02Q5PB6qBAinjvOQ@mail.gmail.com>
Subject: Re: [PATCH] perf cpumap: Make counter as unsigned ints
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 24, 2023 at 9:02 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jan 23, 2023 at 1:13 PM Khem Raj <raj.khem@gmail.com> wrote:
> >
> > These are loop counters which is inherently unsigned. Therefore make
> > them unsigned. Moreover it also fixes alloc-size-larger-than
> > error with gcc-13, where malloc can be called with (-1) due to tmp_len
> > being an int type.
> >
> > Fixes
> > | cpumap.c:366:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
> > |   366 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> > |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/cpumap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 6cd0be7c1bb4..d960880dd903 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -351,8 +351,8 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >                                          struct perf_cpu_map *other)
> >  {
> >         struct perf_cpu *tmp_cpus;
> > -       int tmp_len;
> > -       int i, j, k;
> > +       unsigned int tmp_len;
> > +       unsigned int i, j, k;
> >         struct perf_cpu_map *merged;
> >
> >         if (perf_cpu_map__is_subset(orig, other))
> > @@ -369,7 +369,7 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >
> >         /* Standard merge algorithm from wikipedia */
> >         i = j = k = 0;
> > -       while (i < orig->nr && j < other->nr) {
> > +       while (i < (unsigned int)orig->nr && j < (unsigned int)other->nr) {
>
> Rather than cast 'nr' why not add the unsigned to the declaration?
>

if type of nr is changed from int to unsigned int, this will ensue a
lot of changes including function signature changes, I am not
sure if that is the best approach.

> Thanks,
> Ian
>
> >                 if (orig->map[i].cpu <= other->map[j].cpu) {
> >                         if (orig->map[i].cpu == other->map[j].cpu)
> >                                 j++;
> > @@ -378,10 +378,10 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >                         tmp_cpus[k++] = other->map[j++];
> >         }
> >
> > -       while (i < orig->nr)
> > +       while (i < (unsigned int)orig->nr)
> >                 tmp_cpus[k++] = orig->map[i++];
> >
> > -       while (j < other->nr)
> > +       while (j < (unsigned int)other->nr)
> >                 tmp_cpus[k++] = other->map[j++];
> >         assert(k <= tmp_len);
> >
> > --
> > 2.39.1
> >
