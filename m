Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0324C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 13 Mar 2022 12:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiCMMpp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 13 Mar 2022 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCMMpo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 13 Mar 2022 08:45:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781333E3A
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 05:44:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so28227738ejc.6
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EJ1tBx1dhbkFDPqhVx95CHpZt6g0rmeL6lGzXpgultw=;
        b=zFM9BbgWlCI8Z3Ni6/YkVN/Uuvp03ahg6Fs1xdaBLu4raOaXbF64NdAkjc7h0NZUVa
         QcNR2GSSEiZvjX0PvIwOeAv8dCfWRuTQVcCF9p4zFxfQ/tQGMtTVurdkW0hP4562Kodn
         NO+C6OaHvmQ70LIqfCjKlmVwpvIyy+bPY5CIzlw5vyRHNPlRrpXq3NtIaDQTfDNt4IqH
         Zm6fT/RHmi//0HlUI1PL3ZMB8acBKyADsdDCX+FcyQhqQayXN9LhifGsaIsNrDXETKEq
         9acm9UbFGTnXgHaMhiZDkVfcmo4Nq3R9lNJFBSynDHF8w1CsG0rK/DegKCZqPYOEk2da
         EDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJ1tBx1dhbkFDPqhVx95CHpZt6g0rmeL6lGzXpgultw=;
        b=JolS+RoFzChbJC60sKHsWwaW2iZGuWtCf5na/T4WpuTcYb4M99oUSpwnzIhnP2nOaZ
         0dXnDUvyg6jY1WlpOPzaDC+KckpUFJ4s3SLZ8fA8tYgg8W9j5eweIybX+w/OpdPiTXtj
         zcj5d1aqrf4EPstEJKzFOGM/hKbJUD5nvsSzDPhcG0urh1T7kRKh/IrV8pUbqOf40ke4
         qhgjqlHFDp4bs8VuShPYUiiQLxAunBBo+Me6NYQZtMpR2In5RHSRdt8YkWUAAkiKHwkd
         xq8AQbjwHzw8SU6R0t4AhrFyro6E6Z5z0d9RS5SEKhrmKZafZxLD1+swAwGwHl3VX91z
         p/bA==
X-Gm-Message-State: AOAM532ILi7aIdnRqPkDPaIVFfbELcaRwokj+LIbyFuHt0eiGCUU/l7L
        3H4I697dfX+OZl7pMfE57RiV5Q==
X-Google-Smtp-Source: ABdhPJwWwEQ/BJrrSXJsPZOH2KWN8TEOzijKIe5tSjyPVPvwusH61MygNa6ACyUHmatt6h24pnliaQ==
X-Received: by 2002:a17:906:53c7:b0:6ce:6f32:ce53 with SMTP id p7-20020a17090653c700b006ce6f32ce53mr15441881ejo.352.1647175474370;
        Sun, 13 Mar 2022 05:44:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id z3-20020a056402274300b004169771bd91sm6299081edd.39.2022.03.13.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 05:44:33 -0700 (PDT)
Date:   Sun, 13 Mar 2022 20:44:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
Message-ID: <20220313124427.GB143848@leoy-ThinkPad-X240s>
References: <20220221224807.18172-1-alisaidi@amazon.com>
 <20220221224807.18172-2-alisaidi@amazon.com>
 <d5f9bd40-1f32-9847-33b1-fe7304acf29b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f9bd40-1f32-9847-33b1-fe7304acf29b@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 02, 2022 at 03:39:04PM +0000, German Gomez wrote:
> 
> On 21/02/2022 22:48, Ali Saidi wrote:
> > Current code only support HITM statistics for last level cache (LLC)
> > when mem_lvl encodes the level. On existing Arm64 machines there are as
> > many as four levels cache and this change supports decoding l1, l2, and
> > llc hits from the mem_lvl_num data. Given that the mem_lvl namespace is
> > being deprecated take this opportunity to encode the neoverse data into
> > mem_lvl_num.
> 
> Since Neoverse is mentioned in the commit message, I think there should be a comment somewhere in the code as well.
>

