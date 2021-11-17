Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE8C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C866613C8
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhKQPat (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhKQPat (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 10:30:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82FEC6112D;
        Wed, 17 Nov 2021 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637162870;
        bh=enZ2QdOp/6F2W+MIAIGWqVYhk1KVAOIrZCV9SVd4z0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8jnLVJCv/ZOaNpPeYbJQtKfHHuJBpntnU/Z8cMzKvW8Jw5YIj+mDyDSY9hxMKh6e
         KEvyi0cY4jnCTRYzXKGwM1/dC1PemC7C9LOXbxDIFV5qEjsiWxmwdY4fNK60AI+Dgs
         ZIMYLFMy2S9vrvw7G/S78NqEy8XIzsPAShLgZM0rsXhToB6jxSmSKI/rH66QlEsxmR
         BxOau/jNmVKddydJPoVQVf7s69OfaMrm/4/eVch4xiDgucuIRSpO5U9Kcqjt7+l3tx
         02QwqylJ6Lt85Iz4nj62qUpdnkNRPwk0PTRV7n7SDTjg57iuLC0maGe0ylT6NXiEhB
         t1DAFu7+oF5Xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B1AA4088E; Wed, 17 Nov 2021 12:27:48 -0300 (-03)
Date:   Wed, 17 Nov 2021 12:27:48 -0300
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
Message-ID: <YZUfdLsoQJ5Unq1z@kernel.org>
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


Thanks, applied.

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
