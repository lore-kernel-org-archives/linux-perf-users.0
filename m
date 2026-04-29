Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB003EB7FB
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465829; cv=none; b=ibSnobzMew3Jz93O/61dZBv/rIEYmSSg9+htwUXsA3fniPPifXmxiGtVNuJzZkWQhXkAOxbrq95ymYy0toI1Vp50CK1AjgNQ4tbKbIqQ2QXHnfK2azAbp6dXhs2FNYwB/vyM5meRt6R3/kuS5yAiI8DAgjLrqTsIt3WOwW5Hwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465829; c=relaxed/simple;
	bh=O4m6FSF/8p5h9iCaDgDcj9lLKd7Ha9hfbYIrLe7i0+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bGDkzZ+KZ0/VuT7Gz/QFCfalNiCWLJRMb/++9B9ok38L07hGzKSO04quzBcKsdhfhqxnGIJPDfDJyKHlRjhyppagVyyF1ThvurPNuJ8p2nG9swWZ6YzwN9C6tWXLpIdUUbmusnqn63xutk7b1YMym2twjzAxV2QOTDQSnPbSrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAXzVG9t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAXzVG9t"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so152371135e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777465826; x=1778070626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKXXMcr2mUfen7GgFOumyh5l6FhwVlBnIzCbTzoH5BM=;
        b=ZAXzVG9t+pUMf7JHVdkYQgxE2JUFlP8KlhRTNVtTH9h+CEoYZHoWmQMG2eM/rp3XaJ
         24z6xMO1ap5LXeF74iFhPtpOypqiYXKFkc3TasELdJVVyMx9bFGwev6lVs7UHPtsWZ9T
         U8/kejTynrOu3OeaALyu7sM3VDqOy8hLmcGUpAn8tg4RNyfeIHjw7hi+tx1AhsZjsBv3
         qFhOuQCoVvOi9A3dpStb1GkaiD8qgyNHiWRLeZhO/rNNnFLXGR7iYTQERFTzAduXJCRX
         SHw3Ivm62ShzE0n6ffd1X0LbnTNYa86CtaSKRl2ZWUNONH4S5HxtUJiYTIp/k/fEP12O
         QW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465826; x=1778070626;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKXXMcr2mUfen7GgFOumyh5l6FhwVlBnIzCbTzoH5BM=;
        b=p4ISjbtvWgINsYNzm7bqkq2rVtFFwbgXeDOop6J714zGE2et2QVmU5xRQxaMWyQoNS
         Nox/ZrPsEiRT2yqa7z53OFyR2REi0qFo5DRmaiEzNclLgsEsmBzVEliDt+EhMgp8ckOv
         s7pnO+5nW3ZA6IC+Q3gC9NOS4Nkxp8MzQ02k+3CoDm6ZAkP/QJeyBT3+npZXIfmRnqQ4
         g9ZF+UKqh6GYcuKDO5Kmaq/OCnpYiQK791r2XGPB+zqDyGPXg850rXD9Yfumm7v2uJYz
         pr2Lw+jkrUb8SGUsXQwhBoHn/GKx1vrdqjPQrG0+XyNEYC6I3QegPyATlNRbtvDFb4KQ
         8eWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+6yLKwkBL2pLsVcfuantJhqA1jz4iFnf764uQN+xPsCmQrOrD2zw3pgucZ0z8PfslXTfaWWTv9nsB6xAwOLet@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd849dyKOxB8JhxNs0ileWF41peoWhayW34nQkabujy6S7nozr
	sSWDQ1pZ5JJ7Nl1BNAnazCAll5ZhzHu2acbSBhiWSRw24t76byCvHDpX6dsRir7FQno=
X-Gm-Gg: AeBDietzi29tvAc+MFkM2UabpxYKClPmq46bxVT1+t5TQ5E26hlrnRNcH5PtmUlqWod
	fwW0V6eLoXynAQ+9JVmNXtpUq6Fgt5uc4YOIIRmE1meuZPkzBbgHL9tmWqROOoMxOYz9ImF/RXN
	mWZAFDeXDaJ+TdVrJld5LGuO4fdFmMhLsSWoGxg4oL2X9FTWV+KaOblEilUYC/W39M5iyTFZMPl
	+VEgrZv5ZOqvxE0Z6w5RYscGK0CtY7UNUJTz1HrIAk0/SF/vdHI7XXIgebb7/jCSYNRfg+d95OF
	/WWqoGk7KD7h78RygFAwmcwWqoonKTACqFKX0C0fiBD3KJ2gK9ppEAw7cN0Bg6Rm5GTT5QiQnwR
	qxgSCdhpQ6Po/9XXPYH3ggDOfOrrC4ApT+57v/YK5wQyUv+BHvbmMakRL2mko81KhLEWPyBP4ph
	k+N+VOnfXv0cghvrQpzaGWhv17UfYKXkOapM1mdqE=
