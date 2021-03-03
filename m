Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B0C43331
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4783964EBA
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhCDAYE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhCCQgQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Mar 2021 11:36:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D3EC614A7;
        Wed,  3 Mar 2021 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614789314;
        bh=T4vXj1HwpwwEL1qZXN2x2T47akLygg5FZ3/KhQMvm5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7QC+ENz/GtvoKoiOkKHpkHSupTc//7l5QsEXuBUd7lHHn49iCC1AmYFAubqnzrc6
         qT4a2f5j+Mx/I5V0IaEen0bserlEhQkjHJNIKnGJ6BeSPDQOP6/o+Hxe0Kn4pf+bu0
         Pxm8m00zLMaYMGLMMjeOiH+rj3ptCzj1+DI1NS1SlQcyjk6gkNngpK83uwApYOHP0z
         w+LuWnCGMevTsABVkWYwL70OLDHyI+mvHbExLGhF8meJMb0+UOe7qmsAEf/S3sNdRU
         jmu5p44AUQc4ksLr38MVBzc/Pb+evtkAd9DIWAkf22OMCUO/vE9Rv7tkwuhSmNRJmc
         lMQ/QitaIlrVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B7604038F; Wed,  3 Mar 2021 13:35:12 -0300 (-03)
Date:   Wed, 3 Mar 2021 13:35:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, atrajeev@linux.vnet.ibm.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf test: Fix sample-parsing fails on non-x86
 platforms
Message-ID: <YD+6wNQq/viQMnA6@kernel.org>
References: <1614787285-104151-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614787285-104151-1-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 03, 2021 at 08:01:24AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Executing perf test 27 fails on s390:
>  [root@t35lp46 perf]# ./perf test -Fv 27
>  27: Sample parsing
>  --- start ---
>  ---- end ----
>  Sample parsing: FAILED!
>  [root@t35lp46 perf]#
> 
> The commit fbefe9c2f87f ("perf tools: Support arch specific
> PERF_SAMPLE_WEIGHT_STRUCT processing") changes the ins_lat to a
> model-specific variable only for X86, but perf test still verify the
> variable in the generic test.
> 
> Remove the ins_lat check in the generic test. The following patch will
> add it in the X86 specific test.

Thanks, applied both patches.

- Arnaldo

 
> Fixes: fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/tests/sample-parsing.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index 0dbe3aa..8fd8a4e 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -129,9 +129,6 @@ static bool samples_same(const struct perf_sample *s1,
>  	if (type & PERF_SAMPLE_WEIGHT)
>  		COMP(weight);
>  
> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> -		COMP(ins_lat);
> -
>  	if (type & PERF_SAMPLE_DATA_SRC)
>  		COMP(data_src);
>  
> @@ -245,7 +242,6 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  		.cgroup		= 114,
>  		.data_page_size = 115,
>  		.code_page_size = 116,
> -		.ins_lat        = 117,
>  		.aux_sample	= {
>  			.size	= sizeof(aux_data),
>  			.data	= (void *)aux_data,
> -- 
> 2.7.4
> 

-- 

- Arnaldo
