Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C41C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjE3TDo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjE3TDn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 15:03:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D7CC5
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 12:03:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f81ffc9065so39961cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685473421; x=1688065421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wg+eakYRQJkWFsR8VKHGbMsmZUbdUsVveMbi9l3IrU=;
        b=3BmQfsxcutfEPmqGYcWZ6a1Z5O/lPh3rsVadxX5KMEHUjcanhGptNKJnGxEYxA80Pr
         2ZP7LNROMrce7azCSMf2CZ6VOYrWdF1RepVCJBvUM/XqXsCYE/iGEvXSw1iscTlQLHDy
         U6AWSOx0qz/RDoEbz3PDPZrrZ16/cArEZDOmC+QkNBFDC2O/n/8K4E70uW8KTDIqi817
         FYURPHLzGtiDCCgHuHASq6MLJLq6VoYmte0kJ4QGj9YbtLMk+HGk9QjTb2UdHT5X3U8k
         951Ivghweq5RhxWVyD7RHbRH6F4Mq3idiqIR92BMZQJOkCzkdAuPMPRJagF3dTBwxaMr
         hbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685473421; x=1688065421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wg+eakYRQJkWFsR8VKHGbMsmZUbdUsVveMbi9l3IrU=;
        b=Q8pdy1HdAqGGWGuLi5ccBzKPJFE6BeddUZU9ueNAagRIc/4aj0/M8Tk1tx7uKOqj7j
         9Dh+yMBN3F6YqdIDb87xvTsxVFV4dCn+F8fjl0wvbJIr4SmWSesCk2J9FCBVTh3DpAr5
         bAfh3wjm7L4776M0adEHyXyIZlCyeXj1736pfe11E7axp5ycmckJn+AHzXt8xw7o/MNS
         Urd7V6TGQIDnNFjEqVplvyyuFbSnK+0k+E7SCTzMdNUIG35stnbolWj0GNbQ4GuakqEY
         rjryx1eG2UVBjaYLki2jrk3CJs4igBUJO2SKhtIZ5lDzJrXLLjJo1OHnv0vDz/yEfO/J
         U5QA==
X-Gm-Message-State: AC+VfDwLgJRiUP1KgAr0T5Poiys+haY8xZFJt8JBPqsZpyRbJAhP87Ql
        6OoTPoxcd9NT26Kc01UUr8g9B5qNpV12fx433oAAJw==
X-Google-Smtp-Source: ACHHUZ4tQx7CHfFMGAthsUJbOk3tJkETYESkIEu6PzSgqVUmKF4lp6c4aKVS3iVEhQx3+aj/GpFZwh3LLrvIT/yC8HY=
X-Received: by 2002:a05:622a:1a01:b0:3f8:3065:7fc5 with SMTP id
 f1-20020a05622a1a0100b003f830657fc5mr234549qtb.1.1685473421607; Tue, 30 May
 2023 12:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 12:03:30 -0700
Message-ID: <CAP-5=fXvN1b+_krmFSL2=C31WZ3zKafnq=Bqw3ruBKFNzG_8Kw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/5] perf tools: Modify mksyscalltbl
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 30, 2023 at 3:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> I'm sorry, somehow the patchset didn't reach mailing lists.
> Resending with a fewer people in the cc list, which probably
> was the reason.
>
> Thanks Alexander, Leo and Ian for your reviews and suggestions.

Thanks for the consts!

Acked-by: Ian Rogers <irogers@google.com>

> v3:
>   -- Add a new patch to declare syscalltbl_*[] as const for all archs,
>      suggested by Ian.
>   -- Add a new patch to use max_nr to define SYSCALLTBL_ARM64_MAX_ID.
>
> v2:
>   -- Add a new patch to rename create_table_from_c()
>      to create_sc_table(), suggested by Leo.
>   -- Simplify the shell script, suggested by Alexander.
>
> Tiezhu Yang (5):
>   perf tools: Declare syscalltbl_*[] as const for all archs
>   perf arm64: Rename create_table_from_c() to create_sc_table()
>   perf arm64: Handle __NR3264_ prefixed syscall number
>   perf arm64: Use max_nr to define SYSCALLTBL_ARM64_MAX_ID
>   perf LoongArch: Simplify mksyscalltbl
>
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  | 17 ++++-----
>  .../arch/loongarch/entry/syscalls/mksyscalltbl     | 40 +++++++---------=
------
>  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  2 +-
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  2 +-
>  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  2 +-
>  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  2 +-
>  tools/perf/util/syscalltbl.c                       | 14 ++++----
>  7 files changed, 32 insertions(+), 47 deletions(-)
>
> --
> 2.1.0
>
