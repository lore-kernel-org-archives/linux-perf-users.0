Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03617BCD;
	Wed,  8 May 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149109; cv=none; b=D0mjK1LQUMAuqqsLQCEM7Ou0df1QiS+5JYZz3/KjVO/QuyY3NKKG9xpMqZx2jeR2V/hm3NRgkjg2YbCbYDKcqMZvJsyeirneH2ATy7O6YtXPnAWfDux2aItQaqydgX//HWxtcNQTl9aWZabLnHlT4Qw3dkNBud4cItpAltD0F9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149109; c=relaxed/simple;
	bh=0O6Jrn0zRwiPdIfa506NPSja/s9+WipuhrUjnzn9X7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rqb/rQ/SIhAhijBhUZL0rGnAdKvDXXOYvRvSI0XdHyPemCpSDz9pqGt4jKbEVN8g8Q7nnhsIkG/fK2SG/1muUjDBELQpG//ShSX+ROd9JG9dH1GiYxBir37actz8FCrEA1gPnC+MzInRgScWUZiY3Anvu+MaFGRzikrgamTNQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3GOTw/w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3GOTw/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715149108; x=1746685108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0O6Jrn0zRwiPdIfa506NPSja/s9+WipuhrUjnzn9X7U=;
  b=W3GOTw/wPtHTZnYqU5k/VfW0LlQBmxW1L94ioX0ScRXpZruXPEJSys+Q
   0/Rn1sTsm3sU0omTnM65Kdux5VOhKuX+086oHGGXk56oSKqTJRByduIxy
   zm8tRtt4ZaVVLMuSiGQ6aLcZh+X3oWrlBGr4CJqLWIAaPaoo+9gVQ7avN
   UZdHc7gMjzTHODBnG1WGEp1TPYu54iGirv8/6EDKWyKKZ/4r/GMfFB27H
   0yjHoyrnmq5qtajrMi30s6ydN+2QyXN5ALOy2yd2sI/DISm7IimHnJVEp
   YmJ3gaNpsG50qL/3LVt4hVlbfyA0phN9dOIwsXdmXF3a74KzLc1So9HSe
   g==;
X-CSE-ConnectionGUID: X/cjYjISSbmuu0TUd4sfkg==
X-CSE-MsgGUID: p429NptsRp6QTW5eI6Wj9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28461835"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28461835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:18:28 -0700
X-CSE-ConnectionGUID: E9t8kbvsQwmGPQUlSiKaTQ==
X-CSE-MsgGUID: 3PQphuNHRkah0PM0Tnj4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33295539"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.189])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:18:22 -0700
Message-ID: <479cfef5-daa8-4650-85c7-4a5764885562@intel.com>
Date: Wed, 8 May 2024 09:18:18 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf maps: Process kcore maps in order
To: Leo Yan <leo.yan@linux.dev>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240505202805.583253-1-leo.yan@arm.com>
 <d47346fc-51b4-4af5-a014-0bd6f3b7bae0@intel.com>
 <20240507210151.GB1384@debian-dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240507210151.GB1384@debian-dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/05/24 00:01, Leo Yan wrote:
> Hi Adrian,
> 
> On Mon, May 06, 2024 at 08:43:01AM +0300, Adrian Hunter wrote:
> 
> [...]
> 
>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>> index 9ebdb8e13c0b..e15d70845488 100644
>>> --- a/tools/perf/util/symbol.c
>>> +++ b/tools/perf/util/symbol.c
>>> @@ -1266,7 +1266,24 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>>>  	map__set_end(list_node->map, map__start(list_node->map) + len);
>>>  	map__set_pgoff(list_node->map, pgoff);
>>>  
>>> -	list_add(&list_node->node, &md->maps);
>>> +	/*
>>> +	 * Kcore maps are ordered with:
>>> +	 *   [_text.._end): Kernel text section
>>> +	 *   [VMALLOC_START..VMALLOC_END): vmalloc
>>> +	 *   ...
>>> +	 *
>>> +	 * On Arm64, the '_text' and 'VMALLOC_START' are the same values
>>> +	 * but VMALLOC_END (~124TiB) is much bigger then the text end
>>> +	 * address. So '_text' region is the subset of the vmalloc region.
>>> +	 *
>>> +	 * Afterwards, when dso__load_kcore() adjusts kernel maps, we must
>>> +	 * process the kernel text size prior to handling vmalloc region.
>>> +	 * This can avoid to using any inaccurate kernel text size when
>>> +	 * extending maps with vmalloc region. For this reason, here it
>>> +	 * always adds kcore maps to the tail of list to make sure the
>>> +	 * sequential handling is in order.
>>> +	 */
>>> +	list_add_tail(&list_node->node, &md->maps);
>>
>> This seems reasonable, but I wonder if it might be robust
>> and future proof to also process the main map first
>> e.g. totally untested:
> 
> Makes sense for me, I verified your proposal with a minor improvment,
> please see the comment below.
> 
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 9ebdb8e13c0b..63bce45a5abb 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1365,16 +1365,15 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>  	if (!replacement_map)
>>  		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
>>  
>> -	/* Add new maps */
>> +	/* Add replacement_map */
>>  	while (!list_empty(&md.maps)) {
> 
> For the replacement map, as we have located it in the list, here we
> don't need to iterate the whole kcore map list anymore. We can
> directly use the replacement map to update the passed map:
> 
>         /* Update replacement_map */
>         if (replacement_map) {
>                 struct map *map_ref;
> 
>                 list_del_init(&replacement_node->node);
>                 map__set_start(map, map__start(replacement_map));
>                 map__set_end(map, map__end(replacement_map));
>                 map__set_pgoff(map, map__pgoff(replacement_map));
>                 map__set_mapping_type(map, map__mapping_type(replacement_map));
>                 /* Ensure maps are correctly ordered */
>                 map_ref = map__get(map);
>                 maps__remove(kmaps, map_ref);
>                 err = maps__insert(kmaps, map_ref);
>                 map__put(map_ref);
>                 map__put(replacement_map);
>                 if (err)
>                         goto out_err;
>                 free(replacement_node);
>         }
> 
> I also uploaded the verified change to https://termbin.com/rrfo.
> 
> Please let me know if you would like to send a patch for this, or you
> want me to spin a new version. Either is fine for me.

James has a patch that does this also and looks good:

https://lore.kernel.org/linux-perf-users/CAM9d7cjYvMndUmSuwnE1ETwnu_6WrxQ4UzsNHHvo4SVR250L7A@mail.gmail.com/T/#md3d61e4182fc5bc3aee917db9af23a39b617b8ea

However, the "list_add_tail" change still seems worth doing
because it is more logical to process in order rather than
reverse order.  Probably just need to adjust the comment and
commit message.

