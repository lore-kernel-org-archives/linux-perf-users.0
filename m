Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590CEE4996
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 15:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjHVPLO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjHVPLO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 11:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D831A1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 08:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB9F8621E5
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 15:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC5AC433C7
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692717072;
        bh=WKmDFaA3e4nvoaAQVOOLYIYZVs9ElWoCmAdZTKJpBoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UFG4y38wWBMmq6MElEpkPwcKNyJwuji1p0HD08hIt1Yu99lzSnQbSelNJWANfBxwv
         +qkThCwX3hRUHOA35/0MjK9anRl7tLjE9KZ84ga8TZyMmJuqs3BA8lQRfvEBOeELyz
         rVjP8MKhQWzfOznR7E3J///2BtVSCpT7bJchiFgd5FpAxtYUsbvOcJ8+mL69HR5RGZ
         BFZXFHjlJtXeM5ZM3/IszywqVUY90ddcsO4gHMksVJ6aDlgo7Zppn8ekz/As4Vy+Pv
         2fBiI0Iu0Yg82BXiDo1LzEeHR2eFY5+y7IvS1DFbCfsnGIWZnuiTmf3tgHzkWP6MJM
         5Y+7goBVNFFjw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-997c4107d62so611694766b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 08:11:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YygxUoq7Lv5akuUKKrFMM6ypuEM1PhJ5oYDAKWfPZqiL+v7DImx
        zjdADBcX1kJObrPk4UOgYTWnWgHU6Xm+wkzCj4c=
X-Google-Smtp-Source: AGHT+IEuqtIz3e15nPmDdZ2WLoF+rkypccXXnZaPdUGS0EurK3jhPhpENVsSjGddmlcWDyqfInnmYfl4tJqd7VqbUNw=
X-Received: by 2002:a17:907:75c4:b0:99b:f4b2:6f13 with SMTP id
 jl4-20020a17090775c400b0099bf4b26f13mr7529943ejc.1.1692717070380; Tue, 22 Aug
 2023 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692694595.git.siyanteng@loongson.cn>
In-Reply-To: <cover.1692694595.git.siyanteng@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Aug 2023 23:10:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4pCdHn63c9N5oL39ja2ZPB9+v37D7exhaoW3m+FsPL7w@mail.gmail.com>
Message-ID: <CAAhV-H4pCdHn63c9N5oL39ja2ZPB9+v37D7exhaoW3m+FsPL7w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] tools/perf: Add loongarch cpuinfo and fix build warning
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For this series:

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Aug 22, 2023 at 5:32=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
> * LoongArch and riscv don't have tools/arch/xxxxx/include/uapi/asm/mman.h=
,
>   let's modify the detection rules.
> * Allow to use cpuinfo on loongarch.
>
> Yanteng Si (2):
>   perf/trace: Fix mmap_flags for archs use generic mman.h
>   perf/tools: Allow to use cpuinfo on loongarch
>
>  tools/perf/trace/beauty/mmap_flags.sh | 2 +-
>  tools/perf/util/header.c              | 2 ++
>  tools/perf/util/svghelper.c           | 7 ++++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.31.4
>
>
