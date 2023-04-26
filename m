Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6BC77B60
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 05:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbjDZFme (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 01:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZFmd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 01:42:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAE10E
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Apr 2023 22:42:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so42897445e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Apr 2023 22:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682487751; x=1685079751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAlKjkZlYiS/M9sDjOvQPaGX1RECu1oiyZsTxZm3cVA=;
        b=BRHvhopr81XtR7ioaSYEpa2HHVUfKy2XIJgfQkOh5R3eyLnIgReyaYbXi55SgKRkvQ
         2x4NeWvfP+m0NvQpaxTrXyJTEWKmXVNM76rhmKwDO39WgKR2IqppA90ssp77cW7l+sMh
         X1APAlakl/4i8OhjpSvaczkMLlHA3JH65oT2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682487751; x=1685079751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAlKjkZlYiS/M9sDjOvQPaGX1RECu1oiyZsTxZm3cVA=;
        b=db4elqp6MSTPvX6j0ysd2HQMGZ3xDMlgOgLrFyaAwCnFnBHl55rx0tPMJVphgT/K0u
         aQNyzSGfj4/v6OlmJ6Ox6jdEDYmRnH69oE3WHoTy8QbAXZKVFsEQr0v5y3QGma4CyWPB
         SgzQPx/Y4N1SyljW+hPNlOTxGymNzbC/U/k0m8Gm44wfWquLBx0fBL/cqoEcfNAabJlI
         6iKWVAWGOFKXO4MwlZJDuC+IIzQbYzNy/HR5O2Sp5p876Mou/0k+Y2ReesBfaf/24JNW
         2ye7o/y3KDh8PqDNUzqL2pgoIOBPloeCrUSAIcL2z+HpZnPZW2+K2Wl/wyris4FxVJq7
         vYMw==
X-Gm-Message-State: AAQBX9c9b02sLEplfexAIZ3YXuFmOVEUlXsr4ijqxcmnwE8BsuiMnszs
        YqS8/P5xp5uodx7mTuWMvPJSvODsG+JaS/vF38c//A==
X-Google-Smtp-Source: AKy350azTF5Cz+YsYzhDQEbaSC7fCbwPbNUtEK2fGWS87SlSCUAcRZmsRWGupgYd2zEybhGkEGy7+LIkyrw02QCxj6I=
X-Received: by 2002:a7b:cb8a:0:b0:3f1:7368:ccc6 with SMTP id
 m10-20020a7bcb8a000000b003f17368ccc6mr11173389wmi.25.1682487751190; Tue, 25
 Apr 2023 22:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230424134748.228137-1-james.clark@arm.com> <20230424134748.228137-2-james.clark@arm.com>
 <8acae291-2c3f-6010-de66-d4e54781d21f@arm.com>
In-Reply-To: <8acae291-2c3f-6010-de66-d4e54781d21f@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Tue, 25 Apr 2023 22:42:19 -0700
Message-ID: <CADDJ8CWdKQR_-hgLqYdB6QyMZwzkZMtZ5gkoth3Uj7O7i3Cfvg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf: cs-etm: Fix timeless decode mode detection
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 24, 2023 at 8:14=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
> On 24/04/2023 14:47, James Clark wrote:
> > In this context, timeless refers to the trace data rather than the perf
> > event data. But when detecting whether there are timestamps in the trac=
e
> > data or not, the presence of a timestamp flag on any perf event is used=
.
> >
> > Since commit f42c0ce573df ("perf record: Always get text_poke events
> > with --kcore option") timestamps were added to a tracking event when
> > --kcore is used which breaks this detection mechanism. Fix it by
> > detecting if trace timestamps exist by looking at the ETM config flags.
> > This would have always been a more accurate way of doing it anyway.
> >
> > This fixes the following error message when using --kcore with
> > Coresight:
> >
> >    $ perf record --kcore -e cs_etm// --per-thread
> >    $ perf report
> >    The perf.data/data data has no samples!
> >
> > Fixes: f42c0ce573df ("perf record: Always get text_poke events with --k=
core option")
> > Reported-by: Yang Shi <shy828301@gmail.com>
> > Link: https://lore.kernel.org/lkml/CAHbLzkrJQTrYBtPkf=3Djf3OpQ-yBcJe7Xk=
vQstX9j2frz4WF-SQ@mail.gmail.com/
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   tools/perf/util/cs-etm.c | 30 ++++++++++++++++++------------
> >   1 file changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 8dd81ddd9e4e..50593289d53c 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2684,26 +2684,29 @@ static int cs_etm__process_auxtrace_event(struc=
t perf_session *session,
> >       return 0;
> >   }
> >
> > -static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
> > +static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm=
)
>
> minor nit: "setup" sound more like prepare to do what is required to
> do a timeless decoding, while we are doing more like, check if we
> have to do a timeless decoding. So may be:
>
> cs_etm_check_timeless_decoding() ?
>

I didn't catch that "setup_timeless_decoding" can be treated as the
initialization
of the timeless decoding. On the other hand _check_ doesn't imply that
it changes
the flag.
Maybe "_setup_timeless_decoding_flag" will be more specific about its inten=
tion?

- Denis

>
> Otherwise, looks good to me
>
> Suzuki
>
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
