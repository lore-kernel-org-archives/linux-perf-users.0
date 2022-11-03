Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC0C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 22:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKCWB4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiKCWBh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 18:01:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2116622B0C
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Nov 2022 15:01:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so4720017wrq.3
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Nov 2022 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ7x0KoatrNsQBAKNEtYf8iZiEhkwWW3bWsu00YDlKM=;
        b=DsyHj/9seydbC1Xxo7NHLggirL7MR+qsEjXxdz/rK1TFa0oehqh2GJzSFlv2KTnLJp
         XGQSTiM99H6QTmPmlxaVaaDhK8NLhBDtaPOzy2ewhv13aA2S1bzkm0ZjdL1MEqBtG9+D
         H1hiNGR/OAIRNqymzFmPq9BOeJ+OaSJWXxe6rYD6uOj9l4hkw7PaO131wKTCuBBVR7XI
         duhdzX4L5gRcDHkdJInRxJNDXiJ51C9hDCjbURkxQp3yTWjgRkGObxvZMLAfNKNQEyRs
         AzSHAZX177OUDrN7tqIKYgqZH1lZoYKSLoCq6c/MRBWyb/oSlFCH21bb6UERbnrNEnzI
         vAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZ7x0KoatrNsQBAKNEtYf8iZiEhkwWW3bWsu00YDlKM=;
        b=Y52P4mF8RS6ag/fYw32dcA9x6SFdTZB1K053eq3s5HpC2Y6NA7c1Bi6jR2GPnED+Tf
         j+syAr6oYxu2XhcHGLb5RJkzg7WrYn6z9zoFlarD8QH37MYTkNKTx5fOoEsrB5yBOlU5
         SZ+8auZxOKpja36b29j8rlClIIxbf8huEI4GqVtAxdz/zPqKVho60E8qnP4+k665RilZ
         iDHueYqF6tD07BKSUEzQxtEiCjB1EBlGBixgTe9Ob/7Z6UIhZjrx2hrgI+ars7E8Omxi
         nM3HQNYTTnAE3yEZCe1LRZco/o4UYakYEtDf6gRUO8G4nGCs58Vko6r1Hxq7GT9SZk9p
         8rfA==
X-Gm-Message-State: ACrzQf2ht0QwvzPxeqmcyS8nWKklEUrOD2H1M18MxGwqj4hkwsIl1U7q
        WuGkWUM0poVAE1QqN20JQaJlVo5XYkgHIWHAcSKGGA==
X-Google-Smtp-Source: AMsMyM5ViidOdfiQuz4+SdhtzHErfLcA/uiwq42gdb2Bgm6MRwqiigt7O8jg82SV7KgcYnGV277Wu/MzMKYntcn1Wss=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr19849157wrb.300.1667512893374; Thu, 03
 Nov 2022 15:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com> <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org> <Y2Pgz7luG77Wr+Ci@kernel.org>
 <Y2Pj0KVbbw9rMcPH@kernel.org> <CAP-5=fXkM52E5VvX9s2CfvF8ckQvcbSm8N_7BCfhW3dyuH7YUg@mail.gmail.com>
 <Y2QcgdJNXE/bVZvk@kernel.org> <Y2Q0NSeoEqwUztFe@kernel.org>
