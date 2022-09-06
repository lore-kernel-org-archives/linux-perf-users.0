Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12699ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiIFUur (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIFUup (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 16:50:45 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F901116B
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Sep 2022 13:50:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3450a7358baso81106787b3.13
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Sep 2022 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2h+TR+OM3EYWoBqpTcjOAGgQzsk2TDQnX5OQcnEmOAY=;
        b=Ho5zZG/uahZESDKa+F0uVzl1DcPMJs3pBR3YTFdsYd4TVgIAnglmMYKw7IsipePhlI
         f7MIPmCHSDpWgsuQZra63QsDQjqJJnh8BiLDuylcwrCVHBAjbq7YZ/6Yj6rT0CGMxjsP
         TKGfuGHYqcgRA9iHZhCxEFybEyib41uQeH64arO0bB6zhYjQJAVYRfp1UYq4QNLwESMc
         wCK9YUYbpFIAUePlYovxsNMuvoYbVZp0fdnRP/JD7TInueuN77OD9n3yXUiJ4vIbmeW5
         7uJjMlqhUVQgEMCU5sa7tDyC6wSHMUKBQ7Qw9e1J8IME6qq4+frCPoAWPSPVvD/W2PVG
         U97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2h+TR+OM3EYWoBqpTcjOAGgQzsk2TDQnX5OQcnEmOAY=;
        b=o1822XfE10OObmDpWwTxAh3zPRvpjubNyknlcSC72zqduNW+wajVGDL2ByFwlO2/vS
         NtLbCtoHmIVovTGoHFsowpmAmUzyYplK8qciU2XDhKYy5Bpd+XByegyaoeUvinEXPzrf
         C7V9rAgpuK261ftXeVOxHt84nOrVEDJQa3r6ju18MeTSLZrS2ZDF6n4XMTA7mmBD1OMv
         4RpU+M3r/3aPN5nvT2JXVEzhu63fL/8fkdBYcHzJhmZ0DDOzhhNitmY66Z7nMVFPVTAD
         AaBPZXvHkevi5hsSjeJmhBSLS1KX6IIH0vRSs6TvmPMHXWsFZkE9cQxWIYyAivC+yg1v
         a8TA==
X-Gm-Message-State: ACgBeo31UMFIPQMw03z1nwXjdr+DqknVLdE7Doa3S5Y2DjrJ8YVY/sKy
        N51mX1lDO3JjbWEA13i6lyFWBZdvkCVWi4LoyfFR4Q==
X-Google-Smtp-Source: AA6agR5vGOqK/tsrCshfD4rzlsnoeZHiXp1Rv7xMZmLNFZ1B8DFvAgMN1jNF83x8JwtdB984sjtsTSl8Fi2D/gbT/jw=
X-Received: by 2002:a81:9c2:0:b0:345:4830:1943 with SMTP id
 185-20020a8109c2000000b0034548301943mr446551ywj.86.1662497442006; Tue, 06 Sep
 2022 13:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <YxdA1CVzy9hzE3i1@kernel.org> <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
In-Reply-To: <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Sep 2022 22:50:05 +0200
Message-ID: <CANpmjNMHX2S-29Tyw+zKyaWT7saAiEegxbJapQFs7duJTTncdw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 6 Sept 2022 at 20:31, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Sep 6, 2022 at 5:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
> > > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > If it runs on an old kernel, perf_event_open would fail because of the
> > > > new fields sigtrap and sig_data.  Just skip the test if it failed.
> > > >
> > > > Cc: Marco Elver <elver@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/tests/sigtrap.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > > > index e32ece90e164..7057566e6ae4 100644
> > > > --- a/tools/perf/tests/sigtrap.c
> > > > +++ b/tools/perf/tests/sigtrap.c
> > > > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> > > >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> > > >         if (fd < 0) {
> > > >                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > +               ret = TEST_SKIP;
> > >
> > > Wouldn't we be interested if perf_event_open() fails because it could
> > > actually be a bug? By skipping we'll be more likely to miss the fact
> > > there's a real problem.
> > >
> > > That's my naive thinking at least - what do other perf tests usually
> > > do in this case?
> >
> > Yeah, I was going to try and check if this is the only way that, with
> > the given arguments, perf_event_open would fail, but its better to at
> > least check errno against -EINVAL or something?
>
> EINVAL would be too generic and the kernel returns it in many places.
> I really wish we could have a better error reporting mechanism.
>
> Maybe we could retry perf_event_open with sigtrap and sig_data cleared.
> If it succeeded, then we can skip the test.  If it still failed, then report
> the error.  But it still couldn't find a bug in the sigtrap code.
> What do you think?

Yes, that's what I meant, that it could point out an issue with
sigtrap perf_event_open().

If there's no clear way to determine if it's just not supported or a
bug, it'd be better to leave it as-is.

Some other options:

1. Provide a way to disable certain tests, if it's known they will
fail for otherwise benign reasons i.e. no support.

2. Provide a command line option to skip instead of fail tests where
perf_event_open() returns some particular errnos. The default will be
fail, but you can then choose to trust that failure of
perf_event_open() means no support, and pass the option.
