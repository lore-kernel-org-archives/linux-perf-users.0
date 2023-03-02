Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52838C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 14:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCBOfq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCBOfp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 09:35:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836134DE3A;
        Thu,  2 Mar 2023 06:35:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB402CE1F24;
        Thu,  2 Mar 2023 14:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA2EC433D2;
        Thu,  2 Mar 2023 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767737;
        bh=T4W6p8NZenxPKO5Ju9mqeZNSppRqgv7FuJ6Oz/8+fSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hhk44qN2WaRDDxXxNa3WpH9vopsyh1AuJdvIIB4LnQ989TyxNWX6NBz04oQXtGCYm
         T5g4MJWpREB2iBsJPy+vS+E6M6yPNc9j03T9yuZHglO/kwK0uP0ogqBN24BAvul7Im
         VSCNKFOqkOS2DwUqxfuagljUJR7h6CbVOstSLHZPSPR8N6CJomSbHEq688zsCDUQW3
         SHxJlY6ftYqKXNTkaxNr5ktornPXtrSqVfbQpyY9wDCbMfIDv1n3t0rbsa26TnQIx6
         WqTaWIlR+g43iOE7MsOYICgbNg6x/RoNwGka/L4R13cv32s3+TX4jO4+ACNGvUCAaJ
         Xpk1Qdmw68cVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E16794049F; Thu,  2 Mar 2023 11:35:34 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:35:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 05/10] perf evsel: Limit in group test to CPUs
Message-ID: <ZAC0NgnrD0mQLOgT@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-6-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:06PM -0800, Ian Rogers escreveu:
> Don't just match on the event name, restict based on the PMU too.

restrict.

Can you please expand a bit this explanation?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ea3972d785d1..580b0a172136 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -61,6 +61,9 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  	if (!evsel__sys_has_perf_metrics(evsel))
>  		return false;
>  
> +	if (evsel->pmu_name && strncmp(evsel->pmu_name, "cpu", 3))
> +		return false;
> +
>  	return evsel->name &&
>  		(strcasestr(evsel->name, "slots") ||
>  		 strcasestr(evsel->name, "topdown"));
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
