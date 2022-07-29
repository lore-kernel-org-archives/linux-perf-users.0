Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE8C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 15:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiG2PDi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiG2PDh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 11:03:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0FB1FE
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 08:03:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso2617554wmm.5
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLTFSrskQrti9akgcOE2SqCBtE6dVVYg8MzlEVx8mCs=;
        b=SlwYP/S8pe1GMNTiked6ky3NS1yrgExEkZu0Y4j7YN6x2OhA+OeI37Kx7HWzkKa9ds
         5v5UupwW/7vJK+vGaFxDxry5KzteHtDQwBNDfhX2Z6XOBwCvyw9ViwX8VPRyphWdtTe7
         afge5SLEXkQP4ZBglaMZoSQT2b1B+pwX7zf5OVCYwzabnCl8ImN986DiPx6c8kpJ3xIn
         r5zpFZp3jSxzIhv2/v0qy8pCdufW4YfZQ7Uze170ByRX41HPON8jI/7iZcpFzta6Xnxa
         T9TfyNytf8tuwA8hsKIKmWr3En/2Q3kodzhm6bY3qRGx8sS3yq5s3H5iFR4wkMBydYqC
         hUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLTFSrskQrti9akgcOE2SqCBtE6dVVYg8MzlEVx8mCs=;
        b=UuWS+FTiHGankce0q605SIV3jCdr+2QFJWBPAvLLVWz1sNGxw9M68VK/6XJ2XrH9Pd
         3bOAEsHlq/w5u9qNl6tSwLDiN4kTq+s0iRtkJr3iZdHvkeBjBHAoEaDR/i0bhpeyVTh4
         4qYCeRYn4puYPNNVR7sO2K6BAc3W5lXF2DqQ+u1QY1U0749Sz9SbYjPp/UFP6WAN1e6T
         6aT/LIMbyuaI3+sCb6RoMxUty8KbKbvPTh0oSfJb37LAE+4GIT8O1dL2JJ7THqBQyJiD
         TBorc1vJvfEAUIpda06gDF0VWqhZBtOk+1IX7a9Txbalupdtnv6CFN87v9HqGmOdGA30
         8X4Q==
X-Gm-Message-State: AJIora+96B8+8Sq8Cinm/1dIxs4QtPk941uNGh4tb/y+qt5gax0yLuew
        Uvy9RsC6UpT6OQP6p1hLiw5faA5SFCqDkytWgReJaQ==
X-Google-Smtp-Source: AGRyM1u+s0zFw26fIdlAqeg6KuhGnaVQCCpNaNugIgWimXq9XGquAIiHIepjuQQNDb1Z/3Imc1kWxJV5JOsvNFW5hPE=
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id
 u18-20020a05600c19d200b003a32cdbcc02mr3128443wmq.182.1659107012876; Fri, 29
 Jul 2022 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 08:03:20 -0700
Message-ID: <CAP-5=fUJ2KaxLXwUhyTtAZhwQ=M=QEv4_tP6y5CU08tf_uKAnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add perf stat default events for hybrid machines
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 20, 2022 at 11:56 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> The patch series is to clean up the existing perf stat default and support
> the perf metrics Topdown for the p-core PMU in the perf stat default. The
> first 4 patches are the clean-up patch and fixing the "--detailed" issue.
> The last patch adds support for the perf metrics Topdown, the perf metrics
> Topdown support for e-core PMU will be implemented later separately.
>
> Kan Liang (4):
>   perf stat: Revert "perf stat: Add default hybrid events"
>   perf evsel: Add arch_evsel__hw_name()
>   perf evlist: Always use arch_evlist__add_default_attrs()
>   perf x86 evlist: Add default hybrid events for perf stat
>
> Zhengjun Xing (1):
>   perf stat: Add topdown metrics in the default perf stat on the hybrid
>     machine

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
>  tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
>  tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  1 +
>  tools/perf/builtin-stat.c          | 50 ++++-------------------
>  tools/perf/util/evlist.c           | 11 +++--
>  tools/perf/util/evlist.h           |  9 ++++-
>  tools/perf/util/evsel.c            |  7 +++-
>  tools/perf/util/evsel.h            |  1 +
>  tools/perf/util/stat-display.c     |  2 +-
>  tools/perf/util/topdown.c          |  7 ++++
>  tools/perf/util/topdown.h          |  3 +-
>  12 files changed, 166 insertions(+), 60 deletions(-)
>
> --
> 2.25.1
>
