Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE2C0015E
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjGXQlt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGXQls (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 12:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096C10D3;
        Mon, 24 Jul 2023 09:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783336127C;
        Mon, 24 Jul 2023 16:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0FAC433C9;
        Mon, 24 Jul 2023 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216904;
        bh=slY2K6qUOwPVZDMW1XxpN8Wk8aylahbaAaTLXnyOJ6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6eYP1XzTniWCT9wWlRFkQ/ubGlokLLoGu1+cHpeAzSMZPl8+SKFaI+FiqCxP8hEs
         O1ZuNLGqlqTTPoREWhELqmcTt9JH4couhmX2cXVPOhgwzSiOZPxM2kPMnR4nEHYo2c
         YIrsu1oehctcBzhBfrhdFDtjv7yfr8fZjY4y97TSRJRnBN0ZgkOgSdIYzL6LA0vG+m
         4lRylbMPK1GnwVGTEFsjFyDhvOZ8e3zuPnr2+f3AmPwcNp4vUa/W0e1HSa4cNOKsf1
         GIgFXIqqT50ipBGJSUktQgLfXD2r169xCOYQaIbWWS1GPgB28ZbmFMWmbyu3E3EHwq
         kSfH3MB5Vcfdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C73F240516; Mon, 24 Jul 2023 13:41:41 -0300 (-03)
Date:   Mon, 24 Jul 2023 13:41:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm64: Fix read PMU cpu slots
Message-ID: <ZL6pxZ4RmMC2W7S+@kernel.org>
References: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
 <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e392aa9-859a-75ef-eb3e-1870b1e78061@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 24, 2023 at 03:40:12PM +0800, Jing Zhang escreveu:
> 
> 
> 在 2023/7/24 下午1:06, Haixin Yu 写道:
> > Commit f8ad6018ce3c ("perf pmu: Remove duplication around
> >  EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull to read a full
> > sysfs path, which will never success. Fix it by read file directly.
> > 
> > Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
> > ---
> >  tools/perf/arch/arm64/util/pmu.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> > index 561de0cb6b95..512a8f13c4de 100644
> > --- a/tools/perf/arch/arm64/util/pmu.c
> > +++ b/tools/perf/arch/arm64/util/pmu.c
> > @@ -54,10 +54,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
> >  		perf_pmu__pathname_scnprintf(path, sizeof(path),
> >  					     pmu->name, "caps/slots");
> >  		/*
> > -		 * The value of slots is not greater than 32 bits, but sysfs__read_int
> > -		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
> > +		 * The value of slots is not greater than 32 bits, but
> > +		 * filename__read_int can't read value with 0x prefix,
> > +		 * so use filename__read_ull instead.
> >  		 */
> > -		sysfs__read_ull(path, &slots);
> > +		filename__read_ull(path, &slots);
> >  	}
> >  
> >  	return slots ? (double)slots : NAN;
> 
> Yes, the function perf_pmu__pathname_scnprintf returns the complete slots file path "/sys/bus/xxxxx/caps/slots",
> and sysfs__read_ull will add the prefix "/sys" to the path, so the final file path becomes "/sys/sys/bus/xxxx/caps/slots"
> which does not exist, and the slots file cannot be successfully read, so sysfs__read_ull needs to be changed to the
> filename__read_ull.
> 
> I tested it and it works well.
> 
> Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>

I've applied this to my local branch, thanks.

I also added the missing:

Fixes: f8ad6018ce3c065a ("perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH")

This is another case where a 'perf test' entry would come in handy.

James, please check and ack,

- Arnaldo
