Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8891FC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637B56105A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhKGJI3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhKGJI2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 04:08:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B5C061570
        for <linux-perf-users@vger.kernel.org>; Sun,  7 Nov 2021 01:05:45 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b203so12256967iof.10
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Nov 2021 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=847ptN5qCtO/nijmp437/BJw1mTVnsfqm2uE3FFXRTA=;
        b=FyRALhF5bR05hA1XI06xnKELnKhUHDJQE3ngMxpNerKEL7SvA4Nuy3JQcO6P0XIyd/
         xXW7MyYdx9U6NNVhIg25qsMM+kbfpOwpUva9D6Oo/NM6/yLdjmzFvwyypnDSjv/zUClq
         My2fvG5cNu/qPRODiku0ILfpSDFQ3FHJkenT2TrXY5LkNVlOSA34Js7WoNwbtyGabQfG
         eOFWMFg+eSGSUMp5QyEb/tqvmP7llv5ZEq0sXG0sOyDC/We3q1PeDJxJf3POBD4yKi6i
         8uKNe65lWcweotdwC0JPc5hKaBs6/z3C30YJfF0JibCbJuVYr8yTgokOQDUuVioN1wJw
         8TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=847ptN5qCtO/nijmp437/BJw1mTVnsfqm2uE3FFXRTA=;
        b=XCYSGqd73quJ5i0Mq8K/5i5odpUzgWKbrbbRlfVUHfdPas/mAXUVulFDiSwThIaAMa
         JGq1+Pk/LlCHsZoVGOTudS/n7gRd5547D35fIhJMdB0sEV7a8BEGabJTcte6dXtTBQRs
         VKs6V1c3HzDGOQ5GW475xTBEUpHKndD1DG08Nh3ux4/gbXRb9oW+zInV1O4Bn8lFn+70
         hLbRXdj9Q5Pz5Oq6sT0JZ8dKlKwLF+G29rxlJq8o066+CT1danCJTHKkIIsbzfxJEi1h
         Q2PdR30XN8lWI+2I9CLBet2//mC6qFwEExBBiqbZs4zD6WcG7RPwtHXmknLk39PWVKAx
         9IHQ==
X-Gm-Message-State: AOAM533UtFTXiK0zC0U6cfORZD4+sg+ppMZAJvfWZ3097nCDmjOIqgpI
        2lBF6sEvqA2s98oAFZ055/oN7w935jsUjoHf7+h0l4N3Koyb9A==
X-Google-Smtp-Source: ABdhPJwjJtrJbhEbQ5Pa+Syqiej5MPrLUd7M2r1gyQhSmKdnd2aT2JrvlU+BnSMkLJvhHnpw+Q6aWPIkAvt1p/oQWNc=
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr7651944iov.32.1636275944634;
 Sun, 07 Nov 2021 01:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20211105164657.3476647-1-irogers@google.com> <YYbczk5svUYrbIhQ@kernel.org>
 <CAP-5=fVMtO6zd_Qm9rJkMNGB==606hW-PRiQ7VCWFJLpJRmyBQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVMtO6zd_Qm9rJkMNGB==606hW-PRiQ7VCWFJLpJRmyBQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 7 Nov 2021 01:05:30 -0800
Message-ID: <CAP-5=fU7vh4XAe-jEa13tzy2x+a3oF+tfJfy2_Oxs5q1SSNYEw@mail.gmail.com>
Subject: Re: [PATCH] perf metric: Fix memory leaks.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Nov 6, 2021 at 5:36 PM Ian Rogers <irogers@google.com> wrote:
>
>
>
> On Sat, Nov 6, 2021, 12:51 PM Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>>
>> Em Fri, Nov 05, 2021 at 09:46:57AM -0700, Ian Rogers escreveu:
>> > Certain error paths may leak memory as caught by address sanitizer.
>> > Ensure this is cleaned up to make sure address/leak sanitizer is happy=
.
>> >
>> > Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
>> > Signed-off-by: Ian Rogers <irogers@google.com>
>> > ---
>> >  tools/perf/util/metricgroup.c | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgro=
up.c
>> > index 4917e9704765..734d2ce94825 100644
>> > --- a/tools/perf/util/metricgroup.c
>> > +++ b/tools/perf/util/metricgroup.c
>> > @@ -228,6 +228,7 @@ static void metric__free(struct metric *m)
>> >       free(m->metric_refs);
>> >       expr__ctx_free(m->pctx);
>> >       free((char *)m->modifier);
>> > +     evlist__delete(m->evlist);
>> >       free(m);
>> >  }
>> >
>> > @@ -1352,6 +1353,14 @@ static int parse_ids(struct perf_pmu *fake_pmu,=
 struct expr_parse_ctx *ids,
>> >       *out_evlist =3D parsed_evlist;
>> >       parsed_evlist =3D NULL;
>> >  err_out:
>> > +     /*
>> > +      * Errors are generally cleaned up by printing, but parsing may =
succeed
>> > +      * with intermediate unused errors being recorded.
>> > +      */
>> > +     free(parse_error.str);
>> > +     free(parse_error.help);
>> > +     free(parse_error.first_str);
>> > +     free(parse_error.first_help);
>>
>> Can't this be in a parse_events__free_errors() routine?
>
>
> I was wondering about an init and exit routine, I'm not sure on the conve=
ntion here. The code currently assumes that an error will cause printing an=
d the print routine frees. It is possible to have events that fail but over=
all parsing succeeds. We need to free in both cases which currently isn't d=
one with a helper.
>
> Thanks,
> Ian


I did the bigger cleanup with init/exit in v2:
https://lore.kernel.org/lkml/20211107090002.3784612-2-irogers@google.com/

Thanks,
Ian

>
>
>> - Arnaldo
>>
>> >       evlist__delete(parsed_evlist);
>> >       strbuf_release(&events);
>> >       return ret;
>> > @@ -1481,8 +1490,10 @@ static int parse_groups(struct evlist *perf_evl=
ist, const char *str,
>> >       }
>> >
>> >
>> > -     if (combined_evlist)
>> > +     if (combined_evlist) {
>> >               evlist__splice_list_tail(perf_evlist, &combined_evlist->=
core.entries);
>> > +             evlist__delete(combined_evlist);
>> > +     }
>> >
>> >       list_for_each_entry(m, &metric_list, nd) {
>> >               if (m->evlist)
>> > --
>> > 2.34.0.rc0.344.g81b53c2807-goog
>>
>> --
>>
>> - Arnaldo
