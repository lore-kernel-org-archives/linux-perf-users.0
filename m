Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96321451982;
	Mon, 14 Sep 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388533; cv=none; b=T8tJ0CyoLy1dhyWEVf3DErnQb55dppMIID6vMLyXqZrmqMx0g1+t9OxuxzJfkliOcq6YSM274/mzKMbnKMgcwpwQfqS4GakQxfbYREPsalO5XH/bynm3KaF5QGLFGRvgN+TlcwsMUtpYG3No/QDg3WgP8kSk5j+eu8ezulqfQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388533; c=relaxed/simple;
	bh=1F8yY9IfgsAw7fwZv1pTkLriFGURz2R89iXVfn4xP+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB6/LWa8eyOxo6Yx99Pb0UjWwRJzNuxRRNuwTCkMqKcuXQCoZz6zpqK3ZxwIhq//UK77FC1X4OiEVtoLYRh7CT7V62ChQxuYeuvYIcAs2O9cDsV/y5BYqgHeS5MfkLDMG6LkzBmhPHgmvK1NMP4Fh92k+yBZXpVWy6VS6Xp3s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hk45c386wzKHMWL;
	Mon, 14 Sep 2026 20:21:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8664040561;
	Mon, 14 Sep 2026 20:22:07 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHyW3u5qdqovgSAQ--.55345S2;
	Mon, 14 Sep 2026 20:22:07 +0800 (CST)
Message-ID: <201cf528-d07c-4052-b0b0-11e5f9de97e4@huaweicloud.com>
Date: Mon, 14 Sep 2026 20:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] perf annotate-data: Convert type histogram to
 hashmap
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
 Yanbo Zhao <yzhao62@ncsu.edu>, Shuai Xue <xueshuai@linux.alibaba.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-2-namhyung@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260914064535.1671939-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHyW3u5qdqovgSAQ--.55345S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFykGr1fZF4rAryrtFykAFb_yoWxKw43pa
	17W34UJry5Xr4IgwnxtFWfXFyS9ws7XF15u34Ygw4FkF1avrn7Jr4vgry0kFZYkrn8Kr47
	tF4DtryUK39rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	0PfPUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/14 14:45, Namhyung Kim wrote:
