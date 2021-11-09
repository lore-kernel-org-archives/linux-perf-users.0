Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AAFC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53BF61181
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhKILLD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhKILLC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 06:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636456096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pkc8K4HqCcx+nTHDI7TmhWF3CU0oAPH7TenNLXQ96Sc=;
        b=iqKmpdoJRzPGR8zYABFTtoV5OvwIOsIKFzzKQhITggvN297XvP0RHC6gzbffmNeD4o4RoG
        kmCqvurSlyx5PED/NF//1qyszdC611Yqo6MX7PngrK6h7Nca+PCZXvJCQOidI7sR8v4M4b
        BCclPCWJqnFM9+RXsPifNhUp9pE0IPg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-q5qQag9sNe20BXm9rykgsg-1; Tue, 09 Nov 2021 06:08:16 -0500
X-MC-Unique: q5qQag9sNe20BXm9rykgsg-1
Received: by mail-qt1-f200.google.com with SMTP id i5-20020ac85c05000000b002ae12b76e64so1536965qti.6
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 03:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pkc8K4HqCcx+nTHDI7TmhWF3CU0oAPH7TenNLXQ96Sc=;
        b=7wcdFec6zT4tZENLu69YoETTtFzpndGAGCUP2bKNWEBjhw+B5qZhNvhLL1iUQ81s+i
         HlnXUcYZCpXIQXbfTPqUlM3Kbb/hv/ZaMyUsFgLMRjSkEf8Qq+1icVMs4S6SKiSU11DO
         ro5fxTTBYywZdjBFuLzCg2c9eqkHNVBOQe99djufxy2JkhI6IWYtZBXVBRzfxmTtqMCj
         PPgMWPatLQTVmrJWMcYGGZlIVgnUAHzeQ5jI+gz8tz37ZZbcoPqIX33hmxccxkFKlMhc
         +OgHPNoLBBGUubHHPskb9FEW3aa4TP7XjgkVyUTH24ylsovJg0iPTg+2SnXr2C37hFXo
         YZ9g==
X-Gm-Message-State: AOAM5307MwnEz0GvyjHqaHr5hdHCvUjMRn3WoRr2ftL0w0QE8mTvwXg0
        XmLaIyvJd7E8FvkIMs3TdgQigdd72VGKERGdWj+e17VAmamDml7DqSBpuZyERrZbJ72+Hep7oub
        6XzP37XD9IG63uI112nH+lzjuwi4yxQ==
X-Received: by 2002:ac8:488b:: with SMTP id i11mr7241934qtq.208.1636456094941;
        Tue, 09 Nov 2021 03:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyY4WfjyYrMNT2PPauhfi4YQ1oY71oouiuOkN0d5MnKk6vhJCBmcEDqkxCQyLCdzkvd/HrEQ==
X-Received: by 2002:ac8:488b:: with SMTP id i11mr7241905qtq.208.1636456094711;
        Tue, 09 Nov 2021 03:08:14 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id bk35sm58303qkb.32.2021.11.09.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:08:14 -0800 (PST)
