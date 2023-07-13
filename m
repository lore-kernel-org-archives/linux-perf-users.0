Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA9EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 03:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGMDKd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGMDKb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 23:10:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E791BDA
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 20:10:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so109841cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 20:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689217829; x=1691809829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCEbI3WgmGp1pRdtBWdu/+PPGiU0Pj/o+/7oiTniyaE=;
        b=Hg1CGXQ0eyM5/jE5SmlcTlo1bRmry0Wt9Vl2FzVAPRYpMMTj9uVyJmQtFcKikEXSTB
         B1cG/SdA3VD/wuesbYyHeJaaIvyBZwm72uzXcOFXKEzkOpeP8mQ+TSpGyZ68TxiA5hzd
         4nJO+mL7FXol+qEfzYM0i0rzMEQ7mmLDcaFH/2oxm+PbCKIpj4fOmg4CdznFuDgCZ5qi
         XonaexQDgP884JigkO5lDS3IMk7TIR16xhivyb4/oai+7V4aeqzq8QFGOXQBQ1UU2/Zm
         O4WvwDzz7X30j+2LpOFe9Nwr70u0SRsRiJcg1VjFYDgwIyvccFumbXd4pnr8s7PYi7U3
         IB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217829; x=1691809829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCEbI3WgmGp1pRdtBWdu/+PPGiU0Pj/o+/7oiTniyaE=;
        b=bteMnPMJZL/uu3x8L9vr8nhrivLPMRoZE9SpjLgF+R2A/Vs9xagbB07OPa9zNSdoqO
         bxWeN3idB/fANcrrfMIBuZZkafRJiiGGnhBFKJmC0nJaI5tnEzw9AYszT/+RCN1Oe7dT
         gbFQ+ID3kvrLDXCm8vfXeDFXbZm2cpBP/9ANga2omQ0i1QxqR2ZcbI4ZqGRXnV5A605J
         ARffMYhbrv7PmBEb9t9Os/YFbnXNZWmTglIdVODDKjfjs5rnGMbrGqyQBL+f0hhsTnMu
         gMXTEAF+pcRZoT1/DpNz4PCSbnGVt/mm9pettKkBgSTX5S65Oh65faN+O1O1MpH6VFFc
         Im1Q==
X-Gm-Message-State: ABy/qLZ87p6K2MlLzNOy21DyYsr7p4zCtxbW3oD9qkPLCrY+cJLi/Vn9
        setlHQAxdQJYE88TS5DcDxJDkJBCFdo8nSV6Eu1+Jg==
X-Google-Smtp-Source: APBJJlH79jPWzG5n9UA0czpeAGh9irvaLp4SsnIBSq4hmhIVAqPafLLD+MqdLwOqYP+Fs8W+vcZSUxgUYsb+cU46bpE=
X-Received: by 2002:a05:622a:307:b0:403:b1e5:bcae with SMTP id
 q7-20020a05622a030700b00403b1e5bcaemr454336qtw.10.1689217829371; Wed, 12 Jul
 2023 20:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083037.4081444-1-tmricht@linux.ibm.com>
In-Reply-To: <20230712083037.4081444-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 20:10:18 -0700
Message-ID: <CAP-5=fUM5w8o4LOh470ciNhvH3bRPnOQ8AojGcWNXeQJJq-TsQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix broken feature check for llvm due to C++ standard
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 12, 2023 at 1:35=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf build auto-detects features and packages already installed
> for its build. This is done in directory tools/build/feature. This
> directory contains small sample programs. When they successfully
> compile the necessary prereqs in form of libraries and header
> files are present.
>
> Such a check is also done for llvm. And this check fails.
> Fix this and update to the latest C++ standard.
>
> Output before:
>  # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
>  g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
>                 > test-llvm.make.output 2>&1 -std=3Dgnu++14 \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -lLLVM-16               \
>                         \
>         > test-llvm.make.output 2>&1
>
>  make: *** [Makefile:343: test-llvm.bin] Error 1
>  -bash: ./test-llvm.bin: No such file or directory
>  #
>
> Output after:
>  # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
>  g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
>                 > test-llvm.make.output 2>&1 -std=3Dgnu++17 \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -lLLVM-16               \
>                         \
>         > test-llvm.make.output 2>&1
>  Hello World!
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Tested with clang/llvm 15.

Thanks,
Ian

> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 0f0aa9b7d7b5..f8db69654791 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
>         $(BUILD)
>
>  $(OUTPUT)test-llvm.bin:
> -       $(BUILDXX) -std=3Dgnu++14                                 \
> +       $(BUILDXX) -std=3Dgnu++17                                 \
>                 -I$(shell $(LLVM_CONFIG) --includedir)          \
>                 -L$(shell $(LLVM_CONFIG) --libdir)              \
>                 $(shell $(LLVM_CONFIG) --libs Core BPF)         \
> --
> 2.41.0
>
