Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18053E1D1A
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058449; cv=none; b=VXUTwofqDxXqgAp4jryB2TYi/NrB8P1l2u/ZeicEdmoNIrpit2mm2RGhfKZZTcXX0cRV3+t/W1C2/hBDROUQtninQMO+kew5XVIPPRo9igCrI7hKAyJY3FJ4/ITH2j2ogAN+4EWTiH8dZ9knU6RhajJQTZim0pvjHjnR+MGN5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058449; c=relaxed/simple;
	bh=g/dHjDrir3trF5NsjzdOppCiIMdsNOKaT8w3e5QCZWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEh7TBGyIEGloITmI7wIVgZPTx93GnJ0aMc8wSdvyUSAI3aVjmFbS9b+mUZgqRRT8mUXgZKvC0qDAZWQ6lR0ocjKBO34gZ9j5MyOHlcYI0krMY8/RdLS98McajA8SxnddfwZJrKItBAe02GGsBG1RG16BJLnSjtaQwacHDclGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dn5b+Ro6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dn5b+Ro6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-452169ae568so144622f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778058442; x=1778663242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkeUGJjbchJsyhI9ZwKwV4NqglCtLfo75usWHzQlOeQ=;
        b=dn5b+Ro66eNAxFzOUNfqtJH2BcCnZMzi895qI4qWlnezJ3Ux/hPgDG4Sm0yGBfPnmH
         D1KXN+fbxQwy4uca7WruQqraFihLK0s1zY1RF1k+aH4B0A15/t1cBJURPvPar82hXS+7
         ewmpiqs8W+ixvxH6sDxiMBtyFqck2ykYeo33ryOXjxkTO4EFg2rzFCzeLCCWBVRuTKm6
         tiIQk8BXTEufdISIQQRDL8DvenDH8oQ0ddVvEkUBGVeAmFEBXyDsAfayvxJqKi0qdRcg
         LH5AT3fNZKqeecqRpM5WgfP27mI3I29cOcjnc3NrbctE8aCXhvc/jePvSI5UNtyEZofw
         GACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058442; x=1778663242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkeUGJjbchJsyhI9ZwKwV4NqglCtLfo75usWHzQlOeQ=;
        b=H7Y/7ynjWq+rZgVl+DvvcD8XC1jpuAboLUya0A8WlZ7YbYXjzsGGuCm9O51zNLKhUu
         HVvNnkTPZEdCSn40QYON8mliT50PYZ9aG3hP2SsiVk1jgffCspCIFaiwcEp4I7My7ok3
         IJk2pA+bxOGVLM/dtzRZk8EW3tsyNK1i+GTuLLQ12ELKZnWWUssUtBgSvKHU3A28eglr
         HNnFMKLZ8Geqf5M7ZS5Rz03TdoHxMBzcSDQQ4B+wTr9FciNrZt08yYvnihpo+MPel1b3
         3S82XFv4WLhT76gilR5r3D8mSCw5DcYgNvYiLOSUkr9TH1P71TYuX6fFeAf2J1FK2E+N
         ZQjA==
X-Forwarded-Encrypted: i=1; AFNElJ9QhZdirGfmo5UhGoW5QwtI4iUuBXt7iXrnzxncyhX+faPa2bqgx99s5HfoteRDxNXla6BspYQRcD4FKztQ71gT@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIp2sMZKyk4WEN9u5aYxY8mf9MnaA+1aHqH1CDIXKfBnHBAwz
	CEFRI4Io8QgKbNTPvSzyfd81OGLYj12Kq783sHGM1bLzSNhsGD5DkVPLkyudtEsPPr2yYtCrepg
	tbVRWYWU=
X-Gm-Gg: AeBDies00fMwTr4yhpaH85kq5P7ocxaCcUjTZvwMZpMfUwh0PCFEgSF4XZ0Z6SQl87l
	hly3yVW9igga+97dcOdchyz+z5lDE2b+Pd6brKzHWiW3Lr/eo+D7qPPjvz+/0pQbgOGL6+XyZpr
	qR6UHT485pGcH/MI9LbSH1Xuljzq8fnoDDsjcFFh4Ac4kPCskkYVotvI+OJgRg+n03wAINSWZDB
	rXifx9Zo8fVMd7ikIWmmfZjiUMq/WvtDI3rYVh29uwgxQAlw1VUPQ+kBthaXauzL+ZlHySC7l5H
	LBfNl7p3Hu10zH2yJVEy9x8zi2i7RKYSr/WCz4NOnH5CtvqraT7gLrjVcovszAxqJAYFm7nDxTQ
	vYmSkny7fePiopVLHnJuVYDpDlmQjvrS52mWBx5DYV/BNmrNgky7Z2shlalhnTMWkwqm/X9acTs
	2aFsRATinWDGIO0VV48VQArH5IKFKbRgxZLKGevYCkRaAPzrYk1w==
