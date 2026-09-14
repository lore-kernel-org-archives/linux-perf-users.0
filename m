Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C345199D;
	Mon, 14 Sep 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388393; cv=none; b=h9Goe3ceZ77sQ6Crr+nwtoVPOCP0XJE33ttxe2R4eAQ9pl+14xbDySBlUd0kYqmqbvcFVHRkryYvunZIqVtibILXWm0U15bKIDBj4HkmeWxoGsDb6IL12Qq2sCeS+L+NtC/Vc87Zmh1pKuJ4k/vEwwKXOm/AvCdpSSOXTO+eSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388393; c=relaxed/simple;
	bh=/U6KD0enoKQckIFLUwCMR7gDeSo6RPNYTNqxxabx5kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsoQ6w1HtFxOCQcEufZpQZWM5J7Hsxr1iEk0rsd85TmeiPvjOi7lVs15QKRBF8vPl3V/8/MXSpFSSJCSsUzZbqHhaoEgoU02CSQIZtOdCoa7p48aGYGKG3YhmTPpYmDfiz3bwqxO6nAv0qS8wjzNQZiNmiNl2w+MkPso4Cp1Jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hk42t1vvczKHMTB;
	Mon, 14 Sep 2026 20:19:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5D12140561;
	Mon, 14 Sep 2026 20:19:45 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAXjvhg5qdqpBMTAQ--.37191S2;
	Mon, 14 Sep 2026 20:19:45 +0800 (CST)
Message-ID: <5d51668c-3646-402f-83b4-7f6ee4a415e7@huaweicloud.com>
Date: Mon, 14 Sep 2026 20:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
 Yanbo Zhao <yzhao62@ncsu.edu>, Shuai Xue <xueshuai@linux.alibaba.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-4-namhyung@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260914064535.1671939-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXjvhg5qdqpBMTAQ--.37191S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFykZw1xGrW5Kr45Zw43Wrg_yoW7KFyxpa
	1DGF1UJrW3Gr42grnaqFZ8Xa4ruw4xX348C3s09a4vyFy3Xr1rGr1UK34F9ayrJr9Yyw4r
	KwsxJr4UWwsrX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/14 14:45, Namhyung Kim wrote:
