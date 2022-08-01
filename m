Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC3C00144
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Aug 2022 13:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiHANZU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiHANZT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 Aug 2022 09:25:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7AB6589
        for <linux-perf-users@vger.kernel.org>; Mon,  1 Aug 2022 06:25:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id rq15so14311167ejc.10
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Aug 2022 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HFfO1HMBlAYBBkGgrC3Zdil9m8wfHsNvxnffG7KMRuo=;
        b=NmziJKJz1JfpVQc2os/blbsd+CkXJlYxuJ4vDzaF7b39G295OU5bumPkdwFdj6bDit
         EqmAmQZ2KTW3KWsUS3rmNaXkL0x69Wa7iBop+DaPrcbnajH+V+Y55VyU65Q8YaNth8uJ
         rf9XupigkmQo98VrQknB34nkIzsO1Pl8qtJdUdzIHia4Ijr86w2r10dRJAd6IioMBH48
         VsimMUdUpwI7rKonMC0GX4dnt1vAmtBKQUjNcYh1a3JGUmWg8D1e9TI65QKQw4mebBDq
         Uh6baa7v1mTSQUnzOPvinTGpFuPFRan99auvMCWRiZ2coKShMA2h9e9vZUnK+2jkIA4J
         430Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HFfO1HMBlAYBBkGgrC3Zdil9m8wfHsNvxnffG7KMRuo=;
        b=3U0UI2eMqCtx0YmzZIzcBLqnayE/QEhUuWhBHeC5WdL0+f8HPub6SZK1oA15h7ISwF
         QS+tZyAlKSiADaPYqLs0MNBCVrQeFoXH53gP5oQOAV1Q7ebFBgTIT11Uk+WgY4ykKt+w
         XPJKbykKNBq4N9NZEWejmXZpD1F4YC5TKN2Yq7BPfjj2ZKSUY5VRFOPL345AbrRCNb0P
         su0hfIFdU/qlVLc9UK1e+sR3zDO4dow8+exTeSB8BJwmzO7SZBSQihOA1F6vq5U/ivpf
         TFY7gBBcDzDMsLfXuf+Evimbw70SwNsgQrl0OrArARmLPnRMLstq18IZoomGxp6pfIXv
         uG3Q==
X-Gm-Message-State: AJIora/wTl2qEOKU8HsakStEN7zM6s3+LwpErpo0MMhNYzAkCDgSkNy+
        HTJs3fob26SLNSgdBdhhghGmTg==
X-Google-Smtp-Source: AGRyM1s67iEUBhHkvP0MHbGo0vD5PEpxwXHO/mMEOKvBcb/StnN9Hw6N6KaDK84FWUk/YPlKNqRnGQ==
X-Received: by 2002:a17:906:cc17:b0:72b:4561:9153 with SMTP id ml23-20020a170906cc1700b0072b45619153mr12127952ejb.249.1659360316572;
        Mon, 01 Aug 2022 06:25:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b006fe8b456672sm5171255eju.3.2022.08.01.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:25:16 -0700 (PDT)
Date:   Mon, 1 Aug 2022 21:25:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220801132511.GC73228@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufJP5YqeEBM51HL@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 01, 2022 at 09:38:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 31, 2022 at 11:19:15PM -0700, Ian Rogers escreveu:
> > On Sun, Jul 31, 2022, 6:53 PM Leo Yan <leo.yan@linaro.org> wrote:
> > 
> > > On Sun, Jul 31, 2022 at 09:49:23AM -0700, Ian Rogers wrote:
> > > > The perf jvmti agent doesn't create program headers, in this case
> > > > fallback on section headers as happened previously.
> > > >
> > > > Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not
> > > set")
> > >
> > > It's good to change fix tag as:
> > > Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> > >
> > 
> > Doh! I was rushing this morning. Thanks for catching and reviewing!
> 
> I made the adjustments and added a note with the repro, to help in the
> future when trying to test this area.

Thanks, Arnaldo.

> I also think we could have something like a 'perf test' mode where, when
> asked to, it would enable tests that involve downloading such files to
> perform tests, such as this dacapo benchmark, and then would test if the
> output matches expectations.

I will add a testing based on the steps, alongside with the discussed
testing for data symbols.  Will share out after get ready.

Thanks,
Leo