Date:   Tue, 9 Nov 2021 12:08:09 +0100
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>, eranian@google.com
Subject: Re: [PATCH v3 00/22] Start aligning perf test with kunit style
Message-ID: <YYpWmb/QZGnQQDJi@krava>
References: <20211104064208.3156807-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 03, 2021 at 11:41:46PM -0700, Ian Rogers wrote:
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
> 
> v3. Fixes a missing null and out of bound skip reason load detected by
>     address sanitizer. This issue was reported by Jiri Olsa
>     <jolsa@redhat.com> with an address sanitizer reproduction provided
>     by Sohaib Mohamed <sohaib.amhmd@gmail.com>.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v2. Gets to a point of the perf test test suite/case structs being
>     close facsimiles of the kunit ones. It also addresses feedback on
>     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
> 
> v1. Built/tested on x86.
> 
> Ian Rogers (22):
>   perf test: Use macro for "suite" declarations
>   perf test: Use macro for "suite" definitions
>   perf test: Make each test/suite its own struct.
>   perf test: Move each test suite struct to its test
>   perf test: Rename struct test to test_suite
>   perf test: Add helper functions for abstraction.
>   perf test: Add test case struct.
>   perf test: Add skip reason to test case.
>   perf test: Convert pfm tests to use test cases.
>   perf test: Convert pmu event tests to test cases.
>   perf test: Convert watch point tests to test cases.
>   perf test: Convert clang tests to test cases.
>   perf test: Convert bpf tests to test cases.
>   perf test: Convert llvm tests to test cases.
>   perf test: Remove now unused subtest helpers
>   perf test: bp tests use test case
>   perf test: Convert time to tsc test to test case.
>   perf test: Remove non test case style support.
>   perf test: BP tests, remove is_supported use
>   perf test: TSC test, remove is_supported use
>   perf test: Remove is_supported function
>   perf test: Remove skip_if_fail
> 
>  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
>  tools/perf/arch/arm/tests/arch-tests.c        |  18 +-
>  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
>  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
>  tools/perf/arch/arm64/tests/arch-tests.c      |  11 +-
>  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
>  tools/perf/arch/powerpc/tests/arch-tests.c    |  12 +-
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
>  tools/perf/tests/bp_account.c                 |  36 +-
>  tools/perf/tests/bp_signal.c                  |  34 +-
>  tools/perf/tests/bp_signal_overflow.c         |   9 +-
>  tools/perf/tests/bpf.c                        |  69 ++-
>  tools/perf/tests/builtin-test.c               | 578 ++++++------------
>  tools/perf/tests/clang.c                      |  54 +-
>  tools/perf/tests/code-reading.c               |   4 +-
>  tools/perf/tests/cpumap.c                     |  10 +-
>  tools/perf/tests/demangle-java-test.c         |   4 +-
>  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
>  tools/perf/tests/dlfilter-test.c              |   4 +-
>  tools/perf/tests/dso-data.c                   |  10 +-
>  tools/perf/tests/dwarf-unwind.c               |   5 +-
>  tools/perf/tests/event-times.c                |   4 +-
>  tools/perf/tests/event_update.c               |   4 +-
>  tools/perf/tests/evsel-roundtrip-name.c       |   5 +-
>  tools/perf/tests/evsel-tp-sched.c             |   5 +-
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
>  tools/perf/tests/llvm.c                       |  74 ++-
>  tools/perf/tests/maps.c                       |   4 +-
>  tools/perf/tests/mem.c                        |   4 +-
>  tools/perf/tests/mem2node.c                   |   4 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   5 +-
>  tools/perf/tests/openat-syscall.c             |   5 +-
>  tools/perf/tests/parse-events.c               |   4 +-
>  tools/perf/tests/parse-metric.c               |   4 +-
>  tools/perf/tests/parse-no-sample-id-all.c     |   5 +-
>  tools/perf/tests/pe-file-parsing.c            |   6 +-
>  tools/perf/tests/perf-hooks.c                 |   4 +-
>  tools/perf/tests/perf-record.c                |   4 +-
>  tools/perf/tests/perf-time-to-tsc.c           |  30 +-
>  tools/perf/tests/pfm.c                        |  63 +-
>  tools/perf/tests/pmu-events.c                 |  73 +--
>  tools/perf/tests/pmu.c                        |   4 +-
>  tools/perf/tests/python-use.c                 |   4 +-
>  tools/perf/tests/sample-parsing.c             |   4 +-
>  tools/perf/tests/sdt.c                        |   6 +-
>  tools/perf/tests/stat.c                       |  11 +-
>  tools/perf/tests/sw-clock.c                   |   4 +-
>  tools/perf/tests/switch-tracking.c            |   4 +-
>  tools/perf/tests/task-exit.c                  |   4 +-
>  tools/perf/tests/tests.h                      | 238 ++++----
>  tools/perf/tests/thread-map.c                 |  10 +-
>  tools/perf/tests/thread-maps-share.c          |   4 +-
>  tools/perf/tests/time-utils-test.c            |   4 +-
>  tools/perf/tests/topology.c                   |   4 +-
>  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
>  tools/perf/tests/wp.c                         | 122 +---
>  tools/perf/util/c++/clang-c.h                 |   8 +-
>  tools/perf/util/c++/clang-test.cpp            |   6 +-
>  83 files changed, 812 insertions(+), 966 deletions(-)
> 
> -- 
> 2.33.1.1089.g2158813163f-goog
> 

