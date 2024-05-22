Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0457A15C;
	Wed, 22 May 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373890; cv=none; b=gCYT9Ow07/Zgulquwx9hIPfIgv4shfq0SCDTk5D1wDx4WhNagdKFptmGgAeJc4I7L32fKSjJbMRh0LAJsZi+lo72RikwB+QqctT48vmXcHtNQyQlhDksT19VSHvbD8GATSYuhp2BliwUIU7/UoaC7yXOxQZ3pTsyv0zpZonCgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373890; c=relaxed/simple;
	bh=K8nGBpYmn5/Xkz9UAUlz7hw6W5DQdelisT+tUlEm9IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SQX2AZAHQ9lyNhUfQT3BTc/CchnkDL8QYw7I0Gy+az66m5UZ4xYJ5K35VBirAZVAaW2EACEBwDYxlTCWloeVvTHk/RzB38peLK2z3fQ1o/6GiMsJGrWV9ENLmUOoKzk+3DzPrBusC8zbbM6wZEqPI+W/IzoLCCMcaE4IUWsznPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQDXFwus; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQDXFwus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716373889; x=1747909889;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=K8nGBpYmn5/Xkz9UAUlz7hw6W5DQdelisT+tUlEm9IM=;
  b=LQDXFwuszdrL/rGdSDq7L5y/QnLuxm+oSK36sDCuGXJMs5QUdP9RH6TG
   wFxxkEtnzgbe0HuHM+gpSsHqRym1QHJ7zIOeC/9/iJQRus66qcW8FlR5M
   aZ2UCHxtuSW3tVf4JiHnhIoEZeaZ2I3B3mUPtGt6NG/MjLRWHyPTlRmnl
   s9fKzH0DyZywzKDnc8yGEf5wiSP6T4ywusBmIjpqK98Gje/8y+EnRJTU4
   +5PkyLYEOMrli4+byN9A2BDJ5CizL1k3iYBgUGvjJV7hnQkpl0EyFOUc+
   jROmz8RimKKbHu70QJYsxok6t76hbeYecjc+IyBo/tpmQOUzkzgyTsr4l
   A==;
X-CSE-ConnectionGUID: Ixuv09lCRW+PWMbbvw4LGA==
X-CSE-MsgGUID: 0tnJAq+ATVSJ7xXx/6J5qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="15563988"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="15563988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 03:31:28 -0700
X-CSE-ConnectionGUID: klKjfoyyRJiCxPBKgFuUtg==
X-CSE-MsgGUID: igCx5FxgTT6z+NreK37uhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33296921"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 03:31:25 -0700
Message-ID: <2f4fce9f-6283-40ad-8adc-c370e98627da@intel.com>
Date: Wed, 22 May 2024 13:31:19 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] perf maps: Sort kcore maps
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240520090647.949371-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/24 12:06, Leo Yan wrote:
> When merging kcore maps into the kernel maps, it has an implicit
> requirement for the kcore maps ordering, otherwise, some sections
> delivered by the kcore maps will be ignored.

perf treats the kernel text map as a special case.  The problem
is that the kcore loading logic did not cater for there being 2
maps that covered the kernel mapping.

The workaround was to choose the smaller mapping, but then that
still only worked if that was the first.

James essentially fixed that by ensuring the kernel "replacement"
map is inserted first.

In other respects, the ordering of the maps does not matter, so
I am not sure it is worth this extra processing.

> 
> Let's see below example:
> 
>   Ordering 1:
>   Kcore maps       | Start address      | End address
>   -----------------+--------------------+--------------------
>   kcore_text       | 0xffff800080000000 | 0xffff8000822f0000
>   vmalloc          | 0xffff800080000000 | 0xfffffdffbf800000
> 
>   Ordering 2:
>   Kcore maps       | Start address      | End address
>   -----------------+--------------------+--------------------
>   vmalloc          | 0xffff800080000000 | 0xfffffdffbf800000
>   kcore_text       | 0xffff800080000000 | 0xffff8000822f0000
> 
> The 'kcore_text' map is a subset of the 'vmalloc' map. When merging
> these two maps into the kernal maps with the maps__merge_in() function,
> the ordering 1 inserts the 'kcore_text' map prior to the 'vmalloc' map,
> thus the 'kcore_text' map will be respected. On the other hand, if maps
> are inserted with the ordering 2, the 'vmalloc' is inserted ahead, as a
> result, its subset map will be ignored afterwards.
> 
> To merge the maps in a reliable way, this commit sorts the kcore maps
> before merging them. Besides sorting the maps based on the end address,
> it also gives the priority to a subset map to insert it before its
> superset map in the list.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/symbol.c | 50 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..c1513976ab6e 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1256,6 +1256,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  {
>  	struct kcore_mapfn_data *md = data;
>  	struct map_list_node *list_node = map_list_node__new();
> +	struct map_list_node *node;
>  
>  	if (!list_node)
>  		return -ENOMEM;
> @@ -1269,8 +1270,55 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  	map__set_end(list_node->map, map__start(list_node->map) + len);
>  	map__set_pgoff(list_node->map, pgoff);
>  
> -	list_add(&list_node->node, &md->maps);
> +	list_for_each_entry(node, &md->maps, node) {
> +		/*
> +		 * When the new map (list_node)'s end address is less than
> +		 * current node, it can be divided into three cases.
> +		 *
> +		 * Case 1: the new map does not overlap with the current node,
> +		 * as the new map's end address is less than the current node's
> +		 * start address.
> +		 *                      [*******node********]
> +		 *    [***list_node***] `start              `end
> +		 *    `start          `end
> +		 *
> +		 * Case 2: the new map overlaps with the current node.
> +		 *
> +		 *        ,start              ,end
> +		 *        [*******node********]
> +		 *    [***list_node***]
> +		 *    `start          `end
> +		 *
> +		 * Case 3: the new map is subset of the current node.
> +		 *
> +		 *        ,start              ,end
> +		 *        [*******node********]
> +		 *         [***list_node***]
> +		 *         `start          `end
> +		 *
> +		 * For above three cases, insert the new map node before the
> +		 * current node.
> +		 */
> +		if (map__end(node->map) > map__end(list_node->map))
> +			break;
> +
> +		/*
> +		 * When the new map is subset of the current node and both nodes
> +		 * have the same end address, insert the new map node before the
> +		 * current node.
> +		 *
> +		 *        ,start              ,end
> +		 *        [*******node********]
> +		 *            [***list_node***]
> +		 *            `start          `end
> +		 */
> +		if ((map__end(node->map) == map__end(list_node->map)) &&
> +		    (map__start(node->map) <= map__start(list_node->map)))
> +			break;
> +	}
>  
> +	/* Insert the new node (list_node) ahead */
> +	list_add_tail(&list_node->node, &node->node);
>  	return 0;
>  }
>  

