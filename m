Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F52C19F2A
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiHDPWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiHDPWa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 11:22:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08972716E
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 08:22:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv3so51510wrb.5
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxi8kO7688NCXdg9Xjte2U35xprZFk31wBQ69isj9qY=;
        b=IzkoS9FeSj+3gXfgRB/D9s+n7cbsb+VMFkOgnB9Ki5AGTVXmOZ3m62WtQmfrcAjUt0
         nSN1BLCd1439wsSrPGfAjcVuSLFyYqKB2YYUHgJ9jrAHB3J9eleZaua+PtRg5atnlpUN
         NAiyW0AYvP37nBW0V2n3Mq/6eVItlhnWI24+ZQ7kEGlIBeNcOZ2TOE5sw2b4kjFyn77t
         ZIh1VVqwNmAua5nT8A6gFT3g2oApuNvHi7/kYeKUnN609LT6JithavNIyb5zlzsx94p+
         Y/fdgzO+dRdkA3MdZcVvkoT+LTsCnH6c/dHeEgW0e0YuWNN7GKfzzHyLyTC8r/+/uUlI
         xXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxi8kO7688NCXdg9Xjte2U35xprZFk31wBQ69isj9qY=;
        b=uWSQ1cMV27Sb+8bkVWefHfzVNADKqa20vZExjI5Rqk22shpFkcW2QF5/y2bqpRSxZp
         za+664E/3lChmQOWBzTWDABUpFNWzn7qygi5P4drMI4/XxBfbsYMt3MfoKhPRre/vz79
         NDW6e4BKa6Kjhytl186o3poUyZ6Paim09EE2jLrV15X0JIww2Z0jPHdnEjeXiMOjEbnh
         /BYOrSHbQabZnXKkV/lszLQetRi5KkpFvl01BrWHQ5HyzuOzo6Fp4b0vsVqYlj8uf0xh
         PTmyYvYtmjk3OLoUHqlkPWl9DayxRCn2o03Km2PB8ko1PwK1PC7h3jAXfKJtdc0R2h+K
         /JuA==
X-Gm-Message-State: ACgBeo1Z90nDpyLdNQYnRLYKgT11pIj3I7ocdtO4GGZxy/4MiSRKjQnn
        gq/ieCfBnNpRnlPxSZvlnGM8P/hMIstlvGCaBdOAcw==
X-Google-Smtp-Source: AA6agR6olE1YQ+LoT1UtNm35qbXmJBGJ6DaN4BTzpdwN8yPbu6qAic9og7qdJSXw/LH7D9H3LKw7C9YDglUvyPe5FcI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr1764516wri.300.1659626547026; Thu, 04
 Aug 2022 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220802182502.85562-1-brianrob@linux.microsoft.com>
In-Reply-To: <20220802182502.85562-1-brianrob@linux.microsoft.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 Aug 2022 08:22:14 -0700
Message-ID: <CAP-5=fXY8paDRMcyMokRMXOrrB2CHfY2=HkPsHZrWL_vd_-bWw@mail.gmail.com>
Subject: Re: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump present
To:     Brian Robbins <brianrob@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 2, 2022 at 11:25 AM Brian Robbins
<brianrob@linux.microsoft.com> wrote:
>
> Some processes store jitted code in memfd mappings to avoid having rwx
> mappings.  These processes map the code with a writeable mapping and a
> read-execute mapping.  They write the code using the writeable mapping
> and then unmap the writeable mapping.  All subsequent execution is
> through the read-execute mapping.
>
> perf inject --jit ignores //anon* mappings for each process where a
> jitdump is present because it expects to inject mmap events for each
> jitted code range, and said jitted code ranges will overlap with the
> //anon* mappings.
>
> Ignore /memfd: mappings so that jitted code contained in /memfd:
> mappings is treated the same way as jitted code contained in //anon*
> mappings.
>
> Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/jitdump.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index a23255773c60..335a3c61940b 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -845,8 +845,12 @@ jit_process(struct perf_session *session,
>         if (jit_detect(filename, pid, nsi)) {
>                 nsinfo__put(nsi);
>
> -               // Strip //anon* mmaps if we processed a jitdump for this pid
> -               if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> +               /*
> +                * Strip //anon* and /memfd:* mmaps if we processed a jitdump for this pid
> +                */
> +               if (jit_has_pid(machine, pid) &&
> +                       ((strncmp(filename, "//anon", 6) == 0) ||
> +                        (strncmp(filename, "/memfd:", 7) == 0))

Related to this there is the prctl PR_SET_VMA_ANON_NAME which will
name mapping to start with "[anon:"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/proc.rst#n434
I wonder also we should be checking the pages are executable.

Thanks,
Ian

>                         return 1;
>
>                 return 0;
> --
> 2.25.1
>
