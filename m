Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12515C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B2260F22
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 19:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhHQT5c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:57:32 -0400
Received: from one.firstfloor.org ([193.170.194.197]:35450 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQT5c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 15:57:32 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 784D9870CD; Tue, 17 Aug 2021 21:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1629230216;
        bh=It4qDj6D2OTRCG72jSw8ARvCnvRxSIBuCi8hcbrGBGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLwvKcGS8LLxjJucyhjrm7cJ7KJRPZo47FnkFzh3RIQ95t0khDtCSCAAIiQeGBIll
         uaX2YFZa7bap1hScQ/zQxcl2CI6+oHrVmL/tRFYVj2C3jcGO9J0SEl3gQjmKto4R9h
         lPwhRhs2Uy8nyaPdaJXVCDQTPvk7tX71LrTu4+Ho=
Date:   Tue, 17 Aug 2021 12:56:56 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Claire Jensen <cjense@google.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, song@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alexander.antonov@linux.intel.com,
        changbin.du@intel.com, liuqi115@huawei.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
Subject: Re: [PATCH v2 1/1] perf stat: Add JSON output option.
Message-ID: <20210817195654.lrrytkgs42zcvr62@two.firstfloor.org>
References: <20210813220754.2104922-1-cjense@google.com>
 <20210815144007.3e7cwiecbre2nt6y@two.firstfloor.org>
 <CAP-5=fUg=LU96ATtZ4OtJpyfe75bHwpkD+XTkoZPXVeJdPAVOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUg=LU96ATtZ4OtJpyfe75bHwpkD+XTkoZPXVeJdPAVOQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> CSV:
> https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
> 
> json:
> https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/

How about --metric-only? 

That's another completely different output mode.

Yes agreed a refactor would be useful, but it's a longer term project.

BTW we have similar problems with perf report and perf script output,
but stat is probably the worst.

-Andi
