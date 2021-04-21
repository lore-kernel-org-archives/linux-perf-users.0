Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D1C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Apr 2021 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44913601FD
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Apr 2021 19:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhDUTyl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhDUTyl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Apr 2021 15:54:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65ACC06174A;
        Wed, 21 Apr 2021 12:54:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b38so7951107ljf.5;
        Wed, 21 Apr 2021 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaGZMfKcpaY2SI/xlccaXDE8VdSfkM0I1wpRK4kkOfo=;
        b=mX4k7AcAzC9Nzs+tc4eTqCFngYebglnEkS3JoOV5Jja/R1kfi79G/StPFXEMeRWo/q
         lED8RhMqMBTXmRIY6qUZLe86ASloZZ4f9BqdBocSovV/Y/zR08Nq9eyDYhiH0b098K5i
         YwDuPwiuqovAzGz+ogEiZYExfaZwOyxunY+8H+ZTeOyQtM/3o6N2Gjjvg4l+dA49ilWA
         WGabMW+fk5o5wNqiDvYi5qPCjv5nbTqTnygRmIH3y26x4LOr2G0vsHVUEzpb0BaHvjTR
         WdNHhE8MThYnXnu6+/IYvJYMfMTlrLpAPcOgjjOmHvi4XbSvoCAM6rgsKRCR/ucXzO3d
         8YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaGZMfKcpaY2SI/xlccaXDE8VdSfkM0I1wpRK4kkOfo=;
        b=Lo/bt0efiGe5YqG+MDd5WLa7GhNjXpXeKFWsWR/9litXoGyO7M8aKQ092Q1FIDvBv6
         fJBvaPDkPHLQWZMnz0aXCKS8E9kkeBI4kvyA0rSoWmaUiv1HqRkGo3LiJLYzh62R07rZ
         Scc0TeG/1bCRZx9wH2MMFYwUUCZ6I+aSgc8+nksx6YCPdrcz/CRFgb2UDoRjdoRA6wGW
         mrLd6v25TW1Po4fjFEena7/qyywQts9iv4rEnoZcTBxtfMLkUYJXZCaN+EzO/CuycPu0
         EHbL0FRTnlqPxxsiJPztXaqskmKeauhgt5oRDSQQkJarSBBRSIaPBK2AYbCceSJH3Mr4
         aOHg==
X-Gm-Message-State: AOAM530BxJEXWVYeTFSCOW/KAs3rbuAzbY0/Cp90/IUwBt9D/m2XjbO3
        zH56ew5auUYPvy0yjs8lV3ln48FwJqrkS3WAx2o=
X-Google-Smtp-Source: ABdhPJzqzxlULjo6C0I1dEIRsSnu3iSCqmDiiYM14qyIvYpgS9ZCM5Bh3IrrUQeGdoQi6Xjd7pqu6KD4Jn4acMaJSnM=
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr5744845ljc.23.1619034846218;
 Wed, 21 Apr 2021 12:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210421120400.2126433-1-tmricht@linux.ibm.com>
In-Reply-To: <20210421120400.2126433-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 22 Apr 2021 04:53:55 +0900
Message-ID: <CAM9d7ci4MG1m-ebQQmGaD96ssznsmbCofz1xva2kDHygX1qStQ@mail.gmail.com>
Subject: Re: [PATCH] [PING] perf ftrace: Command fails on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Alexander Schmidt <alexschm@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Wed, Apr 21, 2021 at 10:03 PM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Command 'perf ftrace -v -- ls' fails in s390 (at least 5.12.0rc6).
>
> The root cause is a missing pointer dereference which causes an
> array element address to be used as PID.
>
> Fix this by extracting the PID.
>
> Output before:
>   # ./perf ftrace -v -- ls
>   function_graph tracer is used
>   write '-263732416' to tracing/set_ftrace_pid failed: Invalid argument
>   failed to set ftrace pid
>   #
>
> Output after:
>    ./perf ftrace -v -- ls
>    function_graph tracer is used
>    # tracer: function_graph
>    #
>    # CPU  DURATION                  FUNCTION CALLS
>    # |     |   |                     |   |   |   |
>    4)               |  rcu_read_lock_sched_held() {
>    4)   0.552 us    |    rcu_lockdep_current_cpu_online();
>    4)   6.124 us    |  }
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Alexander Schmidt <alexschm@de.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d49448a1060c..87cb11a7a3ee 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -289,7 +289,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
>
>         for (i = 0; i < perf_thread_map__nr(ftrace->evlist->core.threads); i++) {
>                 scnprintf(buf, sizeof(buf), "%d",
> -                         ftrace->evlist->core.threads->map[i]);
> +                         perf_thread_map__pid(ftrace->evlist->core.threads, i));
>                 if (append_tracing_file("set_ftrace_pid", buf) < 0)
>                         return -1;
>         }
> --
> 2.30.2
>
