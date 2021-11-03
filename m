Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBEC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F0E6112E
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 19:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhKCTSP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhKCTSO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Nov 2021 15:18:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB7C061714
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 12:15:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d70so3165901iof.7
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zvN8Wx3cerlS5kndbX104hKLH3gFaS6msaaX+fbSIaA=;
        b=sn/PLQIBmfI06w/WOGfSjv9Kw13j3swiXnsEhqgCbHbteMIUbCOen4UyZk0AH6wWkN
         1IEIFq5KLrsfJ2vFFB03I0IsLZJ3JX06eusxHqxIXlIbbh2gBJB2ILDk+KUJQFyAmexf
         uRPiqcTti8SZbHRBQPMCfp5tI16Y+UuyXeiTdP9hdG8LLMUPgUqQcmP1Afl5ijYH6dlw
         Tt3gYdC0zn2cteKEyCdxxc0CMv7mUfSu0TAW93Y5J894XHqwomsaHv3udZdWMj48Agpx
         d/4Pw/YNf6ct+1vVYr0RpRpk64LD/B6UHvCDqr9fdH/d82D9Jr1G1E1FR+vJlY2JQGMM
         gc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zvN8Wx3cerlS5kndbX104hKLH3gFaS6msaaX+fbSIaA=;
        b=BgFZNUgo9cDsH6crgXB0r4j/uyIOqFA1o302I9IcbNI5o54QqnLJg5+o7MRZ6v8Yu0
         yovaubo5bbiomoN9OolJhR454NyxeG691tQXbMFvw25wPLyOvN2CCPRcJqgt+5n7BG7Y
         XUiDwdjZfcsCj1nE2Pra6ZFiRm+MrRn0TX5PIslxQFLzlrpEpR2RiDFW7l7XNGioYVTu
         1BrpqwsNowL4A8I8svcv6temlVubqvEzG4JizAGqfUysjK2JrJNogFuk06IlHALJLAfJ
         O4zy8xGvNMznr2VNihxZsofYuHBeEEJVz9ZAZn5ExWx6ee/2PK8opurRDdPq8ZEDe6I5
         4PPw==
X-Gm-Message-State: AOAM530y3x7tdQ/dJPu0i9DLC1ChbmH4sj2w5trRvm4ltIXKQlFNG0mG
        FJ6lBqNmsfe7X1z63pLdkqG4Bj4e7DrBKaFi/OMdkg==
X-Google-Smtp-Source: ABdhPJxudaSAmjjQlGS3xDDYyZVrcKdBo6oXuNr/UTLcuIJ4p6l1tEQvNCUjaVtRr9WFf7YDMvYVtdF5ogAif4lLXsA=
X-Received: by 2002:a05:6602:2d88:: with SMTP id k8mr22838002iow.18.1635966937329;
 Wed, 03 Nov 2021 12:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com> <YXAINnEcHsy450zm@krava>
 <CAP-5=fVCqisvy8-Obx9TA3Zgi_BJdefYr-g4LCsuy1KKb2xtBQ@mail.gmail.com>
 <CAP-5=fXGvBY7hmvCAS7deNAYVxppYj9DZoxstJ93p68BHTSACw@mail.gmail.com> <YXvmtrBKV7eawT7h@krava>
In-Reply-To: <YXvmtrBKV7eawT7h@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Nov 2021 12:15:23 -0700
Message-ID: <CAP-5=fWLY2cF97P0oiMpnLzKjBJ-tC_jRyRNicSHjx6m73KrWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Start aligning perf test with kunit style
To:     Jiri Olsa <jolsa@redhat.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
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

