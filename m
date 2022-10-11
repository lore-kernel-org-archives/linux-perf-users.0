Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F71C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 06:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJKGOO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJKGOM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 02:14:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E486F9B
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 23:14:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so19927056wrp.10
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0TA01kmXvUPheOdi7PWrUQ8bC3Ldfd2bpo9D/D22tM=;
        b=iC8Eu0A8wEOIQzqpkvvzA5G1HbHcX08LWn+3fxHRuBbycUMKDEiGW+E61qErnMIYyR
         yrx+HfbgY8Qqm1ugiweoYpOLnv1vhkB3G45aesBxxS+VDScoVfIYRpxvSHmP9Lu+w2sw
         o/M6TU5EUPZ3Qq54Io7SK7SF86iIoBkGN1eZqFaYLEpCYE5z97wTLuAoNFv/r3L3C+3F
         jlpiB4IWbaRUHvsLIkhkEqYXXFj2v8J8Gb0o9jlxk9diN7addgalt/LuF0qZCjWU4kiG
         WRzIOw+XmYZY+ohLCb+t6S+DGABWLXy7FEWgR6YIY3uzKPdcEJ9Fb/tyeIED+gAxjTPM
         lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0TA01kmXvUPheOdi7PWrUQ8bC3Ldfd2bpo9D/D22tM=;
        b=hufd9vvtIOKoJ1kDkSJmTYBLTx4lDtouCkevemwMacCoawqHfni8BJpZ8Z08D5Vrlg
         AzH0kjyeVX+S/JQqwHNIlp385ApwlKaLLTnRfxTHkjbGKGfF/qMyKOzYPtiCmda5Y1Sy
         LbPecNgYuVv8dvhPnbTps1p+1HGYYYXIutEypG+3rNeiqlSWw+ixCporQrRj0Be7SQ0R
         GDA/c/6N3rGUAZKSvWvKggof8IXZOB2GGSA0cjOBt218mf5TT+hyPSqo2xRT7gzxQnke
         0qZ54ElgwUZvHVeuKVnY+YS39RpjEkn9tGPsapHitlYHBhPZCQsNvuhBYK6W3SBQ7UtW
         Il9Q==
X-Gm-Message-State: ACrzQf1IdFm//qX9EY1cuBRtOVVGMzdxfQxvQhZvS1y3qAv2ahQ5IdK0
        orT7oAa5ITI+/pMYGgIUtiveO87tIY7q/YPVfN3bUpw57zw=
X-Google-Smtp-Source: AMsMyM4po/TUMzer633bzFCiLbaL2CzyI5TuuP7AvvnC2XdtbUaJ40NnyZRtYuz86VtweGhBBw25opHmCHt06h6M8O0=
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id
 y15-20020a056000168f00b0022e04c3de09mr13585250wrd.40.1665468838995; Mon, 10
 Oct 2022 23:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
 <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
In-Reply-To: <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 23:13:46 -0700
Message-ID: <CAP-5=fUK8VXZAyjTVQ3e88F5AeYfEF5PP-=k=PoFONWpXE+XVA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 10, 2022 at 10:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Andi,
>
> On Mon, Oct 10, 2022 at 5:25 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> >
> > On 10/10/2022 10:35 PM, Namhyung Kim wrote:
> > > Hello,
> > >
> > > Current perf stat code is somewhat hard to follow since it handles
> > > many combinations of PMUs/events for given display and aggregation
> > > options.  This is my attempt to clean it up a little. ;-)
> >
> >
> > My main concern would be subtle regressions since there are so many
> > different combinations and way to travel through the code, and a lot of
> > things are not covered by unit tests. When I worked on the code it was
> > difficult to keep it all working. I assume you have some way to
> > enumerate them all and tested that the output is identical?
>
> Right, that's my concern too.
>
> I have tested many combinations manually and checked if they
> produced similar results.  But the problem is that I cannot test
> all hardwares and more importantly it's hard to check
> programmatically if the output is the same or not.  The numbers
> vary on each run and sometimes it fluctuates a lot.  I don't have
> good test workloads and the results work for every combination.
>
> Any suggestions?

I don't think there is anything clever we can do here. A few releases
ago summary mode was enabled by default. For CSV output this meant a
summary was printed at the bottom of perf stat and importantly the
summary print out added a column on the left of all the other columns.
This caused some tool issues for us. We now have a test that CSV
output has a fixed number of columns. We added the CSV test because
the json output code reformatted the display code and it would be easy
to introduce a regression (in fact I did :-/ ). So my point is that
stat output can change and break things and we've been doing this by
accident for a while now. This isn't a reason to not merge this
change.

I think the real fix here is for tools to stop using text or CSV
output and switch to the json output, that way output isn't as brittle
except to the keys we use. It isn't feasible for the perf tool to
stand still in case there is a script somewhere, we'll just accumulate
bugs and baggage. However, if someone has a script and they want to
enforce an output, all they need to do is stick a test on it (the
Beyonce principle except s/ring/test/).

Thanks,
Ian
