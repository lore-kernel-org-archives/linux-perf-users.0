Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD65423A8C
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555751; cv=none; b=MBUvxW6u17uDZH5HrAELrgi05KFxMKSpjI0CM0RmAD3us4wU0F7y+fJUM4xbD5s80LDaV5PSQdjgwpzsDDtBCHD8+I8kD3mo2TXwWxV3q9E8zOnQYR87BjTOVgdNXDd0tTN+vBTJdyiJJAfoWwLtna3FNvm1T06uWPBg/BKn+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555751; c=relaxed/simple;
	bh=1GrE2EZbKR57Tv45qiWf+69h6SLWjPDUSg9KJ+Fl864=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t98/09gaeJRKXTZkVa+iNB+LA2CiLJoxqaAzoxqG0qjcF6cjXVfAH6GtvXXJ05CXL8E9eK6duOadZMTfKLlYycMDyMbwVR967zkzNGLvw5HxAJcqkNsIRGwDtAtvZPBpbSWmcbTPvTgA7zBE3rIEin0u5orfaQgX0F8QSg4thfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RWSmLqrp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWSmLqrp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so8321545e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777555748; x=1778160548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlv8vl000xsTt6CNTENIuzRhsg+T/VV8g5T/0Ti4QQM=;
        b=RWSmLqrpT5F5aqt2JaQSCeEKdhcu1PlXmC9xXHT/zG4OzIPWfsen+8geFiui7hNbqG
         OAsbNsmUUrkALFfLVNbQpxQ2tJ7zYqFkXG0aBQEyzwukdZgC651InbMlZ3WCu+YVRQcf
         0xr3ZU3TLxfs6hn3atakj/pADgIUUMrhrIP+GUpZMjATrzG+JtWEXTYbQh+wsLLwYUH4
         eII/cPCVsbe5nJTwiWEJ7RM5nGmNAzXr4pEjQ3ejFYBT2llr1a10kjD0NR8OX1LXvoYC
         hT8Nk5ARRiqDyPhKAvQXSeuyH7Uvn0v1ugWSETYu5p+j22FtPzRhL5WHCuYC+mOuXL7z
         F2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555748; x=1778160548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlv8vl000xsTt6CNTENIuzRhsg+T/VV8g5T/0Ti4QQM=;
        b=NuQh598e4fJ10szBz6o2ZLVXm80gE/LHLD/vv2Y/eC6YfRbCS+sG15K1Xeq1XiEw4o
         23df+eCEdPKgu0g03V/wtpG0hE/meGcSXhQIcBz+s2E3lJS/bzZJbtjZHZ328fAMJ/bD
         NJIxsfOMEvt8hqJ8HRj955Wf0y9cOjTygmf289HI1I0wfpfaKMLocx+h6aA/TGVePO+1
         dOH5v9lzuPS4yefxGvWLqYEG5RLJ/t9H/6PfHjPksHlpNIs8ZrwSCc1i3as+/kGF2vOD
         RcmEVeHXNX0CeRAde1hyZCihTsaBrxLD/Z3Uln2Rlachwg92g47szStsySQooyhlR/Ci
         gTkA==
X-Forwarded-Encrypted: i=1; AFNElJ8ThtKxzSLeZ03YTX9MnHtPhDbtX9mNgMo1KY6+yNaW6uuCZTu0tP9RyDrbbVRxzWqYo52BL3SZTKJ4SV07oUCL@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEHLryJ7h+eq43YGW9K8DxWepNqxTr6FwdzLWuQZedacnYRtO
	3Bkc6kjPzW5jzBxzsONnlGK4okHQtr3SRsjg7vXcZ8FJm/gW8E2+mjoTTbbKOzfDZAM=
X-Gm-Gg: AeBDietazF3prKcMNQ5JL+9wryC6PV5Eoi6/3bqzL1xR1NGW4X2al/TxT5oM8WNVrw4
	TReKLXsO+e5AUzbVbOO6PamBTmwmPhboYTT39PAaAeuVKqFIByJJ9bcvdiOt/M86efRuPl5KKoe
	okc03FGeyCHRbflwSs5vEDeJoLrQCO8ilHNix8t9OX2ZkYN814HESeC1BbQIRN6ZVU6JFNCn4/a
	aXO4q4lJayidiYlgcPlUqOvyo01egoT/XkHd7xcjVLoAnNA0y/7UciFuj2gXBPgKJjxHFtRQzpl
	BGaLNWgbGxFLeD5mi/AAIBGK5vTQz6gY3JChlveXi6tsP4yS66jBju0oppj5gVFsHE15Dt71CCm
	SktOYAHxCIiQ1FyF7oZ2FNLMcj6H0d1KOa42/jvVlqEDHXU0xZkJjPDdrheHIJitsnHf/36lDDO
	dbf7PuV8iBca/CGpIiGexuCDR1xDKk+f0AeeF4q1U=
X-Received: by 2002:a05:600c:4f0b:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-48a8445e86amr43361105e9.22.1777555747849;
        Thu, 30 Apr 2026 06:29:07 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822d4b57sm169415235e9.15.2026.04.30.06.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:29:06 -0700 (PDT)
Message-ID: <21f4284f-9d73-4e58-9b18-d62c02539aae@linaro.org>
Date: Thu, 30 Apr 2026 14:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched stats: Fix segmentation faults in diff mode
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 venkat88@linux.ibm.com, acme@kernel.org, atrajeev@linux.ibm.com,
 namhyung@kernel.org
