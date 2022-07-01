Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF7EC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Jul 2022 23:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiGAXGV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGAXGU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Jul 2022 19:06:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814936EEB1
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Jul 2022 16:06:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so4620665wmr.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Jul 2022 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7xp4nnQTL9CDa5RM9fRJT3jD+dPM5rIbsC2OObud0M=;
        b=LblUYuIy5SXHWSx5d4ANlDn7+H26GGlOrNWd1X0wQLsV+nBm26Fm3YCX7N+9EIQ44J
         AiC2WSMAe0Xs6L9RJuoPj4h3zObFsiGadgy/a/d1V6mX3FfBbi5EXE1Y7ZY1hrVpJE76
         8AIQ7nwP7EYx4PrdvWqTKFREo6VPPG8PCbuyrL0IwafyjXPfif7fGg7rmkt3iPIHzc7L
         ZI3DQFuc8xdNvzAjE/H2bW41SmNh1GFpAxw7/KULFIfVRn82gmidRAj6Ieva9zKNjyZx
         f3jl0gpe9v2PwYcDkdSL9BJX/SVKAMTFcvjjZ2ZqJsWqT03zn6vQsAWLXaeRi6PWanHH
         YCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7xp4nnQTL9CDa5RM9fRJT3jD+dPM5rIbsC2OObud0M=;
        b=0fdiFFvmVyXfjNodhKu1DCAMHweJpImVYK5g0mI7KP3+fataDZgYoG6COKjxZ3iB7j
         iHe3VyGC1y0unUY0B+77NGm8n4c7ms0cgXF7LxKhl5PBkqNO0BwNqTb61r/yooMohY7c
         gClyfU+XFBt3xTX3qdg+Zilk9Ql93GzyIzx2dPC8cdNm1g6vEnO8qd34ZcCd0hXHhn8e
         qtKy27RZcp0bg9+sklgvzw8sZWCW9dn6CpEpIjBDjMIbLjOa3VmCxCiN0ME7uyijaE+J
         oWuf8DTWFZOf1x/9+itUEes8Udx6u2H++uqYgX3QtuMNtSLEnsjqrUkOqwT5j+tAodCA
         1Lig==
X-Gm-Message-State: AJIora89mJKWq9o/7wRVTa46Bg4DQB5gMVQ+iKbKpKwEX7epqP3vrjrA
        YIZab74DBPG5ciDafHF+jmZ6Z8hFYvFrqxNjCVUsWAJqIEA=
X-Google-Smtp-Source: AGRyM1v4TG9T22ukbtdPxW1GOczpQEwVEWtguEGORPaZuQzTrHnF+xTTs3JjDEuz4C20xf6u4bp+0AjHNi+ZzN6vvWA=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr18301843wmq.174.1656716777822; Fri, 01
 Jul 2022 16:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220701205458.985106-1-namhyung@kernel.org>
In-Reply-To: <20220701205458.985106-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Jul 2022 16:06:05 -0700
Message-ID: <CAP-5=fVbp4QT2J4Ek9e+1XL1HEMrUrYgNXptcWqyCHZxWbVAGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Don't sort the task scan result from /proc
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 1, 2022 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should not sort the result as procfs already returns a proper
> ordering of tasks.  Actually sorting the order caused problems that it
> doesn't guararantee to process the main thread first.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 27acdc5e5723..a068f42833c3 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -754,7 +754,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>         snprintf(filename, sizeof(filename), "%s/proc/%d/task",
>                  machine->root_dir, pid);
>
> -       n = scandir(filename, &dirent, filter_task, alphasort);
> +       n = scandir(filename, &dirent, filter_task, NULL);
>         if (n < 0)
>                 return n;
>
> @@ -987,7 +987,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>                 return 0;
>
>         snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
> -       n = scandir(proc_path, &dirent, filter_task, alphasort);
> +       n = scandir(proc_path, &dirent, filter_task, NULL);
>         if (n < 0)
>                 return err;
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
