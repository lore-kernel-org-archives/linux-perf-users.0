Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30393524B4
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627892; cv=none; b=gtmTBiczMVI+dg0hni406sOgNS9QF1o/XXLZnZ8AeQPT/62Y7h7Sk0rqoKiDcH8YMmds6qe1byjm0o5OhfzlcQQ1nTDR4rsJcXNONHyimbl3ppAXSZvoD0cOaE0eqVMHd3Dl2eLxx7NcpwMw6ROcR8X9gLfnQ8lFmFiLKCPeQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627892; c=relaxed/simple;
	bh=8GHI8LGACb+DA8CihYCwGk9b3byAo46SnqRtME5LV+U=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EONWEMHbqab0LFajRWQ6tzsP12ntwLGZB1t+u+U5two2RjB6PGI60QPiK7awHpupTHZUnbhMa1YrZq0ynNelnnU9FORR8LhUBiU4k1t9QUhjbr4tALg7QqnWl7TtW8w6Q9ZYFHvY5qadyMwh3nLzkt5ePTgKzZOXmATCazKFajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WkNKY33yBz1T773;
	Wed, 14 Aug 2024 17:30:57 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 19E4D180088;
	Wed, 14 Aug 2024 17:31:27 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 14 Aug 2024 17:31:26 +0800
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] perf stat: Display iostat headers correctly
To: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>
References: <20240802065800.48774-1-yangyicong@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <e62e8fd2-6533-f8f0-ae32-f5736fdbedc6@huawei.com>
Date: Wed, 14 Aug 2024 17:31:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240802065800.48774-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

A gentle ping...

On 2024/8/2 14:58, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently we'll only print metric headers for metric leader in
> aggregration mode. This will make `perf iostat` header not shown
> since it'll aggregrated globally but don't have metric events:
> root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
>  Performance counter stats for 'system wide':
>     port
> 0000:00                    0                    0                    0                    0
> 0000:80                    0                    0                    0                    0
> [...]
> 
> Fix this by excluding the iostat in the check of printing metric
> headers. Then we can see the headers:
> root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
>  Performance counter stats for 'system wide':
>     port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
> 0000:00                    0                    0                    0                    0
> 0000:80                    0                    0                    0                    0
> [...]
> 
> Fixes: 193a9e30207f ("perf stat: Don't display metric header for non-leader uncore events")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/util/stat-display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index c38bcb6f4c78..ea96e4ebad8c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1237,7 +1237,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>  
>  	/* Print metrics headers only */
>  	evlist__for_each_entry(evlist, counter) {
> -		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
> +		if (!config->iostat_run &&
> +		    config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
>  			continue;
>  
>  		os.evsel = counter;
> 
