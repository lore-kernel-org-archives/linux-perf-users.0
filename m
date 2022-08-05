Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A4BC00140
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Aug 2022 09:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiHEJz4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiHEJzw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Aug 2022 05:55:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6222877555;
        Fri,  5 Aug 2022 02:55:51 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lzgp52Bmkz67ykV;
        Fri,  5 Aug 2022 17:50:53 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 11:55:48 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 10:55:47 +0100
Message-ID: <b1cc7151-e57c-6ec5-f3f1-361434e0b2ee@huawei.com>
Date:   Fri, 5 Aug 2022 10:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 03/17] perf jevents: Add JEVENTS_ARCH make option
To:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        "James Clark" <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-4-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-4-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04/08/2022 23:18, Ian Rogers wrote:
> Allow the architecture built into pmu-events.c to be set on the make
> command line with JEVENTS_ARCH.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Seems reasonable, so:

Reviewed-by: John Garry <john.garry@huawei.com>

I assume that if we run on the wrong arch (than we build for) then it 
has same effect as if pmu-events is not supported.

> ---
>   tools/perf/pmu-events/Build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 28a9d01b08af..04ef95174660 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -7,6 +7,10 @@ JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
>   			find $(JDIR_TEST) -name '*.json')
>   JEVENTS_PY	=  pmu-events/jevents.py
>   
> +ifeq ($(JEVENTS_ARCH),)
> +JEVENTS_ARCH=$(SRCARCH)
> +endif
> +
>   #
>   # Locate/process JSON files in pmu-events/arch/
>   # directory and create tables in pmu-events.c.
> @@ -19,5 +23,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
>   else
>   $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
>   endif

