Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAAAC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D8C610CB
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhGMNFL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhGMNFK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 09:05:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C3C0613DD;
        Tue, 13 Jul 2021 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMp6dV42xRnlQcyCD45dsoHe0RPJLXS1wpNt9+DfJBE=; b=gtUSRbzqGA40wzFUSnXaJMuUqL
        x91iV79pM3zhMvCQadTmu1q8aBOxweAzI5xONNOUoCGL7sl2IbyPkwBFjNQM+jm87kuZbmrAkDU6s
        QViQmQVQdJgBmi3rdTio50BeGuUml+YvhFsY1MeyYulu4+bgzSP4NsVJSZCcSaxTFDYCIfs0m7s8E
        R4zF4ZAS8Q/jKitj7MZpYqKUtmHVeUSwUPmw4Z9OO0L8iihbxDSRs6eyduwy/467uy7RAVG5aBKkS
        Vn2RJZ04wyvFYaY00ity1eWGP/s5UaxZlhj0RpKsS8cobTPE6BwhBR+uoWOw9fg5e9wIy+uDjICYl
        n49HWOUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3I2t-00HAA7-NW; Tue, 13 Jul 2021 13:01:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E864987782; Tue, 13 Jul 2021 15:01:54 +0200 (CEST)
Date:   Tue, 13 Jul 2021 15:01:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/11] perf/x86: Add barrier after updating bts
Message-ID: <20210713130154.GC4170@worktop.programming.kicks-ass.net>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711104105.505728-5-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 11, 2021 at 06:40:58PM +0800, Leo Yan wrote:
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

Alexander, last time you mentioned (on IRC) that BTS is supposed to be
coherent, in which case we can probably get away with just a compiler
barrier. Can you confirm?

That said; this BTS crud is so horrifically slow, an extra MFENCE isn't
going to matter one way or another.
