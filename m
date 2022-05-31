Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E1C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 May 2022 23:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiEaXSo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 May 2022 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbiEaXSn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 May 2022 19:18:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3098D6A0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 May 2022 16:18:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k19so21542wrd.8
        for <linux-perf-users@vger.kernel.org>; Tue, 31 May 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRyMk+Q6nFripHUkwYzBEVo5OLNNL8RHhRGhadNuFAU=;
        b=ZGBDa3EuRBaYGJ4gg1MjnYswFFIWvsWMvvcw+7tZ5KlNyVMsdA4tLBTaRWZRXVoB5t
         3WeyHiTygg2bxxV214rs0c9sd6ioAqIc5eVfhUMSOW5gFmE4V2RuYX5RHdQB4dTj6WqW
         zDJ0tzn/AP+W7gs2iyYGYmclYf/E+N26CF1FQm4Ztrl36IuhzwV8FLrN4T67Yc4v8prx
         xYeaKoKQaq7Ps8dz2cQ0lGKf12xnxror+nmhZ1h2vjtyV5SdPdDxPmV1r8rjT9xZOFWx
         RVaU+o5gQO229dvOp+ec3Uu0XdiXSb0aK0+Ts+C8RsWwfxvBH1LpZ9J9l6w+ACWP+rpf
         HNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRyMk+Q6nFripHUkwYzBEVo5OLNNL8RHhRGhadNuFAU=;
        b=wgTuoYvgEcm1VduLFj4ruR3u3X2HwQRwbDyoky3GjxzgfxaWkACFPGf4FBYEBKaOsn
         IdmI6oDRMTiQcSyCpDMAcL+SkSW7n7q2P5f1AVRjOeDXdqeiXTyfvvD53DNuZLUuN4R2
         m4iuoDLw3rfK1NroGMEdMVSErtGYY4skDF1s76OyAMpN8FLlGfWkeBL0TQ/vEe51BcXN
         sJ67laUs8qX3Ju1BynxZILKLzC96oAJHTbht5e68WQ7IrTq+mjxdWysYkzN+msPCmAvg
         Hbg7sX5IMwGYdgSaUrBDFhgAJHAhCsfpvKtPvv0Ya9uXa/L1kVtWOQT9TkMID9v7q6MP
         +ALw==
X-Gm-Message-State: AOAM532aw+g4Kae99BIZSHgDBSxATNhCZGrfNebvUPfULDuA/ED9nbRS
        unxey9zz+lUcWQaZEIfq5/orn0nyRArtMxBMeKVAWw==
X-Google-Smtp-Source: ABdhPJx7J+5sVQEHLn65AdSYxEgsPuV+2WTc6LjsDQQLhS5QnnY/r+H2A4YaE2NX1JvdlPqLOjXF7fnw9q1YvmU19XY=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr52723432wri.343.1654039118562; Tue, 31
 May 2022 16:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com> <20220525053814.3265216-3-irogers@google.com>
 <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com> <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
In-Reply-To: <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 16:18:26 -0700
Message-ID: <CAP-5=fXu5rSV6C=WCs3bkCuaXknoKZv6o0O5gGAJKeLcAFuVcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf stat: Add JSON output option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 31, 2022 at 4:13 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, May 31, 2022 at 3:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 24, 2022 at 10:38 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > From: Claire Jensen <cjense@google.com>
> > >
> > > CSV output is tricky to format and column layout changes are susceptible
> > > to breaking parsers. New JSON-formatted output has variable names to
> > > identify fields that are consistent and informative, making
> > > the output parseable.
> > >
> > > CSV output example:
> > >
> > > 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> > > 0,,context-switches:u,1204272,100.00,0.000,/sec
> > > 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> > > 70,,page-faults:u,1204272,100.00,58.126,K/sec
> > >
> > > JSON output example:
> > >
> > > {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> > > "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> > > {"counter-value" : "6166.000000", "unit" : "", "event" :
> > > "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> > > {"counter-value" : "466.000000", "unit" : "", "event" :
> > > "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> > > {"counter-value" : "208.000000", "unit" : "", "event" :
> > > "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
> > >
> > > Also added documentation for JSON option.
> > > There is some tidy up of CSV code including a potential memory over run
> > > in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
> > >
> > > Signed-off-by: Claire Jensen <cjense@google.com>
> >
> > Your sign-off as well?
>
> Doh:
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian

Actually, this was fixed in V5:
https://lore.kernel.org/lkml/20220526224515.4088240-1-irogers@google.com/

Thanks,
Ian

> > Anyway, I think there are places to clean up this part of code
> > more but that's not a part of the work.  Maybe I need to find
> > some time to do that later.
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
