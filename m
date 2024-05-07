Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AF58AB8
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115717; cv=none; b=A2jWYGW0aNPUMqYnBk+t2XgZrZSZHUadpHV2KaiXiKFOKHXKt9Xi/zhqTWLue2RRFUEQnQThcAm4d6Nh75o2GKYQsdpSMGw4AFGj5GzPCR0EebQ5Gc4/gEBllN4mVsTZv9/QdlalwebrRKR9upwddBkrs3fNZsfSozxd3RlNRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115717; c=relaxed/simple;
	bh=JiWno9R6/bTX27Lyw4lnPCe5j/IzJx7mLRUg0SFwwzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXeTWJe1kQ0QOJYIsBaLwxuRckM3bApQQM/zvUEt/VgxmZ5ZmbyFD5KGO58d6G/gTwVFDuBRdvinnBjeThNQQcCSdHArL4WiV1RbeqkpwflB11xAoHfPSokZn93q1DYPI4/7uIaAO/w9O509NaD71Ea11aU9euQxfTevR9T6osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQxPkjUH; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQxPkjUH"
Date: Wed, 8 May 2024 05:01:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715115714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZNs4tA7go3R/DMVxte1WF4G+JtqmyTgtWCsoCAO8/U=;
	b=LQxPkjUHpSk5OiqLAHPQlApMHIdCDDWwHwWi5rhrQDv8xB+Zra1Sex3T5nBDL+Jlo5OC2f
	UKTBXWUxiNGEY7cWSa+q1Uw1ZVV4yMiuXfMCUKT+E7eoJcRkl6AS+Rhe37TPYH/fbTdq6U
	BDBhov3gOiz0f6H3vaLu2x9nDJyuWm8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf maps: Process kcore maps in order
Message-ID: <20240507210151.GB1384@debian-dev>
References: <20240505202805.583253-1-leo.yan@arm.com>
 <d47346fc-51b4-4af5-a014-0bd6f3b7bae0@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47346fc-51b4-4af5-a014-0bd6f3b7bae0@intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Adrian,

On Mon, May 06, 2024 at 08:43:01AM +0300, Adrian Hunter wrote:

[...]

> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 9ebdb8e13c0b..e15d70845488 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1266,7 +1266,24 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
> >  	map__set_end(list_node->map, map__start(list_node->map) + len);
> >  	map__set_pgoff(list_node->map, pgoff);
> >  
> > -	list_add(&list_node->node, &md->maps);
> > +	/*
> > +	 * Kcore maps are ordered with:
> > +	 *   [_text.._end): Kernel text section
> > +	 *   [VMALLOC_START..VMALLOC_END): vmalloc
> > +	 *   ...
> > +	 *
> > +	 * On Arm64, the '_text' and 'VMALLOC_START' are the same values
> > +	 * but VMALLOC_END (~124TiB) is much bigger then the text end
> > +	 * address. So '_text' region is the subset of the vmalloc region.
> > +	 *
> > +	 * Afterwards, when dso__load_kcore() adjusts kernel maps, we must
> > +	 * process the kernel text size prior to handling vmalloc region.
> > +	 * This can avoid to using any inaccurate kernel text size when
> > +	 * extending maps with vmalloc region. For this reason, here it
> > +	 * always adds kcore maps to the tail of list to make sure the
> > +	 * sequential handling is in order.
> > +	 */
> > +	list_add_tail(&list_node->node, &md->maps);
> 
> This seems reasonable, but I wonder if it might be robust
> and future proof to also process the main map first
> e.g. totally untested:

Makes sense for me, I verified your proposal with a minor improvment,
please see the comment below.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9ebdb8e13c0b..63bce45a5abb 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1365,16 +1365,15 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	if (!replacement_map)
>  		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
>  
> -	/* Add new maps */
> +	/* Add replacement_map */
>  	while (!list_empty(&md.maps)) {

For the replacement map, as we have located it in the list, here we
don't need to iterate the whole kcore map list anymore. We can
directly use the replacement map to update the passed map:

        /* Update replacement_map */
        if (replacement_map) {
                struct map *map_ref;

                list_del_init(&replacement_node->node);
                map__set_start(map, map__start(replacement_map));
                map__set_end(map, map__end(replacement_map));
                map__set_pgoff(map, map__pgoff(replacement_map));
                map__set_mapping_type(map, map__mapping_type(replacement_map));
                /* Ensure maps are correctly ordered */
                map_ref = map__get(map);
                maps__remove(kmaps, map_ref);
                err = maps__insert(kmaps, map_ref);
                map__put(map_ref);
                map__put(replacement_map);
                if (err)
                        goto out_err;
                free(replacement_node);
        }

I also uploaded the verified change to https://termbin.com/rrfo.

Please let me know if you would like to send a patch for this, or you
want me to spin a new version. Either is fine for me.

Thanks for review and suggestion!
Leo

>  		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
>  		struct map *new_map = new_node->map;
>  
> -		list_del_init(&new_node->node);
> -
>  		if (RC_CHK_EQUAL(new_map, replacement_map)) {
>  			struct map *map_ref;
>  
> +			list_del_init(&new_node->node);
>  			map__set_start(map, map__start(new_map));
>  			map__set_end(map, map__end(new_map));
>  			map__set_pgoff(map, map__pgoff(new_map));
> @@ -1385,20 +1384,29 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  			err = maps__insert(kmaps, map_ref);
>  			map__put(map_ref);
>  			map__put(new_map);
> +			free(new_node);
>  			if (err)
>  				goto out_err;
> -		} else {
> -			/*
> -			 * Merge kcore map into existing maps,
> -			 * and ensure that current maps (eBPF)
> -			 * stay intact.
> -			 */
> -			if (maps__merge_in(kmaps, new_map)) {
> -				err = -EINVAL;
> -				goto out_err;
> -			}
>  		}
> +	}
> +
> +	/* Add new maps */
> +	while (!list_empty(&md.maps)) {
> +		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
> +		struct map *new_map = new_node->map;
> +
> +		list_del_init(&new_node->node);
> +
> +		/*
> +		 * Merge kcore map into existing maps,
> +		 * and ensure that current maps (eBPF)
> +		 * stay intact.
> +		 */
> +		if (maps__merge_in(kmaps, new_map))
> +			err = -EINVAL;
>  		free(new_node);
> +		if (err)
> +			goto out_err;
>  	}
>  
>  	if (machine__is(machine, "x86_64")) {
> 
> 
> 
