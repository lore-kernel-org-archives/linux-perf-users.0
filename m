Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960ECC77B7C
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 May 2023 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEITwy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 May 2023 15:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjEITwx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 May 2023 15:52:53 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE63AB2;
        Tue,  9 May 2023 12:52:46 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-305f0491e62so5991930f8f.3;
        Tue, 09 May 2023 12:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661964; x=1686253964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY+ka+8lTaOeqjwogYEm47PhcDcHltNDkETFarkaxcE=;
        b=DVmjJS4WUf1AQOJZp1ygX+7mxiELcqyVABxVhI4GkACgTw33FBu+stn8xiTrFqDocZ
         JJ+OBxDY6d/QrEIaI6H90K/MTC1G8iVGy5HT6w1mQFylmPxOTTR7rNobUlWCVEKFSpOf
         J3Hhp9fIbRD7a5/iVDLfb+3XS1OjsEJc06ePWqy5dmVB2NYVHo3rUIGKYnLimSeiOF3U
         x/cLG0BZScgaw8QAv903uOYRlOMViqf9XvhwZhxEVqB+RDQRQ6xAfHW9QHAxg9pFQu1f
         nvT44ZD10zgl7hTKejH3Pm+3Z9zour6YX331blRkMumRcfJ/qah/bQoPxfsZqz1MdfWw
         Igjg==
X-Gm-Message-State: AC+VfDxK+YHNR0ulO1B1k1/T+bp2IT/JERyrOUxuO9E8kw1VFbHOGazf
        BuzZcKbvXnRh3HlOppw4tnVu1VMb11nsWzCAn5w=
X-Google-Smtp-Source: ACHHUZ7XY9KSMKbMcOaT+Egb63cwPFOrFh3ol0HjXirubMItPaCZVYPndckVIFLXuKgtLi5116FNkX3kAHP7HPrUIIA=
X-Received: by 2002:a5d:4309:0:b0:306:492c:cdd8 with SMTP id
 h9-20020a5d4309000000b00306492ccdd8mr9196606wrq.15.1683661964276; Tue, 09 May
 2023 12:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZFqWDrVhaIq5QDwo@kernel.org>
In-Reply-To: <ZFqWDrVhaIq5QDwo@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 9 May 2023 12:52:32 -0700
Message-ID: <CAM9d7cgJT4nZyAFLSZ600T7xwOMKTPF+wKn0So6NqPjtwLduRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Gracefully fail the build if
 BUILD_BPF_SKEL=1 is specified and clang isn't available
To:     arnaldo.melo@gmail.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Tue, May 9, 2023 at 11:54 AM <arnaldo.melo@gmail.com> wrote:
>
> Namhyung,
>
>         The one you acked disabled the build and emitted a warning, but
> then that was when we were trying to have BUILD_BPF_SKEL=1 as default,
> this one is for the current situation, where we need to explicitely ask
> for those features by explicitely adding BUILD_BPF_SKEL=1 to the make
> command line, I think I can keep your Acked-by, right?

Sure thing!

Thanks,
Namhyung


> ---
>
> Build BPF skels require having a compiler able to generate BPF bytecode,
> and so far this is only possible with clang, so check for its
> availability and fail the build when the user explicitely ask for BPF
> skels to be built.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Song Liu <songliubraving@meta.com>
> Cc: Yang Jihong <yangjihong1@huawei.com>,
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4884520f954f4b2a..70268442f7eeca50 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -216,6 +216,12 @@ ifeq ($(call get-executable,$(BISON)),)
>    dummy := $(error Error: $(BISON) is missing on this system, please install it)
>  endif
>
> +ifeq ($(BUILD_BPF_SKEL),1)
> +  ifeq ($(call get-executable,$(CLANG)),)
> +    dummy := $(error $(CLANG) is missing on this system, please install it to be able to build with BUILD_BPF_SKEL=1)
> +  endif
> +endif
> +
>  ifneq ($(OUTPUT),)
>    ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
>      BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> --
> 2.39.2
>