> Structs that have a flex array will have accesses beyond its original
> size as the array was declared as 0 sized.  For now, it just allow any
> offset bigger than the size.  It could be refined later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 63 ++++++++++++++++++---------------
>  tools/perf/util/annotate-data.h |  2 ++
>  2 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index aff60a630fd05b01..e8aff6a916c0afe0 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -7,6 +7,7 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <inttypes.h>
>  #include <linux/zalloc.h>
>  
> @@ -248,8 +249,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	else
>  		die_mem = member_type;
>  
> -	if (dwarf_aggregate_size(&die_mem, &size) < 0)
> -		size = 0;
> +	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
> +		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
> +			die_get_real_type(&die_mem, &die_mem);
> +			if (dwarf_aggregate_size(&die_mem, &size) < 0)
> +				size = 0;
> +		} else {
> +			size = 0;
> +		}
> +	}
>  
>  	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
>  		if (dwarf_formudata(&attr, &loc) != 0) {
> @@ -399,6 +407,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
>  	result->self.type_name = type_name;
>  	result->self.size = size;
>  	INIT_LIST_HEAD(&result->self.children);
> +	result->flex_array = die_has_flex_array(type_die);
>  
>  	if (symbol_conf.annotate_data_member)
>  		add_member_types(result, type_die);
> @@ -517,13 +526,30 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
>  	return false;
>  }
>  
> +static enum type_match_result check_type_offset(Dwarf_Die *type_die, int offset)
> +{
> +	Dwarf_Word size;
> +
> +	/* Get the size of the actual type */
> +	if (dwarf_aggregate_size(type_die, &size) < 0)
> +		return PERF_TMR_NO_SIZE;
> +
> +	/* Minimal sanity check */
> +	if (offset < 0)
> +		return PERF_TMR_BAD_OFFSET;
> +
> +	if ((unsigned)offset >= size && !die_has_flex_array(type_die))
> +		return PERF_TMR_BAD_OFFSET;
> +
> +	return PERF_TMR_OK;
> +}
> +
>  /* The type info will be saved in @type_die */
>  static enum type_match_result check_variable(struct data_loc_info *dloc,
>  					     Dwarf_Die *var_die,
>  					     Dwarf_Die *type_die, int reg,
>  					     int offset, bool is_fbreg)
>  {
> -	Dwarf_Word size;
>  	bool needs_pointer = true;
>  	Dwarf_Die sized_type;
>  
> @@ -554,15 +580,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
>  	else
>  		sized_type = *type_die;
>  
> -	/* Get the size of the actual type */
> -	if (dwarf_aggregate_size(&sized_type, &size) < 0)
> -		return PERF_TMR_NO_SIZE;
> -
> -	/* Minimal sanity check */
> -	if ((unsigned)offset >= size)
> -		return PERF_TMR_BAD_OFFSET;
> -
> -	return PERF_TMR_OK;
> +	return check_type_offset(type_die, offset);
>  }
>  
>  struct type_state_stack *find_stack_state(struct type_state *state,
> @@ -1112,7 +1130,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  						  struct disasm_line *dl,
>  						  Dwarf_Die *type_die)
>  {
> -	Dwarf_Word size;
>  	u32 insn_offset = dl->al.offset;
>  	int reg = dloc->op->reg1;
>  	int offset = dloc->op->offset;
> @@ -1166,12 +1183,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		else
>  			sized_type = *type_die;
>  
> -		/* Get the size of the actual type */
> -		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
> -		    (unsigned)dloc->type_offset >= size)
> -			return PERF_TMR_BAD_OFFSET;
> -
> -		return PERF_TMR_OK;
> +		return check_type_offset(&sized_type, dloc->type_offset);
>  	}
>  
>  	if (state->regs[reg].kind == TSR_KIND_POINTER) {
> @@ -1190,12 +1202,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  
>  		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
>  
> -		/* Get the size of the actual type */
> -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> -		    (unsigned)dloc->type_offset >= size)
> -			return PERF_TMR_BAD_OFFSET;
> -
> -		return PERF_TMR_OK;
> +		return check_type_offset(type_die, dloc->type_offset);
>  	}
>  
>  	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
> @@ -1209,9 +1216,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  
>  		dloc->type_offset = dloc->op->offset;
>  
> -		/* Get the size of the actual type */
> -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> -		    (unsigned)dloc->type_offset >= size)
> +		if (check_type_offset(type_die, dloc->type_offset) != PERF_TMR_OK)
>  			return PERF_TMR_BAIL_OUT;
>  
>  		return PERF_TMR_OK;
> @@ -1839,7 +1844,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
>  			return -1;
>  	}
>  
> -	if (offset < 0 || offset >= adt->self.size)
> +	if (offset < 0 || (offset >= adt->self.size && !adt->flex_array))
>  		return -1;
>  
>  	h = &adt->histograms[evsel->core.idx];
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index ca2096a9ee62cbfe..27b7148b64f60350 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -85,6 +85,7 @@ struct type_hist {
>   * struct annotated_data_type - Data type to profile
>   * @node: RB-tree node for dso->type_tree
>   * @self: Actual type information
> + * @flex_array: Whethere it has a flex array

Nit: typo in the comment -- Whethere should be Whether.

Thanks,
Tengda

>   * @nr_histogram: Number of histogram entries
>   * @histograms: An array of histograms
>   *
> @@ -93,6 +94,7 @@ struct type_hist {
>  struct annotated_data_type {
>  	struct rb_node node;
>  	struct annotated_member self;
> +	bool flex_array;
>  	int nr_histograms;
>  	struct type_hist *histograms;
>  };

