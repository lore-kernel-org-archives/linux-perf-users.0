Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4DC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5530F61205
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhIJQFg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIJQFf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 12:05:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A131C061574;
        Fri, 10 Sep 2021 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tyk8o/8ik0HvgtJvAG8QDKH8qje+2yOdy4HREGr2Dio=; b=jcT61RbAD7oS1dnY0sD6IXVzXr
        WzvPZqjv83FvgGnt7fKKlQOe+gHSxD0AO21ayQyvWRr2w51OmkCLh1/PUSMSZ1q8gBMPpnrTKM5jc
        zi9qE2tncHb9zgGykiFwbdkV+KDfHtBohngHueORVwc9rsj39Rj/XJlcxi0mUET/VzwignyjysK5g
        xHl8XRX4+mKxR9OlSAQL9ihhmxWT1/iSZ0J9Gy64D+gZ2cxGYblAd5w2Xrlucfu3oXTGnd4QTiBfs
        rlswXCeSswKHQ71X5fcRCFNBdluYPulrKsv/Kd0s/BLEXyKUtBEd0N7jLvkTTobRemgMCwismAhtY
        Nr3O2OBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOj0c-002AaZ-Tf; Fri, 10 Sep 2021 16:04:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 116DC98627A; Fri, 10 Sep 2021 18:04:10 +0200 (CEST)
Date:   Fri, 10 Sep 2021 18:04:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
Message-ID: <20210910160409.GI4323@worktop.programming.kicks-ass.net>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 07, 2021 at 01:45:22PM -0400, Liang, Kan wrote:
> On 9/7/2021 12:39 PM, Adrian Hunter wrote:

> > @@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
> >   	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
> >   }
> > +static void intel_aux_output_init(void)
> > +{
> > +	/* Refer also intel_pmu_aux_output_match() */
> > +	if (x86_pmu.intel_cap.pebs_output_pt_available)
> > +		x86_pmu.assign = intel_pmu_assign_event;
> > +}
> 
> For a hybrid machine, x86_pmu.intel_cap.pebs_output_pt_available is always
> cleared. We probably need the PMU specific
> pmu->intel_cap.pebs_output_pt_available here.
> 
> > +
> >   static int intel_pmu_aux_output_match(struct perf_event *event)
> >   {
> > +	/* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
> >   	if (!x86_pmu.intel_cap.pebs_output_pt_available)
> >   		return 0;
> > 
> 
> For a hybrid machine, this always return 0. I think we need to fix it first?

AFAICT the patch is correct for !hybrid, and the hybrid PT muck can then
also fix this up, right?

