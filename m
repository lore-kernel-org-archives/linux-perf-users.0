Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E27C46467
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjASRLp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASRLn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 12:11:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCA8F6E3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 09:11:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1774201wmc.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57MZ11PIA1Ds77M28f1Y2wzXLAor7dO+jeAnFcbBukk=;
        b=qu1lmXVDcrst171fCXQZj2UYdel55vP051+omjnETwBi9nDrS5EkD891yus1I2vTk+
         1OBBUPISWNef2diCKh6Z7XpON5A9z9FUO9eF6SRJc2+VH4NpWRo5773UrWXC3HDxjC4h
         KOuho9VWEtzmGDR6hjQSGXcr5LwzpA11mJiOhOqz+Bw04VUD5n4X0tyvLkY7S14haVAH
         X4/3P/U1zkQtNNhHD4DmW3JwkljcAS+keSPWx/RhkjJfWfbHHcXjYKc4Hfk0ZD5J0UTM
         M582YqiDTrsSrtb6tThsqYYa3nweMjCgG55w4L84hRfblI1sVmZs44xaUclIeOzUg2bg
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57MZ11PIA1Ds77M28f1Y2wzXLAor7dO+jeAnFcbBukk=;
        b=pVNe535x/mBIC2LK9w8J2cP44mVwZAcci6nmRE2MzmENZSucxgxwITJ4rkg7MHtxYH
         sN1Vs92HW7yKP/f5YXvJMgAmg708AXSpt0Bfh26uWgSrc2uGFoACte9IX+92GLWEqeLo
         00VG9wE4S2ewfb4JDJ4RNDuMuw2CSMX8cCk84SP+gODsREJFpGuhZD9HcDD8CyMkW629
         WfHYAOjai6ln7q5wc9z9FIBNJutdYuHD+FSW1iTGAjZYSDLezigV1M1Xz3bPsCMTDKhX
         siPGM2l9UTOQ6UlDr8afgN8U6wUMs6RY71KDlv38H6dwKAw1UsLpJZLuAxGjpj1RIfY8
         CoHg==
X-Gm-Message-State: AFqh2kqnS7xqM5AcqvGABvYERj/hRN1UmxblNxRr9X21SPPDZ4E8alqw
        LSCAhlQZbzmH+2sO13F59Z9sOFMJLw+ZKW1HkQuWbw==
X-Google-Smtp-Source: AMrXdXtel17eHmu0TyITYUgjLXyvQ3eLG09ijZFyqepS9RqcxDo+jxWgody0tH02XzMHJO+k8KOqAJHzBmgABzur56M=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr548716wms.174.1674148276579; Thu, 19
 Jan 2023 09:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com>
In-Reply-To: <20230116010115.490713-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 09:11:03 -0800
Message-ID: <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote:
>
> libbpf 1.0 was a major change in API. Perf has partially supported
> older libbpf's but an implementation may be:
> ..
>        pr_err("%s: not support, update libbpf\n", __func__);
>        return -ENOTSUP;
> ..
>
> Rather than build a binary that would fail at runtime it is
> preferrential just to build libbpf statically and link against
> that. The static version is in the kernel tools tree and newer than
> 1.0.
>
> These patches change the libbpf test to only pass when at least
> version 1.0 is installed, then remove the conditional build and
> feature logic.
>
> The issue is discussed here:
> https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> perf bpf:
>
> A variant of this fix was added to Linux 6.2 in:
> "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
> https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> This change goes further in removing logic that is now no longer
> necessary.
>
> v2. Rebase now that breakage fix patch is in linus/master.

I missed the:
Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
I believe we are waiting for package maintainer input.

Thanks,
Ian



> Ian Rogers (3):
>   tools build: Pass libbpf feature only if libbpf 1.0+
>   perf build: Remove libbpf pre-1.0 feature tests
>   perf bpf: Remove pre libbpf 1.0 conditional logic
>
>  tools/build/feature/Makefile                  |  7 --
>  .../feature/test-libbpf-bpf_map_create.c      |  8 ---
>  .../test-libbpf-bpf_object__next_map.c        |  8 ---
>  .../test-libbpf-bpf_object__next_program.c    |  8 ---
>  .../build/feature/test-libbpf-bpf_prog_load.c |  9 ---
>  .../test-libbpf-bpf_program__set_insns.c      |  8 ---
>  .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ---
>  .../build/feature/test-libbpf-btf__raw_data.c |  8 ---
>  tools/build/feature/test-libbpf.c             |  4 ++
>  tools/perf/Makefile.config                    | 39 +----------
>  tools/perf/util/bpf-event.c                   | 66 -------------------
>  tools/perf/util/bpf-loader.c                  | 18 -----
>  tools/perf/util/bpf_counter.c                 | 18 -----
>  13 files changed, 5 insertions(+), 204 deletions(-)
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
