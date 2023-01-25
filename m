Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84324C54E94
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Jan 2023 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjAYVAF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAYVAF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 16:00:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B374222E7
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 13:00:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d14so14637746wrr.9
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyEAQDH7E/qL1ZNisInxETPwt2MInuGBwA3D/H45OPs=;
        b=rANiYl6msoZZ9RXrwEoPX4db/SpSbab/elvw3avjyMrFDRkRHR0XyL4Ljpq9WURa3d
         FeQ4A6Tl+rmuluexZBNtkyqjsqfqUvDzcZCZR/jXu/l9+Sg/QlLEyDDQv0fj1Sp4ctc7
         nsXGfzTAkJ847IikGBIdnqPALWrsUWVuFj4Zlyq1NbXSBCKIAg9fTMN0/S2Jp4/IpLt1
         PmRT/hQ3X58c2HmHc47WrO8oUVZXReFPKtKlF6DU1XV4NMze0vXrV2AFNsE/NlMUScUa
         1I5jFcMy5aqWJy1E/ve0nLVhM2MqWLkOUngT7OkA/718xd6+vZKK94yRS/dh7I6v8C6w
         qHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyEAQDH7E/qL1ZNisInxETPwt2MInuGBwA3D/H45OPs=;
        b=7JRbJSC1+JBVscEaq2n15UTOgWhLgWP5RxqeLbrvCvxDWxJOw3SHfySjocb+GKYhoE
         1z4orbS2vjNF6tEMS1gagZOCTf6CRii/IaaWxD17S5fGcdf214OO0RZRdZYTmz2pSnec
         ipEpTo2KLMW690igOf9vhRHFmSxe+nr5DQpPrK9Hab1DoKWhrNRfXPYqRIFy2taVHZ4X
         T1yvkti8vi4CrGNkDQ2smXYvseZIHeePhUvWCDwFS7noLAKLoh70u+yfR+ugEdPnuHSw
         JazE7tT6THMQyqY3EIZEF5ZkC6afRzUq4EEQ5FyLG//Kr173uaQtecyGNg277ukB1AO+
         NR8w==
X-Gm-Message-State: AFqh2kpPNcvM4TnpWWXTwv0YDJTHt5qbha0VeppS1Y7HluroeXe+TKpj
        pxsAaXsJ7IiuIV2d5Y8gB8ao5ONQypnOS7Uxu2RJ8w==
X-Google-Smtp-Source: AMrXdXs7dWV8A/t/ikdu5AMRyrGVHYZUrx779Ld0nKLH1tQqOTuv6MYAlwVaJTnBQyms+562QDGQQmL8v9nxrMPgPg8=
X-Received: by 2002:a05:6000:5c6:b0:242:5caa:5fbf with SMTP id
 bh6-20020a05600005c600b002425caa5fbfmr752607wrb.300.1674680401707; Wed, 25
 Jan 2023 13:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20230123211310.127532-1-raj.khem@gmail.com> <CAP-5=fWoQrn3i-Vpec0w8y4djq=PLhbR6TTeQ4XxKaR-bBDZAw@mail.gmail.com>
 <CAMKF1soqvBXcGUjpkN6wuxV8kZbFmqYBwB02Q5PB6qBAinjvOQ@mail.gmail.com>
In-Reply-To: <CAMKF1soqvBXcGUjpkN6wuxV8kZbFmqYBwB02Q5PB6qBAinjvOQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Jan 2023 12:59:49 -0800
Message-ID: <CAP-5=fVp=X8pxC_cc3o_AoCvjxVOOTsztNcexY4NHh6uxPOJ4g@mail.gmail.com>
Subject: Re: [PATCH] perf cpumap: Make counter as unsigned ints
To:     Khem Raj <raj.khem@gmail.com>
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

On Wed, Jan 25, 2023 at 11:04 AM Khem Raj <raj.khem@gmail.com> wrote:
>
> On Tue, Jan 24, 2023 at 9:02 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jan 23, 2023 at 1:13 PM Khem Raj <raj.khem@gmail.com> wrote:
> > >
> > > These are loop counters which is inherently unsigned. Therefore make
> > > them unsigned. Moreover it also fixes alloc-size-larger-than
> > > error with gcc-13, where malloc can be called with (-1) due to tmp_len
> > > being an int type.
> > >
> > > Fixes
> > > | cpumap.c:366:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
> > > |   366 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> > > |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/lib/perf/cpumap.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > > index 6cd0be7c1bb4..d960880dd903 100644
> > > --- a/tools/lib/perf/cpumap.c
> > > +++ b/tools/lib/perf/cpumap.c
> > > @@ -351,8 +351,8 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> > >                                          struct perf_cpu_map *other)
> > >  {
> > >         struct perf_cpu *tmp_cpus;
> > > -       int tmp_len;
> > > -       int i, j, k;
> > > +       unsigned int tmp_len;
> > > +       unsigned int i, j, k;
> > >         struct perf_cpu_map *merged;
> > >
> > >         if (perf_cpu_map__is_subset(orig, other))
> > > @@ -369,7 +369,7 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> > >
> > >         /* Standard merge algorithm from wikipedia */
> > >         i = j = k = 0;
> > > -       while (i < orig->nr && j < other->nr) {
> > > +       while (i < (unsigned int)orig->nr && j < (unsigned int)other->nr) {
> >
> > Rather than cast 'nr' why not add the unsigned to the declaration?
> >
>
> if type of nr is changed from int to unsigned int, this will ensue a
> lot of changes including function signature changes, I am not
> sure if that is the best approach.

All non-libperf accesses to 'nr' should go through perf_cpu_map__nr:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf/core#n25
Fwiw, this is done as there is some hope of 1 day landing a better
reference count checker.

We should migrate all __nr users to being unsigned. The use of __nr is
somewhat confusing, the dummy "program me on any CPU" cpu map has an
nr of 1, while the nr for being on all CPUs will be the number of CPUs
in the system, possibly +1 for the dummy case. I'm reminded that
cpumap needs its API clearing up, perf_cpu_map__empty being especially
confusing.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> > >                 if (orig->map[i].cpu <= other->map[j].cpu) {
> > >                         if (orig->map[i].cpu == other->map[j].cpu)
> > >                                 j++;
> > > @@ -378,10 +378,10 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> > >                         tmp_cpus[k++] = other->map[j++];
> > >         }
> > >
> > > -       while (i < orig->nr)
> > > +       while (i < (unsigned int)orig->nr)
> > >                 tmp_cpus[k++] = orig->map[i++];
> > >
> > > -       while (j < other->nr)
> > > +       while (j < (unsigned int)other->nr)
> > >                 tmp_cpus[k++] = other->map[j++];
> > >         assert(k <= tmp_len);
> > >
> > > --
> > > 2.39.1
> > >
