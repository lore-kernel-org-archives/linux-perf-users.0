Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51821C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Feb 2022 07:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiBAHdy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiBAHdx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Feb 2022 02:33:53 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7646C06173B
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:33:53 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id e81so31660185oia.6
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q58ni/O56sdIgVA2i/gi3EPNdebcIe5HTTwsxm8hE9U=;
        b=aNQ2P6FIK7qh1TBQx3yook2GasqAkK5HA0q9rzfkulQwcJ0Loet8pK3G8g5k+i4C7y
         8WVy2kPKomerLQTL8fMny2eQ3c1H3HTbpThMh6bBzJPBgkjNUfTYmF36HtL/YF+KaObi
         ChOfNnBi4BCydLt3oCLL15z8t290p2OG0OAZ9n3Tj8rhl2T392/Vd6Q93/j3OTKAEndC
         kqnrrNQpfpJcxKs4UVTX7J+Y1lDLRbV2xwM1U6Dylw1UoTeozwkzNeLA6/rpg44rOcfX
         5R/1nRsW6UqDLTE3VgWCV6TSjvvEebqpWq8BV1x8RuE6IYKwXhPaMzrzJGJC9Y0Tm16S
         X8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q58ni/O56sdIgVA2i/gi3EPNdebcIe5HTTwsxm8hE9U=;
        b=d0PlkUCba4WTrG9pL8HvhESttXaI/U+ZQ8JyNJwWCuguyxWSR8dcY58UdLK+mcpZuN
         qlamPZeScF0+yqM9T8mfErlTgpjF7i56HghSivK2Ax8exdspUN4NUmrUdGWbTVYZj+T9
         eM2wr+l6o/tY/rRFzcZiCL5M2vtBrpw1cbwGWDI1BKIjP6kZhhKzYDZFhWMeVrO9R8Sa
         H6uHDYBL7NMVNaJViINbeta+/0wnHBQEck1zSnVZmDMZdzUw2THJ0B14k5WabTCaThFi
         PE6WH66Scj5O3b8dTV7iKaUl8AhNa22+JF2U2aaq2fBfU6R1t5/1AVSKnUleI5l1aBge
         HZ2A==
X-Gm-Message-State: AOAM530fPL8OKT4C6t6zWyj5PYmqiyVM7lRMDzJfwuisY1bl8RXXkVY+
        zbPnwJHyFM2ybwq9zVtmInNV8OIWigNlVrLle9u9bw==
X-Google-Smtp-Source: ABdhPJwXknCX3IRL3sJw39e0iYu+qNPsnt/Cl9auQ1lgpSkVXndmGSooMFHfYDkHvg+AYqr85hYOgezVEwYY08h4TWs=
X-Received: by 2002:a05:6808:1641:: with SMTP id az1mr440454oib.278.1643700833121;
 Mon, 31 Jan 2022 23:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com> <20220131103407.1971678-3-elver@google.com>
In-Reply-To: <20220131103407.1971678-3-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 08:33:42 +0100
Message-ID: <CACT4Y+YfHGxCKOE179LzXkpeRqfEU8OO5zTh-BhLL7NxbNPGGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf: uapi: Document perf_event_attr::sig_data
 truncation on 32 bit architectures
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
> Due to the alignment requirements of siginfo_t, as described in
> 3ddb3fd8cdb0 ("signal, perf: Fix siginfo_t by avoiding u64 on 32-bit
> architectures"), siginfo_t::si_perf_data is limited to an unsigned long.
>
> However, perf_event_attr::sig_data is an u64, to avoid having to deal
> with compat conversions. Due to being an u64, it may not immediately be
> clear to users that sig_data is truncated on 32 bit architectures.
>
> Add a comment to explicitly point this out, and hopefully help some
> users save time by not having to deduce themselves what's happening.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  include/uapi/linux/perf_event.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 1b65042ab1db..82858b697c05 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -465,6 +465,8 @@ struct perf_event_attr {
>         /*
>          * User provided data if sigtrap=1, passed back to user via
>          * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
> +        * Note, siginfo_t::si_perf_data is long-sized, and sig_data will be
> +        * truncated accordingly on 32 bit architectures.
>          */
>         __u64   sig_data;
>  };
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
