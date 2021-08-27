Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A84C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 00:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9053260FD7
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 00:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhH0AeQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:34:16 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37559 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhH0AeQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 20:34:16 -0400
Received: by mail-lf1-f41.google.com with SMTP id k5so10699556lfu.4;
        Thu, 26 Aug 2021 17:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96MOb4RI+nTuXf2CZFEvazqidNFnAA9LZw0UQN78jnM=;
        b=UgpqEuSxn4B2uZNoqU17fiYnX+UU+vTghS4CQ3nal6zGRlJi/bo9qgUj4VPSk1xL/m
         stBfRHPRB+H7u8ut56cWvGSWCSYn2RF9el7F8vHJPgVAwN/61gRFo7fuGgGNMHshjA/d
         ZlsJaGpY+rwT5j+5GELni9Ig4BtC4SjCN9gptEGN7Hdcs7Y21/4jPca4XWe4nCblBYVD
         yHssP64oMjzC2x7piztrNmzpvyYA8Nd0OtRU1pOxAeZPLTXsqpfkpN8+1N+iSPhFMuqX
         gSPLbdhHCm47Dq4Or9PVRfZ9sywQ67+j63xY3f93fwxyzyAUIaE3KZlonsJe8sI8GxuN
         QoIA==
X-Gm-Message-State: AOAM530qhc3sOhrwKtOfOMBVWAX5n7GPr5WZq+cdgUyI8BH8BhPowh0j
        Be2x2vHkY0fd4+9HXRxDXjofrGK9Hv1pd7XywO8=
X-Google-Smtp-Source: ABdhPJy43PDtHDd/exkSQTJRk3jpVDi7awHFab8tiqXDE8RL9XqpDJpB56nBpFDEMtyC1w217Vh0AB/FisHHGgfNORk=
X-Received: by 2002:a05:6512:158b:: with SMTP id bp11mr4630375lfb.300.1630024407310;
 Thu, 26 Aug 2021 17:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com>
 <b7a9f309-9765-2a64-026e-efa835989add@linux.intel.com> <CAP-5=fV1+WKKWVYVivDt1uE8P9koKre-=Boh0-P1vTD6uiw2=A@mail.gmail.com>
 <YSUztlMX8u0P527q@kernel.org>
In-Reply-To: <YSUztlMX8u0P527q@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 26 Aug 2021 17:33:15 -0700
Message-ID: <CAM9d7chJTLeVcqyVvXhBDbUVtdZU+2tdwTyWuX8vdhKd3RQxiA@mail.gmail.com>
Subject: Re: [GSoC] Multi-threading in perf: Final Report
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 24, 2021 at 11:00 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Aug 23, 2021 at 01:47:51PM -0700, Ian Rogers escreveu:
> > On Mon, Aug 23, 2021 at 4:40 AM Bayduraev, Alexey V
> > <alexey.v.bayduraev@linux.intel.com> wrote:
> > >
> > > On 21.08.2021 12:41, Riccardo Mancini wrote:
> > > > Hi,
> > > >
> > > > this is the final report of my project "Multi-threading in perf",
> > > > developed as part of the Google Summer of Code with the Linux Foundation.
> > > > https://summerofcode.withgoogle.com/projects/#4670070929752064
> > > <SNIP>
> > > >
> > > > Review activity:
> > > > PATCHSET Introduce threaded trace streaming for basic perf record operation
> > > >   Link: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> > > >   Contribution: helped in fixing some bugs, performed extensive testing
> > >
> > > Hi Riccardo,
> > >
> > > Thank you very much for the deep review and extensive testing of
> > > this patchset, it was very helpful and allowed us to improve
> > > the quality of the feature used in our product.
> > >
> > > Good luck,
> > > Alexey
> >
> > Likewise, thank you Riccardo! It is always implied but not said often
> > enough, thank you Arnaldo! I'm hoping the success of Riccardo's work
> > will be an example for next year and we can also get more mentor
> > volunteers.
>
> Yeah, it was a great experience, now we need to actually do the tests
> Riccardo asked us on big machines and get his and Alexey's work
> processed :-)

Thanks Riccardo for all your good work!

Namhyung
