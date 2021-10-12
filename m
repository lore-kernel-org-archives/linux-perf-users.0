Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B71C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B52560C41
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhJLCTX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhJLCTR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 22:19:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE8C06161C
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 19:17:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 5so21964631iov.9
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fSrUisARHD7qrqvQy+VrNmjDH5MNGuJPhi8AVkhuyg=;
        b=J1Qo8argQskw9bAOdc9j6mukisL8oQUqcsE0aj60ytFiIlJxtou0qlHDTC7i+WcAPc
         jI/aGUjAVXMFHxmhUXfiB6E1VboGiIM/4SGgs+rD+pq/aUgHu9ZjqsU9tavFEKAtJobn
         XOgDWwo/eNKrAsUvYhU6KRtdfqwSAfBpG9yLzSAEWW5RuLZxbE3bM/pr99LFiVZGYcMx
         tXhZm2ZzIj/2qz3AchzcbiEeAf0pUVfjmvfR1nfZeecEoiZA6KTS/6yFIAfnd9RFVPPm
         cs8lZZnsTkl4ELeMaCoh2UBOqIpncNp1I0VAfn3iKtc7r7I2RM9aIwxnB6kCHmgIZuPm
         3k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fSrUisARHD7qrqvQy+VrNmjDH5MNGuJPhi8AVkhuyg=;
        b=dZgfmx3Bu8ZaMzOqzjmgN1CtcFAdtK6yML+CRmCNFHGV2n9/3CvbDBko0yioiulrzp
         cuLwT5eBBLLvYilVk3f+iB8XiGGqYpMcANmMkSA3b+gm2Pe91sDmSYnF8We2Y/p/oULZ
         oyH3Tr6HFH/zhHQy1QHiK7vWJuZtZ0iMDQlt3ZfsM3JDp8H9NvUZHW0pKU0D4GjG5G8m
         8O4p3tMsUhUbzZy9gBithUB0iflY1QjgSCVEgnFBD8BDubtg0taCY/xDTTCnnLFXY4QQ
         P28Hraq0Vut4uGc20k/IwUuOR3TNTn229x8DriQ2uKsthn1pRK3nY9SU8JpeCnjQ0PyR
         tJtA==
X-Gm-Message-State: AOAM533FsUydmRi2jijZ9bZSw/K1ELsOQzajKqobQMmL+MnibhwUkIuS
        nAof2dbR12+/hU4DtznFgB4dXtF0U73j8Ml5CTyl+w==
X-Google-Smtp-Source: ABdhPJwJFXZGd9x7R5OZLOCdaohcdnyWp0hMZaAmGLRZw/6BHg4tLpBDELnsf86T3Ov2pf7QtEpxda0zbQmeHWd4SD0=
X-Received: by 2002:a05:6602:2a42:: with SMTP id k2mr12990771iov.97.1634005034825;
 Mon, 11 Oct 2021 19:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211011232446.250195-1-irogers@google.com> <20211011232446.250195-2-irogers@google.com>
 <CAP-5=fX9czHvqwj9DGABe8M59Rck17U9kDMhAgwxHn_L=D04zw@mail.gmail.com> <CAFP8O3Km7dDR5i=aOiEAH6kM_jXA0uAvo4hZvPgm43UR3MdYYw@mail.gmail.com>
