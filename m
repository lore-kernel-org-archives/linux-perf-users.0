Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBEBC352A1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Dec 2022 19:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLFTaI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLFTaG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Dec 2022 14:30:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDD4092A
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Dec 2022 11:30:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m19so11967405wms.5
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Dec 2022 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AU08o0UieGBTXtoc7BuYi1GRzucQzgQyDedN5X+1HoY=;
        b=K0oXw6zCd6Tw/WpqrK+ZtnP3GxAbZuH7JSAhHFJYrkjI7ql0CC1RJ5Haa7tMb6pecj
         jDXNTwNn/q20BAe8cFsfJm0YIB4kXRZQXhattVfQv1DkV77XBx5AtqA8SH9figwhHjTy
         ULcWZgjfuD1Lr/o6ZSpJGpgjc5QpHrqJESiIfa11VuhUiNv2SVZBuB4+Le4o7Yg9NMXu
         3+qCWwPcTQKIbOwzFEJEm05jaI1WnKrMUIzWmOzvSF6gZKHRGEsxKsvD9saKdOsiZQ98
         BxZKJTFeNT4UK6kUmxoKYB5sQxRd5Qeg6XjMsaZc9IP128CxI6amMdME1CSLRgneQ5UB
         JMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU08o0UieGBTXtoc7BuYi1GRzucQzgQyDedN5X+1HoY=;
        b=6O9HTjiyYDcwhMP+x9ouAi8l2o5407YZY3BuMRxToQSLcJZ964l2XqrJ2AB7r16cCv
         0uAB8mfQTcQxJV0HBw7KoGnjtu+VBBKgssMqWiKMDIxJBuRgpdTPMmJFbpVXuoknvBTx
         zG4YGIdcdcAEoawCQyqp/MqVa4Fma5sbx7v3AMd3DC3bY2S+5ib0bShjcwGVKwvEhdyZ
         arCsVZzVgEznJrXnHY1tGcQhsg9XJ+wCu1wd7SHjJ65xunICWvY9UPGKg0ThIFZUeOqH
         sJ0f9IgEgbKyLYL6hf0GA4YZzg10TvmRc5kzNiFuWT16FUb31SnDe3FDDok56v1YHE/s
         nFUw==
X-Gm-Message-State: ANoB5pmqvr3h+iefi999bZhR74GsuiObfX28cliJVQ99kI7w1ex86fug
        oGh2Y+qgRS8JEpGAqp2C+0FZjR019xwVohldUBQRHmjArCTx9rNZ
X-Google-Smtp-Source: AA0mqf5UBZn69LIHWNiFUtIyWemIMoYW8vUSJgt4cTy6WHPQvzup5G+XZnKhLXfz7VMordhcpqj9fMsBcQ9WL4eEqiw=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr66781626wmb.182.1670355003819; Tue, 06
 Dec 2022 11:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221201034138.417972-1-irogers@google.com> <61e2f5b7-e332-08d1-7ffb-404cecd23ecb@oracle.com>
In-Reply-To: <61e2f5b7-e332-08d1-7ffb-404cecd23ecb@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Dec 2022 11:29:51 -0800
Message-ID: <CAP-5=fUMsEExYE+hwZz+fc6LW6PqdPRHq_CYKDb8xL0rHTKgAQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf jevents: Parse metrics during conversion
To:     John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 5, 2022 at 7:24 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 01/12/2022 03:41, Ian Rogers wrote:
> > Currently the 'MetricExpr' json value is passed from the json
> > file to the pmu-events.c. This change introduces an expression
> > tree that is parsed into. The parsing is done largely by using
> > operator overloading and python's 'eval' function. Two advantages
> > in doing this are:
> >
> > 1) Broken metrics fail at compile time rather than relying on
> >     `perf test` to detect. `perf test` remains relevant for checking
> >     event encoding and actual metric use.
>
> Do we still require the code to "resolve metrics" in resolve_metric()?
> But I'm not sure it even ever had any users.

We use metrics referencing other metrics for topdown metrics on x86.
For example:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json?h=perf/core#n34
    {
        "BriefDescription": "This metric represents fraction of cycles
the CPU was stalled due to Branch Resteers",
        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS +
tma_unknown_branches",
        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
        "MetricName": "tma_branch_resteers",
        "PublicDescription": "This metric represents fraction of
cycles the CPU was stalled due to Branch Resteers. Branch Resteers
estimates the Frontend delay in fetching operations from corrected
path; following all sorts of miss-predicted branches. For example;
branchy code with lots of miss-predictions might get categorized under
Branch Resteers. Note the value of this node may overlap with its
siblings. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
        "ScaleUnit": "100%"
    },
...
    {
        "BriefDescription": "This metric represents fraction of cycles
the CPU was stalled due to new branch address clears",
        "MetricExpr": "10 * BACLEARS.ANY / CLKS",
        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_group",
        "MetricName": "tma_unknown_branches",
        "PublicDescription": "This metric represents fraction of
cycles the CPU was stalled due to new branch address clears. These are
fetched branches the Branch Prediction Unit was unable to recognize
(First fetch or hitting BPU capacity limit). Sample with:
BACLEARS.ANY",
        "ScaleUnit": "100%"
    },

> >
> > 2) The conversion to a string from the tree can minimize the metric's
> >     string size, for example, preferring 1e6 over 1000000, avoiding
> >     multiplication by 1 and removing unnecessary whitespace. On x86
> >     this reduces the string size by 3,050bytes (0.07%).
>
> Out of curiosity, did you try the exponent change on its own (to see the
> impact on size)?

The file size savings are very modest. Without removing the "1 * " the
savings were roughly 2KB, perhaps 1KB was shrinking the constant
exponents.

> Nit:
>
> Unrelated, really, I notice that sometimes we lose the parenthesis and
> sometimes never had them, like:
>
> /* offset=11526 */ "\000\000metrics\000Ave [...] 0\000( 1000000000 * (
> UNC_CHA
> /* offset=11207 */ "\000\000metrics\000Ave [...] 0\0001e9 * (UNC_CHA_TOR
>
> To me, it seems neater to have the expression contained within (a
> parenthesis) ever since we moved to this "big string". This seems to be
> a preexisting feature.

You can also read the metrics through "perf list --detail", we could
add parentheses there if it helps readability. We can also expand out
what the big string values are for comments. Fwiw, I want to start
refactoring jevents.py in follow up work and that would impact
readability. Some thoughts there are:

1) we shouldn't parse all json events for all PMUs in prior to parsing
events, we should initialize a PMU when an event references it and
then possibly then go through the json events. To facilitate this it
would be useful to organize events by their PMU.
2) metrics and events should be separated at least in the C code.
Currently on x86 ScaleUnit in the json will apply both to an event and
its metric, even though the uses of an event and a metric should have
different units.
3) for some operating systems with limited disk, it would be nice to
be able to have the build exclude models.

Let me know if there's anything more outstanding to fix on this patch set.

Thanks,
Ian

> Thanks,
> John
>
>
> >
> > In future changes it would be possible to programmatically
> > generate the json expressions (a single line of text and so a
> > pain to write manually) for an architecture using the expression
> > tree. This could avoid copy-pasting metrics for all architecture
> > variants.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
