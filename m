Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E77C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Feb 2022 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiBXQxn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiBXQxn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Feb 2022 11:53:43 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180313C251
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 08:53:13 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g6so654696ybe.12
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYjH0epb4EAp0Ra1CbQhm5083zOxgobdxBaH7fLLKYg=;
        b=dgs97y9RhSRXAaApuoZVmQPVv6JCjrAu9KRz12WUdWjcFd91uiuF1/0iNpccMYdmcu
         K4+Hq7fURiB2hjcBr4bkE9AIwHzMnivTE3TYqZmoV1tanAy/jw0eELipKu/ebENRcCgK
         BBXyLNAyu3rzMybB6MNi5JLY0KzTONjZqxZflfVNn5oycmQpN3R3kn5oi8epl/ZlJBNZ
         MpsGQCs4oZrAoDhXVQJ4OQV9r6lNEXeB3I/vswL95b7yYnu/ydiKITjXIN9WHkacJyeA
         9uPFhoXGZF4JnBdi6gaFa57r/uXv7Bjejrq8JQCjQ2t1wxtrG23EXBLm6b6bCKIToTft
         tFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYjH0epb4EAp0Ra1CbQhm5083zOxgobdxBaH7fLLKYg=;
        b=YgvG5K1LZ77T+LeFIFqI5NUubpthxH3ACvc3oPDz2MTdIm8ZxMgCKEsB5D0sWcVaUZ
         3do49PlpXnoEbVHYRCDhhnt/69H4bZc5Zc4Yha9aOnLl4N/G57kVyqMo+i7kl9neLfYW
         c6sYTXKfLxfy3a8wphjsKbVSsI2VySARLWiZ6Sa1T8OXvATX8caQqrfRa8NMjmA82eG1
         9vIB/Tr0ZC5Gs1ZvLHa4jtSpLzDKZt0WpdjAkhq+rq6sKyxJxUsSYXQeT4Rl211dxfou
         81nLTz7dBufWCw4SL2UVPcgF405g0x/FH/f0n04kOF1a4Dd49mOflSZjqeAv3HHBaTWa
         oJFg==
X-Gm-Message-State: AOAM5324ZYEqmTSq30hesFm9SwLwJCsTEiGFymONwpqAdHCGV59/aT8F
        +rOAFpalvLDQvQJ5xdhmdWlELfg5bDgHCnQoBX9k/w==
X-Google-Smtp-Source: ABdhPJyTsvn8tEVAfPSmwz6IzRq2zI8IRly6DlY4nsjIfz75T2tAKPnRncGsWgdJzMyQSo//bwAQG50eObpDmz5XIWA=
X-Received: by 2002:a05:6902:562:b0:610:f96a:49e4 with SMTP id
 a2-20020a056902056200b00610f96a49e4mr3237374ybt.611.1645721592235; Thu, 24
 Feb 2022 08:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20220224163711.185308-1-tz.stoyanov@gmail.com>
In-Reply-To: <20220224163711.185308-1-tz.stoyanov@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Feb 2022 08:52:59 -0800
Message-ID: <CAP-5=fVsQ2kGTvCDmovLWR00SDKQz635ftVmLphZcMM82sGKHA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] trace-cruncher: Initial support for perf
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     y.karadz@gmail.com, acme@kernel.org, olsajiri@gmail.com,
        rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 24, 2022 at 8:37 AM Tzvetomir Stoyanov (VMware)
<tz.stoyanov@gmail.com> wrote:
>
> Two major functionalities are introduced by this patch set:
>  - VMA <-> function name resolving, using bfd library.

Just wanted to point out that perf is often not built against libbfd:
Please build perf against libbfd -
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815

where long running addr2line is now the best performance solution:
https://lore.kernel.org/linux-perf-users/20210909112202.1947499-1-tonyg@leastfixedpoint.com/

The comment from the bug:
perf can link against libbfd if available, but the result is
undistributable as they are licenced under GPL v2 and v3+
respectively.

Thanks,
Ian

>  - Support for Linux kernel perf framework, using perf library.
>
> This is still a work in progress. Depends on this patch, not yet merged:
> https://lore.kernel.org/linux-perf-users/20220221102628.43904-1-tz.stoyanov@gmail.com/
>
> Tzvetomir Stoyanov (VMware) (3):
>   trace-cruncher: Logic for resolving address to function name
>   trace-cruncher: Support for perf
>   trace-cruncher: perf example
>
>  examples/perf_sampling.py |  51 +++
>  setup.py                  |   9 +-
>  src/perfpy-utils.c        | 699 ++++++++++++++++++++++++++++++
>  src/perfpy-utils.h        |  41 ++
>  src/perfpy.c              | 141 ++++++
>  src/trace-obj-debug.c     | 873 ++++++++++++++++++++++++++++++++++++++
>  src/trace-obj-debug.h     |  52 +++
>  7 files changed, 1865 insertions(+), 1 deletion(-)
>  create mode 100755 examples/perf_sampling.py
>  create mode 100644 src/perfpy-utils.c
>  create mode 100644 src/perfpy-utils.h
>  create mode 100644 src/perfpy.c
>  create mode 100644 src/trace-obj-debug.c
>  create mode 100644 src/trace-obj-debug.h
>
> --
> 2.34.1
>
