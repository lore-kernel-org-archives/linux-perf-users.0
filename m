Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD6C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 20:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCMUTN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCMUTF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 16:19:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E3558B51
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 13:18:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id bf15so5519634iob.7
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678738705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMv/ZrKozqk/3N9wcx4SJLTo2Z0dNH3sU+GF9ySHsMM=;
        b=rEtcRxoX5qIvIvWeMDUxCQ3qOdaDNP7GaH9NmLAiCcCuIokZOPvV6JZVWJ6mDEzQjn
         7IgbHZKlOeHh7FyBpyKDsngUpQssXQFgICgI/pp4p/muTGcgWOF8dtGMFYL7r6pEyS8N
         B03xdtEcfH6G6YrENafSwtsMldEolgc6LVJustfHTMHlksDP+LoIOUwTwUrtnBLp8rR2
         GX2YPjyts7AKOxelBxJBasdZBwkKpIZ0blNj5aWOGtRLX3pVwas8eZL2ABqDCkUJXJms
         TcZtSfRwtEsUK2XGAKem9ojEiI/Ycme7jyK5cMm3m1AIWOn+cE0uitAtMIaNmwdzt2Ss
         EtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678738705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMv/ZrKozqk/3N9wcx4SJLTo2Z0dNH3sU+GF9ySHsMM=;
        b=hRVl7HdbJvrnJ3LC/51A7zL1JNr2GVaKtOgbY4nqJptIQiuem6VZCZDFxIsRS6HyZa
         vprleOgoQRvcqsZkWzwW2M2pJWenaUduCzNZZyK7yD1gwvUQe3oCw2Jx96p31MNiYRFI
         DWyNp6139uChgfuRDsBWoSfMGOMDogpYBAj3zlgfJu1Vi0DZACvAb9BqQYZiVdo5q588
         xH4t7oVlN39SFqWTNB805xTt5QHz2ZI+Qu7E5ERjW3rmFEs4v7kPs+IImaH7332S1MxP
         ThZG77Q0Ta1tgJScOT0by0KYvckV7P/zCiqVv/wDOayoHDv9PCof97vlZo5XNmqC7ZGG
         UpfA==
X-Gm-Message-State: AO0yUKU64iipSLI/+C9AGB1uu2LetMPJYvv2t7ydq3S69cbcMv4Rprmf
        Me1pd88E34v9XJHrlKyzCGJ/p732EZHG7I79aaegVA==
X-Google-Smtp-Source: AK7set9EW7eZcvCohYp/536LNrtbyQCXrLmnqDBj1BMSkqfrYy1oSyAzSSYcVuCSuM1admlhcXRJwlkaI8KkcNpfChs=
X-Received: by 2002:a02:94cd:0:b0:3e1:fb3d:4dce with SMTP id
 x71-20020a0294cd000000b003e1fb3d4dcemr17437010jah.0.1678738704775; Mon, 13
 Mar 2023 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com> <20230311065753.3012826-5-irogers@google.com>
 <ZA99SPGAlLUIjQoj@kernel.org>
In-Reply-To: <ZA99SPGAlLUIjQoj@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 13:18:13 -0700
Message-ID: <CAP-5=fXUTXx5ywyxJKkM-nNeaxufJgg+QE064cpo4D_Wn6RnCw@mail.gmail.com>
Subject: Re: [PATCH v1 04/13] perf build: Error if no libelf and NO_LIBELF
 isn't set
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 12:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Mar 10, 2023 at 10:57:44PM -0800, Ian Rogers escreveu:
> > Building without libelf support is going disable a lot of
> > functionality. Require that the NO_LIBELF=3D1 build option is passed if
> > this is intentional.
>
>
> 'make -C tools/perf build-test' is failing:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make=
 -C tools/perf build-test
> ace4d44d094ce850 (HEAD -> perf-tools-next) perf build: Remove redundant N=
O_NEWT build option
> make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs fro=
m latest version at 'include/uapi/linux/in.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' =
differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_reg=
s.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.=
h'
> Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' diffe=
rs from latest version at 'include/linux/coresight-pmu.h'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=3D-static NO_PERF_READ=
_VDSO32=3D1 NO_PERF_READ_VDSOX32=3D1 NO_JVMTI=3D1 -j32  DESTDIR=3D/tmp/tmp.=
jqGYXdF9cQ
> cd . && make LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PERF_READ_VDSOX=
32=3D1 NO_JVMTI=3D1 -j32 DESTDIR=3D/tmp/tmp.jqGYXdF9cQ
>   BUILD:   Doing 'make -j32' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
>   LINK    fixdep
> Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs fro=
m latest version at 'include/uapi/linux/in.h'
> diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' =
differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpu=
features.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_reg=
s.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.=
h'
> diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/=
uapi/asm/perf_regs.h
> Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' diffe=
rs from latest version at 'include/linux/coresight-pmu.h'
> diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
> Makefile.config:429: *** ERROR: No libelf found. Disables 'probe' tool, j=
vmti and BPF support. Please install libelf-dev, libelf-devel, elfutils-lib=
elf-devel or build with NO_LIBELF=3D1..  Stop.
> make[3]: *** [Makefile.perf:236: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
>   test: test -x ./perf
> make[1]: *** [tests/make:316: make_static] Error 1
> make: *** [Makefile:103: build-test] Error 2
>
> Same thing for the libtraceevent, I'll add NO_LIBTRACEEVENT=3D1 and NO_LI=
BELF=3D1 to the static build test in tools/perf/tests/make

Right, this is kind of the point of the patch set. Make it harder for
people to make a reduced perf binary without explicitly flagging that
this is what they want. For the build tests it may be better to make
the flag conditional on what is installed in the image.

Thanks,
Ian
