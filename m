Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799AECAAA1
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ1Rzb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1Rza (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 13:55:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376C3FA1D
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 10:55:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a14so7595996wru.5
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Aoft2L46k6FAy2C9YXo0KNf7YbEySajjvFoUwPMbI=;
        b=G+O9KAKbALBFvQndowNq/s9CCQehs7ZVqQJ34gSuKO/LubzsGTVA1h/nGxjvrW3xV3
         ZnhAxllvNwUEWoPFbdpbawDhOFvcGP5cwnsibCdfpKrtAzjsJNl72jHqSEvXNz7dRWKF
         DAnXCqPKALRxx6Z+pG+mdbBNU5ufxO6lG2ulNEvwK9LP7KMrneJDwPHzOkGRStjWCptB
         SNwcfaIU01gzacu3sokwOVDZgAvYYXaatKktXvCapsG+Tz2HjS2vALNGpR7fkhDbxgal
         x7bs0e3rQ+eTwJKVAm1nVmOBM07fnRESxgFlk6icfv1dh+wMQbgG9ArCryzqYmNUtANV
         hhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Aoft2L46k6FAy2C9YXo0KNf7YbEySajjvFoUwPMbI=;
        b=EkOkkdyEy+AkWaZIgM2e4HIFWSYJmijl6bkQwOsSY13UxRC47LAkPBkLS8iKPMSVXg
         JLHMBC6d4DAGPQ7iJ6d3uD3caZT8YNzIv3PoGXmOyyLgK8EXOFQsJahiwjQCIyPdM5nh
         nAfrZGmhnViyRnZyUDyHiTz2rUmHLnwNaxslf9cBeWLk+kjJmF/YdbEn2Xps68cLnphs
         aSZUVyxc1Ir4Ks4lzZxw083joLS4G6o9Dtydsmb2J2nFpLWp6loJOJPfqPYLBwM4aRKM
         LSAqHN+2dW5mmfEU/0aydMpSLXNO6jswiqc2Rh6QM40+uSZnMu8Vpv+/skGjereUWwwX
         NDXQ==
X-Gm-Message-State: ACrzQf2XSTqdojlVfO+XuD94cBHSSfIG2ybQRnO87rz3e15AYhx7jArm
        4PSxp71lDT3PMbXdDU0if+xBlklpQu79arW0Q1uBANXTEkw=
X-Google-Smtp-Source: AMsMyM7xoZu5nREJVk0gA/6ljbgVyThdSCTzuScgdFU9IeMDm+4yxDXyqoyYpxLLBDHdNprFCCbsBJWDKDMqHk7V5lM=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr344718wrb.300.1666979726410; Fri, 28 Oct
 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221013011205.3151391-1-irogers@google.com> <715c8e4a-f3c3-6521-778e-8ba8c2bf659e@huawei.com>
 <CAP-5=fVBSDPPFnBnLF775noQPyHnjbpu+hC=LiEJo5566oONrA@mail.gmail.com>
In-Reply-To: <CAP-5=fVBSDPPFnBnLF775noQPyHnjbpu+hC=LiEJo5566oONrA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Oct 2022 10:55:14 -0700
Message-ID: <CAP-5=fVmd-f=HAQPJ-UfG5EdnXMk5j6a-PdF5592LDrd8K8neA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Parse events workaround for dash/minus
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 17, 2022 at 4:07 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 5:11 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 13/10/2022 02:12, Ian Rogers wrote:
> > > Skip an event configuration for event names with a dash/minus in them.
> > > Events with a dash/minus in their name cause parsing issues as legacy
> > > encoding of events would use a dash/minus as a separator. The parser
> > > separates events with dashes into prefixes and suffixes and then
> > > recombines them. Unfortunately if an event has part of its name that
> > > matches a legacy token then the recombining fails. This is seen for
> > > branch-brs where branch is a legacy token. branch-brs was introduced
> > > to sysfs in:
> > > https://lore.kernel.org/all/20220322221517.2510440-5-eranian@google.com/
> > > The failure is shown below as well as the workaround to use a config
> > > where the dash/minus isn't treated specially:
> > >
> > > ```
> > > $ perf stat -e branch-brs true
> > > event syntax error: 'branch-brs'
> > >                             \___ parser error
> > >
> > > $ perf stat -e cpu/branch-brs/ true
> > >
> > >   Performance counter stats for 'true':
> > >
> > >              46,179      cpu/branch-brs/
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/tests/parse-events.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >
> > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > > index 459afdb256a1..3440dd2616b0 100644
> > > --- a/tools/perf/tests/parse-events.c
> > > +++ b/tools/perf/tests/parse-events.c
> > > @@ -2237,6 +2237,19 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
> > >                       pr_debug("Test PMU event failed for '%s'", name);
> > >                       ret = combine_test_results(ret, test_ret);
> > >
> >
> > Hi Ian,
> >
> > }
> > > +             /*
> > > +              * Names containing '-' are recognized as prefixes and suffixes
> > > +              * due to '-' being a legacy PMU separator. This fails when the
> > > +              * prefix or suffix collides with an existing legacy token. For
> > > +              * example, branch-brs has a prefix (branch) that collides with
> > > +              * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
> > > +              * isn't expected after this.
> >
> > OK, so you want to skip anything with '-'. Will we now miss out on
> > events which contain a '-' but don't clash with an existing legacy token?
>
> Yes. The long term solution here is to ditch the current parse event
> code and its legacy support. An idea is to create a simplified parser
> as part of libperf2 (libperf but with a libbpf style license), use the
> new parser for metrics and events. In the events case, if the new
> parser fails then use the legacy parser and its weird handling of
> dashes.
>
> > >  As event names in the config
> > > +              * slashes are allowed a '-' in the name we check this works
> > > +              * above.
> >
> > Sorry, I can't follow what you mean here. Do you mean that
> > "cpu/branch-brs/" works ok and we continue to test it?
>
> Yep, as shown in the commit message. The comment isn't great, it
> should be worded something like:
>
> If an event name is in the config slashes, such as cpu/branch-brs/,  a
> '-' in the name works as the dash doesn't separate the parts of the
> name. This continues to be tested above.

Ping. It'd be nice to merge this as otherwise we have a perf test
failure on AMD.

Thanks,
Ian

> > > +              * above.
>
> Thanks,
> Ian
>
> > > +              */
> > > +             if (strchr(ent->d_name, '-'))
> > > +                     continue;
> >
> > Thanks,
> > John
> >
> > > +
> > >               snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
> > >               e.name  = name;
> > >               e.check = test__checkevent_pmu_events_mix;
> >
