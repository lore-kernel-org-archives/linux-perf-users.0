Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47ADC636CD
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Feb 2023 01:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBBBOd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBBBOd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 20:14:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E75125A4;
        Wed,  1 Feb 2023 17:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 745ABB82272;
        Thu,  2 Feb 2023 01:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA09C433D2;
        Thu,  2 Feb 2023 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300468;
        bh=U7d2gu4wq8nJ7qvCABRJl8+2xIkLDM1z2n54iEefEtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9NYbLn5MSdqt6iHCmzjF9XUhmGA4sFDrezpaPihWHbheyWREa1yIje/JbY/IK1CS
         L693yfzzCgX9v/UKxQRugLxyMOgGrfHdel00doI023kZ9anM8ohWmUe2PE+N1TrEjo
         qt1UjkBB0lqcbcLn1AeWW8jh2iBOB93a/EfAz/QbfVNdUGCjBrjzdP+ZTOCDbBjQ6F
         5XAvg4TwzP7O/rCx/mD0cGGoZr1phxSpjA4ngkv59foq5eI4xthRTmd9e9Dyl/Ql0d
         Jj7N7hPdr6mzV4rI+XAGQchJrSlPud9ON4ui4ZibIIfNyYaR6cddt6G2k0GMw2biA/
         6/Nibz9RjqCJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A0B1B405BE; Wed,  1 Feb 2023 22:14:25 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:14:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Only warn once for each unsupported
 address packet
Message-ID: <Y9sOceFTriHj9OIV@kernel.org>
References: <20230127205546.667740-1-robh@kernel.org>
 <Y9cn4NYvI6+XW302@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9cn4NYvI6+XW302@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jan 30, 2023 at 10:13:52AM +0800, Leo Yan escreveu:
> On Fri, Jan 27, 2023 at 02:55:46PM -0600, Rob Herring wrote:
> > Unknown address packet indexes are not an error as the Arm architecture
> > can (and has with SPEv1.2) define new ones and implementation defined
> > ones are also allowed. The error message for every occurrence of the
> > packet is needlessly noisy as well. Change the message to print just
> > once for each unknown index.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 091987dd3966..40dcedfd75cd 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -68,7 +68,11 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
> >  		/* Clean highest byte */
> >  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  	} else {
> > -		pr_err("unsupported address packet index: 0x%x\n", index);
> > +		static u32 seen_idx = 0;
> > +		if (!(seen_idx & BIT(index))) {
> > +			seen_idx |= BIT(index);
> > +			pr_warning("ignoring unsupported address packet index: 0x%x\n", index);
> > +		}
> >  	}
> >  
> >  	return payload;
> > -- 
> > 2.39.0
> > 

-- 

- Arnaldo
