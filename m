Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18DA8F77;
	Fri,  9 May 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756661; cv=none; b=S1b1n/ZOZORPogXtIPSFPBheWu9UDdxtKC1u6niOZqC1LzLl21j+9Gyg//CTPqDFssHXDwTYpFVHmQrlu5D4N9OPg0ikUZHr+/r8KhVY3H2lxZN57Mvcmy47+w4pLfzwg/HzCeqdMBP98t4Z3dmCwmtBKpk8FUvKfzWMogngPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756661; c=relaxed/simple;
	bh=eouLDxNWFtWINNeneQevRkOh1Ike8Q0fYwwO6srNaVc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nm17EKxeRqKlswvacxvZutHb/kl1FKwenxAWzvATPEkM9qPff7iVW6NqvPHyZsPZ3vX1nH+oYk0t9VSTF3+/3eU+PB5j2IIv293Ir9CTLTjh7tC7TnHYPOJyw/txmDZOgHWQCVFjgFNM/IyngDUQKnc9ThuhTpl4/SqFDYs4wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZtsQr68Dbz1Z1Yl;
	Fri,  9 May 2025 09:50:44 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 745B0180B52;
	Fri,  9 May 2025 09:54:21 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 May 2025 09:54:19 +0800
Subject: Re: [PATCH] perf kvm: Fix arm64 VM-EXIT event detection
To: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
CC: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James
 Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, Leo Yan
	<leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shannon Zhao
	<shannon.zhao@linux.alibaba.com>, Sergey Senozhatsky
	<sergey.senozhatsky@gmail.com>
References: <ZNG9PNB-fEBNyK9E@B-Q60VQ05P-2326.local>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <33dd0a17-cf35-4b6b-9ee5-9983669cc98b@huawei.com>
Date: Fri, 9 May 2025 09:54:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZNG9PNB-fEBNyK9E@B-Q60VQ05P-2326.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk200017.china.huawei.com (7.202.194.83)

[ +Cc the original author of perf kvm stat ]

On 2023/8/8 11:57, Haixin Yu wrote:
> A VM-EXIT event shall start at kvm:kvm_exit, and end with the next
> kvm:kvm_entry. But it's reversed on arm64, which means the time running
> guest code in fact.

Good catch! It'd be great if Sergey could take a look.

> 
> Example:
> 
>  # perf kvm stat record -p 2772 -- sleep 1
> 
> Before this change:
> 
>  # perf kvm stat report
> 
> Analyze events for all VMs, all VCPUs:
> 
>     VM-EXIT Samples Samples%   Time%   Min Time   Max Time    Avg time
> 
>     IRQ      756     100.00%  100.00%   2.28us    3674.38us   1375.66us ( +-   4.34% )
> 
> Total Samples:756, Total events handled time:1039996.94us.
> 
> After:
> 
>  # perf kvm stat report
> 
> Analyze events for all VMs, all VCPUs:
> 
>     VM-EXIT Samples Samples%   Time%   Min Time   Max Time    Avg time
> 
>     IRQ     772      100.00%  100.00%   0.24us     62.86us    6.34us ( +-   3.55% )
> 
> Total Samples:772, Total events handled time:4890.80us.
> 
> IRQ average handled time decreases to 6us, which is a more rational result
> as KVM handles IRQ by returning to guest directly.
> 
> Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
> ---
>  tools/perf/arch/arm64/util/kvm-stat.c | 24 +++---------------------
>  tools/perf/builtin-kvm.c              |  2 +-
>  2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> index 6611aa21cba9..eeb659ceedc2 100644
> --- a/tools/perf/arch/arm64/util/kvm-stat.c
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -21,7 +21,7 @@ const char *kvm_events_tp[] = {
>  	NULL,
>  };
>  
> -static void event_get_key(struct evsel *evsel,
> +void exit_event_get_key(struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct event_key *key)
>  {
> @@ -40,27 +40,9 @@ static void event_get_key(struct evsel *evsel,
>  	}
>  }
>  
> -static bool event_begin(struct evsel *evsel,
> -			struct perf_sample *sample __maybe_unused,
> -			struct event_key *key __maybe_unused)
> -{
> -	return evsel__name_is(evsel, kvm_entry_trace);
> -}
> -
> -static bool event_end(struct evsel *evsel,
> -		      struct perf_sample *sample,
> -		      struct event_key *key)
> -{
> -	if (evsel__name_is(evsel, kvm_exit_trace)) {
> -		event_get_key(evsel, sample, key);
> -		return true;
> -	}
> -	return false;
> -}
> -
>  static struct kvm_events_ops exit_events = {
> -	.is_begin_event = event_begin,
> -	.is_end_event	= event_end,
> +	.is_begin_event = exit_event_begin,
> +	.is_end_event	= exit_event_end,
>  	.decode_key	= exit_event_decode_key,
>  	.name		= "VM-EXIT"
>  };
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 71165036e4ca..498cd8e21134 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -615,7 +615,7 @@ static const char *get_filename_for_perf_kvm(void)
>  
>  #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  
> -void exit_event_get_key(struct evsel *evsel,
> +void __weak exit_event_get_key(struct evsel *evsel,
>  			struct perf_sample *sample,
>  			struct event_key *key)
>  {
