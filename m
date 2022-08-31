Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A253EECAAD1
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiHaMVu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiHaMVt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 08:21:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF34CE497;
        Wed, 31 Aug 2022 05:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15569CE1EE2;
        Wed, 31 Aug 2022 12:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B69FC433D6;
        Wed, 31 Aug 2022 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661948505;
        bh=AtDBsF8xhjNjHiHKXo0UTN2kBKz8vHrgMe5WfnM0UtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4yYBhV8RbeQMMW98dXyD7vfhI991A4ya1jdqfMlRESB8OMYmBujw+1mFE3o9HXG0
         z0GTUTPPvQPu29d4YUeCbI0yuXxSaKXzTdx6cxnL3yFruDQVTa4E5+rROafBPZ9ygb
         pSILTLa9PpHccUPDFVzngGrMf42xefg6ZVuAE0x5AUZebnwIsq7iixwPc5NKi6d9Yx
         NKVpmu5OLlVrIgNnbyAL3phSBkaBTYJjnQbG5ir1PvREZMDrEp7AspwqkyNMHebuGK
         Dn7cXLVPEK52X0ZBtgvykvYwrbZqUEVtsDEB7x1hllMkj8wD1t+McthhyxtnMbOfpt
         Oi6ahNewNs+kg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FC61404A1; Wed, 31 Aug 2022 09:21:41 -0300 (-03)
Date:   Wed, 31 Aug 2022 09:21:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 2/8] perf metric: Return early if no CPU PMU table
 exists
Message-ID: <Yw9SVbRWqA2u+fso@kernel.org>
References: <20220830164846.401143-1-irogers@google.com>
 <20220830164846.401143-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830164846.401143-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 30, 2022 at 09:48:40AM -0700, Ian Rogers escreveu:
> Previous behavior is to segfault if there is no CPU PMU table and a
> metric is sought. To reproduce compile with NO_JEVENTS=1 then request
> a metric, for example, "perf stat -M IPC true".

Thanks, applied to perf/urgent.

- Arnaldo

 
> Fixes: 00facc760903 ("perf jevents: Switch build to use jevents.py")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ad5cacdecd81..18aae040d61d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1655,6 +1655,9 @@ int metricgroup__parse_groups(const struct option *opt,
>  	struct evlist *perf_evlist = *(struct evlist **)opt->value;
>  	const struct pmu_events_table *table = pmu_events_table__find();
>  
> +	if (!table)
> +		return -EINVAL;
> +
>  	return parse_groups(perf_evlist, str, metric_no_group,
>  			    metric_no_merge, NULL, metric_events, table);
>  }
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 

- Arnaldo
