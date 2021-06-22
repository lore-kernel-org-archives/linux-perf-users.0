Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92831C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCA76128E
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFVSU1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVSU1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 14:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D08B561289;
        Tue, 22 Jun 2021 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624385891;
        bh=nowAttDsd1UFqodzF+KPbGwA+rzpnVvqAQ3tPN3oORI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Knw6GktxjsXNuN2X2pwhGQD2zkXq428IfsTVA+Up4fBcgkd/5ulVoQ6LWc+42uXB/
         Wnj9QwEunTi/AHTaSXBvLm1cTFZ5NNhDtHtlADwznkMEDh1RzM4agbiQ4jJOMln4mn
         Yl8IiNeQ1zfRcSt20+Z2ZhYcpmv9m0IcMEx5J1BSn9DFT3Q+2Nvi+cOtxWUkod7XaT
         xzQOhRi8RaZcFLrJ3T6dCgpqmz9Hmnykyal9FBNXp2p7pr5ccF6DsfLaqH4dxPYQxh
         0lLchL/arPPqN2NW4RvoqnCEI2+72Eke/Ob7/tzcE0nEYT8OCV/YsC+FUOzhTcQ24u
         1oBe036IZG2Lg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99BD240B1A; Tue, 22 Jun 2021 15:18:08 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:18:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] perf script: Move filtering before scripting
Message-ID: <YNIpYNS0xlZguJIA@kernel.org>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
 <20210621150514.32159-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621150514.32159-3-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 21, 2021 at 06:05:05PM +0300, Adrian Hunter escreveu:
> To make it possible to use filtering with scripts, move filtering before
> scripting.


Thanks, applied.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 08a2b5d51018..ff7b43899f2e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1984,12 +1984,6 @@ static void process_event(struct perf_script *script,
>  	if (output[type].fields == 0)
>  		return;
>  
> -	if (!show_event(sample, evsel, thread, al))
> -		return;
> -
> -	if (evswitch__discard(&script->evswitch, evsel))
> -		return;
> -
>  	++es->samples;
>  
>  	perf_sample__fprintf_start(script, sample, thread, evsel,
> @@ -2203,6 +2197,12 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> +	if (!show_event(sample, evsel, al.thread, &al))
> +		goto out_put;
> +
> +	if (evswitch__discard(&scr->evswitch, evsel))
> +		goto out_put;
> +
>  	if (scripting_ops) {
>  		struct addr_location *addr_al_ptr = NULL;
>  		struct addr_location addr_al;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
