Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94588C001DF
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGXPY5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGXPY4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 11:24:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6FE57
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 08:24:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40631c5b9e9so344361cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690212294; x=1690817094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ARRWNWh2Vmb25NjHP5oLpxafnyIHI4eaaf29F6UDI8=;
        b=7x0VllgkQZ5Lhm3lNOZYgbjqIZVMqawjLMvScJ3sLXCdq0pk0OVB6NpIUxJhgPFKP+
         35RLBrM73909fXim0ML2FaZmcXj0nHajLqvyQREYToX1EWZ6li0z07Z8B+tBjzCtBeiz
         z2Q3Fpw9grdmt9C9I6+9UVMuv6dkKHpyeDlk384H2i90VGjZMQnMVHPgECjogh8AWvuW
         pNcFvHLM5oB4Qe/qBdHljBEEJDr8a5FkSxxlbbRnxsV7yA3tmg9ydLZVSc9XJCqeTTmU
         X1NLWOMax2UtUGCpazbmOJajvXVxpRXq0fY3ff2dy1r//GxJ1NaRbrK7ZIJClO58ThCb
         GpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212294; x=1690817094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ARRWNWh2Vmb25NjHP5oLpxafnyIHI4eaaf29F6UDI8=;
        b=ImdtKpHu3NYKI0yRjlYCbaMM5Ob8MPnOmq/Ch/bPIFzdqsYebR0VKsj7qwt61VLhXe
         ZUaHiYlUv+dsLN86YwjslAzFc9ALoJ8e1zXDpv/B0K9fYWr44P9E9QQLd/PphlBiDx/B
         MljgUn19GTPmJY9KQgzaUxa3haofntGFsBVQmie2zT1ybqybwUTH68+mxAkYMvliQg7e
         rT9adQuAGR1QIh+u9tONOXRlGe4cG4s/FI29lcmDFXsSzu25wR41ptjF20Pm6RRMT0ed
         IUpugKlfosAEKNcOVZ8txoYrtq79vdX6t0KcL37A+kn5lR3ozTLf0Uk9lway1Q0aI1oJ
         /oWQ==
X-Gm-Message-State: ABy/qLYzge3zBtrNO1axo9zNPxaNIJDmeLJ3ZI1l+R/3OGHfRKbCcAkx
        9WI7Aw0mPj8THlMc1X1Dsf7Eu/qaZGvKJM8Tfa4zGA==
X-Google-Smtp-Source: APBJJlEf6NqfF5oOXAsS8tbDsNEIs+dIB+DwL5BKxyMm1DmXo0JNX3tzw75Jk4jlazxsoVQ782TOxUrZveOVOxKy0Fg=
X-Received: by 2002:ac8:7d81:0:b0:403:f5b8:2bd2 with SMTP id
 c1-20020ac87d81000000b00403f5b82bd2mr447401qtd.9.1690212294090; Mon, 24 Jul
 2023 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com> <ZLf4C/+x2ZSpb1Uz@kernel.org>
In-Reply-To: <ZLf4C/+x2ZSpb1Uz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Jul 2023 08:24:42 -0700
Message-ID: <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 19, 2023 at 7:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 18, 2023 at 05:18:33PM -0700, Ian Rogers escreveu:
> > Patch 1, fix:
> > perf stat -e cycles,slots,topdown-fe-bound
> > so that cycles isn't made a group leader (failure caused by PMUs
> > matching). Previously this event list would fail so not necessarily a
> > regression over previous perf release.
> >
> > Patch 2, when regrouping events the leader needs to be updated due to
> > sorting. This fix causes larger event groups that then regress at
> > least the tigerlake metric test as the kernel PMU driver fails to
> > break the weak groups. This is a fix for a bug but the consequence of
> > fixing the bug is to make a passing test fail due to the kernel PMU
> > driver.
> >
> > Patch 3, don't alter the list position of events without a group if
> > they don't need forcing into a group. Analysis showed this was the
> > cause of the issue reported by Andi Kleen:
> > https://lore.kernel.org/linux-perf-users/ZLBgbHkbrfGygM%2Fu@tassilo/
>
> Andi,
>
>         Can you please check these patches and provide a Tested-by?

I think we should be aiming to get these fixes/changes into Linux 6.5
and it's a shame this didn't happen last week. Feedback appreciated.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > Due to the test regression in patch 2, follow up patches may be
> > necessary for Icelake+ Intel vendor metrics to add METRIC_NO_GROUP to
> > avoid the kernel PMU driver issue.
> >
> > Ian Rogers (3):
> >   perf parse-events: Extra care around force grouped events
> >   perf parse-events: When fixing group leaders always set the leader
> >   perf parse-events: Only move force grouped evsels when sorting
> >
> >  tools/perf/util/parse-events.c | 58 +++++++++++++++++++++-------------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > --
> > 2.41.0.487.g6d72f3e995-goog
