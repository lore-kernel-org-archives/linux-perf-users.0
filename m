Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152BAC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Apr 2022 23:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356585AbiDOXtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiDOXtA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Apr 2022 19:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A488786;
        Fri, 15 Apr 2022 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A18962286;
        Fri, 15 Apr 2022 23:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8939DC385AC;
        Fri, 15 Apr 2022 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650066389;
        bh=LTJf/A8Me12vLOMr5JY1SIon/1xfytx3EclH8+DlUvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LBZSxeeTHTnhfUzAb394wiHLjDjPcy6kLVK9zRbNdHz7mA1uf3Fgnv1xQAstRgV+d
         lPFYg6DQsp2l7nbwuMZmQ/97nwSS0PPxnXPPO0+8ebU+guKLBLRCprQ+TO+Zjr090Q
         ZUEzWNL3YyvA3lwmaRaXfiKf/vfOLZa4eQN+w/1i0Db5gOBAQN1bR3XuGcqt9v9vIX
         pZkWct2LfHEUTqGZCXPyLJoNxRblsBNAcNmCnJCPXu6wCQ+A+dJ5+rDeXU9MUkaQHY
         eG4BrBrEVmBhdnNP3yR3tjddyZgEkvRuIN5sz3iHDpsRl7HeFWC2eptCx/DmPweY8z
         YpBGmaNXEhQhA==
Received: by mail-yb1-f175.google.com with SMTP id x200so16608709ybe.13;
        Fri, 15 Apr 2022 16:46:29 -0700 (PDT)
X-Gm-Message-State: AOAM530vC2eCXv7lsXCWGc/eICdB4S0RDS0H5D8nizzXk1WXlFUsHAaF
        A6xuKa/jZHRz3Hgvg77s87unx3MqCZb8WRkizR4=
X-Google-Smtp-Source: ABdhPJyWyr2oTV/QYiBZcOp+HRuagV8MwNq7QqnmSyEnbUluuqK77EmsK07wn6ItjGoYFnwvNX0hmFftNOObm3DtmGs=
X-Received: by 2002:a05:6902:1506:b0:63e:4f1b:40ae with SMTP id
 q6-20020a056902150600b0063e4f1b40aemr1446621ybu.322.1650066388578; Fri, 15
 Apr 2022 16:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220414223704.341028-1-alobakin@pm.me> <20220414223704.341028-7-alobakin@pm.me>
In-Reply-To: <20220414223704.341028-7-alobakin@pm.me>
From:   Song Liu <song@kernel.org>
Date:   Fri, 15 Apr 2022 16:46:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6JoSHe2B4daYjFrkWYBvGLzq2PZnPs76ceT0iW1h6sMQ@mail.gmail.com>
Message-ID: <CAPhsuW6JoSHe2B4daYjFrkWYBvGLzq2PZnPs76ceT0iW1h6sMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/11] tools, bpf: fix fcntl.h include in bpftool
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Chenbo Feng <fengc@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        Thomas Graf <tgraf@suug.ch>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 14, 2022 at 3:46 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Fix the following (on some libc implementations):
>
>   CC      tracelog.o
> In file included from tracelog.c:12:
> include/sys/fcntl.h:1:2: warning: #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h> [-Wcpp]
>     1 | #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
>       |  ^~~~~~~
>
> <sys/fcntl.h> is anyway just a wrapper over <fcntl.h> (backcomp
> stuff).
>
> Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/bpf/bpftool/tracelog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
> index e80a5c79b38f..bf1f02212797 100644
> --- a/tools/bpf/bpftool/tracelog.c
> +++ b/tools/bpf/bpftool/tracelog.c
> @@ -9,7 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <linux/magic.h>
> -#include <sys/fcntl.h>
> +#include <fcntl.h>
>  #include <sys/vfs.h>
>
>  #include "main.h"
> --
> 2.35.2
>
>
