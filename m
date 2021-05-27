Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A349C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30337610FC
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhE0Pxa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhE0Pxa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 11:53:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98028C061763
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:51:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so774152wmc.2
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGM578SjTx4HPSAuDayxd66VlRx8pMIDrOm8Ebr5U4U=;
        b=cznRe/KbSwD4IKSBRhpDdAA3gr55mz4bVGiRHmEOhd+VXY2noIzcwDIN8KVpRNab0s
         nNmAEgJP5V45qsvqJlkcj0eWxMAAMpkCy+r1l9Y0NP0GvnQY7OV2gMrsBXK7EY37bIXB
         InUfP3Vt6XWH2PxXqeOHgC5Smseg6N4oXnvSRq1miEpcVYL0ka0TRiehugi5UU3YAAKx
         A+ydECqCFTS3JsTmSlDp7KS1lieu/iAdSiWya/k2uyskIxRnB1v1+fMzMCUb/m6HaS7k
         N4pOf6yK/Tf3NmNKEqyXRmOxwG+1PKz8qnEFZ+PSCqdIfgcylU3wBGEt30kLnNki5Frl
         4/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGM578SjTx4HPSAuDayxd66VlRx8pMIDrOm8Ebr5U4U=;
        b=lH2jZR9OFWpcD/JFbucBlz/mHDvC+g0LhkQeEekv4OcW/lJnmxLTwuo2QgQ0M/YPv3
         P++fd5y0UX2ZQ6aoBrJ6kYSxottRY/l0e7mG2TUsep4IxutKHrDvmt5H7MaQHrTZTA/3
         bD5q4lmMVeU1rCvkDhbNzY8VnDcttgn9zehDiVVkfYvaRhK9LOpYtc6bXFClJjf2Jf3S
         H0A3tzJEWdbO7/zA9wS7d08NcYcLSk++rdZoHtkuFuxL291uDD7pJypr6uxe7vr6410a
         PdDUx+ZfVVlCsQemA6ITgSySq2I5/APzB9Q2q9i4ZDblLENa5vTFx37VFP8nmlYcUGjI
         8TAQ==
X-Gm-Message-State: AOAM533YpfouMAsKllqVZEmUxCPE8fjYq1tbWgyvS0i6Sqrr2bAYDrCZ
        GwjncZ+AlIZn8hX/piBsgxZVqqXGCfgKMa59d8FujA==
X-Google-Smtp-Source: ABdhPJwx7qe8Y0mZV7gVdyHoTXhTi2y03ykKGYwRQyBeGlbNF1psf9XSsN2gpRnhJtd3uI0x5VZ2QVY/Dm3HlggI4mQ=
X-Received: by 2002:a1c:4006:: with SMTP id n6mr6898753wma.58.1622130714011;
 Thu, 27 May 2021 08:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210519164447.2672030-1-irogers@google.com>
In-Reply-To: <20210519164447.2672030-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 May 2021 08:51:41 -0700
Message-ID: <CAP-5=fWRAbkd8MVAxdGf0YGE1oFPT40rZC3eb3OKjqWmBVq_BA@mail.gmail.com>
Subject: Re: [PATCH] perf: Move debug initialization earlier
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 19, 2021 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
>
> This avoids segfaults during option handlers that use pr_err. For
> example, "perf --debug nopager list" segfaults before this change.
>
> Fixes: 8abceacff87d (perf debug: Add debug_set_file function)
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks!
Ian

> ---
>  tools/perf/perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 20cb91ef06ff..2f6b67189b42 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -443,6 +443,8 @@ int main(int argc, const char **argv)
>         const char *cmd;
>         char sbuf[STRERR_BUFSIZE];
>
> +       perf_debug_setup();
> +
>         /* libsubcmd init */
>         exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
>         pager_init(PERF_PAGER_ENVIRONMENT);
> @@ -531,8 +533,6 @@ int main(int argc, const char **argv)
>          */
>         pthread__block_sigwinch();
>
> -       perf_debug_setup();
> -
>         while (1) {
>                 static int done_help;
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
