Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0C18E056;
	Thu,  8 Aug 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132766; cv=none; b=fGbII4sUlH3xawVjObwfxdIMWlosxvw8Dbigpn8cip6ZkEOrF9hwfiFw7P4anuWHDQOY9wz//qOcwPiXsaNrNhpMe4RWFKjxad9luO2oFghKmnlOpOYBHf0UcvRP/IzotWxaUsd7xy88/YXWCMjBB/4YrP2Zh9fWmfIkwkvsx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132766; c=relaxed/simple;
	bh=MEvxcBvLjv3BSWvOm4fkXUoZALp5jBl627u9jxglorQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H+2Olb1LvIwIvPcSHrimyzKypc9xJ0FBT1oGqxyHx842z6YaN5MhuhJl4mfOo6lRBpX81xjAiwZ4C9uyyGULwg7HNpc44GN5uGIrj9Z1hLYYynO/2IXDkr6xm18P6JikTkSdbqxgdOW1uXB952Sie3F1VlbXnHJ58Qz78/JgRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+IS53tq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+IS53tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723132765; x=1754668765;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=MEvxcBvLjv3BSWvOm4fkXUoZALp5jBl627u9jxglorQ=;
  b=J+IS53tqwThMYeQ7o/xh06GGKABlqnkoSppOaPGxdXJnfoGJoASOfSIk
   r/Lxymu/jm5x1mClEuQyQ14ZKWvo0onSd1MA77/cDhQW5C7TCOf42WV9t
   0OXnfZODhDzjKPZgcozmU25B37wAUHTiE8A+sC/NVIjrpi9c71DGV+mPz
   1U080oFsYWOdtxYjzzWWzyQ6WDJdhrEokFnFb+jAlmQwceFmj1yOD4s9A
   uEInfQwX6pF+Y1ge+/v8CqgMd+KJWgGFu5v0rW9Q/tBUMZntMOzdltnIk
   OfaZvjEJ+n9bPxp4Y8Kb4oEawCEoxZp7u4zaTQD5/GiCN8X5o9d9PZVD1
   A==;
X-CSE-ConnectionGUID: XbnD4gB3TE68IwXY/jU3nQ==
X-CSE-MsgGUID: zVWstbgQSdCrvhbD+dOukw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20837740"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="20837740"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:59:24 -0700
X-CSE-ConnectionGUID: C3J5hc+SSBet162iCN9lDA==
X-CSE-MsgGUID: cuyZeT4sQxSSdUcerky64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57351337"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:59:23 -0700
Received: from [10.212.64.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.64.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id BB68920CFECD;
	Thu,  8 Aug 2024 08:59:21 -0700 (PDT)
Message-ID: <147d8178-70d6-42b8-b255-ee9e24774a61@linux.intel.com>
Date: Thu, 8 Aug 2024 11:59:20 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf callchain: Fix stitch LBR memory leaks
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Anne Macedo <retpolanne@posteo.net>, Changbin Du <changbin.du@huawei.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240808054644.1286065-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240808054644.1286065-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-08 1:46 a.m., Ian Rogers wrote:
> The callchain_cursor_node has a map_symbol whose maps and map
> variables are reference counted. Ensure these values use a _get
> routine to increment the refernece counts and use map_symbol__exit to
> release the reference counts. Do similar for thread's prev_lbr_cursor,
> but save the size of the prev_lbr_cursor array so that it may be
> iterated.
> 
> Ensure that when stitch_nodes are placed on the free list the
> map_symbols are exited. Fix resolve_lbr_callchain_sample by replacing
> list_replace_init to list_splice_init, so the whole list is moved and
> nodes aren't leaked.
> 
> A reproduction of the memory leaks is possible with a leak sanitizer
> build in the perf report command of:
> ```
> $ perf record -e cycles --call-graph lbr perf test -w thloop
> $ perf report --stitch-lbr
> ```
> 
> Fixes: ff165628d726 ("perf callchain: Stitch LBR call stack")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/machine.c | 17 +++++++++++++++--
>  tools/perf/util/thread.c  |  4 ++++
>  tools/perf/util/thread.h  |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8477edefc299..706be5e4a076 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2270,8 +2270,12 @@ static void save_lbr_cursor_node(struct thread *thread,
>  		cursor->curr = cursor->first;
>  	else
>  		cursor->curr = cursor->curr->next;
> +
> +	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
>  	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
>  	       sizeof(struct callchain_cursor_node));
> +	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
> +	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
>  
>  	lbr_stitch->prev_lbr_cursor[idx].valid = true;
>  	cursor->pos++;
> @@ -2482,6 +2486,9 @@ static bool has_stitched_lbr(struct thread *thread,
>  		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
>  		       sizeof(struct callchain_cursor_node));
>  
> +		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
> +		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
> +
>  		if (callee)
>  			list_add(&stitch_node->node, &lbr_stitch->lists);
>  		else
> @@ -2505,6 +2512,8 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
>  	if (!thread__lbr_stitch(thread)->prev_lbr_cursor)
>  		goto free_lbr_stitch;
>  
> +	thread__lbr_stitch(thread)->prev_lbr_cursor_size = max_lbr + 1;
> +
>  	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->lists);
>  	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->free_lists);
>  
> @@ -2560,8 +2569,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>  						max_lbr, callee);
>  
>  		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
> -			list_replace_init(&lbr_stitch->lists,
> -					  &lbr_stitch->free_lists);
> +			struct stitch_list *stitch_node;
> +
> +			list_for_each_entry(stitch_node, &lbr_stitch->lists, node)
> +				map_symbol__exit(&stitch_node->cursor.ms);
> +
> +			list_splice_init(&lbr_stitch->lists, &lbr_stitch->free_lists);
>  		}
>  		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
>  	}
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 87c59aa9fe38..0ffdd52d86d7 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -476,6 +476,7 @@ void thread__free_stitch_list(struct thread *thread)
>  		return;
>  
>  	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
> +		map_symbol__exit(&pos->cursor.ms);
>  		list_del_init(&pos->node);
>  		free(pos);
>  	}
> @@ -485,6 +486,9 @@ void thread__free_stitch_list(struct thread *thread)
>  		free(pos);
>  	}
>  
> +	for (unsigned int i = 0 ; i < lbr_stitch->prev_lbr_cursor_size; i++)
> +		map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
> +
>  	zfree(&lbr_stitch->prev_lbr_cursor);
>  	free(thread__lbr_stitch(thread));
>  	thread__set_lbr_stitch(thread, NULL);
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 8b4a3c69bad1..6cbf6eb2812e 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -26,6 +26,7 @@ struct lbr_stitch {
>  	struct list_head		free_lists;
>  	struct perf_sample		prev_sample;
>  	struct callchain_cursor_node	*prev_lbr_cursor;
> +	unsigned int prev_lbr_cursor_size;
>  };
>  
>  DECLARE_RC_STRUCT(thread) {
