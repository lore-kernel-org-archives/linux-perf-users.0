Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924FC38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 09:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJXJSL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJXJRs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 05:17:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181869BDE
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 02:17:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e129so8182364pgc.9
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E90yK8wonsHofoZqda9QGC2Kinjyxdvs/JNsLBuhZMI=;
        b=MuoVAmKPz2IxYaB6nczSI3E/Y78v4f7sUKyAPkUGTb+M0iiZq8IbgRw2u3QZBpnPRT
         gY0MPc0a/UMRoBuLKRtHRuZXNgLEOBivRI5jA/qFOuHnnjpOOl/b8/letmaAkKnbvAEX
         hhR4hrNkB5RcVMqnU+t8LraIPg3UQIPhrINtWSqpzp+Y7BbBAkyAq/zaJuGsYquGFeiH
         6CohnitTxgTfgOBtQdYzjmh09lu/FfcARO7EeNEn9NggZhWu+vs32ny0P2F9LgsxJHBu
         LhkYfrWzV4+NgLH+MVob7G6gocLimybd5usm7JFM98WY3aPSp6sx49AF3URCGqGvOweG
         Qh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E90yK8wonsHofoZqda9QGC2Kinjyxdvs/JNsLBuhZMI=;
        b=QbdSz0ZsmIFRuN+Jm5UDZ59IfHjGQMscaon+URN4oKlOEfFG+ASue7CMY2Hv2FSi/i
         20fO33r6dZWz8xQ1VEE8xEW5DqbnpK3SUqQNQiy1xgI8nS9OUJj3n6IgjNCTra7TG0r8
         QASF6W6pt8LtqlLQbXUsyLTEpX0j1noN4vjkch9yynPZlB1UDOrwb4srwD7QaqKk6Nec
         v6aguRhSnnZT9qkxgR+K5ENobSKtMX5w17ajxwzk0Ks8r/Q73iUBMp7xDJwBBx6JQEoV
         VSX6xb7YaenujF7SKj9V/xJTvhR2T5BKcAZuaJfp0NWIhyjscL/2uVskFxk5fyKUK+Yh
         5Vlw==
X-Gm-Message-State: ACrzQf2bVPNNAu6Rl8ohgqptz2dsXjyN85xhdxxP1pOBmNugANNarIYd
        V7aMp4xL8iENv3j+lSVCwiTI6Q==
X-Google-Smtp-Source: AMsMyM6+5BaNoVlMbXOb9WhEsuyIraEFR5wrdMYEtNDGK09RXK2gptzkDetXYlPoHQqDgdHXzcybXw==
X-Received: by 2002:a63:1f0d:0:b0:464:69f8:1cbc with SMTP id f13-20020a631f0d000000b0046469f81cbcmr28015852pgf.574.1666603025252;
        Mon, 24 Oct 2022 02:17:05 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0018693643504sm3269727plb.40.2022.10.24.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 02:17:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 17:16:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf record: Fix event fd races
Message-ID: <Y1ZYCD1LjC5OhWsq@leoy-huanghe.lan>
References: <20221024011024.462518-1-irogers@google.com>
 <Y1X+7FCemionnepj@leoy-huanghe.lan>
 <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Oct 23, 2022 at 10:33:30PM -0700, Ian Rogers wrote:

[...]

> > > +static volatile int done_fd = -1;
> >
> > Here is a bit suspecious for adding volatile qualifier.  See the
> > document: process/volatile-considered-harmful.rst.
> >
> > I know the document is mainly for kernel programming, but seems to me
> > it's also valid for C programming in userspace.
> >
> > I not sure what's the purpose for adding volatile for done_fd, if we
> > really have concern for reading any stale value for done_fd, should we
> > use WRITE_ONCE/READ_ONCE?
> 
> We could just switch to C11 and stdatomic. The volatile is consistent
> with the code above and more consistent with the expectation of
> writing to a variable that is read in a signal handler.

Thanks for the info for C11 and stdatomic.h.  The documentation [1] says
the safe way is for accessing shared data in signal handler is:

  static volatile sig_atomic_t done_fd = -1;

It's fine if you want to use another patch to address this issue, this
patch for fixing errno is fine for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

[1] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
