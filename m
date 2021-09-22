Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA55C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BD061019
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhIVV4q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238162AbhIVV4q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632347715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqS74/naZJE5TFiYTVoASdxvH6bMfJJ7gf6aZytwa8E=;
        b=fOcb+AyR4lfukS1E79gsJxdN2f2MGbsnXK12g1ns4NSAUS65HXn2szX2w/F0p1ureyla8W
        Vkw6gsCUfZIGXT4lKIDcsDaOXnDv9uuEIrxQRgFmbC7JLWn1jNQZosoqQs9CjFmFQ9VJsK
        DUKP7fGsh7zrY5jnDdQ5Mm2fRYtmx1E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-bFw_uAxJPVKSsSwSmPgTBw-1; Wed, 22 Sep 2021 17:55:14 -0400
X-MC-Unique: bFw_uAxJPVKSsSwSmPgTBw-1
Received: by mail-wr1-f71.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso3357918wra.23
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 14:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EqS74/naZJE5TFiYTVoASdxvH6bMfJJ7gf6aZytwa8E=;
        b=ubGumWM0nhDMZDXxc7Hs/06I6ZucbaH9QO9IOPQn9uJnadgRpJaxmbNqubyevmFLda
         mslndsLJ7bCMbWTbMSEO+jaMGK8ERh2rY6JflfarXCG8q4ESLu+BAcg5puGIf5F9hcL1
         vJedMJgDHTTf6fuptWNQJcckcmMkC/kIJPcVc04uoKx1aVIYCeSJXVmStkGnAp1yKyEZ
         y0rRbmwTTRgoKrdwxAOC5zYu+AwTTznRVfuaAGM7abhjLtv0BsvUJ7VayP4usAV9Bio4
         dSz46hU2PIdpJ6QbbuYgvR3dUhq/aLcxUkkNNmmwivou1/nUiCwThd1Xloo/jj6IGxNh
         KzLA==
X-Gm-Message-State: AOAM5337LsbfAk995Mc+7JUuJzDRKM+1HsHgOISaqEwZelTPDe7PU/Ub
        oqLDmL9XIw6LEKLNYgqOmrUnJMj6q26660I1GyEYnQThD1iPHNN9K95z4rlIpal4hEZrpXEui46
        xmK39Wg/Ka2jmU1FxaHUfW5AijwD2oQ==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr1129275wml.167.1632347713146;
        Wed, 22 Sep 2021 14:55:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVCyOa1n0vvgmvEeAypXrQOVKWHUlZSyrtCl4h3iBY0nCmoSj6j0xWQ0v4gqILM3CSE2nzWg==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr1129262wml.167.1632347712965;
        Wed, 22 Sep 2021 14:55:12 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id o12sm2825631wms.15.2021.09.22.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:55:12 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:55:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [RFC PATCH 0/5] Start aligning perf test with kunit style
Message-ID: <YUumPj7Oa1HvVGW/@krava>
References: <20210922081959.390059-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922081959.390059-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 01:19:53AM -0700, Ian Rogers wrote:
> Perf test uses its own structs and code layout that differs from kunit
> that was more recently introduced to the kernel. Besides consistency,
> it is hoped that moving in the direction of kunit style will enable
> reuse of infrastructure like test output formatting for continuous
> testing systems. For example:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> 
> The motivation for this restructuring comes from wanting to be able to
> tag tests with a size:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> To have more exhaustive and slower running tests.  This isn't
> something kunit currently supports, nor is the execution of python and
> shell tests, but it seems sensible to work on an approach with kunit
> rather to invent a new wheel inside of perf.
> 
> These initial patches are just refactoring the main test suite
> definitions to be in a more kunit style. Kunit isn't depended upon, it
> is hoped that this can be done in later patches for the sake of
> consistency.

seems good.. how far away from kunit is the code now?

> 
> v1. Built/tested on x86.
> 
> Ian Rogers (5):
>   perf test: Use macro for "suite" declarations
>   perf test: Use macro for "suite" definitions
>   perf test: Make each test/suite its own struct.
>   perf test: Move each test suite struct to its test
>   perf test: Rename struct test to test_suite
> 
>  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
>  tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
>  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
>  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
>  tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
>  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
>  tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-

