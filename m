Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D995C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F0361177
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Oct 2021 12:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhJ2MVo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231510AbhJ2MVi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Oct 2021 08:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635509947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=73h99hJWE5OrS3nYMF4MG/2Jws/54jgP43Y5v4A9xgo=;
        b=AbjsF7itlpX+SOUk+oecb8f7GHea7icinKd8PyRNdWTPr91zUceQLhsYC5Bwu1ieBFX/jC
        38KaVZXuqdMomwsP+2/xGlxQoHx0HyY1oOryUD7S7xwLqYqxbqIM26EL6asR76Eclvy2YF
        xQAHH3uvCPj7nq2wuMWbd6CiVlYI9/4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-8ykFcOQ4MrmwMNUibHSbXw-1; Fri, 29 Oct 2021 08:19:05 -0400
X-MC-Unique: 8ykFcOQ4MrmwMNUibHSbXw-1
Received: by mail-wm1-f71.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso1346375wmb.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Oct 2021 05:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=73h99hJWE5OrS3nYMF4MG/2Jws/54jgP43Y5v4A9xgo=;
        b=Zohy0X3HWxkAo86dekMWLQPJoFkcAFkNrJ0MqQ0RVDsgwct7JYLN+ABuXR7Cvz6qoI
         cWQmk9NcPe5xYCvG/H4kKo5//GXRlxtwTduTYZJIifYYkB7ZDkCUFfYznRFylbGBxJog
         CjBTknmvN/SjYAZ9+xch/Or+Ck5+/unCcqi7IQBBBN5iS5ltLviN19kqv9Ue16A7N6yx
         RvFChSVvO4VKZqN3Ix18uADib2lSJ0LaGJvibS10CrN86Buda7ZkqQlqQTN8OvzGIWFS
         EBTF9z7RMDucp1JzApC/LCFPt8IjTyGcvDYWpSJqWskBiuYK0wJtYP3AEeyL7eivL2ox
         cKBg==
X-Gm-Message-State: AOAM531YLinUkl2avXtKtfP+aDc+m3dU5Le00ClgqpUTtxxKWh8V440j
        0U7E5V98xX5s1E25yjp8/yjmxrvQszUPjC+vUcdsEEHS3xkkgBJdVcR+CI0ZxOwvfrj4Odj+xQz
        Pdek92P2zLxLuYyFeyYeIA7e/GcyAGQ==
X-Received: by 2002:a1c:2047:: with SMTP id g68mr10196791wmg.181.1635509944734;
        Fri, 29 Oct 2021 05:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIgpvSw0ZswIlVG9WaM8erUI+2qIw/k8U6+b3m3QP5N8rEzXJ+qTLTUwF2TuFs9XYqef7Q0g==
X-Received: by 2002:a1c:2047:: with SMTP id g68mr10196771wmg.181.1635509944541;
        Fri, 29 Oct 2021 05:19:04 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n10sm7150280wmq.24.2021.10.29.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:19:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 14:19:02 +0200
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
Message-ID: <YXvmtrBKV7eawT7h@krava>
References: <20211013174604.747276-1-irogers@google.com>
 <YXAINnEcHsy450zm@krava>
 <CAP-5=fVCqisvy8-Obx9TA3Zgi_BJdefYr-g4LCsuy1KKb2xtBQ@mail.gmail.com>
 <CAP-5=fXGvBY7hmvCAS7deNAYVxppYj9DZoxstJ93p68BHTSACw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP-5=fXGvBY7hmvCAS7deNAYVxppYj9DZoxstJ93p68BHTSACw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 28, 2021 at 04:52:13PM -0700, Ian Rogers wrote:
> On Wed, Oct 20, 2021 at 8:51 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 5:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Oct 13, 2021 at 10:45:42AM -0700, Ian Rogers wrote:
> > > > Perf test uses its own structs and code layout that differs from ku=
nit
> > > > that was more recently introduced to the kernel. Besides consistenc=
y,
> > > > it is hoped that moving in the direction of kunit style will enable
> > > > reuse of infrastructure like test output formatting for continuous
> > > > testing systems. For example:
> > > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c=
7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > > >
> > > > The motivation for this restructuring comes from wanting to be able=
 to
