Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110AEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 17:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhKXRbP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 12:31:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4165 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbhKXRbO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 12:31:14 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HznyD53Cgz67sTc;
        Thu, 25 Nov 2021 01:27:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 18:28:03 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:28:02 +0000
Subject: Re: [PATCH v2 1/4] perf expr: Add debug logging for literals
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <5a516c85-695c-60da-a3cc-ab1c1b08c87f@huawei.com>
Date:   Wed, 24 Nov 2021 17:28:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211124001231.3277836-1-irogers@google.com>
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


>   	}
> -	if (!strcmp("#num_packages", literal))
> -		return topology->package_cpus_lists;
> -	if (!strcmp("#num_dies", literal))
> -		return topology->die_cpus_lists;
> -	if (!strcmp("#num_cores", literal))
> -		return topology->core_cpus_lists;
> +	if (!strcmp("#num_packages", literal)) {
> +		result = topology->package_cpus_lists;
> +		goto out;
> +	}
> +	if (!strcmp("#num_dies", literal)) {
> +		result = topology->die_cpus_lists;
> +		goto out;
> +	}
> +	if (!strcmp("#num_cores", literal)) {
> +		result = topology->core_cpus_lists;

if we find that we now get the same print many times, how about:
		pr_debug2_once("literal: num_cores = %f\n", result);

... not sure if it scales though

Thanks,
John


> +		goto out;
> +	}
>   
>   	pr_err("Unrecognized literal '%s'", literal);
> -	return NAN;
> +out:
> +	pr_debug2("literal: %s = %f\n", literal, result);
> +	return result;
>   }

