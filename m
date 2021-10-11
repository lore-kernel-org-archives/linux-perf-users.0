Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF172C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA5160F22
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJKXhZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJKXhZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 19:37:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C9C061570
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 16:35:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i11so18774967ila.12
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5doF16hgQ3anNx2OCPKaP+dXIpOli1yTZ6ngdBuBPis=;
        b=orely8MgtNwldKi8vvjgwRrrVmEA3FT1+7e7APbVNVZLwik9l0ldgZvrGZX8MEsOjX
         O5bbA7TNPjFzkEErsb+BRjq5sAQrDNZRat7QASgMHXMUXY7swNKiI5ZtT+GURzKaSPVi
         DRaCXRT9WHbCfwvSJbc4YMZ6/2iBME/Eu4ohahxAutQG7bKRgDk7/7/XWovPGNg/9iKk
         h2pYzE0p0q4PnCWbG9JUW4NuvyLHqIgM5ltWqbmRWPYQcV0urE3wDNNMAEWinEx8HkJN
         FN9fWmHrF0ErNm5Bf+5Z1uUVufyFaigo+TMbjDqV9N5qKBpiysPGNfOoss9aOi4SRJJ3
         T6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5doF16hgQ3anNx2OCPKaP+dXIpOli1yTZ6ngdBuBPis=;
        b=jafGKaHjzAlsK/EhwGEfR3A5tfIr1txU7SWQcppfnJxTmuQh7nxvTV2kh2zAb/5UT/
         KbLUVrnuRlZoNaNgKnnqZOS84D6TfdAWbTV4noxJoNViytZCDTV6q3lYYQ7KLookftsQ
         gyMLhP0voD8N1lBS3ITZ8j5Hsl/IMq4LOUAmCeRS790AqVDf2s5D5GG0Efhu5nQ5yfQv
         6faM0HIJ+TxrgKXj3IzvW//SsBoBArJz3OmkdnWGQQ3KZK7v7r0JI4+AlNzzqDjTRhrC
         YDxZFyuARWL3uRrYLSATZHnXWbq/JXZdS6NEJLQlZtrUKpl2QUIxxfsHC5fK6eujcZrq
         koeg==
X-Gm-Message-State: AOAM533lFr6rUx+3zyW6ylyAt5+ok1Xb2DrQ51bCVVZYeg6CtM5f7EyN
        /RsvzwjE5C1LoL63dkQzxu4s4f4LM05UaBZvIHpmMw==
X-Google-Smtp-Source: ABdhPJy2izrFy6yKEjmXxdCtTrauEY8LyyOUbl1XHovhk5CFgmN6Xmv2q/VEA2U+HlGpHWCLx79RI0ExAYTeCmo9bvg=
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr11836329ila.89.1633995323893;
 Mon, 11 Oct 2021 16:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211011232446.250195-1-irogers@google.com> <20211011232446.250195-2-irogers@google.com>
In-Reply-To: <20211011232446.250195-2-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Oct 2021 16:35:11 -0700
Message-ID: <CAP-5=fX9czHvqwj9DGABe8M59Rck17U9kDMhAgwxHn_L=D04zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
To:     Peter Zijlstra <peterz@infradead.org>,
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 11, 2021 at 4:24 PM Ian Rogers <irogers@google.com> wrote:
>
> The parameters to two functions and the location of a variable have
> changed in more recent LLVM/clang releases.
>
> Tested with LLVM 6, 8, 9, 10 and 11.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/c++/clang.cpp | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index c8885dfa3667..756200cb80b1 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -44,7 +44,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
>                 "-triple", "bpf-pc-linux",
>                 "-fsyntax-only",
>                 "-ferror-limit", "19",
> -               "-fmessage-length", "127",

Sorry, missed from the commit message. I removed this flag to format
output down to 127 columns as with clang 11 I see in perf test:

58: builtin clang support                                           :
58.1: builtin clang compile C source to IR                          :
--- start ---
test child forked, pid 279307
error: unknown argument: '-fmessage-length'
1 error generated.
test child finished with -1

The flag isn't necessary for correct operation.

Thanks,
Ian

>                 "-O2",
>                 "-nostdsysteminc",
>                 "-nobuiltininc",
> @@ -55,7 +54,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
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
> @@ -151,13 +154,16 @@ getBPFObjectFromModule(llvm::Module *Module)
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
