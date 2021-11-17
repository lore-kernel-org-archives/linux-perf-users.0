Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE3C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9F061AA3
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhKQPcp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237806AbhKQPcp (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 10:32:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BFAF61A64;
        Wed, 17 Nov 2021 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637162986;
        bh=wBhs8OiE6DLnIqc6LmSUDGkwqqTdHTFdXmF1wF4mCRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2btentXfgkYyQ0S6rVw8FlO/LHbCdFdN3JtLIzdRV2fceovBrfW0n9lTv9cQ8Uvp
         FAtU8R6MEmg7p+xj9GIBXr4I+/CCtSrJ0iclUEeVdZIZwES3OHOrDi6aUgk2xuF9q0
         fRONEr7FD+3rbBgmY/yDjfAlwp6Legyw/6qVzUf03xzntNjG+bUNWfeX4emHcbO0s7
         XGIfWKQy2MCrCz7+g4sEC2uNO7GXqAXdeO+qXbymkSGgU3uZZyGs7Q4KAq1cAiXS2H
         +IBokbRk3YbCCZOKkL/utss1/eSspytWJCCXqHn6QCiJPSCucwn7dsVQ4p0hv8BP/j
         sARiXvkAlmfzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B07654088E; Wed, 17 Nov 2021 12:29:43 -0300 (-03)
Date:   Wed, 17 Nov 2021 12:29:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] perf arm-spe: Inject SPE samples in perf-inject
Message-ID: <YZUf5zu4aOfoIhFl@kernel.org>
References: <20211105104130.28186-1-german.gomez@arm.com>
 <20211105104130.28186-2-german.gomez@arm.com>
 <5163f41f-2337-6557-ca91-fb2c66738872@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5163f41f-2337-6557-ca91-fb2c66738872@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 08, 2021 at 08:39:58PM +0000, James Clark escreveu:
> 
> 
> On 05/11/2021 10:41, German Gomez wrote:
> > Inject synthesized SPE samples during perf-inject run.
> > 
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Next time please expand this explanations a bit more: why should we
inject such samples? Is this enabling some new mode of operation, fixing
something, what is an example of output before this patch and after it?

- Arnaldo

> > ---
> >  tools/perf/util/arm-spe.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 58b7069c5..7054f2315 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -51,6 +51,7 @@ struct arm_spe {
> >  	u8				timeless_decoding;
> >  	u8				data_queued;
> >  
> > +	u64				sample_type;
> >  	u8				sample_flc;
> >  	u8				sample_llc;
> >  	u8				sample_tlb;
> > @@ -248,6 +249,12 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
> >  	event->sample.header.size = sizeof(struct perf_event_header);
> >  }
> >  
> > +static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
> > +{
> > +	event->header.size = perf_event__sample_event_size(sample, type, 0);
> > +	return perf_event__synthesize_sample(event, type, 0, sample);
> > +}
> > +
> >  static inline int
> >  arm_spe_deliver_synth_event(struct arm_spe *spe,
> >  			    struct arm_spe_queue *speq __maybe_unused,
> > @@ -256,6 +263,12 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
> >  {
> >  	int ret;
> >  
> > +	if (spe->synth_opts.inject) {
> > +		ret = arm_spe__inject_event(event, sample, spe->sample_type);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	ret = perf_session__deliver_synth_event(spe->session, event, sample);
> >  	if (ret)
> >  		pr_err("ARM SPE: failed to deliver event, error %d\n", ret);
> > @@ -920,6 +933,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
> >  	else
> >  		attr.sample_type |= PERF_SAMPLE_TIME;
> >  
> > +	spe->sample_type = attr.sample_type;
> > +
> >  	attr.exclude_user = evsel->core.attr.exclude_user;
> >  	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
> >  	attr.exclude_hv = evsel->core.attr.exclude_hv;
> > 

-- 

- Arnaldo