X-Received: by 2002:a05:600c:8b04:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48a77ad5a7emr115002295e9.5.1777465824930;
        Wed, 29 Apr 2026 05:30:24 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc12bc0sm58236865e9.2.2026.04.29.05.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:30:24 -0700 (PDT)
Message-ID: <0f0145da-b4f7-42d3-a4ad-cf18a0bed062@linaro.org>
Date: Wed, 29 Apr 2026 13:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf sched stats: Fix segmentation faults in diff mode
To: Ian Rogers <irogers@google.com>
References: <20260428070811.1883202-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Athira Rajeev <atrajeev@linux.ibm.com>, Venkat <venkat88@linux.ibm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260428070811.1883202-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2026 8:08 am, Ian Rogers wrote:
> Address several segmentation fault vectors in `perf sched stats diff`:
> 
> 1. When processing invalid or empty data files, the CPU domain maps may
>     be NULL. Added NULL checks for `cd_map1` and `cd_map2` in
>     `show_schedstat_data()` to fail gracefully.
> 
> 2. When files contain a different number of CPUs or domains, the parallel
>     list iteration in `show_schedstat_data()` could wrap around the list
>     heads and dereference invalid memory. Added `list_is_last` checks
>     to safely terminate iteration at the end of each list.
> 
> 3. When summarizing CPU statistics in `get_all_cpu_stats()`, parallel list
>     iteration over domains could similarly wrap around if a CPU has more
>     domains than the first CPU. Added `list_is_last` check to prevent this.
> 
> 4. Added bounds checks for `cs1->cpu` and `cs2->cpu` against `nr1` and
>     `nr2` (passed from `env->nr_cpus_avail`) to prevent out-of-bounds
>     reads from `cd_map1` and `cd_map2` when processing data from machines
>     with different CPU configurations.
> 
> 5. Added NULL checks for `cd_info1` and `cd_info2` in `show_schedstat_data()`
>     to prevent crashes when a CPU has samples in the data file but no
>     corresponding domain info in the header (which leaves the map entry NULL).
> 
> 6. Added NULL checks for `dinfo1` and `dinfo2` in `show_schedstat_data()`
>     to prevent crashes when a domain is present in the list but has no
>     corresponding info in the CPU domain map (which leaves the entry NULL).
> 
> 7. Zero-initialized the `perf_data` array in `perf_sched__schedstat_diff()`
>     to prevent stack garbage from causing `perf_data_file__fd()` to attempt
>     to use a NULL `fptr` when `use_stdio` happened to be non-zero.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Previously this patch was part of a large perf script refactor:
> https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/
> ---
>   tools/perf/builtin-sched.c | 95 +++++++++++++++++++++++++++++++-------
>   1 file changed, 79 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..9ecda631b3ab 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4212,12 +4212,20 @@ static int get_all_cpu_stats(struct list_head *head)
>   
>   		cnt++;
>   		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
> -		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
> -					 domain_list);
> +		if (!list_empty(&summary_head->domain_head))
> +			tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
> +						 domain_list);
> +		else
> +			tdptr = NULL;
>   
>   		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> -			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> -			tdptr = list_next_entry(tdptr, domain_list);
> +			if (tdptr) {

Minor nit, but would it be better to check "if (tdptr)" before 
list_for_each_entry() and not do the loop at all if tdptr is NULL? It 
implies that there is some useful side effect of list_for_each_entry() 
even if the body is a nop, but I can't see any.

> +				summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> +				if (list_is_last(&tdptr->domain_list, &summary_head->domain_head))
> +					tdptr = NULL;
> +				else
> +					tdptr = list_next_entry(tdptr, domain_list);
> +			}
>   		}
>   	}
>   
> @@ -4225,8 +4233,8 @@ static int get_all_cpu_stats(struct list_head *head)
>   	return ret;
>   }
>   
> -static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
> -			       struct list_head *head2, struct cpu_domain_map **cd_map2,
> +static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1, int nr1,
> +			       struct list_head *head2, struct cpu_domain_map **cd_map2, int nr2,
>   			       bool summary_only)
>   {
>   	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
> @@ -4238,6 +4246,15 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   	bool is_summary = true;
>   	int ret = 0;
>   
> +	if (!cd_map1) {
> +		pr_err("Error: CPU domain map 1 is missing.\n");
> +		return -1;
> +	}
> +	if (head2 && !cd_map2) {
> +		pr_err("Error: CPU domain map 2 is missing.\n");
> +		return -1;
> +	}
> +
>   	printf("Description\n");
>   	print_separator2(SEP_LEN, "", 0);
>   	printf("%-30s-> %s\n", "DESC", "Description of the field");
> @@ -4269,12 +4286,33 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
>   
>   		cs1 = cptr1->cpu_data;
> +		cs2 = NULL;

cs1 and cs2 are only used inside this loop, probably makes sense to 
define them and initialize them both here.

> +		dptr2 = NULL;
> +		if (cs1->cpu >= (u32)nr1) {
> +			pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
> +			return -1;
> +		}
>   		cd_info1 = cd_map1[cs1->cpu];
> +		if (!cd_info1) {
> +			pr_err("Error: CPU %d domain info is missing in map 1.\n", cs1->cpu);
> +			return -1;
> +		}
>   		if (cptr2) {
>   			cs2 = cptr2->cpu_data;
> +			if (cs2->cpu >= (u32)nr2) {
> +				pr_err("Error: CPU %d exceeds domain map size %d\n", cs2->cpu, nr2);
> +				return -1;
> +			}
>   			cd_info2 = cd_map2[cs2->cpu];
> -			dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
> -						 domain_list);
> +			if (!cd_info2) {
> +				pr_err("Error: CPU %d domain info is missing in map 2.\n", cs2->cpu);
> +				return -1;
> +			}
> +			if (!list_empty(&cptr2->domain_head))
> +				dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
> +							 domain_list);
> +			else
> +				dptr2 = NULL;