> The type histogram maintains sample counts and periods per offset.  Use
> a hashmap instead of an array to reduce the memory overhead.
> 
> No functional changes intended.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate-data.c | 10 ++--
>  tools/perf/util/annotate-data.c        | 72 ++++++++++++++++----------
>  tools/perf/util/annotate-data.h        |  8 +--
>  3 files changed, 57 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index aa8c89fe2e82c1c5..c6e07a9b64089ab5 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -62,12 +62,16 @@ static int get_member_overhead(struct annotated_data_type *adt,
>  
>  		k = 0;
>  		for_each_group_evsel(evsel, leader) {
> +			struct type_hist_entry *hist;
> +
>  			if (symbol_conf.skip_empty &&
>  			    evsel__hists(evsel)->stats.nr_samples == 0)
>  				continue;
>  
> -			h = adt->histograms[evsel->core.idx];
> -			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
> +			h = &adt->histograms[evsel->core.idx];
> +			if (hashmap__find(&h->samples, offset, &hist))
> +				update_hist_entry(&entry->hists[k], hist);
> +			k++;
>  		}
>  	}
>  	return 0;
> @@ -416,7 +420,7 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
>  
>  	/* print the number */
>  	for_each_group_evsel(evsel, leader) {
> -		struct type_hist *h = adt->histograms[evsel->core.idx];
> +		struct type_hist *h = &adt->histograms[evsel->core.idx];
>  
>  		if (symbol_conf.skip_empty &&
>  		    evsel__hists(evsel)->stats.nr_samples == 0)
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 4e4c587640823c81..aff60a630fd05b01 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1750,42 +1750,45 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
>  	return dso__findnew_data_type(dso, &type_die);
>  }
>  
> +static size_t data_type_hash(long key, void *ctx __maybe_unused)
> +{
> +	return key;
> +}
> +
> +static bool data_type_equal(long key1, long key2, void *ctx __maybe_unused)
> +{
> +	return key1 == key2;
> +}
> +
>  static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_entries)
>  {
>  	int i;
> -	size_t sz = sizeof(struct type_hist);
>  
> -	sz += sizeof(struct type_hist_entry) * adt->self.size;
> -
> -	/* Allocate a table of pointers for each event */
> +	/* Allocate a histogram for each event */
>  	adt->histograms = calloc(nr_entries, sizeof(*adt->histograms));
>  	if (adt->histograms == NULL)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Each histogram is allocated for the whole size of the type.
> -	 * TODO: Probably we can move the histogram to members.
> -	 */
>  	for (i = 0; i < nr_entries; i++) {
> -		adt->histograms[i] = zalloc(sz);
> -		if (adt->histograms[i] == NULL)
> -			goto err;
> +		hashmap__init(&adt->histograms[i].samples, data_type_hash,
> +			      data_type_equal, /*ctx=*/NULL);
>  	}
>  
>  	adt->nr_histograms = nr_entries;
>  	return 0;
> -
> -err:
> -	while (--i >= 0)
> -		zfree(&(adt->histograms[i]));
> -	zfree(&adt->histograms);
> -	return -ENOMEM;
>  }
>  
>  static void delete_data_type_histograms(struct annotated_data_type *adt)
>  {
> -	for (int i = 0; i < adt->nr_histograms; i++)
> -		zfree(&(adt->histograms[i]));
> +	for (int i = 0; i < adt->nr_histograms; i++) {
> +		struct hashmap *map = &adt->histograms[i].samples;
> +		struct hashmap_entry *pos, *tmp;
> +		size_t bkt;
> +
> +		hashmap__for_each_entry_safe(map, pos, tmp, bkt)
> +			free(pos->pvalue);
> +		hashmap__clear(map);
> +	}
>  
>  	zfree(&adt->histograms);
>  	adt->nr_histograms = 0;
> @@ -1824,6 +1827,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
>  					int nr_samples, u64 period)
>  {
>  	struct type_hist *h;
> +	struct type_hist_entry *entry;
>  
>  	if (adt == NULL)
>  		return 0;
> @@ -1838,12 +1842,23 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
>  	if (offset < 0 || offset >= adt->self.size)
>  		return -1;
>  
> -	h = adt->histograms[evsel->core.idx];
> +	h = &adt->histograms[evsel->core.idx];
>  
>  	h->nr_samples += nr_samples;
> -	h->addr[offset].nr_samples += nr_samples;
>  	h->period += period;
> -	h->addr[offset].period += period;
> +
> +	if (!hashmap__find(&h->samples, offset, &entry)) {
> +		entry = zalloc(sizeof(*entry));
> +		if (entry == NULL)
> +			return -1;
> +
> +		if (hashmap__append(&h->samples, offset, entry) < 0) {
> +			free(entry);
> +			return -1;
> +		}
> +	}
> +	entry->nr_samples += nr_samples;
> +	entry->period += period;
>  	return 0;
>  }
>  
> @@ -1911,14 +1926,14 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
>  				      struct evsel *evsel, int indent)
>  {
>  	struct annotated_member *child;
> -	struct type_hist *h = mem_type->histograms[evsel->core.idx];
> +	struct type_hist *h;
>  	int i, nr_events = 0, samples = 0;
>  	u64 period = 0;
>  	int width = symbol_conf.show_total_period ? 11 : 7;
>  	struct evsel *pos;
>  
>  	for_each_group_evsel(pos, evsel) {
> -		h = mem_type->histograms[pos->core.idx];
> +		h = &mem_type->histograms[pos->core.idx];
>  
>  		if (symbol_conf.skip_empty &&
>  		    evsel__hists(pos)->stats.nr_samples == 0)
> @@ -1927,8 +1942,13 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
>  		samples = 0;
>  		period = 0;
>  		for (i = 0; i < member->size; i++) {
> -			samples += h->addr[member->offset + i].nr_samples;
> -			period += h->addr[member->offset + i].period;
> +			struct type_hist_entry *entry;
> +
> +			if (!hashmap__find(&h->samples, member->offset + i, &entry))
> +				continue;
> +
> +			samples += entry->nr_samples;
> +			period += entry->period;
>  		}
>  		print_annotated_data_value(h, period, samples);
>  		nr_events++;
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index c26130744260955f..ca2096a9ee62cbfe 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -73,12 +73,12 @@ struct type_hist_entry {
>   * struct type_hist - Type histogram for each event
>   * @nr_samples: Total number of samples in this data type
>   * @period: Total count of the event in this data type
> - * @offset: Array of histogram entry
> + * @samples: Hashmap of (offset, type_hist_entry)
>   */
>  struct type_hist {
>  	u64			nr_samples;
>  	u64			period;
> -	struct type_hist_entry	addr[];
> +	struct hashmap		samples;
>  };
>  
>  /**
> @@ -86,7 +86,7 @@ struct type_hist {
>   * @node: RB-tree node for dso->type_tree
>   * @self: Actual type information
>   * @nr_histogram: Number of histogram entries
> - * @histograms: An array of pointers to histograms
> + * @histograms: An array of histograms
>   *
>   * This represents a data type accessed by samples in the profile data.
>   */
> @@ -94,7 +94,7 @@ struct annotated_data_type {
>  	struct rb_node node;
>  	struct annotated_member self;
>  	int nr_histograms;
> -	struct type_hist **histograms;
> +	struct type_hist *histograms;
>  };
>  
>  extern struct annotated_data_type unknown_type;

Reviewed-by: Tengda Wu <wutengda@huaweicloud.com>

Thanks,
Tengda

