Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4851DC433FE
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300C060F5E
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhIEV0N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbhIEV0F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:26:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0405C0617AE
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b10so6863451wru.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIKy04n4SEct/kBbtr4jBMWbMzYLLzxmc9yw++ulVoU=;
        b=N86W1IJOKcV1SWTuhSmRlI5f79Nw7JC6F4ceQ/Ln9kz/BYw523ugT825Kz8NTbj2VJ
         Crzbo9kRW3fOSx1/YJX2cbCVDP4qSKRNNLFiyGa0qgRYfsyREy+GeviXzVaLD4syt5dd
         q1fAf1/Ffo1HEv9VynbKrlvhVsweqb9DgkyZS+4fAXSk7fStMFVWVueqUaVr9d/BILri
         zuqIcBp1psUJ7MxYrltDKT0tuuazHRi1UF7xbvtZKa823O68Hn24UfQFP2/gWiDOylV3
         eMhkR1BdSmnNy1TEOMm17gH08mSMmmqMiOcR3fJWFegqGP7D73PE3ZhOff43L2tq8nDU
         tZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIKy04n4SEct/kBbtr4jBMWbMzYLLzxmc9yw++ulVoU=;
        b=dGRoG4E6nlqzw3JhFUCuflpNwYuhWcz8FvBDvVu49/7fa32o3GmgjYbsVa3EbgtKFm
         hkWlcMSfdykxn26TQlal7h7K7JpesJWe9GK/TA+E6sm0ysAZOMfd+QuTAU3v3inEcvBH
         tV1hji2FXuNGoH/DqECnRa6R4XGqEvKhjGoH8nIw1iuFe4Ib2VeFtaBLB/QbI7mlkbKh
         gT6BBCXNk4xUu9hytFHe1WKWFVvmkJtspv4G8odC7r8bRFv5woPKjDZHTsr5143fBn3T
         6O3XN0JZ9HWKHiVxJQFg54dx5H7XdQuLBf59sNrMYWnZdWPeQ+7YX9jLKa01+MQ5ioBP
         Q5pw==
X-Gm-Message-State: AOAM530FLJXaZRvrX0+FCQkEq29byU00OoGPFx0l23cazAQMopeh4O1K
        n75bDDFs5A9pPruz0rKA6WG+i/I6H8Tth0UF7HdVXg==
X-Google-Smtp-Source: ABdhPJyHhGbGj5/aBMqLo8ftUlD+qEetFvZ8k0dh0n4d01mLIXJijTpRitU0QwB/MbTek9ZpkSOtY9r9e3sc4Yvxwko=
X-Received: by 2002:a5d:4a08:: with SMTP id m8mr9717729wrq.263.1630877097634;
 Sun, 05 Sep 2021 14:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s> <YS+iOrcPTzQfmbqU@kernel.org>
 <20210902174851.GB1078000@p14s> <YTEVwVCWoS8cgqql@kernel.org> <CANLsYkxhj1RkJ+BYLGBZ=c=VHT6ayfHvP_T68xGxcnsKQXEVxA@mail.gmail.com>
In-Reply-To: <CANLsYkxhj1RkJ+BYLGBZ=c=VHT6ayfHvP_T68xGxcnsKQXEVxA@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:47 +0100
Message-ID: <CAJ9a7Vh48zXnh8Wq8FDAik2GbX6JCnoq=h7B6wokkht0KRb7WA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic number
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Thu, 2 Sept 2021 at 20:22, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, 2 Sept 2021 at 12:19, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, Sep 02, 2021 at 11:48:51AM -0600, Mathieu Poirier escreveu:
> > > Hi Arnaldo,
> > >
> > > On Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > > > for a potentially user facing issue. If we add a new magic number in
> > > > > > the future, perf will be able to report unrecognised magic numbers.
> > > > > >
> > > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > >
> > > > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > >
> > > > Applies cleanly to my tree, test building it now, holler if there is
> > > > something that prevents it from being merged.
> > >
> > > Have you already merged this?
> > >
> > > If so than let it be.  Otherwise please hold off as I'd like to take a look,
> > > something I intend on doing next week.
> >
> > Ok, I can remove them from my local branch, but this may make this miss
> > the v5.15 merge window, please advise.
> >
>
> Nah, leave it in your branch and proceed for this merge window.
>
> > - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
