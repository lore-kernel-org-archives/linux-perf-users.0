Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC9C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Jun 2022 21:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiFXVig (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiFXVif (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Jun 2022 17:38:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940817C87F;
        Fri, 24 Jun 2022 14:38:32 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so1496449oty.3;
        Fri, 24 Jun 2022 14:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYcXXZ+B2CoGXK414DiWpGrGWSwnr+1yUkDbpi5uzp0=;
        b=pQB59/ezUxfFdnIG81MtrZP27f+7Zx8Rqa2VYZ4pO7CAHenMqh+RWx7qSQZIHaYaVM
         DjZSXjl8kqh8yEOpY9/OhTzxmZr7bfk7l5KLVXGddYGGAS1k8ZVWSsMtSP2t0UX9jsx0
         8Ce8XsSRthCgmnpjArWVDLzmZqUrbp99dauie3LsUXy8MBaIpsJgjHmOcmSVQAATJDNJ
         tLo2NMd1B78GW+lqZF+rg1DMLiPLtEc7swx21Lmp+URPCS1WM12iZhWWwzUOiCEUenvD
         yJrivt3vo+GNSQ/L6+sfbyC7q1QyXLXtDl+NhQqhfp8/q67aCbxB9MYr4+vlSOdZ7GEm
         CByQ==
X-Gm-Message-State: AJIora+xP0Iw++b2Fn51BSENn+91DiNBAVJ7o8Kx302tGvnn5DJ4ejrR
        kfMj/9y5rrB3hlY6cUt08AU0017wogKwQe78yyZVi7yt9Lw=
X-Google-Smtp-Source: AGRyM1snja+oK2x+mVIkaS3jdsjGyQUiYHxBVdHahnHLf1GDk9E9NQxw3HHkdKm91Ulk3sOxQN6gB1pv29kuV3CLqF0=
X-Received: by 2002:a9d:620a:0:b0:616:afea:1d62 with SMTP id
 g10-20020a9d620a000000b00616afea1d62mr454373otj.124.1656106711634; Fri, 24
 Jun 2022 14:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615163222.1275500-1-namhyung@kernel.org> <CAM9d7cjD=at=AtKmvMLogjN6mieWVR2kk-HigxO01cvPPRGFBg@mail.gmail.com>
 <YrYJq8UQ04FFN12/@kernel.org>
In-Reply-To: <YrYJq8UQ04FFN12/@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Jun 2022 14:38:20 -0700
Message-ID: <CAM9d7cjSPB+YfUBKHC_b3ux8z5r0QOr_B=nbPX62vygOogiVYQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf lock: New lock contention tracepoints support (v4)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Fri, Jun 24, 2022 at 11:59 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 24, 2022 at 09:40:05AM -0700, Namhyung Kim escreveu:
> >> Ping!  Any comments?
>
>
> I'll take a look and test it soon.

Thanks for doing that!
Namhyung
