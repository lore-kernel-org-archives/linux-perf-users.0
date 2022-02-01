Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC66C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Feb 2022 07:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiBAHc6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiBAHc5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Feb 2022 02:32:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28DFC06173B
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:32:57 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so15416374otf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJSDBj0HvFrkS4TLKuPLvlZS13YusH/7w8kLNZ4wxGA=;
        b=LJlQ0q/uL3MKzgZ4tIKPUGf5ZdjHG3YbTGagkGQxErLE4GBrP3pwtVAXcfI5DOb35r
         f00BWzfnnUUT5iYd+03lUSTl8kRq88RhbO3jYBPd3Zl0Rn+QqgfJEX+CJ19AacVQfGr4
         N6v3W/E44lcWKD5oUwsRX7FY7jU2eSQJYPKuqSOpOkb6FF7wfgRi2y/IExRaHHs5vxPx
         AMVhxMzRPnQm+APmaNOSn18Hz/In7wZXJNkgJovDhIHBLZKI0AprlnlqXWHeZQuHl8fr
         h3yLsL1/c2RO1yrytOTE/VRejXuJW4wqW3kzfgcVVfYHwesKQc56G3gjThWJIu9DPj9r
         +GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJSDBj0HvFrkS4TLKuPLvlZS13YusH/7w8kLNZ4wxGA=;
        b=UJ3m3cWaGXaBUT45BmTp8Z6MN8KLH+5milSors6SvjN/QnCT3xG/L3Jcl0I6UmySRJ
         cU8jdnxCTRZu3+QtIuqG3ATvUwIhC7qZAeALj2dGNmD8COEzYJvTPnUSuNdBve9aXRkr
         Cux+v56LU20JUYyUuDA3gpHJECuv1ISkPZjsuxQoNwGpSpC4Lw5ZKQBsosgDTk7BHGg4
         QxlxQl7SXjB9CS2cndyQhdDNfsRr2lpFQu18HxakQeQnWspHMhv0cnRsbrI1yLDlFZFp
         alBOPkvvmZ7Yz9LP/JuI7b8gEigaE7r03Vk6MsEDz9KHdoBSAwDwvMba2Uqt6qxAGono
         a7Nw==
X-Gm-Message-State: AOAM530XxXiEjLpXpYJf4MqyC5aU4Ck3qztse1mqAddizZ9LCbqvHmDO
        e+fJBXhrbQB/BruUYO83V77wfHdD3dnQUxxFHmHMBQ==
X-Google-Smtp-Source: ABdhPJyT9m4eJrn2NJRLqyik1zmslChCJeZLrGkukJT+0lnFfwqo/WvDQUXQ8MvtVpST6dcT6SNask0BDMM/CbbmysQ=
X-Received: by 2002:a9d:356:: with SMTP id 80mr13762561otv.335.1643700776891;
 Mon, 31 Jan 2022 23:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com>
In-Reply-To: <20220131103407.1971678-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 08:32:45 +0100
Message-ID: <CACT4Y+Zcg9Jf9p+RHWwKNDoCpfH-SBTzPpuQBBryyeopMONmEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: Copy perf_event_attr::sig_data on modification
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 31 Jan 2022 at 11:34, Marco Elver <elver@google.com> wrote:
>
> The intent has always been that perf_event_attr::sig_data should also be
> modifiable along with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, because it is
> observable by user space if SIGTRAP on events is requested.
>
> Currently only PERF_TYPE_BREAKPOINT is modifiable, and explicitly copies
> relevant breakpoint-related attributes in hw_breakpoint_copy_attr().
> This misses copying perf_event_attr::sig_data.
>
> Since sig_data is not specific to PERF_TYPE_BREAKPOINT, introduce a
> helper to copy generic event-type-independent attributes on
> modification.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for the quick fix.

> ---
>  kernel/events/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fc18664f49b0..db0d85a85f1b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3197,6 +3197,15 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
>         return err;
>  }
>
> +/*
> + * Copy event-type-independent attributes that may be modified.
> + */
> +static void perf_event_modify_copy_attr(struct perf_event_attr *to,
> +                                       const struct perf_event_attr *from)
> +{
> +       to->sig_data = from->sig_data;
> +}
> +
>  static int perf_event_modify_attr(struct perf_event *event,
>                                   struct perf_event_attr *attr)
>  {
> @@ -3219,10 +3228,17 @@ static int perf_event_modify_attr(struct perf_event *event,
>         WARN_ON_ONCE(event->ctx->parent_ctx);
>
>         mutex_lock(&event->child_mutex);
> +       /*
> +        * Event-type-independent attributes must be copied before event-type
> +        * modification, which will validate that final attributes match the
> +        * source attributes after all relevant attributes have been copied.
> +        */
> +       perf_event_modify_copy_attr(&event->attr, attr);
>         err = func(event, attr);
>         if (err)
>                 goto out;
>         list_for_each_entry(child, &event->child_list, child_list) {
> +               perf_event_modify_copy_attr(&child->attr, attr);
>                 err = func(child, attr);
>                 if (err)
>                         goto out;
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