In-Reply-To: <Y2Q0NSeoEqwUztFe@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Nov 2022 15:01:21 -0700
Message-ID: <CAP-5=fUcawweX-n2nmGg5+ZEo5nG7QuRN7yyVtz-FmUGctrEjw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf trace: 5sec fix libbpf 1.0+ compatibility
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 3, 2022 at 2:35 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> With this:
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d3d3c13a9f25b55c..067a6e56eeacc9fc 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1239,7 +1239,7 @@ includedir = $(abspath $(prefix)/$(includedir_relative))
>  mandir = share/man
>  infodir = share/info
>  perfexecdir = libexec/perf-core
> -perf_include_dir = lib/perf/include
> +perf_include_dir = /usr/include
>  perf_examples_dir = lib/perf/examples
>  sharedir = $(prefix)/share
>  template_dir = share/perf-core/templates
> diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> index 13c72fd602c307e4..98a2731c011339ba 100644
> --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> @@ -17,8 +17,9 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
> -#include <stdbool.h>
> -#include <sys/socket.h>
> +
> +typedef char bool;
> +typedef int pid_t;
>
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
> @@ -94,6 +95,30 @@ struct pids_filtered {
>         __uint(max_entries, 64);
>  } pids_filtered SEC(".maps");
>
> +/*
> + * Desired design of maximum size and alignment (see RFC2553)
> + */
> +#define _K_SS_MAXSIZE   128     /* Implementation specific max size */
> +
> +typedef unsigned short sa_family_t;
> +
> +/*
> + * The definition uses anonymous union and struct in order to control the
> + * default alignment.
> + */
> +struct sockaddr_storage {
> +        union {
> +                struct {
> +                        sa_family_t    ss_family; /* address family */
> +                        /* Following field(s) are implementation specific */
> +                        char __data[_K_SS_MAXSIZE - sizeof(unsigned short)];
> +                                /* space to achieve desired size, */
> +                                /* _SS_MAXSIZE value minus size of ss_family */
> +                };
> +                void *__align; /* implementation specific desired alignment */
> +        };
> +};
> +
>  struct augmented_args_payload {
>         struct syscall_enter_args args;
>         union {
> diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
> index 3e296c0c53d7d8e2..e4872c48a484f218 100644
> --- a/tools/perf/examples/bpf/empty.c
> +++ b/tools/perf/examples/bpf/empty.c
> @@ -7,6 +7,6 @@ struct syscall_enter_args;
>  SEC("raw_syscalls:sys_enter")
>  int sys_enter(struct syscall_enter_args *args)
>  {
> -       return 0;
> +       return 1;
>  }
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 2dc7970074196ca8..a5cac85783d8711f 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -495,7 +495,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
>
>         snprintf(linux_version_code_str, sizeof(linux_version_code_str),
>                  "0x%x", kernel_version);
> -       if (asprintf(&perf_bpf_include_opts, "-I%s/bpf", perf_include_dir) < 0)
> +       if (asprintf(&perf_bpf_include_opts, "-I%s/", perf_include_dir) < 0)
>                 goto errout;
>         force_set_env("NR_CPUS", nr_cpus_avail_str);
>         force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
>
>
> The connect calls gets served, tomorrow, if you don't beat me I'll apply
> the series after adding these minimal changes so that we have this
> working with libbpf 1.0 and then we can move from there, with a switch
> to a BPF skel, simplest things first, then deal with faults at pointer
> payload copy, which is another avenue, AFAIK with solutions already.

So I was trying to be clean and not redefine too much. My clang
command line was:

clang -target bpf -O2 -g -c -I/usr/include/x86_64-linux-gnu
-D__NR_CPUS__=16 -D__x86_64__=1

It'd be nice to just drop the need for __NR_CPUS__ and have it be
dynamic, the skeleton approach would require this. Not sure how to
workaround the x86 define and path :-/ Perhaps send out your changes
for review and I can look at and test them.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> [root@quaco perf]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,connect* --max-events 10
>      0.000 ( 0.074 ms): fetchmail/175578 connect(fd: 3, uservaddr: { .family: LOCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) = 0
>      0.397 ( 0.011 ms): systemd-resolv/973 connect(fd: 23, uservaddr: { .family: INET, port: 53, addr: 127.0.0.1 }, addrlen: 16) = 0
>      0.532 ( 0.006 ms): systemd-resolv/973 connect(fd: 24, uservaddr: { .family: INET, port: 53, addr: 127.0.0.1 }, addrlen: 16) = 0
>      0.910 ( 0.007 ms): systemd-resolv/973 connect(fd: 23, uservaddr: { .family: INET, port: 53, addr: 127.0.0.1 }, addrlen: 16) = 0
>      0.962 ( 0.003 ms): systemd-resolv/973 connect(fd: 24, uservaddr: { .family: INET, port: 53, addr: 127.0.0.1 }, addrlen: 16) = 0
>      1.337 ( 0.007 ms): fetchmail/175578 connect(fd: 3, uservaddr: { .family: INET, port: 0, addr: 67.195.176.151 }, addrlen: 16) = 0
>      1.348 ( 0.014 ms): fetchmail/175578 connect(fd: 3, uservaddr: { .family: UNSPEC }, addrlen: 16)           = 0
>      1.363 ( 0.003 ms): fetchmail/175578 connect(fd: 3, uservaddr: { .family: INET, port: 0, addr: 76.13.33.33 }, addrlen: 16) = 0
>      1.527 ( 0.014 ms): fetchmail/175578 connect(fd: 3, uservaddr: { .family: LOCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) = 0
>      1.726 ( 0.008 ms): systemd-resolv/973 connect(fd: 23, uservaddr: { .family: INET, port: 53, addr: 127.0.0.1 }, addrlen: 16) = 0
> [root@quaco perf]#