In-Reply-To: <CAFP8O3Km7dDR5i=aOiEAH6kM_jXA0uAvo4hZvPgm43UR3MdYYw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Oct 2021 19:17:03 -0700
Message-ID: <CAP-5=fXK4f1G7ec05MM04hdxw53Ys2vQzzx6gvNpgVSQHDiuTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 11, 2021 at 4:49 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> On Mon, Oct 11, 2021 at 4:35 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 4:24 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The parameters to two functions and the location of a variable have
> > > changed in more recent LLVM/clang releases.
> > >
> > > Tested with LLVM 6, 8, 9, 10 and 11.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/c++/clang.cpp | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clan=
g.cpp
> > > index c8885dfa3667..756200cb80b1 100644
> > > --- a/tools/perf/util/c++/clang.cpp
> > > +++ b/tools/perf/util/c++/clang.cpp
> > > @@ -44,7 +44,6 @@ createCompilerInvocation(llvm::opt::ArgStringList C=
Flags, StringRef& Path,
> > >                 "-triple", "bpf-pc-linux",
> > >                 "-fsyntax-only",
> > >                 "-ferror-limit", "19",
> > > -               "-fmessage-length", "127",
> >
> > Sorry, missed from the commit message. I removed this flag to format
> > output down to 127 columns as with clang 11 I see in perf test:
> >
> > 58: builtin clang support                                           :
> > 58.1: builtin clang compile C source to IR                          :
> > --- start ---
> > test child forked, pid 279307
> > error: unknown argument: '-fmessage-length'
> > 1 error generated.
> > test child finished with -1
> >
> > The flag isn't necessary for correct operation.
>
> Right, I changed the -cc1 option from Separate-form -fmessage-length
> to -fmessage-length=3D in 2020-03.
> -ferror-limit can be deleted as well.

Done in v2 (please consider adding Acked-by, Reviewed-by, etc).

> > Thanks,
> > Ian
> >
> > >                 "-O2",
> > >                 "-nostdsysteminc",
> > >                 "-nobuiltininc",
> > > @@ -55,7 +54,11 @@ createCompilerInvocation(llvm::opt::ArgStringList =
CFlags, StringRef& Path,
> > >                 "-x", "c"};
> > >
> > >         CCArgs.append(CFlags.begin(), CFlags.end());
> > > -       CompilerInvocation *CI =3D tooling::newInvocation(&Diags, CCA=
rgs);
> > > +       CompilerInvocation *CI =3D tooling::newInvocation(&Diags, CCA=
rgs
> > > +#if CLANG_VERSION_MAJOR >=3D 11
> > > +                                                        ,/*BinaryNam=
e=3D*/nullptr
> > > +#endif
> > > +                                                        );
> > >
> > >         FrontendOptions& Opts =3D CI->getFrontendOpts();
> > >         Opts.Inputs.clear();
> > > @@ -151,13 +154,16 @@ getBPFObjectFromModule(llvm::Module *Module)
> > >
> > >         legacy::PassManager PM;
> > >         bool NotAdded;
> > > -#if CLANG_VERSION_MAJOR < 7
> > > -       NotAdded =3D TargetMachine->addPassesToEmitFile(PM, ostream,
> > > -                                                     TargetMachine::=
CGFT_ObjectFile);
> > > +       NotAdded =3D TargetMachine->addPassesToEmitFile(PM, ostream
> > > +#if CLANG_VERSION_MAJOR >=3D 7
> > > +                                                      , /*DwoOut=3D*=
/nullptr
> > > +#endif
> > > +#if CLANG_VERSION_MAJOR < 10
> > > +                                                      , TargetMachin=
e::CGFT_ObjectFile
> > >  #else
> > > -       NotAdded =3D TargetMachine->addPassesToEmitFile(PM, ostream, =
nullptr,
> > > -                                                     TargetMachine::=
CGFT_ObjectFile);
> > > +                                                      , llvm::CGFT_O=
bjectFile
> > >  #endif
> > > +                                                      );
> > >         if (NotAdded) {
> > >                 llvm::errs() << "TargetMachine can't emit a file of t=
his type\n";
> > >                 return std::unique_ptr<llvm::SmallVectorImpl<char>>(n=
ullptr);
> > > --
> > > 2.33.0.882.g93a45727a2-goog
> > >
>
> Related, does it make sense to drop CLANG_VERSION_MAJOR<7 support?

Arnaldo can likely best comment. Clang 6.0.1 was released on July 5th
2018 so it may still be in his build tests.

Thanks!
Ian
