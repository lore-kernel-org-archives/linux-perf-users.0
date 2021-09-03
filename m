Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68173C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522A1610C8
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhICLI2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235183AbhICLI2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 07:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591D161057;
        Fri,  3 Sep 2021 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667248;
        bh=wWeivC5PqODTu3my4qvaLE+osJF8nYHfV2kWPsQjtd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORu8PBv5iYBY4R9dsltKS6/P1JZ+Q6yigbCRaJ8GgMwBmPI0N+RlMk4e3xKfiFF29
         dEX8C2Ul2gYHgDJyYQQ5+9fj6Z3GshebKcMwAtIKgbGswBoVT33jEXrA7XCRJKU7uR
         yewEqfLEqoLyao6yyzGzdsu8Cmbz8Mh3xXe2i4Ocq9TqK82Dm85fdFYsa6sUaQr+G5
         HhgJ4n3ZIkrsGrgqWnNVpb/ZRR1PtlVIIlC+f6oD7+SAKcHJI0/O232l7fbTu7U1c5
         BPlFQZ+1Q1oQj7anji6hIIKWM0ncy070GMx+Nb2WC9unRoO/2I6m+97cslaYfvFJ+q
         IgI9s4t6xW1hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D05C74007E; Fri,  3 Sep 2021 08:07:25 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:07:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on
 TRCIDR1
Message-ID: <YTIB7aNBErDCK+sf@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-3-james.clark@arm.com>
 <d2379e72-a285-c63f-8c32-806e412458a3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2379e72-a285-c63f-8c32-806e412458a3@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 03, 2021 at 09:55:37AM +0100, Suzuki K Poulose escreveu:
> On 06/08/2021 14:41, James Clark wrote:
> > Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
> > onwards this should be ARCH_AA64.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 187c038caa19..787b19642e78 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
> >   	return 0;
> >   }
> > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> 
> minor nit: Please add a blank line here

Fixed it
 
> > +static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
> > +{
> > +	/*
> > +	 * For ETMv4 if the trace minor version is 4 or more then we can assume
> > +	 * the architecture is ARCH_AA64 rather than just V8.
> > +	 * ARCH_V8 = V8 architecture
> > +	 * ARCH_AA64 = Min v8r3 plus additional AA64 PE features
> 
> Does this need to be >= 3 then, to be accurate ?
> 
> The comment "reads", minimum v8.3 and any additional features.
> 
> Otherwise looks good to me.

Didn't have enough coffee, I think, can you please provide this as a
patch? :)

- Arnaldo
