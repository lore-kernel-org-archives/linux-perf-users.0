Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CEC2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6436142D
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 12:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEYMwU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 08:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhEYMwU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 08:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F83861408;
        Tue, 25 May 2021 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621947050;
        bh=iFcdOQW8C7RB7FFaCRuxpF8s81TWClQVaJZ8VnFTLkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6gxqORWw9MQg5CPnjggOE9COf9dToMZKVSYR2G8HhuhDlCDbMmyCi6ews2vwS2q8
         Q4NfoBzkUct7ZtmNCGx92mBmxk12jNdHmBkqxXtwXLZuJMOZWRS+cW4QDjdDBRTU/x
         ymljnjOLM8vj+Tq9ICUEC2fHbqnzdmoFP3sN+j+IXjGqrcFtx59rgUKCxj/RtVIidj
         a1Q+uixqauVYwDUAJ3mGWUvhmRHFmYqjz+9kJyDVQgWUqPCGCZCIze31Px6zXck6iO
         AZB8hZsWZ7yQtF2tHnc3HzGRru3RVr+dD3pv63dUscQ0qekKxmOqwkGrF/pEgwicFP
         DDSur+Hg2QFag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB4B24011C; Tue, 25 May 2021 09:50:45 -0300 (-03)
Date:   Tue, 25 May 2021 09:50:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf arm-spe: Remove redundant checking for
 "full_auxtrace"
Message-ID: <YKzypV/rlCDXg0Q0@kernel.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
 <20210519041546.1574961-5-leo.yan@linaro.org>
 <326bfc02-e02d-997b-2f7f-1c0565f4d5cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326bfc02-e02d-997b-2f7f-1c0565f4d5cc@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, May 25, 2021 at 03:03:53PM +0300, James Clark escreveu:
> 
> 
> On 19/05/2021 07:15, Leo Yan wrote:
> > The option "opts->full_auxtrace" is checked at the earlier place, if it
> > is false the function will directly bail out.  So remove the redundant
> > checking for "opts->full_auxtrace".
> > 
> > Suggested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/arm64/util/arm-spe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index bacdf366040d..a4420d4df503 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -116,7 +116,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  		return 0;
> >  
> >  	/* We are in full trace mode but '-m,xyz' wasn't specified */
> > -	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> > +	if (!opts->auxtrace_mmap_pages) {
> >  		if (privileged) {
> >  			opts->auxtrace_mmap_pages = MiB(4) / page_size;
> >  		} else {
> > 
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied the series,

- Arnaldo

