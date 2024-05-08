Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CE53389;
	Wed,  8 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178007; cv=none; b=psiKO90iuF3kYmzTPbud6IfBPdhIv8XNDPF03aJoaUMTxr39tqBYVwSLs8SOqcIyqyNrxj4mCjGSwbD/R2HSlA/6t3aDI11Ka/WKRORL575qM6h52WpB2BZlQh/i8WT0AnrqtLjD0AzVsnnlkYLiEHb1Sy+zD/tPkO1O3lUR4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178007; c=relaxed/simple;
	bh=MywWnECT1IA57bzYsC62zZaCOfyYL9X9TzJpNmQ9Mkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPqkejLz+H6/17So+kVvp+WDo0nxgWhFlEGpt+jS3OS68sdRUOhSWE8RGG5QkzUi9eZdBg3zirbEIuXSYyXI+ZSnZj8/0SGLVXG5KCM9LnJo7GfiYKS+TjOpPQIANluJSnK14q/MY21EGKMfeiVDdH8bkxuYkciYVyY715l6nYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 054B51007;
	Wed,  8 May 2024 07:20:31 -0700 (PDT)
Received: from [10.1.30.37] (PF4Q20KV.arm.com [10.1.30.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB5013F905;
	Wed,  8 May 2024 07:20:03 -0700 (PDT)
Message-ID: <0ab3a37a-f569-471f-b6a8-6e35959f568d@arm.com>
Date: Wed, 8 May 2024 15:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf symbols: Update kcore map before merging in
 remaining symbols
To: James Clark <james.clark@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
 irogers@google.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20240507141210.195939-1-james.clark@arm.com>
 <20240507141210.195939-4-james.clark@arm.com>
 <CAM9d7cjYvMndUmSuwnE1ETwnu_6WrxQ4UzsNHHvo4SVR250L7A@mail.gmail.com>
 <16116798-52d6-4004-8514-9b81c789474f@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <16116798-52d6-4004-8514-9b81c789474f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/2024 10:14 AM, James Clark wrote:

[...]

>> Looks like you and Leo are working on the same problem.
>>
>> https://lore.kernel.org/r/20240505202805.583253-1-leo.yan@arm.com/
>>
> 
> Oops I should have checked the list. It looks like we can still take his
> fix as well though, with an updated comment.

Sorry for duplicate work. I will resend my patch separately with refined
comment, as suggested by Adrian.

[...]

>>> @@ -1289,7 +1289,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>>  {
>>>         struct maps *kmaps = map__kmaps(map);
>>>         struct kcore_mapfn_data md;
>>> -       struct map *replacement_map = NULL;
>>> +       struct map *map_ref, *replacement_map = NULL;
>>>         struct machine *machine;
>>>         bool is_64_bit;
>>>         int err, fd;
>>> @@ -1367,6 +1367,24 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>>         if (!replacement_map)
>>>                 replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;

As the 'replacement' map is mainly used to adjust the kernel's sections
between '_stext' and '_end', some arches might don't share the same issue with
Arm64.  So it is a bit redundant for assignment 'replacement_map' if it is
NULL, we can consider to remove the above two lines.

>>>
>>> +       /*
>>> +        * Update addresses of vmlinux map. Re-insert it to ensure maps are
>>> +        * correctly ordered. Do this before using maps__merge_in() for the
>>> +        * remaining maps so vmlinux gets split if necessary.
>>> +        */
>>> +       map_ref = map__get(map);
>>> +       maps__remove(kmaps, map_ref);
>>
>> A nitpick.  It'd be natural to use 'map' instead of 'map_ref'
>> (even if they are the same) since IIUC we want to remove
>> the old 'map' and update 'map_ref' then add it back.
>>
> 
> Using map makes sense, I can update that.
> 
>>> +
>>> +       map__set_start(map_ref, map__start(replacement_map));
>>> +       map__set_end(map_ref, map__end(replacement_map));
>>> +       map__set_pgoff(map_ref, map__pgoff(replacement_map));
>>> +       map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
>>
>> So here, replacement_map should not be NULL right?
>>
> 
> Yes it shouldn't be. It would only be NULL if md.maps is empty, but
> there's already an exit condition for that above.
> 
> Some of the other code also assumes node->map is always set, so it can't
> be NULL that way either.

Thus, we can consider to check condition for 'replacement' map is NULL or not.

    if (replacement_map) {
	list_del_init(&new_node->node);

	map_ref = map__get(map);
	maps__remove(kmaps, map_ref);
	...
	map__put(new_map);
	if (err)
		goto out_err;
	free(new_node);
    }

[...]

>>> @@ -1374,24 +1392,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>>
>>>                 list_del_init(&new_node->node);
>>>
>>> -               if (RC_CHK_EQUAL(new_map, replacement_map)) {
>>> -                       struct map *map_ref;
>>> -
>>> -                       /* Ensure maps are correctly ordered */
>>> -                       map_ref = map__get(map);
>>> -                       maps__remove(kmaps, map_ref);
>>> -
>>> -                       map__set_start(map_ref, map__start(new_map));
>>> -                       map__set_end(map_ref, map__end(new_map));
>>> -                       map__set_pgoff(map_ref, map__pgoff(new_map));
>>> -                       map__set_mapping_type(map_ref, map__mapping_type(new_map));
>>> -
>>> -                       err = maps__insert(kmaps, map_ref);
>>> -                       map__put(map_ref);
>>> -                       map__put(new_map);
>>> -                       if (err)
>>> -                               goto out_err;
>>> -               } else {
>>> +               /* skip if replacement_map, already inserted above */
>>> +               if (!RC_CHK_EQUAL(new_map, replacement_map)) {

With above change, we don't need check 'replacement_map' at here.

Just extend a bit for considering a more clean fixing, we need to sort all
ranges in 'md.maps', this would be benefit for two things:

- We can fix up any map regions, not only limit to the 'replacement_map'. With
  sorting maps in 'md.maps', we can totally remove the code for
  'replacement_map'.
- We can report the potential issue caused by overlapping in the first place
  rather than the assert log in check_invariants(). This is easier for later
  debugging.

But current patch is good enough for me, I don't have strong opinion for this.

Thanks,
Leo

>>>                         /*
>>>                          * Merge kcore map into existing maps,
>>>                          * and ensure that current maps (eBPF)
>>> --
>>> 2.34.1
>>>