On Fri, Oct 29, 2021 at 5:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Oct 28, 2021 at 04:52:13PM -0700, Ian Rogers wrote:
> > On Wed, Oct 20, 2021 at 8:51 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 5:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 13, 2021 at 10:45:42AM -0700, Ian Rogers wrote:
> > > > > Perf test uses its own structs and code layout that differs from =
kunit
> > > > > that was more recently introduced to the kernel. Besides consiste=
ncy,
> > > > > it is hoped that moving in the direction of kunit style will enab=
le
> > > > > reuse of infrastructure like test output formatting for continuou=
s
> > > > > testing systems. For example:
> > > > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn=
6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > > > >
> > > > > The motivation for this restructuring comes from wanting to be ab=
le to
> > > > > tag tests with a size:
> > > > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWmGyuqFKc-EMP3r=
bmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > > > > To have more exhaustive and slower running tests.  This isn't
> > > > > something kunit currently supports, nor is the execution of pytho=
n and
> > > > > shell tests, but it seems sensible to work on an approach with ku=
nit
> > > > > rather to invent a new wheel inside of perf.
> > > > >
> > > > > These initial patches are just refactoring the main test suite
> > > > > definitions to be in a more kunit style. Kunit isn't depended upo=
n, it
> > > > > is hoped that this can be done in later patches for the sake of
> > > > > consistency.
> > > > >
> > > > > v2. Gets to a point of the perf test test suite/case structs bein=
g
> > > > >     close facsimiles of the kunit ones. It also addresses feedbac=
k on
> > > > >     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
> > > >
> > > > hi,
> > > > when I compile with DEBUG=3D1 it's ok, but with just make:
> > > >
> > > > [root@krava perf]# ./perf test
> > > > Segmentation fault (core dumped)
> > > > [root@krava perf]# gdb ./perf
> > > > GNU gdb (GDB) Fedora 10.2-4.fc33
> > > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses=
/gpl.html>
> > > > This is free software: you are free to change and redistribute it.
> > > > There is NO WARRANTY, to the extent permitted by law.
> > > > Type "show copying" and "show warranty" for details.
> > > > This GDB was configured as "x86_64-redhat-linux-gnu".
> > > > Type "show configuration" for configuration details.
> > > > For bug reporting instructions, please see:
> > > > <https://www.gnu.org/software/gdb/bugs/>.
> > > > Find the GDB manual and other documentation resources online at:
> > > >     <http://www.gnu.org/software/gdb/documentation/>.
> > > >
> > > > For help, type "help".
> > > > Type "apropos word" to search for commands related to "word"...
> > > > Reading symbols from ./perf...
> > > > (gdb) r test
> > > > Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf tes=
t
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > >
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:96
> > > > 96              VPCMPEQ (%rdi), %ymm0, %ymm1
> > > > Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-=
1.0.8-4.fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod=
-client-0.185-2.fc33.x86_64 elfutils-libelf-0.185-2.fc33.x86_64 elfutils-li=
bs-0.185-2.fc33.x86_64 keyutils-libs-1.6.1-1.fc33.x86_64 krb5-libs-1.18.2-3=
1.fc33.x86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_=
64 libcap-2.48-2.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libgcc-10.3.1-=
1.fc33.x86_64 libidn2-2.3.2-1.fc33.x86_64 libnghttp2-1.43.0-1.fc33.x86_64 l=
ibpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_64 libssh-0.9.6-1.fc33=
.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.4.0-4.fc33.x86_64 lib=
uuid-2.36.1-1.fc33.x86_64 libxcrypt-4.4.26-2.fc33.x86_64 numactl-libs-2.0.1=
4-1.fc33.x86_64 openldap-2.4.50-5.fc33.x86_64 openssl-libs-1.1.1l-2.fc33.x8=
6_64 pcre-8.44-2.fc33.x86_64 perl-libs-5.32.1-471.fc33.x86_64 popt-1.18-2.f=
c33.x86_64 python2.7-2.7.18-15.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-lib=
s-5.2.5-4.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
> > > > (gdb) bt
> > > > #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:9=
6
> > > > #1  0x00000000004a3848 in __cmd_test (skiplist=3D0x0, argv=3D0x7fff=
ffffd6c0, argc=3D0) at tests/builtin-test.c:150
> > > > #2  cmd_test (argc=3D0, argv=3D0x7fffffffd6c0) at tests/builtin-tes=
t.c:628
> > > > #3  0x00000000004cc47b in run_builtin (p=3Dp@entry=3D0xa7cda8 <comm=
ands+552>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffd6c0) at pe=
rf.c:313
> > > > #4  0x00000000004397ae in handle_internal_command (argv=3D0x7ffffff=
fd6c0, argc=3D1) at perf.c:365
> > > > #5  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointe=
r>) at perf.c:409
> > > > #6  main (argc=3D1, argv=3D0x7fffffffd6c0) at perf.c:539
> > > > (gdb)
> > >
> > > Thanks, I'll take a look.
> >
> > I wasn't able to reproduce this, I tried with gcc-10 on each patch
> > individually, debug disabled and O3. I can send a v3 patch set, but
> > currently it is just a rebase of v2.
>
> ok, I'll try to debug that if I can still reproduce
>
> jirka

Thanks to Sohaib I have a reproduction now, and it looks like there
are a bunch of issues to fix in v3.

Thanks,
Ian
