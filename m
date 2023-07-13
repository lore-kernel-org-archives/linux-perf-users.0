Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454CEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 02:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGMCwK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 22:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGMCwJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 22:52:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25D19A3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 19:52:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403b622101bso101741cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689216728; x=1691808728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnEExmMtBlXytX3ytqMyuRpy6nTvH/BFEaJCJgLiLFQ=;
        b=HD6LlMMmsXJDkvTV07Riv2/4h+zQQEw6/4FcZivimVWC2NcVzXTBB3zsRR5VNUsBhn
         M+JGBPfnRun+jWwgOIjIfUoL6fLj4JiOJktVsrk7BSUTX+XcKuuYkPNwd4QZLIxmPcdg
         7b2wM67lXNkstYSnOOKGLgmi2E1d5vG0UxcaQdXpCAxvxVkLCA4YCBqbyNyfUAZyV7bK
         fU8xbhfQYIA6X21jSucWQMLMvJTQMTk2gNVA7q2S46WMkAJkL9rWqOXbEDw2Zk/2dD5Y
         b54JNQhbRj3evg6ddmW/QOiRmswd9A37S6GuNM6Ec2lHwy1kaDhqxYdObIqO/pBDmm/P
         XryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689216728; x=1691808728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnEExmMtBlXytX3ytqMyuRpy6nTvH/BFEaJCJgLiLFQ=;
        b=D/++5ea+8eRB7EwSGtoobgWP6LT2I6db6Lvb/q3PDqyQX0DAIO/sAbOge6ujnarq7o
         Jdug5wsJrX6dcyGQoljtXOGwCNcdOqIew2almqcvzvnikWkrAQBPo197/hMX2h5DPp6q
         0Tp6RyrI1cowc6H1rbfiSJdijX6E7Wo0bS3kEOJGlGeIuo3RtGkuSAhD04Ul2oUmt493
         NkjHyoL45Wli3nYCaatqb61++Yo3jNvaj44nZ6LxAYQlAXHKM5C0G6lEXgAYv45JmCcr
         Biez346dCBGsJn32XCzcFMYdFW7R5TlW3vrHKE6TScVsiNBPCcZnUqinZs3vWXTbFdnA
         EiNQ==
X-Gm-Message-State: ABy/qLYuq6eXiiYdtnn0Vf3p+rBJj9Ga6RA7mnWLfg3XUnF+qGNo6JhJ
        jI9RDFWa180xP8NgMWVg6DetNS35wu6bd3zj+UN6mbcSeSaiLt5vw0eA+g==
X-Google-Smtp-Source: APBJJlExM8szqDPWYjIH8TU5WKoIK5GQ9BP1n5ICvw3Wg+2n0dEIWrUP5L+6w2qTOE91qKzEEEhd41SKjCParmaUYPQ=
X-Received: by 2002:a05:622a:1898:b0:403:b242:3e30 with SMTP id
 v24-20020a05622a189800b00403b2423e30mr324606qtc.1.1689216727804; Wed, 12 Jul
 2023 19:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <648ac57d-0578-30cb-2cd8-577e1016442e@linux.ibm.com>
In-Reply-To: <648ac57d-0578-30cb-2cd8-577e1016442e@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 19:51:56 -0700
Message-ID: <CAP-5=fVjvBL4UvDGZZpP9xSMHzM2cNZKVCR6kWx1UPQ0cg1T=Q@mail.gmail.com>
Subject: Re: Perf tool build with clang/llvm support broken
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 11, 2023 at 3:22=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> I would like to build the perf tool with LLVM/CLANG support and did
>
> # make LIBCLANGLLVM=3D1
>   BUILD:   Doing 'make -j2' parallel build
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' d=
iffers...
>   ... some more similar lines removed.
>
>   Makefile.config:1120: No suitable libLLVM found, disabling builtin clan=
g and LLVM support.
>   Please install llvm-dev(el) (>=3D 3.9.0)
>
> However when I check llvm packages, I do have them installed on that mach=
ine:
>
>  # rpm -qa | grep llvm
>  llvm-libs-16.0.3-1.fc38.x86_64
>  llvm-16.0.3-1.fc38.x86_64
>  llvm-test-16.0.3-1.fc38.x86_64
>  llvm-static-16.0.3-1.fc38.x86_64
>  llvm-devel-16.0.3-1.fc38.x86_64
>
>  # rpm -qa | grep clang
>  clang-resource-filesystem-16.0.3-1.fc38.x86_64
>  clang-libs-16.0.3-1.fc38.x86_64
>  clang-tools-extra-16.0.3-1.fc38.x86_64
>  clang-16.0.3-1.fc38.x86_64
>  clang-devel-16.0.3-1.fc38.x86_64
>  git-clang-format-16.0.3-1.fc38.x86_64
> [root@f38 ~]#
>
> This shows up on s390x and x86_64 (my virtual machine).
> Any ideas have to fix this? Am I missing a package?
>
> Thanks.

Hmm.. I found when building in tools/perf I needed BUILD_BPF_SKEL=3D1.
The build output was put in
./util/bpf_skel/.tmp/feature/test-llvm.make.output. Testing with
clang/llvm 14 and 15, things were okay. Could you check the make
output file?

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
