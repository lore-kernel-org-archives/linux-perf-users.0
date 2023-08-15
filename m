Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F8BC001B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 17:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbjHORnx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbjHORnZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 13:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746441BE2;
        Tue, 15 Aug 2023 10:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2E9F62952;
        Tue, 15 Aug 2023 17:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04422C433C8;
        Tue, 15 Aug 2023 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121403;
        bh=D8DPbSofSMpuxPgO7mTbMtJ0tw7xuZlEiWH0AVihSh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXtfcDF1phykJmNYTay6DFBSOcQ2OSU+VF5ixNNcMJVpTCnsdbLgMJgaeMV4JPRAc
         cynrjJFX3ekdarTTmbMAX9k6kWV61rwfOekYrgmru7p7RxKPIuklWZ3jtYU3ODWrNa
         c+qWaydRkkkP+cP5CmeKhCWGTOfbn4XE9kOJNTrrnurM1l5iL6DHhL6wSXYxbniHn+
         jbjyR7Ia8rDpvmqtMbb+oi0e898KlocmP56Dqp8QE6XBXanM8F7wZI1BO8A7lVggi1
         uhA0v/HUxIJZuekU8Q8nlDrAIchJhwt40nOnPA+vV3yGDzFrzFKE0b3nA5MVGq7DrQ
         5zmiEG3WMrB5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E72D404DF; Tue, 15 Aug 2023 14:43:20 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:43:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, sandipan.das@amd.com,
        ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Remove duplicate check for `field` in
 evsel__intval()
Message-ID: <ZNu5OKeGcJlxbvdm@kernel.org>
References: <20230815221009.3641751-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815221009.3641751-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 15, 2023 at 10:10:09PM +0000, Yang Jihong escreveu:
> The `file` parameter in evsel__intval() is checked repeatedly, fix it.
> 
> No functional change.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/evsel.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index e41bc4d9925f..0c50c443d456 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2827,9 +2827,6 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
>  {
>  	struct tep_format_field *field = evsel__field(evsel, name);
>  
> -	if (!field)
> -		return 0;
> -
>  	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
>  }
>  #endif
> -- 
> 2.39.2
> 

-- 

- Arnaldo