> > > > tag tests with a size:
> > > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWmGyuqFKc-EMP3rbm=
TkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > > > To have more exhaustive and slower running tests.  This isn't
> > > > something kunit currently supports, nor is the execution of python =
and
> > > > shell tests, but it seems sensible to work on an approach with kunit
> > > > rather to invent a new wheel inside of perf.
> > > >
> > > > These initial patches are just refactoring the main test suite
> > > > definitions to be in a more kunit style. Kunit isn't depended upon,=
 it
> > > > is hoped that this can be done in later patches for the sake of
> > > > consistency.
> > > >
> > > > v2. Gets to a point of the perf test test suite/case structs being
> > > >     close facsimiles of the kunit ones. It also addresses feedback =
on
> > > >     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
> > >
> > > hi,
> > > when I compile with DEBUG=3D1 it's ok, but with just make:
> > >
> > > [root@krava perf]# ./perf test
> > > Segmentation fault (core dumped)
> > > [root@krava perf]# gdb ./perf
> > > GNU gdb (GDB) Fedora 10.2-4.fc33
> > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/g=
pl.html>
> > > This is free software: you are free to change and redistribute it.
> > > There is NO WARRANTY, to the extent permitted by law.
> > > Type "show copying" and "show warranty" for details.
> > > This GDB was configured as "x86_64-redhat-linux-gnu".
> > > Type "show configuration" for configuration details.
> > > For bug reporting instructions, please see:
> > > <https://www.gnu.org/software/gdb/bugs/>.
> > > Find the GDB manual and other documentation resources online at:
> > >     <http://www.gnu.org/software/gdb/documentation/>.
> > >
> > > For help, type "help".
> > > Type "apropos word" to search for commands related to "word"...
> > > Reading symbols from ./perf...
> > > (gdb) r test
> > > Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf test
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
> > > 96              VPCMPEQ (%rdi), %ymm0, %ymm1
> > > Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.=
0.8-4.fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-c=
lient-0.185-2.fc33.x86_64 elfutils-libelf-0.185-2.fc33.x86_64 elfutils-libs=
-0.185-2.fc33.x86_64 keyutils-libs-1.6.1-1.fc33.x86_64 krb5-libs-1.18.2-31.=
fc33.x86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64=
 libcap-2.48-2.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libgcc-10.3.1-1.=
fc33.x86_64 libidn2-2.3.2-1.fc33.x86_64 libnghttp2-1.43.0-1.fc33.x86_64 lib=
psl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 libssh-0.9.6-1.fc33.x=
86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.0-4.fc33.x86_64 libuu=
id-2.36.1-1.fc33.x86_64 libxcrypt-4.4.26-2.fc33.x86_64 numactl-libs-2.0.14-=
1.fc33.x86_64 openldap-2.4.50-5.fc33.x86_64 openssl-libs-1.1.1l-2.fc33.x86_=
64 pcre-8.44-2.fc33.x86_64 perl-libs-5.32.1-471.fc33.x86_64 popt-1.18-2.fc3=
3.x86_64 python2.7-2.7.18-15.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs-=
5.2.5-4.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
> > > (gdb) bt
> > > #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
> > > #1  0x00000000004a3848 in __cmd_test (skiplist=3D0x0, argv=3D0x7fffff=
ffd6c0, argc=3D0) at tests/builtin-test.c:150
> > > #2  cmd_test (argc=3D0, argv=3D0x7fffffffd6c0) at tests/builtin-test.=
c:628
> > > #3  0x00000000004cc47b in run_builtin (p=3Dp@entry=3D0xa7cda8 <comman=
ds+552>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffd6c0) at perf=
=2Ec:313
> > > #4  0x00000000004397ae in handle_internal_command (argv=3D0x7fffffffd=
6c0, argc=3D1) at perf.c:365
> > > #5  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>=
) at perf.c:409
> > > #6  main (argc=3D1, argv=3D0x7fffffffd6c0) at perf.c:539
> > > (gdb)
> >
> > Thanks, I'll take a look.
>=20
> I wasn't able to reproduce this, I tried with gcc-10 on each patch
> individually, debug disabled and O3. I can send a v3 patch set, but
> currently it is just a rebase of v2.

ok, I'll try to debug that if I can still reproduce

jirka

