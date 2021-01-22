Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D3C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F6923106
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbhAVMws (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 07:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhAVMwl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 07:52:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2654B23106;
        Fri, 22 Jan 2021 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611319920;
        bh=5pQT64VGfC0BZiVj3AnsJWDMHD/kNYTSmMy2Cl/LF9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZ0AkwDXFz07pR68nelC5uawYbTkXiiODQ93aJ36v2oGSxq/oJGDuYQCo7D1WCxMA
         tAzb6/ZRdrTBQNdje/3X2hm5YvW7rUyEGWBttU7GPGMmmvXViwazc/4kWAnPlOLbzT
         NjPOxDmiV9LWmqMdVSo1z4obvkMMXRQ026rl3lBIh7U/5T5j3yQxNUrEC70QDvMnpf
         9ZQ7RHIDxvdz/mVk5nFzepjXwMzxo2OF3kWECwavmp/OUSH7z9RwicMMRI9IHyVb5W
         NE5aB9Zzp062oUMCyimirxYOWheqBwO48IdE7qAiSbatp+T9J9sREFKwiLSBEfjpOB
         FJM06GVGAqsrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9439840513; Fri, 22 Jan 2021 09:51:57 -0300 (-03)
Date:   Fri, 22 Jan 2021 09:51:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/8] perf arm-spe: Enable sample type PERF_SAMPLE_DATA_SRC
Message-ID: <20210122125157.GG356537@kernel.org>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jan 19, 2021 at 04:46:51PM +0200, James Clark escreveu:
> From: Leo Yan <leo.yan@linaro.org>
> 
> This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
> the perf data, when output the tracing data, it tells tools that it
> contains data source in the memory event.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

I see two Signed-off-by, ok, any Reviewed-by?

- Arnaldo

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Wei Li <liwei391@huawei.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/arm-spe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8901a1656a41..b134516e890b 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -803,7 +803,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.type = PERF_TYPE_HARDWARE;
>  	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
> -		PERF_SAMPLE_PERIOD;
> +			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
>  	if (spe->timeless_decoding)
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
>  	else
> -- 
> 2.28.0
> 

-- 

- Arnaldo
