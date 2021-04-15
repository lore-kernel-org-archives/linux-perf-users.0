Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A8C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1A66115C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 05:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhDOFeP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 01:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhDOFeP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Apr 2021 01:34:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC6C061756
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Apr 2021 22:33:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g9so5971229wrx.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Apr 2021 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcxipN5cxSd0VM+cEvQ6NWIOLmc57Nk1DsdNT+GW7KA=;
        b=e0QLLuXiL/4lCdt6iFXdA71OTjsHKMqML07QdxGi37fdb0xY2T0TJ/+nFDlQfV/0G3
         SVspNpOpWJvTCS3LdwIGhbaJAbuid29eogP4KwFR/haLC2IFdpJ9nr5KjuSA+vd4AKqK
         9Gg6HuSFhqFUKjFTj94VZH2oiqeiefCksJ1SIaxhdreCEGRYXRqyr/U9rQKYKGDODf3O
         GsXIIr7898lvGKOXkgLoZ5M62Bb0snj6gwAMqc6+UrrIj011Fud7QSOxXJLIyOXoe1Cp
         /fszAHSmxQ/xXq4aHqDaGGvs2aWY6EMnTjxNI0ilNnt0pNbv7RHrwwKeKhwmcwqseeEs
         r17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcxipN5cxSd0VM+cEvQ6NWIOLmc57Nk1DsdNT+GW7KA=;
        b=Ikrrikngs+onPpLMsqy7SmwRA0MCymJFI4cjAnStUoq4P68KrBmf5H606rmVci8uHp
         pBw2Buw5gVmGqVNmOLXfRH6B1/6Koll20vrxqPq5X5nv9nEKSp0UUGgyHhX2GGEdTxH4
         ZH2niC9QIGm1Kv0zkLoXK96UJwApSDvb8jPmTdoWYw3VNPJUdgGgH2oiW+Mu0NBH9Qd2
         zt9zXympgJHJ3jHDqAqo4P3PrXLNmUdPgcybSFPj6gTtMWfYV9JuMiXPDjCm5/WbE8DB
         Q3ZjmSbE2XHwPsGe7Hd7H+WoZ4ZUzcPjUbVVov0WrnVV7XADAfx2ZQYNZjtOz88aXc0Y
         sIUg==
X-Gm-Message-State: AOAM530oQENXmn4pV1auBZi+BzBhzigFkC2ZnZMX18l0Yd5iMnUr4PwC
        WP67WpC5T1e7KVPNHObrzzLiEq8RX0hyFCfylHII6w==
X-Google-Smtp-Source: ABdhPJwr7DViLtLjzXCMiLGgHdvYPmNn6emVUmWM5evE07PXfyadzlYTCSsmY72xkVEO0wkdFINhS4zFc1TVm6x0Fwk=
X-Received: by 2002:a5d:524e:: with SMTP id k14mr1397309wrc.282.1618464831026;
 Wed, 14 Apr 2021 22:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210414131628.2064862-1-acme@kernel.org>
In-Reply-To: <20210414131628.2064862-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Apr 2021 22:33:38 -0700
Message-ID: <CAP-5=fVRFKnTJb4m6bzSQhC8sndSLFTom8Hak9PZQ=W75CK4Yg@mail.gmail.com>
Subject: Re: [RFC] Improve workload error in 'perf record'
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 14, 2021 at 6:16 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         Please take a look,
>
> Best regards,

Acked-by: Ian Rogers <irogers@google.com>

Having been confused by this for a case in the past, thanks! It'd be
nice for code coverage's sake to have a shell test on this.

Thanks,
Ian

> - Arnaldo
>
> Arnaldo Carvalho de Melo (2):
>   perf evlist: Add a method to return the list of evsels as a string
>   perf record: Improve 'Workload failed' message printing events + what
>     was exec'ed
>
>  tools/perf/builtin-record.c |  8 ++++++--
>  tools/perf/util/evlist.c    | 19 +++++++++++++++++++
>  tools/perf/util/evlist.h    |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> --
> 2.26.2
>
