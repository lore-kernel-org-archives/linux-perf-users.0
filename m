Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E4C47094
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6360F611AC
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFGPc2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhFGPcZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 11:32:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BDC061766;
        Mon,  7 Jun 2021 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wGh/o95PASfc32SBFSIegHlmqOK2TygZjEiPHTK933M=; b=CqNL8wXfO3QHiYQC1ZLHdLBUlL
        1Bl51ka0chncyjyhb423c2eAM3oUmPl4E4XyI3QTEbwja/hyotO1yaKkR9YUCZX8LgIxeBNS4HZc5
        5koLbaKN+dLCZiSop5roNHtAAnqZkJDqbaj5/DqixpOF4IE/rT2RGeiVpPCUHDMlJOJf04pNA+fPy
        H7CSUJRMCDsqQ5WuHMfNiH72gpThSAsZemcQ5w+O8wcuOY5kpXXlnc0OAL1L7V6WpaLi/oN9x3W6e
        YTshY46Nwpcf1/Ny9Z9YFJg8PxbnuE7WET9p2lfZ6I8jwQKyVGSRYgzpmm1MLwx+endy9c4lmo9Ja
        zDKU+Qbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqHBs-00FwXX-DS; Mon, 07 Jun 2021 15:29:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9309830018A;
        Mon,  7 Jun 2021 17:29:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D2982D6A7343; Mon,  7 Jun 2021 17:29:23 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:29:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] perf/x86: Add barrier after updating bts
Message-ID: <YL47U1GyrY0kG06n@hirez.programming.kicks-ass.net>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602103007.184993-5-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 02, 2021 at 06:30:03PM +0800, Leo Yan wrote:
> Add barrier wmb() to separate the AUX data store and aux_head store.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/x86/events/intel/bts.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 6320d2cfd9d3..4a015d160bc5 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -209,6 +209,9 @@ static void bts_update(struct bts_ctx *bts)
>  	} else {
>  		local_set(&buf->data_size, head);
>  	}
> +
> +	/* The WMB separates data store and aux_head store matches. */
> +	wmb();

Alexander, do we indeed need an MFENCE here? or is the BTS hardware
coherent, in which case a compiler barrier would be sufficient.
