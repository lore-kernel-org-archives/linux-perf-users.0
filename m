Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A5C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 17:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbhKXRIC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 12:08:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4162 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbhKXRIC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 12:08:02 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HznQp3kdzz67bvT;
        Thu, 25 Nov 2021 01:03:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 18:04:50 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:04:49 +0000
Subject: Re: [PATCH v2 3/4] perf tools: Fix SMT fallback with large core
 counts
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20211124001231.3277836-1-irogers@google.com>
 <20211124001231.3277836-3-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1f5cd846-a0fc-3919-bb5f-41ab56fe7f1a@huawei.com>
Date:   Wed, 24 Nov 2021 17:04:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211124001231.3277836-3-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/11/2021 00:12, Ian Rogers wrote:
> strtoull can only read a 64-bit bitmap. On an AMD EPYC core_cpus may look
> like:
> 00000000,00000000,00000000,00000001,00000000,00000000,00000000,00000001
> and so the sibling wasn't spotted. Fix by writing a simple hweight string
> parser.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/smt.c | 68 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 34f1b1b1176c..2636be65305a 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -5,6 +5,56 @@
>   #include "api/fs/fs.h"
>   #include "smt.h"
>   
> +/**
> + * hweight_str - Returns the number of bits set in str. Stops at first non-hex
> + *	       or ',' character.

nit: the wording here could be improved, I think. You really mean we 
iter until we reach a character which is neither a hex nor a ',', while 
I read this as iter until either a non-hex or a ','.

> + */
> +static int hweight_str(char *str)
> +{
> +	int result = 0;
> +
> +	while (*str) {

Can we use __buitin_popcount() to try to simplify?

> +		switch (*str++) {
> +		case '0':
> +		case ',':
> +			break;
> +		case '1':
> +		case '2':
> +		case '4':
> +		case '8':
> +			result++;
> +			break;
> +		case '3':
> +		case '5':
> +		case '6':
> +		case '9':
> +		case 'a':
> +		case 'A':
> +		case 'c':
> +		case 'C':
> +			result += 2;
> +			break;
> +		case '7':
> +		case 'b':
> +		case 'B':
> +		case 'd':
> +		case 'D':
> +		case 'e':
> +		case 'E':
> +			result += 3;
> +			break;
> +		case 'f':
> +		case 'F':
> +			result += 4;
> +			break;
> +		default:
> +			goto done;
> +		}
> +	}
> +done:
