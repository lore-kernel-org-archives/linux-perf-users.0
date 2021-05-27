Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053EC4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF07A613BA
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhE0Pjl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhE0Pjk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 11:39:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9398C061760
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:38:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k4so649029ili.4
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2crjK0WkoLk1yIKgn4T+sf7fuQ4+lslYOkCkxigqz6k=;
        b=HZqATLPbPzHq6IDZSeyW6yH3VLhnhrOp5bu1V+jQffAojleUQIGYzRCLBTyyAF7nTw
         QZdn6q3lNQvvH94cVuMX6+YSeETwJjiUqVI3hHgZEWGje65RasGlKI9IU2/Qb6W5IpLp
         6aUq14d4eX44abInTxfQRMnCoTlWzntjphX6fjdlh9f5UrKWtoqdgrFS6068t/uofmQE
         C+Had2Qt+I5/EBQaI2YQq1uvB7x5OhaH1Ts6Q1Yg9zqyx1Dj6uD8LBdBx7+tmCU2Kqik
         QBO9GxjTTyNCd7BpIvdFDrbKyasY2MWTur57x6ZjClfx+FC85KZkhYHcxjjx58ISBnfL
         m8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2crjK0WkoLk1yIKgn4T+sf7fuQ4+lslYOkCkxigqz6k=;
        b=TqQ6Vhfl41bj7uaPCGlR+ezMZdmZgk2o7QM9oHEQGayFJAiLl89yKK/DfHkdF1KUge
         bJFWks4+Ay015OGCA6ujM5SZDQjCr15c1R8x11Znv+evjV+Jdt6I5kQ+/LhNo9c8zjNu
         3F/g0zHiABmMDYLd+Eog3kwcog/BfKaiEUuIod1xO9QNvLMrmbVIr6YGL/Q8Ws8v7xaI
         r61Zgc27TzTsMJm5phE7ec4zW6YRcYwqsb0r7tIT/+Fz4i2n5PuafnWx7Z1Ma5hpM0kI
         ox1AF26KbKhZgXkPvJTE0VP6bMfRRL4nMgkwOonKu4bzfKjSd68jgd3F9Rwg8xJbFfae
         2rqQ==
X-Gm-Message-State: AOAM531tgL94K+ibbGQ1OMWGGjm7QlvuUI98vlF6eVU11+mRGg47kOqJ
        Mau9DFeBjUZj845lLyDUzbshWMf2piwvHS9S1CiV0Q==
X-Google-Smtp-Source: ABdhPJwEeY2zSrutI4aF0G0bm/TwO5xOgq5IIyL9IMRKy/P97LQ/FPMd1WBfxtwT4wPgD2diYeMeoKv6gQKs6NAZbeM=
X-Received: by 2002:a92:c54a:: with SMTP id a10mr3421574ilj.140.1622129885983;
 Thu, 27 May 2021 08:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210527104234.24313-1-james.clark@arm.com> <11822824-7486-2333-f039-bfd801b86922@arm.com>
In-Reply-To: <11822824-7486-2333-f039-bfd801b86922@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 27 May 2021 09:37:54 -0600
Message-ID: <CANLsYkynQbGRhOmyramX+nSHvVnH_nSJb=t03Dp-2WeXP3ZYAw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] perf cs-etm: Split Coresight decode by aux records
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        branislav.rankov@arm.com, Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 27 May 2021 at 07:46, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 27/05/2021 13:42, James Clark wrote:
> > Populate the auxtrace queues using AUX records rather than whole
> > auxtrace buffers.
> >
> ...
> > Snapshot mode still needs to be tested.
> >
>
> Snapshot mode is also working, but needs the following patch applied to reverse aux_offset
> from the end of the buffer to the beginning:

It might be better to send another revision with this patch included
in to make sure everyone is looking at (and testing) the same thing.

>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5d6c03488187..9db556e14dfa 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2700,6 +2700,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>         struct perf_record_auxtrace *auxtrace_event;
>         union perf_event auxtrace_fragment;
>         bool matchesCpuPid;
> +       __u64 aux_offset;
>         struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>                                                    struct cs_etm_auxtrace,
>                                                    auxtrace);
> @@ -2730,19 +2731,26 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>         else
>                 matchesCpuPid = auxtrace_event->cpu == sample->cpu;
>
> +       /*
> +        * In snapshot/overwrite mode, the head points to the end of the buffer so aux_offset needs
> +        * to have the size subtracted so it points to the beginning as in normal mode.
> +        */
> +       if (aux_event->flags && PERF_AUX_FLAG_OVERWRITE)
> +               aux_offset = aux_event->aux_offset - aux_event->aux_size;
> +       else
> +               aux_offset = aux_event->aux_offset;
> +
>         if (matchesCpuPid &&
> -           aux_event->aux_offset >= auxtrace_event->offset &&
> -           aux_event->aux_offset + aux_event->aux_size <=
> -                       auxtrace_event->offset + auxtrace_event->size) {
> +           aux_offset >= auxtrace_event->offset &&
> +           aux_offset + aux_event->aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>                 /*
>                  * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>                  * based on the sizes of the aux event, and queue that fragment.
>                  */
>                 auxtrace_fragment.auxtrace = *auxtrace_event;
>                 auxtrace_fragment.auxtrace.size = aux_event->aux_size;
> -               auxtrace_fragment.auxtrace.offset = aux_event->aux_offset;
> -               file_offset += aux_event->aux_offset - auxtrace_event->offset +
> -                               auxtrace_event->header.size;
> +               auxtrace_fragment.auxtrace.offset = aux_offset;
> +               file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>                 return auxtrace_queues__add_event(&etm->queues,
>                                                session,
>                                                &auxtrace_fragment,
>
>
