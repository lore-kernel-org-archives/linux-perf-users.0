Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11CC60E05
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJLDIZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJLDIZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 23:08:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FEBC06161C
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 20:06:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n65so43403742ybb.7
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ0KAePC541aIFWPu+Qph3nd5pn2jLDyqAKx+t7Tp4o=;
        b=ip3uRvIOdVNMESQOX2/a7CEt9Jag9Yczb/UVEk/hSMBBk2B/TBXKa85Yz3ZATtEuIi
         okqzfUkd+xRuKb9BvEhRCJPrpZewaGE/gmB341grpZnJrOmLpPENegFykPASTaLYeWY5
         Bu3I05v2rVeO2jWbx5IZY9M25R/zmZMXatdsZTauau8mz3u81R6plfqmw6Wue92ee88U
         luUfVrKha5EJ20R7L5zsIjHvzY/UHRSzs4E38SvoGZB5VOTYeHSvCJblDefWjS4fWpg8
         Pa9o0E8MOH1tMiBcHNKOX4WKqTeur/m8AQrjSdJ+CKkwP76LlBs1mY8qDynjTRL2dSSG
         yrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ0KAePC541aIFWPu+Qph3nd5pn2jLDyqAKx+t7Tp4o=;
        b=glZyUqT8AfRF/e1QJoZMl3stbZEOvCEJdQe1JmDb8bXTWRSqWhGml3huKD03jbbmFQ
         l9cEe7Cnb9x5caqHHf+C9urqetDzvCxc/gi25tK6U/ah2xyhDGaRi+wRBBSvkfrLByg8
         /CLpWOtPYd+U2i6xGnIZF14Qel7sJ7TEli/mE7Rl4ewh6XcHTQdVZ4q7iijUANuf38cO
         TggNwwfRS6BP6kq2C2JXkQLTn/SsVLxglGFHXQswTZiUPi2PIJQDr2i+rMEBq14qikDv
         rrc+xQD4AzgQl4Mzj1SWdOvODvNpM36KSCZ06m1Hp0Z6zAnMoFCsshohlDxDWu035gSE
         qlyA==
X-Gm-Message-State: AOAM531930RIPkqvLJ/pq60FSrHqwELnD/w59bD1jyhwwPnlG583ZDUe
        UwlMVvqYkt8jNvSnUhmyy8hC3NR5CbqBvFt1nMcwHw==
X-Google-Smtp-Source: ABdhPJyCvPJnDReSx/9fAMemeVHUYBwuWOlOqJf3tf3/qsJ2Uy15pOKdfPd6dmnQpxo9o47ajP9U4QvYHvhbTXB2QNU=
X-Received: by 2002:a25:3212:: with SMTP id y18mr24979104yby.308.1634007982533;
 Mon, 11 Oct 2021 20:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com> <20211012021321.291635-2-irogers@google.com>
In-Reply-To: <20211012021321.291635-2-irogers@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Oct 2021 20:06:11 -0700
Message-ID: <CAFP8O3KXocfMYhQBoBskg3VN0-xmUUEy2fA_SuzptWa1gAXbnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf clang: Fixes for more recent LLVM/clang
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
>
> The parameters to two functions and the location of a variable have
> changed in more recent LLVM/clang releases.
>
> Remove the unneecessary -fmessage-length and -ferror-limit flags, the
> former causes failures like:
>
> 58: builtin clang support                                           :
> 58.1: builtin clang compile C source to IR                          :
> --- start ---
> test child forked, pid 279307
> error: unknown argument: '-fmessage-length'
> 1 error generated.
> test child finished with -1
>
> Tested with LLVM 6, 8, 9, 10 and 11.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/c++/clang.cpp | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index c8885dfa3667..df7b18fb6b6e 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -43,8 +43,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
>                 "-cc1",
>                 "-triple", "bpf-pc-linux",
>                 "-fsyntax-only",
> -               "-ferror-limit", "19",
> -               "-fmessage-length", "127",
>                 "-O2",
>                 "-nostdsysteminc",
>                 "-nobuiltininc",
> @@ -55,7 +53,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
>                 "-x", "c"};
>
>         CCArgs.append(CFlags.begin(), CFlags.end());
> -       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs);
> +       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
> +#if CLANG_VERSION_MAJOR >= 11
> +                                                        ,/*BinaryName=*/nullptr
> +#endif
> +                                                        );
>
>         FrontendOptions& Opts = CI->getFrontendOpts();
>         Opts.Inputs.clear();
> @@ -151,13 +153,16 @@ getBPFObjectFromModule(llvm::Module *Module)
>
>         legacy::PassManager PM;
>         bool NotAdded;
> -#if CLANG_VERSION_MAJOR < 7
> -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
> -                                                     TargetMachine::CGFT_ObjectFile);
> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
> +#if CLANG_VERSION_MAJOR >= 7
> +                                                      , /*DwoOut=*/nullptr
> +#endif
> +#if CLANG_VERSION_MAJOR < 10
> +                                                      , TargetMachine::CGFT_ObjectFile
>  #else
> -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
> -                                                     TargetMachine::CGFT_ObjectFile);
> +                                                      , llvm::CGFT_ObjectFile
>  #endif
> +                                                      );
>         if (NotAdded) {
>                 llvm::errs() << "TargetMachine can't emit a file of this type\n";
>                 return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
> --
> 2.33.0.882.g93a45727a2-goog
>

Thanks for the change:)

Reviewed-by: Fangrui Song <maskray@google.com>
