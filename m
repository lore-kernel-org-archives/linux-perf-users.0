Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80986C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 05:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8806140E
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 05:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFYFmJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 01:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYFmJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 01:42:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2358C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jun 2021 22:39:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c84so5431391wme.5
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jun 2021 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDeOsCIsygdTA6avg2dQ+qq5UMH5IgvY8ajPpIdUvvg=;
        b=KY9mAcIKw9DjSmvqQEp+6WfGjd9tkYKqnDhb4+48JyphFlHuAe4HXXNpckVPYXvZd4
         X50qtp/hEue45W9Telcp94NZMaq+tcuFPd4bmJpT4BE7SC+TS/C5sqZqrkZLIEkvHOmz
         wezDc1fekPsvwnXerIP3p7EAq652FukaWPEGyd5V1mXlhUIAWdD39mu9Ey6Hc1uA/2Xo
         na0GGBEXdq1gKDtxtflWHFblkStT1nVXExu8vqYotDsy5JRji0rTiPCxdRGMGz83iYWi
         kl+c79Rc1EI+k605axxZCDGyJ8Lpn4Wt74A0ECIZm9Om/nPP34NTv01zv+mvivObiA5n
         aPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDeOsCIsygdTA6avg2dQ+qq5UMH5IgvY8ajPpIdUvvg=;
        b=kFlxNCLjY9p2PIjU+PdDZqhxciLKS2Y3/kHxtEt2Lff07i07q4fxaR4PRr69BmUOPz
         yAS8spiHQMxNbIb0rFxydwKu12dQvE2VHbGRPK5O9kMwYPRzTBYBKrSufJ9+tCYEACra
         VFup2vmdubDiIwOpckuC5SL2XQzhZk0LCklae2uPy7re9W3G/I0wRIr88Z1MEcEjPnER
         koIR4A8g7wqn1lIixVjDv5Kfwtq7raST1wwjmvJaJHEF2G68NjCZPJV/cLsrZIcLRzZk
         oPfL0JB+UiqTHNudQF7DsiZXWtNhxeOQGiLh9lewbhJf1pU1YB+D8n16sdyul5h+Rkv1
         Ytnw==
X-Gm-Message-State: AOAM532dMgUQBlhpGRRdLLLTldIXMJf2pPWuld95Tzd0QNa5K8qVQQ75
        +mYLhl4nEVKdKj30IFhlCEaUfkJacZU7vKffAkrobg==
X-Google-Smtp-Source: ABdhPJyAzRkNqYWkkJOCUxNWccHdbHtYpoxTsRoaQtcJRhIMUBJiaKWA8ANXYKR1tDH3h/kHhAJL3O2EljKp0PviZQ0=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr8497876wml.87.1624599586263;
 Thu, 24 Jun 2021 22:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210624231926.212208-1-rickyman7@gmail.com>
In-Reply-To: <20210624231926.212208-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Jun 2021 22:39:34 -0700
Message-ID: <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when deleting
 a session
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reports a memory leak caused by evlist not being deleted on exit in
> perf-report, perf-script and perf-data.
> The problem is caused by evlist->session not being deleted, which is
> allocated in perf_session__read_header, called in perf_session__new if
> perf_data is in read mode.
> In case of write mode, the session->evlist is filled by the caller.
> This patch solves the problem by calling evlist__delete in
> perf_session__delete if perf_data is in read mode.

Acked-by: Ian Rogers <irogers@google.com>

It is messy that in read mode the session owns the evlist, but
otherwise not. Imo, it'd be nice to make the ownership unconditional.

Thanks,
Ian

> Changes in v2:
>  - call evlist__delete from within perf_session__delete
>
> v1: https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/
>
> ASan report follows:
>
> $ ./perf script report flamegraph
> =================================================================
> ==227640==ERROR: LeakSanitizer: detected memory leaks
>
> <SNIP unrelated>
>
> Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
>     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
>     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
>     #2 0x7f999e in evlist__new /home/user/linux/tools/perf/util/evlist.c:77:26
>     #3 0x8ad938 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3797:20
>     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
>     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
>     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
>     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
>     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
>
> Indirect leak of 568 byte(s) in 1 object(s) allocated from:
>     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
>     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
>     #2 0x80ce88 in evsel__new_idx /home/user/linux/tools/perf/util/evsel.c:268:24
>     #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
>     #4 0x8ae07e in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3853:11
>     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
>     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
>     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
>     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
>     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
>
> Indirect leak of 264 byte(s) in 1 object(s) allocated from:
>     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
>     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
>     #2 0xbe3e70 in xyarray__new /home/user/linux/tools/lib/perf/xyarray.c:10:23
>     #3 0xbd7754 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:361:21
>     #4 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
>     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
>     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
>     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
>     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
>     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
>     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
>     #2 0xbd77e0 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:365:14
>     #3 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
>     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
>     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
>     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
>     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
>     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
>
> Indirect leak of 7 byte(s) in 1 object(s) allocated from:
>     #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
>     #1 0x8b4459 in evlist__set_event_name /home/user/linux/tools/perf/util/header.c:2292:16
>     #2 0x89d862 in process_event_desc /home/user/linux/tools/perf/util/header.c:2313:3
>     #3 0x8af319 in perf_file_section__process /home/user/linux/tools/perf/util/header.c:3651:9
>     #4 0x8aa6e9 in perf_header__process_sections /home/user/linux/tools/perf/util/header.c:3427:9
>     #5 0x8ae3e7 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3886:2
>     #6 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
>     #7 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
>     #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
>     #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #10 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
>     #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
>
> SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/session.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index e59242c361ce..c36464d94387 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -301,8 +301,11 @@ void perf_session__delete(struct perf_session *session)
>         perf_session__release_decomp_events(session);
>         perf_env__exit(&session->header.env);
>         machines__exit(&session->machines);
> -       if (session->data)
> +       if (session->data) {
> +               if (perf_data__is_read(session->data))
> +                       evlist__delete(session->evlist);
>                 perf_data__close(session->data);
> +       }
>         free(session);
>  }
>
> --
> 2.31.1
>
