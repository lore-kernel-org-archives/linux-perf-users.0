Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C001ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Sep 2022 10:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIIKat (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Sep 2022 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIIKaC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Sep 2022 06:30:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FF8732A8E;
        Fri,  9 Sep 2022 03:29:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 163FC15DB;
        Fri,  9 Sep 2022 03:29:53 -0700 (PDT)
Received: from [10.57.77.227] (unknown [10.57.77.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217483F73D;
        Fri,  9 Sep 2022 03:29:45 -0700 (PDT)
Message-ID: <50fba997-d8c1-257b-fd11-db2bb1e53f70@arm.com>
Date:   Fri, 9 Sep 2022 11:29:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] perf tools: remove perf_pmu_lex declaration
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, atrajeev@linux.vnet.ibm.com,
        eranian@google.com
References: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
 <20220909044542.1087870-3-cuigaosheng1@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220909044542.1087870-3-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/09/2022 05:45, Gaosheng Cui wrote:
> perf_pmu_lex has been removed since
> commit 65f3e56e0c81 ("perf tools: Remove auto-generated bison/flex files"),
> so remove it.

Not 100% sure if that is the right commit to reference because it didn't
touch pmu.y.

perf_pmu_lex is still used and there are plenty of references to it, but
maybe the extern declaration isn't needed anymore because it still
builds for me with this change.

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  tools/perf/util/pmu.y | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index bfd7e8509869..0dab0ec2eff7 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -10,8 +10,6 @@
>  #include <string.h>
>  #include "pmu.h"
>  
> -extern int perf_pmu_lex (void);
> -
>  #define ABORT_ON(val) \
>  do { \
>          if (val) \
