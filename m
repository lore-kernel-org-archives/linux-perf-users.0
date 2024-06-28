Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF37FF;
	Fri, 28 Jun 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542020; cv=none; b=O1jRPuKCw6pDJuNzqp11bVXsFpkaqzsh7pHnVlLqBlUY3oFoLRTqk/1LhEW5X4Akq+lnot5HiZ7QYBPo41NhmWHW1qqCu3uVBRRvdgcheozL+NjHZOLgxwUkh8Fh6s45xIlkHuCVS/meZnStW2zCD6TOHHbcAmPreRjVOnzf+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542020; c=relaxed/simple;
	bh=oyDI734ARDefjR3kNiw3Wf7uFfhzW8qVKv93V4DSXiY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CueySOmm7jgZAWWlrUvCPNYSNhGXixEuwz3LLmBIXKkhWl9h/GccZwvobWmpR+U9mwzjZ/r3vpCZZi6SDYmNLef1HPaYBgJ4oskCgfsAoBBtAPQVoD/2cZhnODaHBYJqyhLm3p1XPMsLmwqwG9f0BHeEVKNOx2pWeKjGDV5rKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W9KBX428Tz1T4JJ;
	Fri, 28 Jun 2024 10:29:08 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id CF396180088;
	Fri, 28 Jun 2024 10:33:34 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 28 Jun 2024 10:33:34 +0800
CC: <yangyicong@hisilicon.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf stat: Fix a segfault with --per-cluster
 --metric-only
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
	<kan.liang@linux.intel.com>
References: <20240628000604.1296808-1-namhyung@kernel.org>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <83aa958a-5bd6-06eb-06a4-39e51e2eb3b5@huawei.com>
Date: Fri, 28 Jun 2024 10:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240628000604.1296808-1-namhyung@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Namhyung,

On 2024/6/28 8:06, Namhyung Kim wrote:
> The new --per-cluster option was added recently but it forgot to update
> the aggr_header fields which are used for --metric-only option.  And it
> resulted in a segfault due to NULL string in fputs().
> 
> Fixes: cbc917a1b03b ("perf stat: Support per-cluster aggregation")
> Cc: Yicong Yang <yangyicong@hisilicon.com>

Thanks for fixing this.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Tested on my cluster machine and this patch fixes the issue:

[root@localhost perf]# ./perf-before stat -M TopDownL1 --per-cluster --metric-only --timeout 100 -x ,
Segmentation fault (core dumped)
[root@localhost perf]# ./perf-after stat -M TopDownL1 --per-cluster --metric-only --timeout 100 -x ,
cluster,cpus,retiring,bad_speculation,backend_bound,frontend_bound,
S56-D0-CLS158,4,0.03,0.00,0.96,0.00,
[...]

So,

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks.

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 91d2f7f65df7..186305fd2d0e 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -38,6 +38,7 @@
>  static int aggr_header_lens[] = {
>  	[AGGR_CORE] 	= 18,
>  	[AGGR_CACHE]	= 22,
> +	[AGGR_CLUSTER]	= 20,
>  	[AGGR_DIE] 	= 12,
>  	[AGGR_SOCKET] 	= 6,
>  	[AGGR_NODE] 	= 6,
> @@ -49,6 +50,7 @@ static int aggr_header_lens[] = {
>  static const char *aggr_header_csv[] = {
>  	[AGGR_CORE] 	= 	"core,cpus,",
>  	[AGGR_CACHE]	= 	"cache,cpus,",
> +	[AGGR_CLUSTER]	= 	"cluster,cpus,",
>  	[AGGR_DIE] 	= 	"die,cpus,",
>  	[AGGR_SOCKET] 	= 	"socket,cpus,",
>  	[AGGR_NONE] 	= 	"cpu,",
> @@ -60,6 +62,7 @@ static const char *aggr_header_csv[] = {
>  static const char *aggr_header_std[] = {
>  	[AGGR_CORE] 	= 	"core",
>  	[AGGR_CACHE] 	= 	"cache",
> +	[AGGR_CLUSTER]	= 	"cluster",
>  	[AGGR_DIE] 	= 	"die",
>  	[AGGR_SOCKET] 	= 	"socket",
>  	[AGGR_NONE] 	= 	"cpu",
> 
