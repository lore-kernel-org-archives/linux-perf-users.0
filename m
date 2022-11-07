Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736CC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Nov 2022 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiKGU7P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiKGU7N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Nov 2022 15:59:13 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F5CD;
        Mon,  7 Nov 2022 12:59:12 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13ae8117023so14088242fac.9;
        Mon, 07 Nov 2022 12:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EurRGdIXmrZYEmrrxoQ5RYPb5xqSkjb6kydBYZiyHNg=;
        b=djETqYxWR4XFQN8ucGfMg041tASMbeWnfjwroo9Znpk2b+Da45PzE3w35evs9e6SIX
         3fmxulUiOyznd67H+UBFjTj/Z5snYPXcKGQufbxgxxQQt49DYVSHJPBsjncNzTJwmIj+
         MvavP8zkXV+DvBxKHAwqvjR9xnsJg9iUy4h/RhsP8HmP3T7luCQlahNvFG6pQwrBBBAi
         /jXfP2RBPd1KnOqmjCfmYYeSnFzb4QnTR6JWca+OjTtA4cW0rScI4dDZ8tECp2bZU3Zg
         bxXteGB91Asnd9+3M9Z+t4Fn7s62mhmwU6WRL/4meG9X2kAzjw+gjjgt1K3JsAiDiB2F
         6zSw==
X-Gm-Message-State: ACrzQf1WTYtusRVk9+qhmw9jUtYdU/jSKxsMUoOCWMRCpZfFAbylLffe
        KiH1Cf2nUgs/0nvKtgxEEEYTnTqk4LJGcmnQrXE=
X-Google-Smtp-Source: AMsMyM4EFjXZNq+yVBfuWjXYn+r6rhsFoosLyTP7TmEdjjU2ziECawiB7ho+2LxhbYUHD2bOUGReT0JRRxw20vfNmOY=
X-Received: by 2002:a05:6870:9a27:b0:140:6f4c:f532 with SMTP id
 fo39-20020a0568709a2700b001406f4cf532mr11190737oab.209.1667854751778; Mon, 07
 Nov 2022 12:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20221105135932.81612-1-tegongkang@gmail.com>
In-Reply-To: <20221105135932.81612-1-tegongkang@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Nov 2022 12:59:00 -0800
Message-ID: <CAM9d7cjm+_h3C6=0UYR=pSiB4m8fEt3WUy-tkLos_yYu4bFWsA@mail.gmail.com>
Subject: Re: [PATCH] perf print-events: Remove redundant comparison with zero
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Minchul,

On Sat, Nov 5, 2022 at 6:59 AM Kang Minchul <tegongkang@gmail.com> wrote:
>
> Since variable npmus is unsigned int, comparing with 0 is unnecessary.
>
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>  tools/perf/util/print-events.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index c4d5d87fae2f..6df947df1c0f 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -311,10 +311,8 @@ int print_hwcache_events(const char *event_glob, bool name_only)
>                                 if ((hybrid_supported == 0) ||
>                                     (hybrid_supported == npmus)) {
>                                         evt_list[evt_i] = strdup(name);
> -                                       if (npmus > 0) {
> -                                               for (j = 0; j < npmus; j++)
> -                                                       zfree(&evt_pmus[j]);
> -                                       }
> +                                       for (j = 0; j < npmus; j++)
> +                                               zfree(&evt_pmus[j]);

You can still have 0 npmus, but then the for loop will not be executed.  So,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>                                 } else {
>                                         for (j = 0; j < hybrid_supported; j++) {
>                                                 evt_list[evt_i++] = evt_pmus[j];
> --
> 2.34.1
>
