Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A417E572;
	Wed, 22 May 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368294; cv=none; b=DjicNFmIsRrHnyUoOPAp/zsvePUpty+NJPs2aSnE+6EmCVWf0uyCy1uPGVv84A8z/vAIsVlhyXx1oG9jLEw3v1VIJO1Lya0aELq3YGiFKe/w6BDLXxZa7ifcij3qCvGJPnrrQ6Ee1WfupFyGJhDpzRBpLZOMo4vXUD37kktDT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368294; c=relaxed/simple;
	bh=X6iqZiLGEw+GNXUfJNsLcSk7n3NM00188BHJh+kM7Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rw5drkeKKTwGLKjaknh4UDFJ/eqxFYDpg7osS29Syg1Xdv3+4DmQL6UDIty72uJhwoTUPF7l+ZHKA61DgyiGUMVwMdKSiQm2K5IP4rfaPuswCq3nrEYW/grKw0PLg553Ah9s7lLW7DLJ0GimkIIB3R9+fi0bk26QandnHN8MdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRikXVWX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRikXVWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716368293; x=1747904293;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=X6iqZiLGEw+GNXUfJNsLcSk7n3NM00188BHJh+kM7Wo=;
  b=eRikXVWXCQsWfXhA60TA8pGzgCMleOV/GWD9K+eNNLpkGmNuBtreJJBC
   9qjZVmQdLnQfxGe1KqlzulONb+bVBPtZ3Cbhhctx/ntgeQVQU6IUbbcKG
   NoKzYhX+gvSYbXPC+jSKS8+vLIs5sGmuUkNQQd3xFto1BotMbjdJ0YX/5
   3J2+ynryP/2hgAuhF1Q9bq1xwJlhomJRq81PEpGYlRq0I4PwUwA/plzLk
   lACh5TFMV/cfF+Tk82Ipm1cC9wYGuKOLUvFO2fN+LCs33FQLn/BKlFcgw
   H++hrTEwkNSHSAiAYaO6FJYYXFpunva/otF9mfgBFx1xfczl+SKjg3Lr/
   A==;
X-CSE-ConnectionGUID: opBQX60oRKOcd4IDh/P6AA==
X-CSE-MsgGUID: lE//53GPTZu3idAa0cXxpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12389028"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12389028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:57:51 -0700
X-CSE-ConnectionGUID: Ad79jrqTQqaO+8N2E9x3pQ==
X-CSE-MsgGUID: Z7UQuLE1T7q7LjjHvB898Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37699452"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:57:47 -0700
Message-ID: <08b239b8-0d89-4602-bf2b-e785544ac2d7@intel.com>
Date: Wed, 22 May 2024 11:57:42 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] perf maps: Remove the replacement of kernel map
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-4-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240520090647.949371-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/24 12:06, Leo Yan wrote:
> The kernel text map has been removed from the kernel maps by
> maps__remove_maps(), and the kcore maps are organized in order, allowing
> us to achieve neat kernel maps.
> 
> As a result, it is not necessary to replace the old kernel text map.
> Instead, the commit finds the latest text map, assigns it to
> 'machine->vmlinux_map', and releases the old map.

There is also the parameter 'map' that the caller can continue
to use.  It was originally vmlinux_map which was checked:

	/* This function requires that the map is the kernel map */
	if (!__map__is_kernel(map))
		return -EINVAL;

Although that now looks broken and should probably be:

	/* This function requires that the map is the kernel map */
	if (map != machine__kernel_map(machine))
		return -EINVAL;

> 
> One concern is if a platform fails to find a kernel text map after
> updating maps list with kcore, in this case, it should not happen and
> reports the failure.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/symbol.c | 77 ++++++++++------------------------------
>  1 file changed, 19 insertions(+), 58 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 915435d55498..a4b65d868fc9 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1335,13 +1335,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  			   const char *kallsyms_filename)
>  {
>  	struct maps *kmaps = map__kmaps(map);
> +	struct map *vmlinux_map;
>  	struct kcore_mapfn_data md;
> -	struct map *map_ref, *replacement_map = NULL;
>  	struct machine *machine;
>  	bool is_64_bit;
>  	int err, fd;
>  	char kcore_filename[PATH_MAX];
> -	u64 stext;
>  
>  	if (!kmaps)
>  		return -EINVAL;
> @@ -1386,51 +1385,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	maps__remove_maps(kmaps, remove_old_maps);
>  	machine->trampolines_mapped = false;
>  
> -	/* Find the kernel map using the '_stext' symbol */
> -	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
> -		u64 replacement_size = 0;
> -		struct map_list_node *new_node;
> -
> -		list_for_each_entry(new_node, &md.maps, node) {
> -			struct map *new_map = new_node->map;
> -			u64 new_size = map__size(new_map);
> -
> -			if (!(stext >= map__start(new_map) && stext < map__end(new_map)))
> -				continue;
> -
> -			/*
> -			 * On some architectures, ARM64 for example, the kernel
> -			 * text can get allocated inside of the vmalloc segment.
> -			 * Select the smallest matching segment, in case stext
> -			 * falls within more than one in the list.
> -			 */
> -			if (!replacement_map || new_size < replacement_size) {
> -				replacement_map = new_map;
> -				replacement_size = new_size;
> -			}
> -		}
> -	}
> -
> -	if (!replacement_map)
> -		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
> -
> -	/*
> -	 * Update addresses of vmlinux map. Re-insert it to ensure maps are
> -	 * correctly ordered. Do this before using maps__merge_in() for the
> -	 * remaining maps so vmlinux gets split if necessary.
> -	 */
> -	map_ref = map__get(map);
> -
> -	map__set_start(map_ref, map__start(replacement_map));
> -	map__set_end(map_ref, map__end(replacement_map));
> -	map__set_pgoff(map_ref, map__pgoff(replacement_map));
> -	map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
> -
> -	err = maps__insert(kmaps, map_ref);
> -	map__put(map_ref);
> -	if (err)
> -		goto out_err;
> -
>  	/* Add new maps */
>  	while (!list_empty(&md.maps)) {
>  		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
> @@ -1438,21 +1392,28 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  
>  		list_del_init(&new_node->node);
>  
> -		/* skip if replacement_map, already inserted above */
> -		if (!RC_CHK_EQUAL(new_map, replacement_map)) {
> -			/*
> -			 * Merge kcore map into existing maps,
> -			 * and ensure that current maps (eBPF)
> -			 * stay intact.
> -			 */
> -			if (maps__merge_in(kmaps, new_map)) {
> -				err = -EINVAL;
> -				goto out_err;
> -			}
> +		/*
> +		 * Merge kcore map into existing maps,
> +		 * and ensure that current maps (eBPF)
> +		 * stay intact.
> +		 */
> +		if (maps__merge_in(kmaps, new_map)) {
> +			err = -EINVAL;
> +			goto out_err;
>  		}
>  		free(new_node);
>  	}
>  
> +	/* Update vmlinux_map */
> +	vmlinux_map = maps__find(kmaps, map__start(map));
> +	if (vmlinux_map) {
> +		free(machine->vmlinux_map);

Reference counting?

> +		machine->vmlinux_map = vmlinux_map;
> +	} else {
> +		pr_err("Failed to find vmlinux map from kcore\n");
> +		goto out_err;
> +	}
> +
>  	if (machine__is(machine, "x86_64")) {
>  		u64 addr;
>  

