Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C56824AF;
	Wed, 22 May 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377277; cv=none; b=qB7LV2ZALPFdHv/hTVdkHTkr+XClSYXDYa17k0DcY+ybxKo8nHHsu6MnKKVcwyHlWhmamMXA39EnTXdg9B6WJcZXXikqhPhnmywvro7p4Qk0r56NqiFqlZRdKj2GL+mwhAdMIgURcNxQ6UW2f+22ZtiwQHPbPd21asgic5A4WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377277; c=relaxed/simple;
	bh=XVkbth8lj3MXtZAYK/gPt/sMHggpj26IMReKmcdvLtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ESBRRcTd7HPPz/47UaAv9tXuTI85WvvscF+rCkGU46jLwS60M/QOjuzsUPbqgkg190YPceRAMDrBDbQDQAxSfkjxS0UdQaax4xPaK9c1Phv+cMglQhslmsuqVdDsMtMvN///xzOThS6+Hn48nJiw5hIu6agYhZLVqtFuSPlbVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM4jHVE3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM4jHVE3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716377275; x=1747913275;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XVkbth8lj3MXtZAYK/gPt/sMHggpj26IMReKmcdvLtM=;
  b=ZM4jHVE3wpfLZuwejD/nriisbqEmoTWSq1fr0P62HsjZh973OoAjP6g0
   0K5B+JNM14ysk+p92Swy7oqX4K/EycTJnaneviigYSIZMeaYpLjK4RHGw
   rp+Om+yLIjDckQsBbeTOf6uBCttA9zo7cnN8zAcIyA/BzjmwHNcgTXLWB
   OShAC8CZvhycwMUVAZg5+3QhlStJiRmY/KmXCMamGGRdW3rw5r4B7cNSt
   9Mtew4vTpvpF8dwHIbxRU0r0P2sIfgJwcXuei/IADxYJdfkbbmz/lzNtZ
   8btwSPfD7Cl1+7gyahheBFvJbazqpeSoM/v66E774X9YOvAR8X8Xu/3Lg
   Q==;
X-CSE-ConnectionGUID: 1QzzKPR1TU68d1+AGqvF5Q==
X-CSE-MsgGUID: TGb2kuduTjuSjb17Yibr5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12494460"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12494460"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:27:54 -0700
X-CSE-ConnectionGUID: HWw8LQtqSySf4hkNs4jB/w==
X-CSE-MsgGUID: 6Pbqhv/wS8O0DboTImI+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33253526"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 04:27:51 -0700
Message-ID: <8e5ab323-f893-4186-813b-e87394e0a9fd@intel.com>
Date: Wed, 22 May 2024 14:27:46 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] perf maps: Remove the kernel text map with
 maps__remove_maps()
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-3-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240520090647.949371-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/24 12:06, Leo Yan wrote:
> maps__remove_maps() removes all kernel maps except the text map and eBPF
> maps. Afterwards, the kernel text map is removed from the list and
> added again with updated information to the maps list.
> 
> This commit refactors maps__remove_maps() for deleting the 'map'
> parameter, resulting in the removal of all kernel maps from the list.
> Thus, the dso__load_kcore() function no longer needs to remove the kernel
> text map.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/maps.c   | 4 ++--
>  tools/perf/util/maps.h   | 2 +-
>  tools/perf/util/symbol.c | 9 +++------
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 16b39db594f4..4ddd0d50ac2c 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -589,7 +589,7 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
>  	return ret;
>  }
>  
> -void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
> +void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map))
>  {
>  	struct map **maps_by_address;
>  
> @@ -597,7 +597,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
>  
>  	maps_by_address = maps__maps_by_address(maps);
>  	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
> -		if (cb(maps_by_address[i], data))
> +		if (cb(maps_by_address[i]))
>  			__maps__remove(maps, maps_by_address[i]);
>  		else
>  			i++;
> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> index d9aa62ed968a..90a1ff8b39c5 100644
> --- a/tools/perf/util/maps.h
> +++ b/tools/perf/util/maps.h
> @@ -40,7 +40,7 @@ bool maps__equal(struct maps *a, struct maps *b);
>  /* Iterate over map calling cb for each entry. */
>  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
>  /* Iterate over map removing an entry if cb returns true. */
> -void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
> +void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map));
>  
>  struct machine *maps__machine(const struct maps *maps);
>  unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index c1513976ab6e..915435d55498 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1322,15 +1322,13 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  	return 0;
>  }
>  
> -static bool remove_old_maps(struct map *map, void *data)
> +static bool remove_old_maps(struct map *map)
>  {
> -	const struct map *map_to_save = data;
> -
>  	/*
>  	 * We need to preserve eBPF maps even if they are covered by kcore,
>  	 * because we need to access eBPF dso for source data.
>  	 */
> -	return !RC_CHK_EQUAL(map, map_to_save) && !__map__is_bpf_prog(map);
> +	return !__map__is_bpf_prog(map);
>  }
>  
>  static int dso__load_kcore(struct dso *dso, struct map *map,
> @@ -1385,7 +1383,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	}
>  
>  	/* Remove old maps */
> -	maps__remove_maps(kmaps, remove_old_maps, map);
> +	maps__remove_maps(kmaps, remove_old_maps);
>  	machine->trampolines_mapped = false;
>  
>  	/* Find the kernel map using the '_stext' symbol */
> @@ -1422,7 +1420,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	 * remaining maps so vmlinux gets split if necessary.
>  	 */
>  	map_ref = map__get(map);

If the ref is needed, then it should be taken before
the call to maps__remove_maps().

> -	maps__remove(kmaps, map_ref);
>  
>  	map__set_start(map_ref, map__start(replacement_map));
>  	map__set_end(map_ref, map__end(replacement_map));