dptr2 is already NULL initialized, and not that far away from here so 
this is probably a bit too defensive.

>   		}
>   
>   		if (cs2 && cs1->cpu != cs2->cpu) {
> @@ -4302,10 +4340,26 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
>   
>   			ds1 = dptr1->domain_data;
> +			if (ds1->domain >= cd_info1->nr_domains) {
> +				pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 1.\n", ds1->domain, cd_info1->nr_domains, cs1->cpu);
> +				return -1;
> +			}
>   			dinfo1 = cd_info1->domains[ds1->domain];
> +			if (!dinfo1) {
> +				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n", ds1->domain, cs1->cpu);
> +				return -1;
> +			}
>   			if (dptr2) {
>   				ds2 = dptr2->domain_data;
> +				if (ds2->domain >= cd_info2->nr_domains) {
> +					pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 2.\n", ds2->domain, cd_info2->nr_domains, cs2->cpu);
> +					return -1;
> +				}
>   				dinfo2 = cd_info2->domains[ds2->domain];
> +				if (!dinfo2) {
> +					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n", ds2->domain, cs2->cpu);
> +					return -1;
> +				}
>   			}
>   
>   			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
> @@ -4334,14 +4388,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
>   			print_separator2(SEP_LEN, "", 0);
>   
> -			if (dptr2)
> -				dptr2 = list_next_entry(dptr2, domain_list);
> +			if (dptr2) {
> +				if (list_is_last(&dptr2->domain_list, &cptr2->domain_head))
> +					dptr2 = NULL;
> +				else
> +					dptr2 = list_next_entry(dptr2, domain_list);
> +			}
>   		}
>   		if (summary_only)
>   			break;
>   
> -		if (cptr2)
> -			cptr2 = list_next_entry(cptr2, cpu_list);
> +		if (cptr2) {
> +			if (list_is_last(&cptr2->cpu_list, head2))
> +				cptr2 = NULL;
> +			else
> +				cptr2 = list_next_entry(cptr2, cpu_list);
> +		}
>   
>   		is_summary = false;
>   	}
> @@ -4523,7 +4585,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>   		}
>   
>   		cd_map = session->header.env.cpu_domain;
> -		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +		err = show_schedstat_data(&cpu_head, cd_map, session->header.env.nr_cpus_avail, NULL, NULL, 0, false);
>   	}
>   
>   out:
> @@ -4538,7 +4600,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>   	struct perf_session *session[2];
> -	struct perf_data data[2];
> +	struct perf_data data[2] = {0};
>   	int ret = 0, err = 0;
>   	static const char *defaults[] = {
>   		"perf.data.old",
> @@ -4610,7 +4672,8 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   		goto out_delete_ses0;
>   	}
>   
> -	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
> +	show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
> +			    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
>   
>   out_delete_ses1:
>   	free_schedstat(&cpu_head_ses1);
> @@ -4720,7 +4783,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
>   		goto out;
>   	}
>   
> -	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +	show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
>   	free_cpu_domain_info(cd_map, sv, nr);
>   out:
>   	free_schedstat(&cpu_head);

