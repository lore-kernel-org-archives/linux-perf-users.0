Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C061439
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbhI2QxI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245753AbhI2QxH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 12:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 710FA6142A;
        Wed, 29 Sep 2021 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632934286;
        bh=emBPpoiw27wreF76TyqicFzW982o12rjgMyP5kO42rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxwKyz8gPmIzOLiLqCVhtLRuZhUFLFpuejkT2FSar8qtdo+EOspSUF6MFYjbP1cEU
         9OrAuvMhv5RmFhegeZNdChTObQDdNTil49ty6Fpc9RTM6GnJ4M8VSeWBjUB1g/rnOm
         jaPuyn1fc2pEVGBoojpnBbKctDtxAVUGahfFa2ggmSM3XiZlgQCjNKNuxywJbdJgWm
         a2xNdAhonrkQeEG45Dg6sTEwrqIag4oVl69TI4lmNdzgF4srBD4lFiqaU0DM33LVeF
         wQK9rNgbNzyFG1UbBU83rWoTi+hAGJFw0TOlCoTW7eO8SVISPK+lCUr0Ly+3z+lmuc
         DeNksLN6t8dCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66EAD410A1; Wed, 29 Sep 2021 13:51:23 -0300 (-03)
Date:   Wed, 29 Sep 2021 13:51:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v9 00/13] Don't compute events that won't be used in a
 metric.
Message-ID: <YVSZi3PhwsNl3LdE@kernel.org>
References: <20210923074616.674826-1-irogers@google.com>
 <00eb6280-fad0-66c4-b957-a4d27dffd0da@huawei.com>
 <CAP-5=fXcq6Npio0n9y8znknNUGJ4ovtbi=hHr4jWG6H38=BzSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXcq6Npio0n9y8znknNUGJ4ovtbi=hHr4jWG6H38=BzSA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 29, 2021 at 09:09:24AM -0700, Ian Rogers escreveu:
> On Wed, Sep 29, 2021 at 8:16 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 23/09/2021 08:46, Ian Rogers wrote:
> > > For a metric like:
> > >    EVENT1 if #smt_on else EVENT2
> > >
> > > currently EVENT1 and EVENT2 will be measured and then when the metric
> > > is reported EVENT1 or EVENT2 will be printed depending on the value
> > > from smt_on() during the expr parsing. Computing both events is
> > > unnecessary and can lead to multiplexing as discussed in this thread:
> > > https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> > >
> > > This change modifies expression parsing so that constants are
> > > considered when building the set of ids (events) and only events not
> > > contributing to a constant value are measured.
> >
> > Based on some testing on my arm64 platform, no regression seen, so:
> >
> > Tested-by: John Garry <john.garry@huawei.com>
> 
> Awesome, much thanks Jiri, John, Andi for the reviews and testing!

Thanks, applied.

- Arnaldo

