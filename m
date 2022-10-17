Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A9C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Oct 2022 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJQXJo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiJQXIp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Oct 2022 19:08:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4226857C5
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 16:08:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j16so20851442wrh.5
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VkmZ6BS9mgBWXse91fXAkBFVaB7qaQEapO6tRFc+vo=;
        b=aAdhRpoycwbSSESuWmb/ew3H5j+mWH9EEBjEybaWTql9Z1nMG2zZtb6EosotlPPnwy
         PlystUKgv0G7vgTuHvqlWQsLXJdJZmBU8Fs1yN30fj8H0+KLcREq3l6Sxjez6C596M0R
         /0/2YxMPbQ5/eTVBff+Jd4enMixPufgU+cIthoYgd32JmXjwIFBlAcP380v1DzNiBhzi
         dxuqGRODgdEIuDPU2RWaXQCs/EmsoYuYyqb1cRdqzyevFNQwFwnV8S0Xm1iG1ddspNNy
         pXyyWXXA1EQZnZlCePMsDvFzgzq2PWSHfsiWZlISRmdZ0WQ0nlDWH5MlzcwoLwlqjGgI
         TT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VkmZ6BS9mgBWXse91fXAkBFVaB7qaQEapO6tRFc+vo=;
        b=WzDAP1QpTpXImWMPOv9wRCgZZZAlcLWr5w8780wS+NO6C6xBn52qMHCSHya92DnDMy
         RpKUYhf2t/MekbSErHgcWNI5Pt5oqEx+hwiPbbKGE9HiAGWqTWV7l/VUBhOWC3/qe6dC
         /M87sUW/LjGyVBfu27mpuLCWctWwKstOIF02mswIRnl3yDs2cVJHCP1WcYYnMFZ6iIkV
         2qYyGuJFKaGD0Y6X2uFHglDLvWwQIvpc8q96ECxbpHoXPJ1HsCeS+APp8+WhfuWcSv2u
         p9NsFXIC/RMy1pG53lixTs8n1KcsXRo7tLg1NCDDwcoDFdaHwTZ/YgSQsF04Ml2ryS+2
         kvdQ==
X-Gm-Message-State: ACrzQf1hcA6aRV5S+s/t5Yd7Jg8vZgXhBIqxa1/DfP0FGJ3A5AwETIt1
        VB8yRw8UcakWYCv3VkgbPD1PEXaIC5huMg5wqI5s3Q==
X-Google-Smtp-Source: AMsMyM5fyS7eL+2YgT1m5kmvnDs0h8B52OwfASz43WQoYLR1DZNj4BuUIAVgWkh+saIbuLLvZmst1c2M0ic8Q+l9gE8=
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id
 9-20020a5d47a9000000b0022e3bebdc3amr62278wrb.654.1666048036569; Mon, 17 Oct
 2022 16:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221013011205.3151391-1-irogers@google.com> <715c8e4a-f3c3-6521-778e-8ba8c2bf659e@huawei.com>
In-Reply-To: <715c8e4a-f3c3-6521-778e-8ba8c2bf659e@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Oct 2022 16:07:04 -0700
Message-ID: <CAP-5=fVBSDPPFnBnLF775noQPyHnjbpu+hC=LiEJo5566oONrA@mail.gmail.com>
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

On Thu, Oct 13, 2022 at 5:11 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/10/2022 02:12, Ian Rogers wrote:
> > Skip an event configuration for event names with a dash/minus in them.
> > Events with a dash/minus in their name cause parsing issues as legacy
> > encoding of events would use a dash/minus as a separator. The parser
> > separates events with dashes into prefixes and suffixes and then
> > recombines them. Unfortunately if an event has part of its name that
> > matches a legacy token then the recombining fails. This is seen for
> > branch-brs where branch is a legacy token. branch-brs was introduced
> > to sysfs in:
> > https://lore.kernel.org/all/20220322221517.2510440-5-eranian@google.com/
> > The failure is shown below as well as the workaround to use a config
> > where the dash/minus isn't treated specially:
> >
> > ```
> > $ perf stat -e branch-brs true
> > event syntax error: 'branch-brs'
> >                             \___ parser error
> >
> > $ perf stat -e cpu/branch-brs/ true
> >
> >   Performance counter stats for 'true':
> >
> >              46,179      cpu/branch-brs/
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/parse-events.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index 459afdb256a1..3440dd2616b0 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -2237,6 +2237,19 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
> >                       pr_debug("Test PMU event failed for '%s'", name);
> >                       ret = combine_test_results(ret, test_ret);
> >
>
> Hi Ian,
>
> }
> > +             /*
> > +              * Names containing '-' are recognized as prefixes and suffixes
> > +              * due to '-' being a legacy PMU separator. This fails when the
> > +              * prefix or suffix collides with an existing legacy token. For
> > +              * example, branch-brs has a prefix (branch) that collides with
> > +              * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
> > +              * isn't expected after this.
>
> OK, so you want to skip anything with '-'. Will we now miss out on
> events which contain a '-' but don't clash with an existing legacy token?

Yes. The long term solution here is to ditch the current parse event
code and its legacy support. An idea is to create a simplified parser
as part of libperf2 (libperf but with a libbpf style license), use the
new parser for metrics and events. In the events case, if the new
parser fails then use the legacy parser and its weird handling of
dashes.

> >  As event names in the config
> > +              * slashes are allowed a '-' in the name we check this works
> > +              * above.
>
> Sorry, I can't follow what you mean here. Do you mean that
> "cpu/branch-brs/" works ok and we continue to test it?

Yep, as shown in the commit message. The comment isn't great, it
should be worded something like:

If an event name is in the config slashes, such as cpu/branch-brs/,  a
'-' in the name works as the dash doesn't separate the parts of the
name. This continues to be tested above.

> > +              * above.

Thanks,
Ian

> > +              */
> > +             if (strchr(ent->d_name, '-'))
> > +                     continue;
>
> Thanks,
> John
>
> > +
> >               snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
> >               e.name  = name;
> >               e.check = test__checkevent_pmu_events_mix;
>
