Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Apr 2022 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiDOXrL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiDOXrH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Apr 2022 19:47:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B4B1DA76;
        Fri, 15 Apr 2022 16:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11D5CB831BA;
        Fri, 15 Apr 2022 23:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC07C385B5;
        Fri, 15 Apr 2022 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650066273;
        bh=BJ4yI4e3T5R6YlCYcwG8kMVsAMKr7M9Y5rWC/P9WuUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJ1RlEvMAjER3ZFVI3HSyIhLCsQ35tUuVOBeDnMIZ0DlAI3v6ypwthCCrooCwmpXe
         EATUHvvfNPth3qDMEZMcKFJPxPpCI4gHo4b0nkisuE+3UJiCIn42qkXfarwjvQav/p
         33Nb+rGdJ/K47qK9VdaLqurM2SJMXw0j39A5jFzu+4J3O1PFEYBA6UttDD+dthQc0A
         oQJH6WrnURgeLXt+ef+BnkPJ6kptXn6Wuxs308U91k29Ahii3KPD5rINAqpU9CnCmc
         ghZOo2SoU9t8I0Pdw9sZIxK0P3xk1Lok9+YaNS1Bu+nHEVbUkM1upWawXHfKmOvqxL
         y7JlQNp5fi1YQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ec42eae76bso95397767b3.10;
        Fri, 15 Apr 2022 16:44:33 -0700 (PDT)
X-Gm-Message-State: AOAM531TBasWG6PwFIGpd2/731feNo+rMVckWchXyajWxVMj2dUcoIXV
        87lfdxdGMhqscm41+tvE2eWD5CF82+Px5eZIYIQ=
X-Google-Smtp-Source: ABdhPJw9968jTzOt6gz9W4g0aOTltkD6p3FL8bzMBCVOFNwz4HrVPX4+c4iPXHNR2KMviPIXoPxm7E95Zzzie3H5GUk=
X-Received: by 2002:a81:5087:0:b0:2ef:33c1:fccd with SMTP id
 e129-20020a815087000000b002ef33c1fccdmr1182835ywb.73.1650066272767; Fri, 15
 Apr 2022 16:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220414223704.341028-1-alobakin@pm.me> <20220414223704.341028-6-alobakin@pm.me>
 <20220415133839.y6tjf3ymbvbrntx4@apollo.legion>
In-Reply-To: <20220415133839.y6tjf3ymbvbrntx4@apollo.legion>
From:   Song Liu <song@kernel.org>
Date:   Fri, 15 Apr 2022 16:44:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6SJ=Gyh89tmJEtsnPqgsE3csDAmkzFky5=yCRuO1JVTQ@mail.gmail.com>
Message-ID: <CAPhsuW6SJ=Gyh89tmJEtsnPqgsE3csDAmkzFky5=yCRuO1JVTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/11] samples: bpf: use host bpftool to generate
 vmlinux.h, not target
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Fri, Apr 15, 2022 at 6:38 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 04:15:50AM IST, Alexander Lobakin wrote:
> > Use the host build of bpftool (bootstrap) instead of the target one
> > to generate vmlinux.h/skeletons for the BPF samples. Otherwise, when
> > host != target, samples compilation fails with:
> >
> > /bin/sh: line 1: samples/bpf/bpftool/bpftool: failed to exec: Exec
> > format error
> >
> > Fixes: 384b6b3bbf0d ("samples: bpf: Add vmlinux.h generation support")
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

>
> >  samples/bpf/Makefile | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 97203c0de252..02f999a8ef84 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -291,12 +291,13 @@ $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >
> >  BPFTOOLDIR := $(TOOLS_PATH)/bpf/bpftool
> >  BPFTOOL_OUTPUT := $(abspath $(BPF_SAMPLES_PATH))/bpftool
> > -BPFTOOL := $(BPFTOOL_OUTPUT)/bpftool
> > +BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
> >  $(BPFTOOL): $(LIBBPF) $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) | $(BPFTOOL_OUTPUT)
> >           $(MAKE) -C $(BPFTOOLDIR) srctree=$(BPF_SAMPLES_PATH)/../../ \
> >               OUTPUT=$(BPFTOOL_OUTPUT)/ \
> >               LIBBPF_OUTPUT=$(LIBBPF_OUTPUT)/ \
> > -             LIBBPF_DESTDIR=$(LIBBPF_DESTDIR)/
> > +             LIBBPF_DESTDIR=$(LIBBPF_DESTDIR)/ \
> > +             bootstrap
> >
> >  $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
> >       $(call msg,MKDIR,$@)
> > --
> > 2.35.2
> >
> >
>
> --
> Kartikeya
