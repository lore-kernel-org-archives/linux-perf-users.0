Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70FC6FD1F
	for <linux-perf-users@archiver.kernel.org>; Sat, 25 Mar 2023 04:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCYEb6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Mar 2023 00:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCYEbq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:46 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCED1815A;
        Fri, 24 Mar 2023 21:31:38 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id bl9so1621648iob.8;
        Fri, 24 Mar 2023 21:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718697; x=1682310697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QshTmLJTyi9qX5SkDwCDlbE2dc7E+l9twlijdylPf7o=;
        b=OnCYEvN1YI3GsOsk0XM62ikt1MBIBl6V8sEJQuUpvAkN7jpNiNwhxbn1TQW89y+VHh
         /BdrE2zZWD0ZC35xgaAnVwM5PVZdYbX9gUNk0FXuym2A2NxcKwHKaIApMQdJfiR4Vf7V
         ac+keFtxkN1lri9lDc62P5Ho1+njXsm2RPPVm6UM0lO3dOmvaRfMEOvqnrpGBqAIN5PQ
         y2VZdPmKlDG7lGlPC+I/U6UlkwUFmIT6ase0iR0Iky4pHPpIj7E9nBmstxFa8OLrdnPH
         wSoSFOT4pivMZ8QkM622OD7C9tOuQQROtax+HSgxGBVr6S89CYSTFSXDClvR9WDIyJH6
         HHKw==
X-Gm-Message-State: AO0yUKVZeFlDdQGlZqFdgYAqu5eh3seMAnIeJWNzjZf+Q6KMVmxpFrwS
        3vcHC24U1akZLUgEYRbtxrlpb+DtWHUNgHHqnUM=
X-Google-Smtp-Source: AK7set/a+tfEGjCk1N5v7IBtI1Fa/ix1K4irok/GjHIxTi9wNU/SfHsMc8CVp74dsAqB/u/cWAiiO2++qzfKweapa2s=
X-Received: by 2002:a6b:6a14:0:b0:751:dcc3:3279 with SMTP id
 x20-20020a6b6a14000000b00751dcc33279mr3448370iog.14.1679718697147; Fri, 24
 Mar 2023 21:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <1679381821-22736-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1679381821-22736-1-git-send-email-yangtiezhu@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Mar 2023 21:31:25 -0700
Message-ID: <CAM9d7chTUDnrwrOnOS-CDBjNnuyLcSx05agDS4S7DgJ2Sj_9vw@mail.gmail.com>
Subject: Re: [PATCH] perf bench syscall: Add fork syscall benchmark
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Mon, Mar 20, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> This is a follow up patch for the execve bench which is actually
> fork + execve, it makes sense to add the fork syscall benchmark
> to compare the execve part precisely.
>
> Some archs have no __NR_fork definition which is used only as a
> check condition to call test_fork(), let us just define it as -1
> to avoid build error.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h |  4 ++--
>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
>  tools/perf/bench/bench.h                    |  1 +
>  tools/perf/bench/syscall.c                  | 35 +++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c                  |  1 +
>  5 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
> index 2712d5e..b8ddfc4 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __NR_execve
> -#define __NR_execve 11
> +#ifndef __NR_fork
> +#define __NR_fork 2
>  #endif
>  #ifndef __NR_getppid
>  #define __NR_getppid 64
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> index a6f7fe8..f70d2cad 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -1,4 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __NR_fork
> +#define __NR_fork 57
> +#endif
>  #ifndef __NR_execve
>  #define __NR_execve 59
>  #endif
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index e438931..edfc257 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -23,6 +23,7 @@ int bench_sched_messaging(int argc, const char **argv);
>  int bench_sched_pipe(int argc, const char **argv);
>  int bench_syscall_basic(int argc, const char **argv);
>  int bench_syscall_getpgid(int argc, const char **argv);
> +int bench_syscall_fork(int argc, const char **argv);
>  int bench_syscall_execve(int argc, const char **argv);
>  int bench_mem_memcpy(int argc, const char **argv);
>  int bench_mem_memset(int argc, const char **argv);
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> index fe79f7f..ea4dfc07 100644
> --- a/tools/perf/bench/syscall.c
> +++ b/tools/perf/bench/syscall.c
> @@ -18,6 +18,10 @@
>  #include <unistd.h>
>  #include <stdlib.h>
>
> +#ifndef __NR_fork
> +#define __NR_fork -1
> +#endif
> +
>  #define LOOPS_DEFAULT 10000000
>  static int loops = LOOPS_DEFAULT;
>
> @@ -31,6 +35,23 @@ static const char * const bench_syscall_usage[] = {
>         NULL
>  };
>
> +static void test_fork(void)
> +{
> +       pid_t pid = fork();
> +
> +       if (pid < 0) {
> +               fprintf(stderr, "fork failed\n");
> +               exit(1);
> +       } else if (pid == 0) {
> +               exit(0);
> +       } else {
> +               if (waitpid(pid, NULL, 0) < 0) {
> +                       fprintf(stderr, "waitpid failed\n");
> +                       exit(1);
> +               }
> +       }
> +}
> +
>  static void test_execve(void)
>  {
>         const char *pathname = "/bin/true";
> @@ -71,6 +92,12 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>                 case __NR_getpgid:
>                         getpgid(0);
>                         break;
> +               case __NR_fork:
> +                       test_fork();
> +                       /* Only loop 10000 times to save time */
> +                       if (i == 10000)
> +                               loops = 10000;
> +                       break;
>                 case __NR_execve:
>                         test_execve();
>                         /* Only loop 10000 times to save time */
> @@ -92,6 +119,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>         case __NR_getpgid:
>                 name = "getpgid()";
>                 break;
> +       case __NR_fork:
> +               name = "fork()";
> +               break;
>         case __NR_execve:
>                 name = "execve()";
>                 break;
> @@ -143,6 +173,11 @@ int bench_syscall_getpgid(int argc, const char **argv)
>         return bench_syscall_common(argc, argv, __NR_getpgid);
>  }
>
> +int bench_syscall_fork(int argc, const char **argv)
> +{
> +       return bench_syscall_common(argc, argv, __NR_fork);
> +}
> +
>  int bench_syscall_execve(int argc, const char **argv)
>  {
>         return bench_syscall_common(argc, argv, __NR_execve);
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 814e9af..d0fcc3c 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
>  static struct bench syscall_benchmarks[] = {
>         { "basic",      "Benchmark for basic getppid(2) calls",         bench_syscall_basic     },
>         { "getpgid",    "Benchmark for getpgid(2) calls",               bench_syscall_getpgid   },
> +       { "fork",       "Benchmark for fork(2) calls",                  bench_syscall_fork      },
>         { "execve",     "Benchmark for execve(2) calls",                bench_syscall_execve    },
>         { "all",        "Run all syscall benchmarks",                   NULL                    },
>         { NULL,         NULL,                                           NULL                    },
> --
> 2.1.0
>
