Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA77C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGYQ4P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiGYQ4O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 12:56:14 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F04B1E0;
        Mon, 25 Jul 2022 09:56:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10d845dcf92so15437084fac.12;
        Mon, 25 Jul 2022 09:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQ/YFxfV00z7+mUQYiCapUw6QbltoYDNq4t//YArlGk=;
        b=RLyqRnp3re2ZO/GYapNHFmN/kr7O9rTv/aTj27nauZquU7W3oOzKLKUUEdtpaXx4UU
         g4AtRMXWOC+SJBCPlz4bZDfU+M2ywoxWKL14H6u02/xJx+GqjDo0fLjrwtS3Sis3qz66
         zr6fNU9Qru2vtDV+9ihzF4sZjVESh5UAXrgmkRouQIHXvRUE0NbH3cfHlfUEPoZAnp/M
         CL9+9AbJeGWaXjYqXfDtKZUNeajZRP5GCNuG/Ixq/tm8nt902N2oX7BhxMluFxoS3dKN
         0BX5a/uHhmooRUYpEL8jDXzMSLfMG81uPXBMzsx3xCwHVgj3U77qenk3Eaq4qqWoPqcZ
         2DkA==
X-Gm-Message-State: AJIora8E2CpVNqOl0+GIPM85FQtUb2GLwqz5ALXTiu2j0KG2ZoBT53xZ
        781pd1m1xg23lti8UzlaKuuY62psSyAbrmNDZRc=
X-Google-Smtp-Source: AGRyM1vs7wCCECVpdS8yAZ8TMcS0GvLf9g3hu2m0ezMk6WrIfveH7DQ6PkARQKhUWBYS7e0OSBEFTErdaHnqxeV8ez8=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr7016483oab.92.1658768172916; Mon, 25
 Jul 2022 09:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721043644.153718-1-namhyung@kernel.org> <20220721043644.153718-4-namhyung@kernel.org>
 <Ytmi4otIpXA+zNSx@kernel.org> <YtmjkCbvemjvlPBN@kernel.org>
In-Reply-To: <YtmjkCbvemjvlPBN@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 25 Jul 2022 09:56:02 -0700
Message-ID: <CAM9d7cjstn7KHKXhHzQRoNoEFosC0XZM5VpR37rH3i7B+Pcjbg@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf lock: Add lock aggregation enum
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Thu, Jul 21, 2022 at 12:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 21, 2022 at 04:02:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jul 20, 2022 at 09:36:41PM -0700, Namhyung Kim escreveu:
> > > Introduce the aggr_mode variable to prepare the later code change.
> > > The default is LOCK_AGGR_ADDR which aggregate the result for the lock
> > > instances.  When -t/--threads option is given, it'd be set to
> > > LOCK_AGGR_TASK.  The LOCK_AGGR_CALLER is for the contention analysis
> > > and it'd aggregate the stat by comparing the callstacks.
> >
> > builtin-lock.c: In function ‘report_lock_contention_end_event’:
> > builtin-lock.c:1113:13: error: variable ‘key’ set but not used [-Werror=unused-but-set-variable]
> >  1113 |         u64 key;
> >       |             ^~~
> > cc1: all warnings being treated as errors
> >
> >
> > trying to fix
>
> Please take a look at this:
>
> builtin-lock.c: In function ‘report_lock_contention_end_event’:
> builtin-lock.c:1113:13: error: variable ‘key’ set but not used [-Werror=unused-but-set-variable]
>  1113 |         u64 key;
>       |             ^~~
> cc1: all warnings being treated as errors

Ooops, sorry.  Will fix!

Thanks,
Namhyung


> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/builtin-lock.o] Error 1
> make[2]: *** [Makefile.perf:660: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':
>
>      6,642,782,729      cycles:u
>     12,246,940,928      instructions:u            #    1.84  insn per cycle
>
>        2.513486078 seconds time elapsed
>
>        1.649124000 seconds user
>        1.272055000 seconds sys
>
>
> ⬢[acme@toolbox perf]$ gcc -v
> Using built-in specs.
> COLLECT_GCC=/usr/bin/gcc
> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/12/lto-wrapper
> OFFLOAD_TARGET_NAMES=nvptx-none
> OFFLOAD_TARGET_DEFAULT=1
> Target: x86_64-redhat-linux
> Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-12.1.1-20220507/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 12.1.1 20220507 (Red Hat 12.1.1-1) (GCC)
> ⬢[acme@toolbox perf]$ cat /etc/fedora-release
> Fedora release 36 (Thirty Six)
> ⬢[acme@toolbox perf]$
