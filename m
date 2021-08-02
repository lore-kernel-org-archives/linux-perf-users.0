Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC486C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68C4603E9
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhHBOyz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhHBOyy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 10:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4492860F70;
        Mon,  2 Aug 2021 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916085;
        bh=V6nVIfGdYZP3YW1zd8g4Q9eIJtnKJMX2I5ylnnnpUms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQfHtnb4ckN39v/vai2uDyJFmryAMODfcLZG5YNipbRdTB2nvWHvWTavU5h9w+H4y
         IXdZUYFr8B73AKk59/WfLDEQzJDCNET6iBqKmPnj4a3sG+qxZM/1GrVB77i4ld9W6E
         3w2hkDacYAk1bOTowF/0u21pcT14s1R1si1O8e4+qwjCu+3GZJGBRHhqgdb+x1wI7G
         Ajqp3okISFnQaIAiYA1LO3gSRjwDQIA4GyY3YB8Gs68IYtarrhlwTx3UV2SH15zouP
         qqtcwvDtyv0OihYZ0v7SmUaw2Z0PLuuql75V7ACrYYYh6i3dyGOZpYXTi2t/cNOgUI
         RZke/jEvIM9AA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC864403F2; Mon,  2 Aug 2021 11:54:42 -0300 (-03)
Date:   Mon, 2 Aug 2021 11:54:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Message-ID: <YQgHMt4BsDeJnE09@kernel.org>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627566986-30605-3-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 29, 2021 at 09:56:17PM +0800, John Garry escreveu:
> In future to add support for sys events, relocate the core and uncore
> events to a cpu folder.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json | 0
>  .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json  | 0
>  .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json  | 0
>  .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json | 0
>  tools/perf/pmu-events/jevents.c                                 | 2 +-
>  5 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json (100%)
>  rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json (100%)
>  rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json (100%)
>  rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json (100%)
> 
> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/test/test_cpu/branch.json
> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/cache.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/test/test_cpu/cache.json
> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/test/test_cpu/other.json
> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/test/test_cpu/uncore.json
> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 9604446f8360..405bdd36b9b9 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -814,7 +814,7 @@ static void print_mapping_test_table(FILE *outfp)
>  	fprintf(outfp, "\t.cpuid = \"testcpu\",\n");
>  	fprintf(outfp, "\t.version = \"v1\",\n");
>  	fprintf(outfp, "\t.type = \"core\",\n");
> -	fprintf(outfp, "\t.table = pme_test_cpu,\n");
> +	fprintf(outfp, "\t.table = pme_test_soc_cpu,\n");

Humm, is this already generated by some script? I.e. this
'pme_test_soc_cpu' table? Or does this works only when applying the full
patchset?

- Arnaldo

>  	fprintf(outfp, "},\n");
>  }
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
