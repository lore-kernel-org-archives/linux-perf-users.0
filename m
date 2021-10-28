Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA2C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 23:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEE0610C7
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 23:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJ1XzL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhJ1Xyy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 19:54:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3250C061570
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 16:52:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d63so10405770iof.4
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFqiqlshAA/+AXhynrC3qnv3RK18Pl5KVyjcf+2/e3Q=;
        b=R/NQJOdUUDWGVExQSAu1KrZONfOy30nUMpCkOq5htRKbjjm/SFJwxzuhwTsm9fK3xu
         aJ37uVfkkqDDzsBUGca3iOz+gm4BY5OD89Yogv51bqy8aJpS/+xTbxjPlYTW67+5bcoR
         ddwkH8pgClqOP1eopmTmw5shrYBFb5nQLknwUJHZkprR+8qm3GzESPDy3RZW6VtJQEfd
         rY3ZdLJTH5+MiH3CN9zETybWb4NAf/qkFEv1I7Ye/kUnozqGj/J2v2i06Rq1wLQg/dob
         78ebs2hgGnTFWd82vpn5vF4nQv/1eWs6o5T/pRfsfLtdbl5dtAYKyOf2MP0PQ9+YVBni
         XaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFqiqlshAA/+AXhynrC3qnv3RK18Pl5KVyjcf+2/e3Q=;
        b=NuAg4063PC2OtM/SY3iNgCKZ5QEGI3xYswFVvndX1pIFN9k1PKSXfqtqus42Zkd0SC
         CpCUHpLOO6AtMRajPFcuuIJgCI03p/UcXjBfd8MMmXs5K9+eFBpuCdHA1gUvSfDxlBpp
         9jzeYQPG4y9dg6tf9peY96kIq0xVfHG3CGR54ttNPtFE3w8hRcR64cKA3Qhv3f1qpKnP
         e6hUu8e1jwJRo1/KaY34Gbd2aH0gIIQnFs+CK7A+lZyd5mwGWZIuqtzziii8eFJ7DOax
         A7lwMfZ/ywxYBg0mWZHonU4RoDVNxoF9trUdUJK9gQ9V6pSqytBKU3uj2bskpSunodaP
         muTw==
X-Gm-Message-State: AOAM530QhiySZLK/DmXwErhLt9FG89nzSapepud3+zDCNYgkPaxaJhl5
        Um3LDl/5BMgdU7PGPhHC/WJ3eLA9vae+Q8mRP4TL8Q==
X-Google-Smtp-Source: ABdhPJyo00oFR9ohczYj/G4iuKNXIx/NeovrEqfR518BT/YrOgiJ2A0fRCeN8bQyB2DxKWZPiXBCCr1FtBRVHS0BtF0=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr5683930iow.151.1635465145810;
 Thu, 28 Oct 2021 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com> <YXAINnEcHsy450zm@krava>
 <CAP-5=fVCqisvy8-Obx9TA3Zgi_BJdefYr-g4LCsuy1KKb2xtBQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVCqisvy8-Obx9TA3Zgi_BJdefYr-g4LCsuy1KKb2xtBQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 Oct 2021 16:52:13 -0700
Message-ID: <CAP-5=fXGvBY7hmvCAS7deNAYVxppYj9DZoxstJ93p68BHTSACw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Start aligning perf test with kunit style
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 20, 2021 at 8:51 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 5:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 10:45:42AM -0700, Ian Rogers wrote:
> > > Perf test uses its own structs and code layout that differs from kuni=
t
> > > that was more recently introduced to the kernel. Besides consistency,
> > > it is hoped that moving in the direction of kunit style will enable
> > > reuse of infrastructure like test output formatting for continuous
> > > testing systems. For example:
> > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7N=
ViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > >
> > > The motivation for this restructuring comes from wanting to be able t=
o
> > > tag tests with a size:
> > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWmGyuqFKc-EMP3rbmTk=
jZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > > To have more exhaustive and slower running tests.  This isn't
> > > something kunit currently supports, nor is the execution of python an=
d
> > > shell tests, but it seems sensible to work on an approach with kunit
> > > rather to invent a new wheel inside of perf.
> > >
> > > These initial patches are just refactoring the main test suite
> > > definitions to be in a more kunit style. Kunit isn't depended upon, i=
t
> > > is hoped that this can be done in later patches for the sake of
> > > consistency.
> > >
> > > v2. Gets to a point of the perf test test suite/case structs being
> > >     close facsimiles of the kunit ones. It also addresses feedback on
> > >     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
> >
> > hi,
> > when I compile with DEBUG=3D1 it's ok, but with just make:
> >
> > [root@krava perf]# ./perf test
> > Segmentation fault (core dumped)
> > [root@krava perf]# gdb ./perf
> > GNU gdb (GDB) Fedora 10.2-4.fc33
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-redhat-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://www.gnu.org/software/gdb/bugs/>.
> > Find the GDB manual and other documentation resources online at:
> >     <http://www.gnu.org/software/gdb/documentation/>.
> >
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from ./perf...
> > (gdb) r test
> > Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf test
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
> > 96              VPCMPEQ (%rdi), %ymm0, %ymm1
> > Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.=
8-4.fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-cli=
ent-0.185-2.fc33.x86_64 elfutils-libelf-0.185-2.fc33.x86_64 elfutils-libs-0=
.185-2.fc33.x86_64 keyutils-libs-1.6.1-1.fc33.x86_64 krb5-libs-1.18.2-31.fc=
33.x86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 l=
ibcap-2.48-2.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libgcc-10.3.1-1.fc=
33.x86_64 libidn2-2.3.2-1.fc33.x86_64 libnghttp2-1.43.0-1.fc33.x86_64 libps=
l-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 libssh-0.9.6-1.fc33.x86=
_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.0-4.fc33.x86_64 libuuid=
-2.36.1-1.fc33.x86_64 libxcrypt-4.4.26-2.fc33.x86_64 numactl-libs-2.0.14-1.=
fc33.x86_64 openldap-2.4.50-5.fc33.x86_64 openssl-libs-1.1.1l-2.fc33.x86_64=
 pcre-8.44-2.fc33.x86_64 perl-libs-5.32.1-471.fc33.x86_64 popt-1.18-2.fc33.=
