Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF674C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C084B60F8F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhHCNZy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236257AbhHCNZy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 09:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5190260724;
        Tue,  3 Aug 2021 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627997143;
        bh=DBOV+sLiodjz3XvPMCJ9WYSqkgPQ9eyjU6qlmV9sTnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLrIqT8ZSitrWbItGqotK8VV4e7xnJcRWjHrWbOpRdfAw7cX/fbVc3sfzvDydHBSZ
         kCvXnidOB66jp12gzN83usgAsim1dDd0yID9S+bEyOQHSmymGJ/u77J+0dy79woVTQ
         ye6xytHFABNP0OJJDka1z9HcJgmXDKK9eKq4iF7B1rLkZDD9Lxrb2gZd6MSPfbfRo9
         FLJs7Xay/uR8u19qeHNBxfyGTMrXt08wuDa0TkvCrp3fbPlaMyBc1wt8OLhJlGBw6o
         qkHpAB+o0uecU6Y6MhzT2rdrTAC0wPlTI86eTQ7MvjU4Bb5+VLVgc6xHit8ZpK+6Se
         0R5Qdc4QdH3Vw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0593F403F2; Tue,  3 Aug 2021 10:25:40 -0300 (-03)
Date:   Tue, 3 Aug 2021 10:25:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 5/6] perf cs-etm: Improve Coresight zero timestamp
 warning
Message-ID: <YQlD06FZ3SyBeolc@kernel.org>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-6-james.clark@arm.com>
 <20210802151710.GB148327@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802151710.GB148327@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 02, 2021 at 11:17:10PM +0800, Leo Yan escreveu:
> On Thu, Jul 29, 2021 at 04:58:04PM +0100, James Clark wrote:
> > Only show the warning if the user hasn't already set timeless mode and
> > improve the text because there was ambiguity around the meaning of '...'
> > 
> > Change the warning to a UI warning instead of printing straight to
> > stderr because this corrupts the UI when perf report TUI is used. The UI
> > warning function also handles printing to stderr when in perf script
> > mode.
> > 
> > Suggested-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 3e1a05bc82cc..5084bd2ca6eb 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -324,8 +324,11 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
> >  		 * underflow.
> >  		 */
> >  		packet_queue->cs_timestamp = 0;
> > -		WARN_ONCE(true, "Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> > -				". Decoding may be improved with --itrace=Z...\n", indx);
> > +		if (!cs_etm__etmq_is_timeless(etmq))
> > +			pr_warning_once("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> > +					". Decoding may be improved by prepending 'Z' to your current --itrace arguments.\n",
> > +					indx);
> > +
> >  	} else if (packet_queue->instr_count > elem->timestamp) {
> >  		/*
> >  		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