X-Received: by 2002:a05:6000:2689:b0:44a:2555:f8a9 with SMTP id ffacd0b85a97d-4515b524014mr4384106f8f.10.1778058442240;
        Wed, 06 May 2026 02:07:22 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02abbsm10540578f8f.18.2026.05.06.02.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:07:21 -0700 (PDT)
Message-ID: <b5eb312e-2a19-4a99-9d6a-d409fcd72ffb@linaro.org>
Date: Wed, 6 May 2026 10:07:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf sched stats: Fix segmentation faults, memory
 leaks, and stale pointers in diff mode
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 venkat88@linux.ibm.com, acme@kernel.org, atrajeev@linux.ibm.com,
 namhyung@kernel.org
References: <20260506000018.3113599-1-irogers@google.com>
 <20260506041004.3196084-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260506041004.3196084-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2026 5:10 am, Ian Rogers wrote:
> The patch addresses multiple segmentation fault vectors, out-of-bounds
> reads, and memory leaks in perf sched stats by adding bounds checks,
> NULL checks, proper error propagation, and robust memory cleanup.
> 
> 1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
>     unsafe list_first_entry() calls on empty lists, added a missing NULL
>     check for summary_head->cpu_data allocation, and implemented a cleanup
>     ladder using a temporary list to prevent memory leaks on error paths.
> 2. In free_schedstat(), fixed memory leaks by ensuring internal domain_data
>     and cpu_data pointers are freed.
> 3. In show_schedstat_data(), fixed a stale pointer issue where ds2 retained
>     its value from a previous iteration when dptr2 became NULL, and added
>     proper propagation of errors from get_all_cpu_stats().
> 4. Propagated show_schedstat_data() errors up to perf_sched__schedstat_diff()
>     and perf_sched__schedstat_live() to prevent output corruption on failure.
> 5. In show_schedstat_data(), added NULL checks for cd_map1 and cd_map2
>     to gracefully handle invalid or empty data files.
> 6. Added parallel iteration termination checks using list_is_last() in
>     show_schedstat_data() for both domain and CPU lists to safely terminate
>     at the end of each list when files contain a different number of CPUs
>     or domains.
> 7. Added CPU bounds checks (cs1->cpu >= nr1 and cs2->cpu >= nr2) in
>     show_schedstat_data() to prevent out-of-bounds reads from cd_map1 and
>     cd_map2 when comparing files from machines with different CPU counts.
> 8. Added NULL checks for cd_info1 and cd_info2 to prevent crashes when
>     a CPU has data samples but no corresponding domain info in the header.
> 9. Added domain bounds checks (ds1->domain >= cd_info1->nr_domains and
>     ds2->domain >= cd_info2->nr_domains) to prevent out-of-bounds array
>     accesses in the domains array.
> 10. Added NULL checks for dinfo1 and dinfo2 in show_schedstat_data()
>      to prevent crashes when a domain has no corresponding domain info.
> 11. Zero-initialized the perf_data array in perf_sched__schedstat_diff()
>      to prevent stack garbage from causing perf_data_file__fd() to attempt
>      to use a NULL fptr when use_stdio happened to be non-zero.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> ---
> v4:
> Address further sashiko feedback:
>   - Fix memory leaks of global cpu_head list when perf_session__process_events() fails.
>   - Fix resource leak of second session by correcting cleanup order when first session's data is empty.
> 
> v3:
> Address sashiko feedback:
>   - Fix memory leaks in free_schedstat() by freeing internal data.
>   - Fix missing NULL check for summary_head->cpu_data in get_all_cpu_stats().
>   - Fix memory leaks in get_all_cpu_stats() on error paths using a temporary cleanup list.
>   - Fix stale ds2 pointer comparison in show_schedstat_data() by resetting it to NULL.
>   - Add error propagation from get_all_cpu_stats() and show_schedstat_data().
>   - Correct commit message to remove inaccurate claim about uninitialized variable 'ret'.
>   - Add forward declaration for free_schedstat() to fix compilation error.
> 
> v2: Had tested-by Athira Rajeev and reviewed-by James Clark, removed
>      from v3 given the number of changes.
> https://lore.kernel.org/linux-perf-users/20260429173931.2700115-1-irogers@google.com/
> ---
>   tools/perf/builtin-sched.c | 175 +++++++++++++++++++++++++++++--------
>   1 file changed, 138 insertions(+), 37 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..fd679b106582 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3947,6 +3947,8 @@ static struct schedstat_domain *domain_second_pass;
>   static bool after_workload_flag;
>   static bool verbose_field;
>   
> +static void free_schedstat(struct list_head *head);
> +
>   static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workload)
>   {
>   	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
> @@ -4170,37 +4172,50 @@ static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
>    */
>   static int get_all_cpu_stats(struct list_head *head)
>   {
> -	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
> -	struct schedstat_cpu *summary_head = NULL;
> -	struct perf_record_schedstat_domain *ds;
> -	struct perf_record_schedstat_cpu *cs;
> +	struct schedstat_cpu *cptr, *summary_head = NULL;
>   	struct schedstat_domain *dptr, *tdptr;
>   	bool is_last = false;
>   	int cnt = 1;
>   	int ret = 0;
> +	struct list_head tmp_cleanup_list;
>   
> -	if (cptr) {
> -		summary_head = zalloc(sizeof(*summary_head));
> -		if (!summary_head)
> -			return -ENOMEM;
> +	assert(!list_empty(head));
> +	cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
>   
> -		summary_head->cpu_data = zalloc(sizeof(*cs));
> -		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
> +	INIT_LIST_HEAD(&tmp_cleanup_list);
>   
> -		INIT_LIST_HEAD(&summary_head->domain_head);
> +	summary_head = zalloc(sizeof(*summary_head));
> +	if (!summary_head)
> +		return -ENOMEM;
>   
> -		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> -			tdptr = zalloc(sizeof(*tdptr));
> -			if (!tdptr)
> -				return -ENOMEM;
> +	INIT_LIST_HEAD(&summary_head->domain_head);
> +	INIT_LIST_HEAD(&summary_head->cpu_list);
> +	list_add(&summary_head->cpu_list, &tmp_cleanup_list);
>   
> -			tdptr->domain_data = zalloc(sizeof(*ds));
> -			if (!tdptr->domain_data)
> -				return -ENOMEM;
> +	summary_head->cpu_data = zalloc(sizeof(*summary_head->cpu_data));
> +	if (!summary_head->cpu_data) {
> +		ret = -ENOMEM;
> +		goto out_cleanup;
> +	}
> +	memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_head->cpu_data));
> +
> +	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> +		tdptr = zalloc(sizeof(*tdptr));
> +		if (!tdptr) {
> +			ret = -ENOMEM;
> +			goto out_cleanup;
> +		}
> +		INIT_LIST_HEAD(&tdptr->domain_list);
>   
> -			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
> -			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
> +		tdptr->domain_data = zalloc(sizeof(*tdptr->domain_data));
> +		if (!tdptr->domain_data) {
> +			free(tdptr);
> +			ret = -ENOMEM;
> +			goto out_cleanup;
>   		}
> +
> +		memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*tdptr->domain_data));
> +		list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
>   	}
>   
>   	list_for_each_entry(cptr, head, cpu_list) {
> @@ -4212,32 +4227,52 @@ static int get_all_cpu_stats(struct list_head *head)
>   
>   		cnt++;
>   		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
> +		if (list_empty(&summary_head->domain_head))
> +			continue;
> +
>   		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
>   					 domain_list);
>   
>   		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>   			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
> +			if (list_is_last(&tdptr->domain_list, &summary_head->domain_head)) {
> +				tdptr = NULL;
> +				break;
> +			}
>   			tdptr = list_next_entry(tdptr, domain_list);
>   		}
>   	}
>   
> +	list_del_init(&summary_head->cpu_list);
>   	list_add(&summary_head->cpu_list, head);
> +	return 0;
> +
> +out_cleanup:
> +	free_schedstat(&tmp_cleanup_list);
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
>   	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
> -	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
>   	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
>   	struct schedstat_cpu *cptr2 = NULL;
>   	__u64 jiffies1 = 0, jiffies2 = 0;
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
> @@ -4260,21 +4295,47 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   	printf("\n");
>   
>   	ret = get_all_cpu_stats(head1);
> +	if (ret)
> +		return ret;
>   	if (cptr2) {
>   		ret = get_all_cpu_stats(head2);
> +		if (ret)
> +			return ret;
>   		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
>   	}
>   
>   	list_for_each_entry(cptr1, head1, cpu_list) {
>   		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
> +		struct perf_record_schedstat_cpu *cs1 = cptr1->cpu_data;
> +		struct perf_record_schedstat_cpu *cs2 = NULL;
>   
> -		cs1 = cptr1->cpu_data;
> +		dptr2 = NULL;
> +		if (cs1->cpu >= (u32)nr1) {
> +			pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
> +			return -1;
> +		}
>   		cd_info1 = cd_map1[cs1->cpu];
> +		if (!cd_info1) {
> +			pr_err("Error: CPU %d domain info is missing in map 1.\n",
> +			       cs1->cpu);
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
> +				pr_err("Error: CPU %d domain info is missing in map 2.\n",
> +				       cs2->cpu);
> +				return -1;
> +			}
> +			if (!list_empty(&cptr2->domain_head))
> +				dptr2 = list_first_entry(&cptr2->domain_head,
> +							 struct schedstat_domain,
> +							 domain_list);
>   		}
>   
>   		if (cs2 && cs1->cpu != cs2->cpu) {
> @@ -4302,10 +4363,31 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
>   
>   			ds1 = dptr1->domain_data;
> +			ds2 = NULL;
> +			if (ds1->domain >= cd_info1->nr_domains) {
> +				pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 1.\n",
> +				       ds1->domain, cd_info1->nr_domains, cs1->cpu);
> +				return -1;
> +			}
>   			dinfo1 = cd_info1->domains[ds1->domain];
> +			if (!dinfo1) {
> +				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n",
> +				       ds1->domain, cs1->cpu);
> +				return -1;
> +			}
>   			if (dptr2) {
>   				ds2 = dptr2->domain_data;
> +				if (ds2->domain >= cd_info2->nr_domains) {
> +					pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 2.\n",
> +					       ds2->domain, cd_info2->nr_domains, cs2->cpu);
> +					return -1;
> +				}
>   				dinfo2 = cd_info2->domains[ds2->domain];
> +				if (!dinfo2) {
> +					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n",
> +					       ds2->domain, cs2->cpu);
> +					return -1;
> +				}
>   			}
>   
>   			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
> @@ -4334,14 +4416,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
> @@ -4473,9 +4563,11 @@ static void free_schedstat(struct list_head *head)
>   	list_for_each_entry_safe(cptr, n2, head, cpu_list) {
>   		list_for_each_entry_safe(dptr, n1, &cptr->domain_head, domain_list) {
>   			list_del_init(&dptr->domain_list);
> +			free(dptr->domain_data);
>   			free(dptr);
>   		}
>   		list_del_init(&cptr->cpu_list);
> +		free(cptr->cpu_data);
>   		free(cptr);
>   	}
>   }
> @@ -4523,7 +4615,9 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>   		}
>   
>   		cd_map = session->header.env.cpu_domain;
> -		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +		err = show_schedstat_data(&cpu_head, cd_map,
> +					  session->header.env.nr_cpus_avail,
> +					  NULL, NULL, 0, false);
>   	}
>   
>   out:
> @@ -4538,7 +4632,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>   	struct perf_session *session[2];
> -	struct perf_data data[2];
> +	struct perf_data data[2] = {0};
>   	int ret = 0, err = 0;
>   	static const char *defaults[] = {
>   		"perf.data.old",
> @@ -4573,8 +4667,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	}
>   
>   	err = perf_session__process_events(session[0]);
> -	if (err)
> +	if (err) {
> +		free_schedstat(&cpu_head);
>   		goto out_delete_ses0;
> +	}
>   
>   	cd_map0 = session[0]->header.env.cpu_domain;
>   	list_replace_init(&cpu_head, &cpu_head_ses0);
> @@ -4590,8 +4686,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	}
>   
>   	err = perf_session__process_events(session[1]);
> -	if (err)
> +	if (err) {
> +		free_schedstat(&cpu_head);
>   		goto out_delete_ses1;
> +	}
>   
>   	cd_map1 = session[1]->header.env.cpu_domain;
>   	list_replace_init(&cpu_head, &cpu_head_ses1);
> @@ -4607,10 +4705,13 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	if (list_empty(&cpu_head_ses0)) {
>   		pr_err("Data is not available\n");
>   		ret = -1;
> -		goto out_delete_ses0;
> +		goto out_delete_ses1;
>   	}
>   
> -	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
> +	ret = show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
> +				  &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
> +	if (ret)
> +		goto out_delete_ses1;
>   
>   out_delete_ses1:
>   	free_schedstat(&cpu_head_ses1);
> @@ -4720,7 +4821,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
>   		goto out;
>   	}
>   
> -	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +	err = show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
>   	free_cpu_domain_info(cd_map, sv, nr);
>   out:
>   	free_schedstat(&cpu_head);