x86_64 python2.7-2.7.18-15.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs-5.=
2.5-4.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
> > (gdb) bt
> > #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
> > #1  0x00000000004a3848 in __cmd_test (skiplist=3D0x0, argv=3D0x7fffffff=
d6c0, argc=3D0) at tests/builtin-test.c:150
> > #2  cmd_test (argc=3D0, argv=3D0x7fffffffd6c0) at tests/builtin-test.c:=
628
> > #3  0x00000000004cc47b in run_builtin (p=3Dp@entry=3D0xa7cda8 <commands=
+552>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffd6c0) at perf.c=
:313
> > #4  0x00000000004397ae in handle_internal_command (argv=3D0x7fffffffd6c=
0, argc=3D1) at perf.c:365
> > #5  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) =
at perf.c:409
> > #6  main (argc=3D1, argv=3D0x7fffffffd6c0) at perf.c:539
> > (gdb)
>
> Thanks, I'll take a look.

I wasn't able to reproduce this, I tried with gcc-10 on each patch
individually, debug disabled and O3. I can send a v3 patch set, but
currently it is just a rebase of v2.

Thanks,
Ian

> > also during the metric test (in make DEBUG=3D1 build) it runs the
> > perf bench synthesize and it takes forever ;-)
> >
> >   89: perf all metrics test
> >
> > that might be another patchset I haven't checked,
> > but I thought we already agreed not to do that ;-)
>
> The PMU test was merged, and that may be the very slow running one.
> The metric tests run with /bin/true, but if they get "not counted" in
> the output they try again with perf bench. It generally runs in
> O(seconds) for me, but maybe it is slower on a loaded machine. There
> may be some middle sized thing between "perf bench" and true that
> gives us enough counts for the tests.
>
> Thanks,
> Ian
>
> > jirka
> >
> > >
> > > v1. Built/tested on x86.
> > >
> > > Ian Rogers (22):
> > >   perf test: Use macro for "suite" declarations
> > >   perf test: Use macro for "suite" definitions
> > >   perf test: Make each test/suite its own struct.
> > >   perf test: Move each test suite struct to its test
> > >   perf test: Rename struct test to test_suite
> > >   perf test: Add helper functions for abstraction.
> > >   perf test: Add test case struct.
> > >   perf test: Add skip reason to test case.
> > >   perf test: Convert pfm tests to use test cases.
> > >   perf test: Convert pmu event tests to test cases.
> > >   perf test: Convert watch point tests to test cases.
> > >   perf test: Convert clang tests to test cases.
> > >   perf test: Convert bpf tests to test cases.
> > >   perf test: Convert llvm tests to test cases.
> > >   perf test: Remove now unused subtest helpers
> > >   perf test: bp tests use test case
> > >   perf test: Convert time to tsc test to test case.
> > >   perf test: Remove non test case style support.
> > >   perf test: BP tests, remove is_supported use
> > >   perf test: TSC test, remove is_supported use
> > >   perf test: Remove is_supported function
> > >   perf test: Remove skip_if_fail
> > >
> > >  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
> > >  tools/perf/arch/arm/tests/arch-tests.c        |  18 +-
> > >  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
> > >  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
> > >  tools/perf/arch/arm64/tests/arch-tests.c      |  11 +-
> > >  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
> > >  tools/perf/arch/powerpc/tests/arch-tests.c    |  12 +-
> > >  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
> > >  tools/perf/arch/x86/tests/arch-tests.c        |  46 +-
> > >  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
> > >  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
> > >  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
> > >  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
> > >  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
> > >  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
> > >  tools/perf/tests/api-io.c                     |   6 +-
> > >  tools/perf/tests/attr.c                       |   4 +-
> > >  tools/perf/tests/backward-ring-buffer.c       |   4 +-
> > >  tools/perf/tests/bitmap.c                     |   4 +-
> > >  tools/perf/tests/bp_account.c                 |  36 +-
> > >  tools/perf/tests/bp_signal.c                  |  34 +-
> > >  tools/perf/tests/bp_signal_overflow.c         |   9 +-
> > >  tools/perf/tests/bpf.c                        |  69 ++-
> > >  tools/perf/tests/builtin-test.c               | 578 ++++++----------=
--
> > >  tools/perf/tests/clang.c                      |  54 +-
> > >  tools/perf/tests/code-reading.c               |   4 +-
> > >  tools/perf/tests/cpumap.c                     |  10 +-
> > >  tools/perf/tests/demangle-java-test.c         |   4 +-
> > >  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
> > >  tools/perf/tests/dlfilter-test.c              |   4 +-
> > >  tools/perf/tests/dso-data.c                   |  10 +-
> > >  tools/perf/tests/dwarf-unwind.c               |   5 +-
> > >  tools/perf/tests/event-times.c                |   4 +-
> > >  tools/perf/tests/event_update.c               |   4 +-
> > >  tools/perf/tests/evsel-roundtrip-name.c       |   5 +-
> > >  tools/perf/tests/evsel-tp-sched.c             |   5 +-
> > >  tools/perf/tests/expand-cgroup.c              |   6 +-
> > >  tools/perf/tests/expr.c                       |   4 +-
> > >  tools/perf/tests/fdarray.c                    |   7 +-
> > >  tools/perf/tests/genelf.c                     |   6 +-
> > >  tools/perf/tests/hists_cumulate.c             |   4 +-
> > >  tools/perf/tests/hists_filter.c               |   4 +-
> > >  tools/perf/tests/hists_link.c                 |   4 +-
> > >  tools/perf/tests/hists_output.c               |   4 +-
> > >  tools/perf/tests/is_printable_array.c         |   4 +-
> > >  tools/perf/tests/keep-tracking.c              |   4 +-
> > >  tools/perf/tests/kmod-path.c                  |   4 +-
> > >  tools/perf/tests/llvm.c                       |  74 ++-
> > >  tools/perf/tests/maps.c                       |   4 +-
> > >  tools/perf/tests/mem.c                        |   4 +-
> > >  tools/perf/tests/mem2node.c                   |   4 +-
> > >  tools/perf/tests/mmap-basic.c                 |   4 +-
> > >  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
> > >  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
> > >  tools/perf/tests/openat-syscall-tp-fields.c   |   5 +-
> > >  tools/perf/tests/openat-syscall.c             |   5 +-
> > >  tools/perf/tests/parse-events.c               |   4 +-
> > >  tools/perf/tests/parse-metric.c               |   4 +-
> > >  tools/perf/tests/parse-no-sample-id-all.c     |   5 +-
> > >  tools/perf/tests/pe-file-parsing.c            |   6 +-
> > >  tools/perf/tests/perf-hooks.c                 |   4 +-
> > >  tools/perf/tests/perf-record.c                |   4 +-
> > >  tools/perf/tests/perf-time-to-tsc.c           |  30 +-
> > >  tools/perf/tests/pfm.c                        |  63 +-
> > >  tools/perf/tests/pmu-events.c                 |  73 +--
> > >  tools/perf/tests/pmu.c                        |   4 +-
> > >  tools/perf/tests/python-use.c                 |   4 +-
> > >  tools/perf/tests/sample-parsing.c             |   4 +-
> > >  tools/perf/tests/sdt.c                        |   6 +-
> > >  tools/perf/tests/stat.c                       |  11 +-
> > >  tools/perf/tests/sw-clock.c                   |   4 +-
> > >  tools/perf/tests/switch-tracking.c            |   4 +-
> > >  tools/perf/tests/task-exit.c                  |   4 +-
> > >  tools/perf/tests/tests.h                      | 238 ++++----
> > >  tools/perf/tests/thread-map.c                 |  10 +-
> > >  tools/perf/tests/thread-maps-share.c          |   4 +-
> > >  tools/perf/tests/time-utils-test.c            |   4 +-
> > >  tools/perf/tests/topology.c                   |   4 +-
> > >  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
> > >  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
> > >  tools/perf/tests/wp.c                         | 122 +---
> > >  tools/perf/util/c++/clang-c.h                 |   8 +-
> > >  tools/perf/util/c++/clang-test.cpp            |   6 +-
> > >  83 files changed, 811 insertions(+), 966 deletions(-)
> > >
> > > --
> > > 2.33.0.882.g93a45727a2-goog
> > >
> >
