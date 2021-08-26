Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310BDC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4A261004
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbhHZSur (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbhHZSuq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 14:50:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510AC061757
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 11:49:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a15so5035240iot.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RVi0xq01CWNWufmobfxfogmS5uOuV8P3fshSQwxbB8=;
        b=ckfAwHli4znfUylvCi3Qe/6NR65vbI2VAcnuiRLbbQYADkn4xWHdIEtfZ/FcFyjR1H
         Hq7b12TwHNXi2xYbWkXHwdaHPZjUWOwNITLiZ8QSk783kAbQF8VIRU1H8dE2g7NWeuNt
         dH50l5ngA/GHZkBnf46O7e9tZjqfqJ7K5BVkU9EE1aKAQWSQXuMtMfvwev2dJyvMgRJI
         NT+qIytM6bx6OTgpmvcJzNVPGY2TdC0pN24ojOcXnKwa0My8vMt+lgSfM+/1KDFk2UBr
         9g5ypH0PzCyV6QL4qLcUwXT8pRRsi2QmHa63Ku7XDGjvW/H90arxWZkYmZOA9wv2IEOZ
         DrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RVi0xq01CWNWufmobfxfogmS5uOuV8P3fshSQwxbB8=;
        b=bG9S6X3vPYPaIzn1B3ClCIxbw4VD5bNulvhCFaB+mat9q3HmVxvsqafV5B+fmhAzwI
         NTgCVBrSWgjp1c27EqxA/nPdKAIw8guXaXlxNzu06Psn0nydkpn2ycrdkZEA9yDhnW8f
         mbjIoCIqb28+ITVQr4NkXKrJBBNv1xqyceHX7r79y43QNOql8YV9KAB5gn02tXSaMlW0
         MzQml9cyE/WRu2RaL4C6l3OqfS79txmNK7YKrRZl56yblxDHOd46zQYiueAhbROTwuhq
         woDZpnlO+JA5OvSuH1cR/OeRlFNNn9iw9aPY74YSJ9OHk5anKSZRwPJvTpaDx4T9Q9pp
         +8Bw==
X-Gm-Message-State: AOAM531Kx2VOatGIY8xeuJoxMER1i4SGmwCa0mejOpF3uM/fIAQ0qgw0
        o7xixsSBWohP0Lie/KUhdZP/6rzvdBef9bq8sh3U0Q==
X-Google-Smtp-Source: ABdhPJwGbCC1XoYLtk1S/CPsklRnFcXwZMjD42jFcx4CV3PWfgPIdI9fdFw5R8DoLVjWIWI2/iIe8x2ZtxkssOlq58Y=
X-Received: by 2002:a05:6638:38aa:: with SMTP id b42mr4702797jav.6.1630003797721;
 Thu, 26 Aug 2021 11:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210826001635.285752-1-irogers@google.com> <ad17ba1f-34d8-fa5e-72fc-e05107fe2822@linux.ibm.com>
In-Reply-To: <ad17ba1f-34d8-fa5e-72fc-e05107fe2822@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 Aug 2021 11:49:43 -0700
Message-ID: <CAP-5=fVvZMyQdFm2u28VeK9QKspe2t1PoM9AB3_c--8Rgk4U+g@mail.gmail.com>
Subject: Re: [PATCH] perf bpf: Fix memory leak during synthesis.
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 26, 2021 at 1:02 AM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 8/26/21 5:46 AM, Ian Rogers wrote:
> > BTF needs to be freed with btf_free.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/bpf-event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index cdecda1ddd36..d193104db7f7 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
> >
> >  out:
> >       free(info_linear);
> > -     free(btf);
> > +     btf__free(btf);
>
> Hi Ian,
>    Patch looks good to me. I can see in one more place we are using free(btf) in the
> same file. Can you correct that as well.

Done. Also found 1 more in annotate :-)
https://lore.kernel.org/lkml/20210826184833.408563-1-irogers@google.com/T/#u

Thanks,
Ian

> Thanks,
> Kajol Jain
>
> >       return err ? -1 : 0;
> >  }
> >
> >
