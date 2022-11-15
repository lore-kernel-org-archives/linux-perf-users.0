Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB0EC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 19:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKOTNM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKOTNL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 14:13:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE62303FC
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 11:13:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a14so26019945wru.5
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVmIK2KbmJcILQt5r8JiDxSMthBbVHuraQkf2M+r6zU=;
        b=glxVraLDq6ErCS0YWPINbeqZZiQ1hA5c9A2gN06m1BOXrHnUSMdK9e2OvJty/UbiDB
         bHoNHG1ugIncwjk4bkc0mkhFtPEFIWItDdWxd8tN5gamuZfZH4zu8oJcJyLeeHq2KrT4
         LUNaPxVGvHzY3a5yuPIthrIgp5AXd31R/JQ98XWTvxorSP2y1ym421vOQnpmwgq2Fv5l
         N1RR9tK/aQrWqeDH7xKupWbtyUsS6yQpPC1XmOOCvxehqKnmwDQY4FeQlCmZmlF0CZt4
         yaHgYJUPrG5+KHlXYs6knDSJTQQ3XYX0fNfE/9pJkUwr0a5ztJGryqzVvcJTBvE1IZO2
         b7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVmIK2KbmJcILQt5r8JiDxSMthBbVHuraQkf2M+r6zU=;
        b=s0Ve0EwcfdZY8bqFk39fSOUixDw1X8BuOGRgQjWZUVSxS6bH5FWxrenUtcUrxtb1Ho
         81gnlZ/WJPeVJp7i4/ieXQS1mVLXfL6tSdve08pT0uONwgwc8WlLGc7aFyyxRhZJe4SO
         6zJhvKPF5euXj7Y9z/icLm+021vhyAX+uSwHHMfQL7yhXrSRkHpK3IZoaIqdYUgFt+Yd
         PCHiwZyNKUCqgJMC9tS7ROI1R0CTCiaTRa36pKPR2rgo5WsmQaGHB5t4AL29FI9Tt6Mz
         /neeC+T+UBLnaL3mjRANEC/ogox7qJCnfMP5cBQS1bYZ6KO3wNfYou6Eob42pgFsrke8
         vAaQ==
X-Gm-Message-State: ANoB5pnLaZNygxaZLJtf3svbrvK4pCdPzhWjX3POE2FBvu92EtBigOgf
        VHV3aj8VluLPCzzXjeabNKEOgN6SYZ2zfwpgz9O0zg==
X-Google-Smtp-Source: AA0mqf5rwMM4FiNjOSbh6rvc1Af5bUo/EbW3oitQGTe1Umpso6zA++OkrRp2d50BRAyXtPU4Fe66/Ls4Jf6XqmRMB6A=
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id
 j1-20020a056000124100b00236d8f8b87dmr11346690wrx.343.1668539587668; Tue, 15
 Nov 2022 11:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com> <Y247VY99skmc1wRk@leoy-huanghe.lan>
In-Reply-To: <Y247VY99skmc1wRk@leoy-huanghe.lan>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 11:12:55 -0800
Message-ID: <CAP-5=fX-Qa8y0yq5a2T=_=W59_4F-VPPHZpP4Vk3ZjnDRO8uOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Fix perf trace libbpf 1.0+ compatibility
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Fri, Nov 11, 2022 at 4:09 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Ian, Arnaldo,
>
> On Wed, Nov 02, 2022 at 09:54:30PM -0700, Ian Rogers wrote:
> > Perf trace can augment system calls with a BPF program passed as an
> > event. The BPF code for this lives in examples. This patch fixes the
> > example code to not used deprecated/removed APIs in libbpf. As libbpf
> > has similar header files to tools/perf/include/bpf the code is
> > transitioned to use the more standard libbpf code and the perf BPF
> > header files removed.
>
> I think you missed to update the code examples/bpf/sys_enter_openat.c,
> either you could remove it (since it's duplicate with
> augmented_raw_syscalls.c), or we should apply below fixing:

Arnaldo, what do you think?

Thanks,
Ian

> From f30af3b43060e482c54e113cbe90223173c69abd Mon Sep 17 00:00:00 2001
> From: Leo Yan <leo.yan@linaro.org>
> Date: Fri, 11 Nov 2022 12:02:24 +0000
> Subject: [PATCH] perf trace: sys_enter_openat.c fix libbpf 1.0+ compatibility
>
> Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
> headers.
>
> With fixing:
>
>   # ./perf trace -e examples/bpf/sys_enter_openat.c
>   0.000 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.596 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.832 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>   1.864 irqbalance/1025 syscalls:sys_enter_openat(AT_FDCWD, "", O_RDONLY)
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/examples/bpf/sys_enter_openat.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
> index c4481c390d23..8edfa7c147d1 100644
> --- a/tools/perf/examples/bpf/sys_enter_openat.c
> +++ b/tools/perf/examples/bpf/sys_enter_openat.c
> @@ -14,7 +14,9 @@
>   * the return value.
>   */
>
> -#include <bpf/bpf.h>
> +#include <linux/bpf.h>
> +#include <linux/limits.h>
> +#include <bpf/bpf_helpers.h>
>
>  struct syscall_enter_openat_args {
>         unsigned long long unused;
> @@ -25,9 +27,10 @@ struct syscall_enter_openat_args {
>         long               mode;
>  };
>
> -int syscall_enter(openat)(struct syscall_enter_openat_args *args)
> +SEC("syscalls:sys_enter_openat")
> +int syscall_enter_openat(struct syscall_enter_openat_args *args)
>  {
>         return 1;
>  }
>
> -license(GPL);
> +char _license[] SEC("license") = "GPL";
