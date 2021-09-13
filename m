Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAEDC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BFF61106
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347629AbhIMTyw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347625AbhIMTyv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Sep 2021 15:54:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA966610F9;
        Mon, 13 Sep 2021 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631562815;
        bh=gja3Lq8kJyo0jFxR+Lk017Y+M1k5exr3M+MtPxjCvPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeCBVhTnmsUkwtZb5jl1TrqeQ4Q4/S1Wz/03BQq2hCy34Nkr51d5nVRkEY22pM1jg
         XqdwhpwcFuo48DVKP+avNqreyakJw0QF2bHiPMoTzqT5BWi8ejGs1+gkN82UeyQVCz
         EuTTDz8tWOdqQoijUAQHqlVvLEm/4w3yE9wiJ6/qexYijhUOBu4GaLhOPRQ0IWQNgV
         3jx+6sLv2kYrhXggLjdpAWuuJCA+LOyFlv67Iy2ngck/ErFJhX6zT9K4mQHDecrrWz
         G6fD2KbJwtZjxapeYB1/xHvsKfnxPOHqt+f41UAmko6xV8i3msu+mHGA0k/FMo9nc3
         k9WSd7JgbYDcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 280E84038F; Mon, 13 Sep 2021 16:53:31 -0300 (-03)
Date:   Mon, 13 Sep 2021 16:53:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kim.phillips@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf annotate: Fix fused instr logic for assembly
 functions
Message-ID: <YT+sOxJeEplSm2pl@kernel.org>
References: <20210911043854.8373-1-ravi.bangoria@amd.com>
 <YTz9nfyXOSXDdpSE@kernel.org>
 <211bb79d-80ff-e9b6-1851-1aaed987301d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211bb79d-80ff-e9b6-1851-1aaed987301d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 13, 2021 at 09:54:00AM +0800, Jin, Yao escreveu:
> Hi Arnaldo, Ravi
> 
> On 9/12/2021 3:03 AM, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Sep 11, 2021 at 10:08:53AM +0530, Ravi Bangoria escreveu:
> > > Some x86 microarchitectures fuse a subset of cmp/test/ALU instructions
> > > with branch instructions, and thus perf annotate highlight such valid
> > > pairs as fused.
> > 
> > Jin, are you ok with this? Can I have your reviewed-by?
> > 
> > - Arnaldo
> 
> Oh, my original patch could only handle the case like:
> 
> cmp xxx
> je  aaa
> 
> But it didn't consider Ravi's case something like:
> 
> cmp xxx
> cmp yyy
> je  aaa
> je  bbb
> 
> Thanks for Ravi fixing this issue! Backward searching is probably a better solution.
> 
> Frankly I can't reproduce Ravi's case, but for my test suite, Ravi's patch works as well.
> 
> Reviewed-by: Jin Yao <yao.jin@linux.intel.com>

Thanks, applied.

- Arnaldo