> > For loads that hit in a the LLC snoop filter and are fullfilled from a
> > higher level cache, it's not usually clear what the true level of the
> > cache the data came from (i.e. a transfer from a core could come from
> > it's L1 or L2). Instead of making an assumption of where the line came
> > from, add support for incrementing HITM if the source is CACHE_ANY.
> >
> > Since other architectures don't seem to populate the mem_lvl_num field
> > here there shouldn't be a change in functionality.
> >
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > ---
> >  tools/perf/util/mem-events.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > index ed0ab838bcc5..6c3fd4aac7ae 100644
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
> >  	u64 daddr  = mi->daddr.addr;
> >  	u64 op     = data_src->mem_op;
> >  	u64 lvl    = data_src->mem_lvl;
> > +	u64 lnum   = data_src->mem_lvl_num;
> >  	u64 snoop  = data_src->mem_snoop;
> >  	u64 lock   = data_src->mem_lock;
> >  	u64 blk    = data_src->mem_blk;
> > @@ -527,16 +528,18 @@ do {				\
> >  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
> >  			if (lvl & P(LVL, IO))  stats->ld_io++;
> >  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> > -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> > -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> > -			if (lvl & P(LVL, L3 )) {
> > +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> > +				stats->ld_l1hit++;
> > +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> > +				stats->ld_l2hit++;

It's good to split into two patches: one patch is to add statistics for
field 'mem_lvl_num', the second patch is to handle HITM tags.

> > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {

It's a bit weird that we take either PERF_MEM_LVL_L3 or
PERF_MEM_LVLNUM_L4 as the last level local cache in the same condition
checking.

> According to a comment in the previous patch, using L4 is specific to Neoverse, right?
> 
> Maybe we need to distinguish the Neoverse case from the generic one here as well
> 
> if (is_neoverse)
> // treat L4 as llc
> else
> // treat L3 as llc

I personally think it's not good idea to distinguish platforms in the decoding code.

To make more more clear statistics, we can firstly increment hit values
for every level cache respectively;  so we can consider to adde two
extra statistics items 'stats->ld_l3hit' and 'stats->ld_l4hit'.

        if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3))
                stats->ld_l3hit++;
        if (lnum == P(LVLNUM, L4))
                stats->ld_l4hit++;

> >  				if (snoop & P(SNOOP, HITM))
> >  					HITM_INC(lcl_hitm);
> >  				else
> >  					stats->ld_llchit++;

For the statistics of 'ld_llchit' and 'lcl_hitm', please see below comment.

> >  			}
> >  
> > -			if (lvl & P(LVL, LOC_RAM)) {
> > +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
> >  				stats->lcl_dram++;
> >  				if (snoop & P(SNOOP, HIT))
> >  					stats->ld_shared++;
> > @@ -564,6 +567,9 @@ do {				\
> >  				HITM_INC(rmt_hitm);
> >  		}
> >  
> > +		if (lnum == P(LVLNUM, ANY_CACHE) && snoop & P(SNOOP, HITM))
> > +			HITM_INC(lcl_hitm);
> > +

The condition checking of "lnum == P(LVLNUM, ANY_CACHE)" is a bit
suspecious and it might be fragile for support multiple archs.

So I am just wandering if it's possible that we add a new field
'llc_level' in the structure 'mem_info', we can initialize this field
based on different memory hardware events (e.g. Intel mem event,
Arm SPE, etc).  During the decoding phase, the local last level cache
is dynamically set to 'mem_info:: llc_level', we can base on it to
increment 'ld_llchit' and 'lcl_hitm', the code is like below:

                 if ((lvl & P(LVL, REM_CCE1)) ||
                     (lvl & P(LVL, REM_CCE2)) ||
                      mrem) {
                         if (snoop & P(SNOOP, HIT))
                                 stats->rmt_hit++;
                         else if (snoop & P(SNOOP, HITM))
                                 HITM_INC(rmt_hitm);
+               } else {
+                       if ((snoop & P(SNOOP, HIT)) && (lnum == mi->llc_level))
+                               stats->ld_llchit++;
+                       else if (snoop & P(SNOOP, HITM))
+                               HITM_INC(lcl_hitm);
                 }

Thanks,
Leo

> >  		if ((lvl & P(LVL, MISS)))
> >  			stats->ld_miss++;
> >  
