Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF674407;
	Wed,  8 May 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159676; cv=none; b=OLXFkCLSKREByHHmVe3dmZeBycQ9JEWWurQOIP526yubNclTmlwAOLsh2sECGye7frtn//PqFd5bKwLZmG5xqGLlBr/mlBKFQFhsDKleW1yy7pMhttHpYLx6YnuxubxkknTQcn4zaNAD1vh2tt8lhl0Npm/+68SJEDoEQ9/RXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159676; c=relaxed/simple;
	bh=B4UJb+tlzEFJiyJpw6WvgTTkrDytDNJUypQi6BUwPyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5Vp1X73YqkQSmMb9W2VNwGleGyf1rVV8H74vR6wRXLlE0Hl3MkglI6zdWOOB7fe9ETwkIbcj2mVZJAg8ePXoN441Tv7tFSd5nSB988WX2bY+MNEj0I+w2cl5e3cz5lmVhbjhbSlgY9EFw8aIKJeF7uKmyRdRfiWEO4GwcA2/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F20B1063;
	Wed,  8 May 2024 02:15:00 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB6D3F6A8;
	Wed,  8 May 2024 02:14:32 -0700 (PDT)
Message-ID: <16116798-52d6-4004-8514-9b81c789474f@arm.com>
Date: Wed, 8 May 2024 10:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf symbols: Update kcore map before merging in
 remaining symbols
To: Namhyung Kim <namhyung@kernel.org>
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
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cjYvMndUmSuwnE1ETwnu_6WrxQ4UzsNHHvo4SVR250L7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/05/2024 05:10, Namhyung Kim wrote:
> On Tue, May 7, 2024 at 7:13 AM James Clark <james.clark@arm.com> wrote:
>>
>> When loading kcore, the main vmlinux map is updated in the same loop
>> that merges the remaining maps. If a map that overlaps is merged in
>> before kcore, the list can become unsortable when the main map addresses
>> are updated. This will later trigger the check_invariants() assert:
>>
>>   $ perf record
>>   $ perf report
>>
>>   util/maps.c:96: check_invariants: Assertion `map__end(prev) <=
>>     map__start(map) || map__start(prev) == map__start(map)' failed.
>>   Aborted
>>
>> Fix it by moving the main map update prior to the loop so that
>> maps__merge_in() can split it if necessary.
> 
> Looks like you and Leo are working on the same problem.
> 
> https://lore.kernel.org/r/20240505202805.583253-1-leo.yan@arm.com/
> 

Oops I should have checked the list. It looks like we can still take his
fix as well though, with an updated comment.

>>
>> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/symbol.c | 40 +++++++++++++++++++++-------------------
>>  1 file changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 2d95f22d713d..e98dfe766da3 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1289,7 +1289,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>  {
>>         struct maps *kmaps = map__kmaps(map);
>>         struct kcore_mapfn_data md;
>> -       struct map *replacement_map = NULL;
>> +       struct map *map_ref, *replacement_map = NULL;
>>         struct machine *machine;
>>         bool is_64_bit;
>>         int err, fd;
>> @@ -1367,6 +1367,24 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>         if (!replacement_map)
>>                 replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
>>
>> +       /*
>> +        * Update addresses of vmlinux map. Re-insert it to ensure maps are
>> +        * correctly ordered. Do this before using maps__merge_in() for the
>> +        * remaining maps so vmlinux gets split if necessary.
>> +        */
>> +       map_ref = map__get(map);
>> +       maps__remove(kmaps, map_ref);
> 
> A nitpick.  It'd be natural to use 'map' instead of 'map_ref'
> (even if they are the same) since IIUC we want to remove
> the old 'map' and update 'map_ref' then add it back.
> 

Using map makes sense, I can update that.

>> +
>> +       map__set_start(map_ref, map__start(replacement_map));
>> +       map__set_end(map_ref, map__end(replacement_map));
>> +       map__set_pgoff(map_ref, map__pgoff(replacement_map));
>> +       map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
> 
> So here, replacement_map should not be NULL right?
> 

Yes it shouldn't be. It would only be NULL if md.maps is empty, but
there's already an exit condition for that above.

Some of the other code also assumes node->map is always set, so it can't
be NULL that way either.

> Thanks,
> Namhyung
> 
>> +
>> +       err = maps__insert(kmaps, map_ref);
>> +       map__put(map_ref);
>> +       if (err)
>> +               goto out_err;
>> +
>>         /* Add new maps */
>>         while (!list_empty(&md.maps)) {
>>                 struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
>> @@ -1374,24 +1392,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>
>>                 list_del_init(&new_node->node);
>>
>> -               if (RC_CHK_EQUAL(new_map, replacement_map)) {
>> -                       struct map *map_ref;
>> -
>> -                       /* Ensure maps are correctly ordered */
>> -                       map_ref = map__get(map);
>> -                       maps__remove(kmaps, map_ref);
>> -
>> -                       map__set_start(map_ref, map__start(new_map));
>> -                       map__set_end(map_ref, map__end(new_map));
>> -                       map__set_pgoff(map_ref, map__pgoff(new_map));
>> -                       map__set_mapping_type(map_ref, map__mapping_type(new_map));
>> -
>> -                       err = maps__insert(kmaps, map_ref);
>> -                       map__put(map_ref);
>> -                       map__put(new_map);
>> -                       if (err)
>> -                               goto out_err;
>> -               } else {
>> +               /* skip if replacement_map, already inserted above */
>> +               if (!RC_CHK_EQUAL(new_map, replacement_map)) {
>>                         /*
>>                          * Merge kcore map into existing maps,
>>                          * and ensure that current maps (eBPF)
>> --
>> 2.34.1
>>
