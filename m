Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A12C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD2A61359
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJTMRI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhJTMRG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 08:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634732092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUWgVgfK8Di9WCoIIdZFXjsSmVJN9Z7sAMQZDyCO608=;
        b=bMpL2B0H7SLeBCLMQF13kHU3vEInY6ZnoOIRNAGwtWg+l7gmBL82pROdsgvP0Qz7PRqJNO
        rKUsm06x99m1FXSiLk93yAkEEU1qnBDHfvbIkbmd0xA7Bvv9IgXIXMQAGXq6IH0hKp87Of
        GdZxsXSiAKkk3bhK40aVjjIBEIKIufE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-aVyJCF51OQelrqzUHVHKdQ-1; Wed, 20 Oct 2021 08:14:50 -0400
X-MC-Unique: aVyJCF51OQelrqzUHVHKdQ-1
Received: by mail-ed1-f70.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so20772702edl.5
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KUWgVgfK8Di9WCoIIdZFXjsSmVJN9Z7sAMQZDyCO608=;
        b=OWqM7KlbawIbss+tNR9XhOr6RzdBze10emgOS4xjFrOdVn7Rh40cZeRHzJrUib05b8
         /Ngcce1bbycLXw5u60axAAvXr1sCt3ELUsvBcm73n8PZdyeiti+K1ptQ7DON6yfGfd3I
         3eaq6kDZDIGGoLYhwwznBdb3HtIfsgHDXVEGmr5ouiPJkFcUSoiiIJV82XU2RHyAEw9j
         aIZvtGei04Lp65FTzzc+qxmO0AukDIYR4ePJJ62n0LuhU52GRMaSus/SeMhf5YBCTnWX
         FvtscMB4nhPtytZBtxHNrmUUT9aplG7+icU456jUoaHNb2bat3z+2UEgUe0J4QwqqREk
         o06Q==
X-Gm-Message-State: AOAM533xSIQjVQ6izV2m50eWrCdCk78ytJeev/DnGiWRg7iPGa4u4O4J
        aJBKt9y2A9fACBcssDgZBcpTBIgfGb8GpDvWqbNdni1rzerTT74N27OegeZOK/oZvvKJb5PAskg
        dmGkzlH2T5XNYJuP8Nw5ATV4cJmTVLA==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr62823208edv.384.1634732089307;
        Wed, 20 Oct 2021 05:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvGXDzBa499GtqgVkxT8EH3KVPcdg0tvHnSVuhV5qmQFMp2RDYEgel+o+xymXxNoFYIk8Ngg==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr62823162edv.384.1634732088990;
        Wed, 20 Oct 2021 05:14:48 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id w15sm956515ejb.4.2021.10.20.05.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:14:48 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:14:46 +0200
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
Subject: Re: [PATCH v2 00/22] Start aligning perf test with kunit style
Message-ID: <YXAINnEcHsy450zm@krava>
References: <20211013174604.747276-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 13, 2021 at 10:45:42AM -0700, Ian Rogers wrote:
> Perf test uses its own structs and code layout that differs from kunit
> that was more recently introduced to the kernel. Besides consistency,
> it is hoped that moving in the direction of kunit style will enable
> reuse of infrastructure like test output formatting for continuous
> testing systems. For example:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJx=
qaJk+r-K1YJzPggFDQ@mail.gmail.com/
>=20
> The motivation for this restructuring comes from wanting to be able to
> tag tests with a size:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWmGyuqFKc-EMP3rbmTkjZ3M=
S+YSajGZfeRMc38HS82gw@mail.gmail.com/
> To have more exhaustive and slower running tests.  This isn't
> something kunit currently supports, nor is the execution of python and
> shell tests, but it seems sensible to work on an approach with kunit
> rather to invent a new wheel inside of perf.
>=20
> These initial patches are just refactoring the main test suite
> definitions to be in a more kunit style. Kunit isn't depended upon, it
> is hoped that this can be done in later patches for the sake of
> consistency.
>=20
> v2. Gets to a point of the perf test test suite/case structs being
>     close facsimiles of the kunit ones. It also addresses feedback on
>     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.

hi,
when I compile with DEBUG=3D1 it's ok, but with just make:

[root@krava perf]# ./perf test
Segmentation fault (core dumped)
[root@krava perf]# gdb ./perf
GNU gdb (GDB) Fedora 10.2-4.fc33
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./perf...
(gdb) r test
Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf test
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
__strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
96              VPCMPEQ (%rdi), %ymm0, %ymm1
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-4.=
fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-client-=
0.185-2.fc33.x86_64 elfutils-libelf-0.185-2.fc33.x86_64 elfutils-libs-0.185=
-2.fc33.x86_64 keyutils-libs-1.6.1-1.fc33.x86_64 krb5-libs-1.18.2-31.fc33.x=
86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libca=
p-2.48-2.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libgcc-10.3.1-1.fc33.x=
86_64 libidn2-2.3.2-1.fc33.x86_64 libnghttp2-1.43.0-1.fc33.x86_64 libpsl-0.=
21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 libssh-0.9.6-1.fc33.x86_64 =
libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.0-4.fc33.x86_64 libuuid-2.3=
6.1-1.fc33.x86_64 libxcrypt-4.4.26-2.fc33.x86_64 numactl-libs-2.0.14-1.fc33=
=2Ex86_64 openldap-2.4.50-5.fc33.x86_64 openssl-libs-1.1.1l-2.fc33.x86_64 p=
cre-8.44-2.fc33.x86_64 perl-libs-5.32.1-471.fc33.x86_64 popt-1.18-2.fc33.x8=
6_64 python2.7-2.7.18-15.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs-5.2.=
5-4.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
(gdb) bt
#0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
#1  0x00000000004a3848 in __cmd_test (skiplist=3D0x0, argv=3D0x7fffffffd6c0=
, argc=3D0) at tests/builtin-test.c:150
#2  cmd_test (argc=3D0, argv=3D0x7fffffffd6c0) at tests/builtin-test.c:628
#3  0x00000000004cc47b in run_builtin (p=3Dp@entry=3D0xa7cda8 <commands+552=
>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffd6c0) at perf.c:313
#4  0x00000000004397ae in handle_internal_command (argv=3D0x7fffffffd6c0, a=
rgc=3D1) at perf.c:365
#5  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) at p=
erf.c:409
#6  main (argc=3D1, argv=3D0x7fffffffd6c0) at perf.c:539
(gdb)=20

also during the metric test (in make DEBUG=3D1 build) it runs the
perf bench synthesize and it takes forever ;-)

  89: perf all metrics test=20

that might be another patchset I haven't checked,
but I thought we already agreed not to do that ;-)

jirka

>=20
> v1. Built/tested on x86.
>=20
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
>=20
>  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
>  tools/perf/arch/arm/tests/arch-tests.c        |  18 +-
>  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
>  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
>  tools/perf/arch/arm64/tests/arch-tests.c      |  11 +-
>  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
>  tools/perf/arch/powerpc/tests/arch-tests.c    |  12 +-
>  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
>  tools/perf/arch/x86/tests/arch-tests.c        |  46 +-
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
>  83 files changed, 811 insertions(+), 966 deletions(-)
>=20
> --=20
> 2.33.0.882.g93a45727a2-goog
>=20