References: <20260428070811.1883202-1-irogers@google.com>
 <20260429173931.2700115-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260429173931.2700115-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/04/2026 6:39 pm, Ian Rogers wrote:
> Address several segmentation fault vectors in `perf sched stats diff`:
> 
> 1. In `get_all_cpu_stats()`, added `assert(!list_empty(head))` to prevent
>     unsafe `list_first_entry()` calls on empty lists, fixed uninitialized
>     variable `ret`, and added `list_is_last` check when iterating domains to
>     prevent out-of-bounds reads during parallel list traversal.
> 
> 2. In `show_schedstat_data()`, added NULL checks for `cd_map1` and `cd_map2`
>     to gracefully handle invalid or empty data files.
> 
> 3. Added parallel iteration termination checks using `list_is_last()` in
>     `show_schedstat_data()` for both domain and CPU lists to safely terminate
>     at the end of each list when files contain a different number of CPUs
>     or domains.
> 
> 4. Added CPU bounds checks (`cs1->cpu >= nr1` and `cs2->cpu >= nr2`) in
>     `show_schedstat_data()` to prevent out-of-bounds reads from `cd_map1` and
>     `cd_map2` when comparing files from machines with different CPU counts.
> 
> 5. Added NULL checks for `cd_info1` and `cd_info2` to prevent crashes when
>     a CPU has data samples but no corresponding domain info in the header.
> 
> 6. Added domain bounds checks (`ds1->domain >= cd_info1->nr_domains` and
>     `ds2->domain >= cd_info2->nr_domains`) to prevent out-of-bounds array
>     accesses in the domains array.
> 
> 7. Added NULL checks for `dinfo1` and `dinfo2` in `show_schedstat_data()`
>     to prevent crashes when a domain has no corresponding domain info.
> 
> 8. Zero-initialized the `perf_data` array in `perf_sched__schedstat_diff()`
>     to prevent stack garbage from causing `perf_data_file__fd()` to attempt
>     to use a NULL `fptr` when `use_stdio` happened to be non-zero.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Reduce indentation and variable scopes. Hopefully address feedback
>      from James Clark.
> 
> Previously this patch was part of a large perf script refactor:
> https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/
> ---
>   tools/perf/builtin-sched.c | 144 +++++++++++++++++++++++++++----------
>   1 file changed, 106 insertions(+), 38 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..e67241415255 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4170,40 +4170,40 @@ static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
>    */
>   static int get_all_cpu_stats(struct list_head *head)
>   {
> -	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
> -	struct schedstat_cpu *summary_head = NULL;
> -	struct perf_record_schedstat_domain *ds;
> -	struct perf_record_schedstat_cpu *cs;
> -	struct schedstat_domain *dptr, *tdptr;
> +	struct schedstat_cpu *cptr, *summary_head;
> +	struct schedstat_domain *dptr;
>   	bool is_last = false;
>   	int cnt = 1;
> -	int ret = 0;
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
> +	summary_head = zalloc(sizeof(*summary_head));
> +	if (!summary_head)
> +		return -ENOMEM;
>   
> -		INIT_LIST_HEAD(&summary_head->domain_head);
> +	summary_head->cpu_data = zalloc(sizeof(*summary_head->cpu_data));
> +	memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_head->cpu_data));
>   
> -		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> -			tdptr = zalloc(sizeof(*tdptr));
> -			if (!tdptr)
> -				return -ENOMEM;
> +	INIT_LIST_HEAD(&summary_head->domain_head);
>   
> -			tdptr->domain_data = zalloc(sizeof(*ds));
> -			if (!tdptr->domain_data)
> -				return -ENOMEM;
> +	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> +		struct schedstat_domain *tdptr = zalloc(sizeof(*tdptr));
>   
> -			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
> -			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
> -		}
> +		if (!tdptr)
> +			return -ENOMEM;
> +
> +		tdptr->domain_data = zalloc(sizeof(*tdptr->domain_data));
> +		if (!tdptr->domain_data)
> +			return -ENOMEM;
> +
> +		memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*tdptr->domain_data));
> +		list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
>   	}
>   
>   	list_for_each_entry(cptr, head, cpu_list) {
> +		struct schedstat_domain *tdptr;
> +
>   		if (list_is_first(&cptr->cpu_list, head))
>   			continue;
>   
> @@ -4212,32 +4212,47 @@ static int get_all_cpu_stats(struct list_head *head)
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
>   	list_add(&summary_head->cpu_list, head);
> -	return ret;
> +	return 0;
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
> @@ -4267,14 +4282,36 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
> @@ -4302,10 +4339,30 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>   			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
>   
>   			ds1 = dptr1->domain_data;
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
> @@ -4334,14 +4391,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
> @@ -4523,7 +4588,9 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
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
> @@ -4538,7 +4605,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>   	struct perf_session *session[2];
> -	struct perf_data data[2];
> +	struct perf_data data[2] = {0};
>   	int ret = 0, err = 0;
>   	static const char *defaults[] = {
>   		"perf.data.old",
> @@ -4610,7 +4677,8 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   		goto out_delete_ses0;
>   	}
>   
> -	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
> +	show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
> +			    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
>   
>   out_delete_ses1:
>   	free_schedstat(&cpu_head_ses1);
> @@ -4720,7 +4788,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
>   		goto out;
>   	}
>   
> -	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +	show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
>   	free_cpu_domain_info(cd_map, sv, nr);
>   out:
>   	free_schedstat(&cpu_head);

