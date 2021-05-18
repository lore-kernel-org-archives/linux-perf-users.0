Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B77EC433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6370D6124C
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 12:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349372AbhERMzY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 May 2021 08:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233502AbhERMzY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 May 2021 08:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DC8611CE;
        Tue, 18 May 2021 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621342446;
        bh=9lenmshXeiU9okb7x8EkrhziX5DvkNFHZglZh7iyXh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egpyDl4iUgrv2k9SFO6wiHiM/2OrxIisPsq+vXi7qXou6Y+v69xqzKI/01hNz9h8m
         RzIDqHAjWtdIOzCj0CNZ+aoZhvxZrS5bYUC4e0ay8R+Oymjq41InC9yUU/g4ZsFupI
         UIPaOLRXfaOWmR8FarVNHLvAas8SDJE2Xw8iOqdj33YyItotVb1W16DPzr1fxmYsCe
         bToqkAWhyBYF1LJD88nLHvN/WFaasieqIN+W+lY8aVPUjyzz64m/TW7OMgisxA8pn6
         7jZiE/pduJdUMvuaZdaIU1CjEx60nnqTjBRCUBUfOs5hKCpma7QEA9kmEHvpyCBIoY
         aaUKHr3zM3Bnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84B864034C; Tue, 18 May 2021 09:54:02 -0300 (-03)
Date:   Tue, 18 May 2021 09:54:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <YKO46nX17/GjqJjV@kernel.org>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
 <20210512152330.GA121227@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512152330.GA121227@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 12, 2021 at 11:23:30PM +0800, Leo Yan escreveu:
> On Wed, May 12, 2021 at 05:39:56PM +0300, James Clark wrote:
> > 
> > 
> > On 29/04/2021 18:00, Leo Yan wrote:
> > > The dummy event is mainly used for mmap, the TIME sample is only needed
> > > for per-cpu case so that the perf tool can rely on the correct timing
> > > for parsing symbols.  And the CPU sample is useless for mmap.
> > > 
> > > This patch enables TIME sample for per-cpu mmap and doesn't enable CPU
> > > sample.  For later extension (e.g. support multiple AUX events), it sets
> > > the dummy event when the condition "opts->full_auxtrace" is true.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/arch/arm64/util/arm-spe.c | 30 ++++++++++++++++------------
> > >  1 file changed, 17 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > > index 902e73a64184..f6eec0900604 100644
> > > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > > @@ -70,7 +70,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> > >  	struct evsel *evsel, *arm_spe_evsel = NULL;
> > >  	struct perf_cpu_map *cpus = evlist->core.cpus;
> > >  	bool privileged = perf_event_paranoid_check(-1);
> > > -	struct evsel *tracking_evsel;
> > >  	int err;
> > >  
> > >  	sper->evlist = evlist;
> > > @@ -126,18 +125,23 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> > >  		evsel__set_sample_bit(arm_spe_evsel, CPU);
> > >  
> > >  	/* Add dummy event to keep tracking */
> > > -	err = parse_events(evlist, "dummy:u", NULL);
> > > -	if (err)
> > > -		return err;
> > > -
> > > -	tracking_evsel = evlist__last(evlist);
> > > -	evlist__set_tracking_event(evlist, tracking_evsel);
> > > -
> > > -	tracking_evsel->core.attr.freq = 0;
> > > -	tracking_evsel->core.attr.sample_period = 1;
> > > -	evsel__set_sample_bit(tracking_evsel, TIME);
> > > -	evsel__set_sample_bit(tracking_evsel, CPU);
> > > -	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
> > > +	if (opts->full_auxtrace) {
> > > +		struct evsel *tracking_evsel;
> > 
> > Hi Leo,
> > 
> > I know the "if (opts->full_auxtrace)" pattern is copied from other auxtrace
> > files, but I don't think it does anything because there is this at the top
> > of the function:
> > 
> >    	if (!opts->full_auxtrace)
> > 		return 0;
> > 
> > The same applies for other usages of "full_auxtrace" in the same function.
> > They are all always true. I'm also not sure if it's ever defined what
> > full_auxtrace means.
> 
> Good pointing.  TBH, I also stuggled for handling "opts->full_auxtrace"
> when wrote the patch; IIUC, "opts->full_auxtrace" is also used in
> builtin-record.c to indicate if the recording contains AUX tracing.
> 
> Will follow your suggestion to respin the patch (and refine the code)
> to remove the redundant condition checking for "opts->full_auxtrace".

Ok, so please collect his Tested-by and Reviewed-by and I'll wait for v2
then,

- Arnaldo
