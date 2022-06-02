Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79966C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 06:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiFBGVy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiFBGVv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 02:21:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD66DEE5
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Jun 2022 23:21:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso3298562wms.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2022 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOVgUxA1bDTDyTIwmAcMyzfNGeAcBs7vn2fkT3URToc=;
        b=avOI5wm80HcfnD5JSHV7pK5BsH2+jVSuFyJ0O3c7HNgCLu8Iq6iYXahvWw0avss3eR
         OnEGjxGmWICyBVIHkTj92usczbn9/N5FBHaBqO1wp3+Uqkmyul0llhXTdVW9kDmpUYAW
         veDqiLVP0TXTyVsIk6kp2QSlg57vDs6nj4e/sDOVEFr7KjDkgdqkshtQvMa107DP6z0R
         L71RMNTEyjhK78/fN80/mjnnY2cNuTZJ2jgjuHtqDhgksnFn/5HojsgBb6Syb6oZH1Ys
         +b5+kf8wPP4yulJL4bcrJaiSJGja9DLWWySsMTnwb9zp1/JkzhO9uPs4dEkOCfi9NgoN
         MFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOVgUxA1bDTDyTIwmAcMyzfNGeAcBs7vn2fkT3URToc=;
        b=MVRqwAg8NhdDxvaNJ3zlRDDSgWEccuPB5viCNUz7cZl3vL7YsnEZ2pjx4QUUwBDyD2
         4cEkj+UfWxmROSfQDcbN5UI04q3gd+TQlMOCEFbyo2vPFLWdrS8FQILZd2I3Cc0K0pkU
         19KuQkRIT/CB033ePxvECY0naZbt7FNjq9uNJbyrd/XFppU4yC3ug8S19HN8lfv3hP60
         87yktCj3B6ZZqEI9AA10bQU+GE/cNQCr9Qn9QSkYBDJ8yZbsQ32tOnOg99D885B14nv3
         YSIq6gi/XTMS9/BgS4AEyO7bsep0KH4odoE0KdhVCNiPLenYdCO6TA7gF2bvFRkcAGnj
         U2YA==
X-Gm-Message-State: AOAM532gdO7TqqD4IEGYaDEat7X1MavKBIxzILzoAyntw1R6gIvatVAv
        Qil828IDva+hV2Q5ESGFM+eqn9cDrPD6GJTb1YUkyQ0ArkKQxDgo
X-Google-Smtp-Source: ABdhPJx+Qg9/XPJgAjGUvPxditJJ54bsPjYt9M7fFcFlP4MsNMvGJmvit/KkVxeCCqj60h0rP7xlP0ScE+qOSxcDlPA=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr2446589wme.67.1654150908114; Wed, 01 Jun
 2022 23:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-3-namhyung@kernel.org>
In-Reply-To: <20220601065846.456965-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 23:21:34 -0700
Message-ID: <CAP-5=fWvS=1XrXnE_a+sif8ZKy2oc6pmo6RmZ6+fFrWoa1VM3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf lock: Add lock contention tracepoints record support
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When LOCKDEP and LOCK_STAT events are not available, it falls back to
> record the new lock contention tracepoints.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 70 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 23a33ac15e68..3e3320b8cede 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -495,6 +495,12 @@ struct trace_lock_handler {
>
>         int (*release_event)(struct evsel *evsel,
>                              struct perf_sample *sample);
> +
> +       int (*contention_begin_event)(struct evsel *evsel,
> +                                     struct perf_sample *sample);
> +
> +       int (*contention_end_event)(struct evsel *evsel,
> +                                   struct perf_sample *sample);

Would it make sense to add a comment here about LOCKDEP and LOCK_STAT?
It could be confusing if the handler isn't called on different
kernels.

Thanks,
Ian

>  };
>
>  static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
> @@ -822,6 +828,20 @@ static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *
>         return 0;
>  }
>
> +static int evsel__process_contention_begin(struct evsel *evsel, struct perf_sample *sample)
> +{
> +       if (trace_handler->contention_begin_event)
> +               return trace_handler->contention_begin_event(evsel, sample);
> +       return 0;
> +}
> +
> +static int evsel__process_contention_end(struct evsel *evsel, struct perf_sample *sample)
> +{
> +       if (trace_handler->contention_end_event)
> +               return trace_handler->contention_end_event(evsel, sample);
> +       return 0;
> +}
> +
>  static void print_bad_events(int bad, int total)
>  {
>         /* Output for debug, this have to be removed */
> @@ -1023,6 +1043,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
>         { "lock:lock_release",   evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
>  };
>
> +static const struct evsel_str_handler contention_tracepoints[] = {
> +       { "lock:contention_begin", evsel__process_contention_begin, },
> +       { "lock:contention_end",   evsel__process_contention_end,   },
> +};
> +
>  static bool force;
>
>  static int __cmd_report(bool display_info)
> @@ -1086,20 +1111,41 @@ static int __cmd_record(int argc, const char **argv)
>                 "record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>         };
>         unsigned int rec_argc, i, j, ret;
> +       unsigned int nr_tracepoints;
>         const char **rec_argv;
> +       bool has_lock_stat = true;
>
>         for (i = 0; i < ARRAY_SIZE(lock_tracepoints); i++) {
>                 if (!is_valid_tracepoint(lock_tracepoints[i].name)) {
> -                               pr_err("tracepoint %s is not enabled. "
> -                                      "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
> -                                      lock_tracepoints[i].name);
> -                               return 1;
> +                       pr_debug("tracepoint %s is not enabled. "
> +                                "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
> +                                lock_tracepoints[i].name);
> +                       has_lock_stat = false;
> +                       break;
> +               }
> +       }
> +
> +       if (has_lock_stat)
> +               goto setup_args;
> +
> +       for (i = 0; i < ARRAY_SIZE(contention_tracepoints); i++) {
> +               if (!is_valid_tracepoint(contention_tracepoints[i].name)) {
> +                       pr_err("tracepoint %s is not enabled.\n",
> +                              contention_tracepoints[i].name);
> +                       return 1;
>                 }
>         }
>
> +setup_args:
>         rec_argc = ARRAY_SIZE(record_args) + argc - 1;
> +
> +       if (has_lock_stat)
> +               nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
> +       else
> +               nr_tracepoints = ARRAY_SIZE(contention_tracepoints);
> +
>         /* factor of 2 is for -e in front of each tracepoint */
> -       rec_argc += 2 * ARRAY_SIZE(lock_tracepoints);
> +       rec_argc += 2 * nr_tracepoints;
>
>         rec_argv = calloc(rec_argc + 1, sizeof(char *));
>         if (!rec_argv)
> @@ -1108,9 +1154,19 @@ static int __cmd_record(int argc, const char **argv)
>         for (i = 0; i < ARRAY_SIZE(record_args); i++)
>                 rec_argv[i] = strdup(record_args[i]);
>
> -       for (j = 0; j < ARRAY_SIZE(lock_tracepoints); j++) {
> +       for (j = 0; j < nr_tracepoints; j++) {
> +               const char *ev_name;
> +
> +               if (has_lock_stat)
> +                       ev_name = strdup(lock_tracepoints[j].name);
> +               else
> +                       ev_name = strdup(contention_tracepoints[j].name);
> +
> +               if (!ev_name)
> +                       return -ENOMEM;
> +
>                 rec_argv[i++] = "-e";
> -               rec_argv[i++] = strdup(lock_tracepoints[j].name);
> +               rec_argv[i++] = ev_name;
>         }
>
>         for (j = 1; j < (unsigned int)argc; j++, i++)
> --
> 2.36.1.255.ge46751e96f-goog
>
