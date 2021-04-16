Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C2C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0061361026
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 15:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbhDPPSq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245739AbhDPPR0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 11:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5123661166;
        Fri, 16 Apr 2021 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618586216;
        bh=U93wI/FdWrUToBu8xZjlCo5IjUY1zrGhkG1tmpB6jGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BG1mRRXwmGmYEatJ7hn+/b4sdc0bea/LF5LZL+7azKC1m546u0t3WNtPN24fnip1d
         62V7nGQXoSLADrUIk8CCPbwNVDlm8A1CKBy2yM4hzHEvTxRCWNUlb3fYg+QafktTiD
         8SHQG/6/kiOumsvF2zTCOE4UaAdBV60IbbC6H8tyxVvXLysc3cuwoJyzv4E6ojdmqF
         nIOG1xrRG55RzZFhC58a1TFQ/AX//VzPf9YnZjsOqYUo6GmrcN8gnR7VHPPUwEc/QP
         bfBeoYYJEQpLewUnjxZdzhauyHI6PKSkjM4dxLioZzdZIAFA30mOAP+7zkXk3U7/Ie
         HHHYNkg/yyatQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D90F040647; Fri, 16 Apr 2021 12:16:52 -0300 (-03)
Date:   Fri, 16 Apr 2021 12:16:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <YHmqZKGMFydbsvEy@kernel.org>
References: <20210416105632.8771-1-james.clark@arm.com>
 <20210416150709.GA1046932@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416150709.GA1046932@xps15>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Apr 16, 2021 at 09:07:09AM -0600, Mathieu Poirier escreveu:
> Hi James,
> 
> On Fri, Apr 16, 2021 at 01:56:30PM +0300, James Clark wrote:
> > Changes since v1:
> >  * Improved variable name from etm_timestamp -> cs_timestamp
> >  * Fixed ordering of Signed-off-by
> > 
> 
> You forgot to add the RB and AB you received.  Since Arnaldo is responsible for
> the perf tools subsystem, please send another revision.
 


Yep, please collect Reported-by and Acked-by as you go sending new
versions of a patchset, the last one I don't have a problem collecting
myself, but if you have to resend, please collect the feedback tags.

- Arnaldo

> Thanks,
> Mathieu
> 
> > James Clark (2):
> >   perf cs-etm: Refactor timestamp variable names
> >   perf cs-etm: Set time on synthesised samples to preserve ordering
> > 
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
> >  tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
> >  tools/perf/util/cs-etm.h                      |  4 +-
> >  3 files changed, 39 insertions(+), 35 deletions(-)
> > 
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
