Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE9CC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8712960243
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbhHFSg4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFSg4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 14:36:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F34D061050;
        Fri,  6 Aug 2021 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628275000;
        bh=7kLgMLAVZMaJQW537DPU6fs5U4Fhrbh8Tm4DF6ri2dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0dcrqEet9R8gwt+oDL0E0Qj0oqZQcdhtOl7MuumECaoK5Kp//8beIqZw4I95Gigp
         +Gm7N3EVsRSZwRKDkmjD0i1zMtNLEK85NwaxaxtLzfR9cinwd/5Fhg2VdXL+S22kHQ
         RR294vVfhE8cJoFEDDRBaEJzPwSsIMXseYADtL5+rAS8trGtaZiWFAS1aZ6guIFTW4
         ZbDRhjWLsAsHE8uI60vTF9K5Nh0egokV3OwK06/cE0y47lmVZ1vV0peqG9ac6jKQ1P
         Oco1bav07uN5vNZ+1/gT2pCwWT/61IB5iraAMgwwFa5nHz1RfhF8q3LyC7xp42e1jL
         h5x8Rmo33sW1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44EE9403F2; Fri,  6 Aug 2021 15:36:37 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:36:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <YQ2BNSpxCfG7IL70@kernel.org>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
 <20210802154145.GC148327@leoy-ThinkPad-X240s>
 <YQlDefz+g45dqFsP@kernel.org>
 <20210803140122.GC247709@leoy-ThinkPad-X240s>
 <b03f9794-ff84-c869-0370-e8f13c577ed5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03f9794-ff84-c869-0370-e8f13c577ed5@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 05, 2021 at 01:59:49PM +0100, James Clark escreveu:
> 
> 
> On 03/08/2021 15:01, Leo Yan wrote:
> >> one can also use debuginfod-client, which, as time passes, probably will
> >> be the main way of finding DSOs now that we have build-ids in
> >> PERF_RECORD_MMAP2 and debuginfod servers such as:
> >>
> >> export DEBUGINFOD_URLS=https://debuginfod.fedoraproject.org/
> > If so, maybe should use more general description for missing DSO.
> > 
> >> https://fedoraproject.org/wiki/Debuginfod
> >>  
> >>> With this improvement, the patch looks good to me:
> >>>
> >>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> >> Does this apply to the other 5 patches in this series?
> > I finished to reivew patches 01, 04, 05, 06/06, so my review tag can
> > apply on these patches.  Current patch 06/06 needs James to improve for
> > the comments.
> 
> Thanks for the reviews, I've submitted v2.
> 
> I also had a play around with debuginfod, it looks promising.
> Especially if it's integrated with perf report, which I assume is the plan?

Yeah, code is needed for that in the underlying symbols library so that
we can tune its usage, i.e. the threshold of samples to trigger asking
for the auto-download of debuginfo files.

- Arnaldo