I can run/test this on ppc/arm if you don't have any

jirka

>  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
>  tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
>  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
>  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
>  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
>  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
>  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
>  tools/perf/tests/api-io.c                     |   6 +-
>  tools/perf/tests/attr.c                       |   4 +-
>  tools/perf/tests/backward-ring-buffer.c       |   4 +-
>  tools/perf/tests/bitmap.c                     |   4 +-
>  tools/perf/tests/bp_account.c                 |  10 +-
>  tools/perf/tests/bp_signal.c                  |   8 +-
>  tools/perf/tests/bp_signal_overflow.c         |   8 +-
>  tools/perf/tests/bpf.c                        |  22 +-
>  tools/perf/tests/builtin-test.c               | 441 ++++--------------
>  tools/perf/tests/clang.c                      |  18 +-
>  tools/perf/tests/code-reading.c               |   4 +-
>  tools/perf/tests/cpumap.c                     |  10 +-
>  tools/perf/tests/demangle-java-test.c         |   4 +-
>  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
>  tools/perf/tests/dlfilter-test.c              |   4 +-
>  tools/perf/tests/dso-data.c                   |  10 +-
>  tools/perf/tests/dwarf-unwind.c               |   2 +-
>  tools/perf/tests/event-times.c                |   4 +-
>  tools/perf/tests/event_update.c               |   4 +-
>  tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
>  tools/perf/tests/evsel-tp-sched.c             |   4 +-
>  tools/perf/tests/expand-cgroup.c              |   6 +-
>  tools/perf/tests/expr.c                       |   4 +-
>  tools/perf/tests/fdarray.c                    |   7 +-
>  tools/perf/tests/genelf.c                     |   6 +-
>  tools/perf/tests/hists_cumulate.c             |   4 +-
>  tools/perf/tests/hists_filter.c               |   4 +-
>  tools/perf/tests/hists_link.c                 |   4 +-
>  tools/perf/tests/hists_output.c               |   4 +-
>  tools/perf/tests/is_printable_array.c         |   4 +-
>  tools/perf/tests/keep-tracking.c              |   4 +-
>  tools/perf/tests/kmod-path.c                  |   4 +-
>  tools/perf/tests/llvm.c                       |  22 +-
>  tools/perf/tests/maps.c                       |   4 +-
>  tools/perf/tests/mem.c                        |   4 +-
>  tools/perf/tests/mem2node.c                   |   4 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
>  tools/perf/tests/openat-syscall.c             |   5 +-
>  tools/perf/tests/parse-events.c               |   4 +-
>  tools/perf/tests/parse-metric.c               |   4 +-
>  tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
>  tools/perf/tests/pe-file-parsing.c            |   6 +-
>  tools/perf/tests/perf-hooks.c                 |   4 +-
>  tools/perf/tests/perf-record.c                |   4 +-
>  tools/perf/tests/perf-time-to-tsc.c           |  10 +-
>  tools/perf/tests/pfm.c                        |  16 +-
>  tools/perf/tests/pmu-events.c                 |  19 +-
>  tools/perf/tests/pmu.c                        |   4 +-
>  tools/perf/tests/python-use.c                 |   4 +-
>  tools/perf/tests/sample-parsing.c             |   4 +-
>  tools/perf/tests/sdt.c                        |   6 +-
>  tools/perf/tests/stat.c                       |  10 +-
>  tools/perf/tests/sw-clock.c                   |   4 +-
>  tools/perf/tests/switch-tracking.c            |   4 +-
>  tools/perf/tests/task-exit.c                  |   4 +-
>  tools/perf/tests/tests.h                      | 179 ++++---
>  tools/perf/tests/thread-map.c                 |  10 +-
>  tools/perf/tests/thread-maps-share.c          |   4 +-
>  tools/perf/tests/time-utils-test.c            |   4 +-
>  tools/perf/tests/topology.c                   |   4 +-
>  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
>  tools/perf/tests/wp.c                         |  22 +-
>  81 files changed, 543 insertions(+), 618 deletions(-)
> 
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

