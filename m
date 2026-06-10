Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CB3CAE94
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088047; cv=none; b=aJFO/S7eHkThrPoibo635OjcBQwSAwigoF4oZu+NfjjKzEZ7COuZQwBF37cWHpkDNChcL1Bk3GRqfv2+syIttTqvpmXrNj9nHvpPv8vkgCFjWTqBszkwSRIk18A2UbmUIFQsHUOGCvIYQartOBwUUKRNy767bnQABsV15abbvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088047; c=relaxed/simple;
	bh=wHAUq6dqHLzHDbGq74wWjMO6ICAAWa7gWyCN5EsHaZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7q9epSEWg16SwCDTIBzNcEbmXfwZRLKyxogy570T1M5otq1t2lAHewIhTLE/W6rq6RlXohyuKr6pWM06z5kPhTLbfbW6uzbA5ipaB7XTi/k/wJhYWjYiya+2iu7gKwHpo14BkbpFNyzulAgSpXywzggI83bVQLogS1KqtKc7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lOxukpWK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOxukpWK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec423a5265so1065189966b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781088044; x=1781692844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3jlqzJxwyyOz+TTO8ePaEkjcMI/7Wb1YHmnGXvlUUc=;
        b=lOxukpWK4UP9LIopHkFRwDCpGD3XULUOOtFovYV1Bn6NE4t1F0KN5lG0qwhHVseM+I
         IHgfs13BmLZMJw+dUfUlcMJRbxPaohV3nxXyfpZgYSlcCFosJ6DQhAiGZ96UexYiM/r1
         NKX4jFNv5dQo2/okFVQsYP9Mc8mD9a+th8Y3CDgsitr0yy4/diyll8WqrIAHTSWQ561F
         dYD5+ROxwcUIXz3FHRTcLckAGPDkY2ri4UrsbocnoxCHwZHCdUQJOOc5g4tjajXfraxg
         tUJrXqzJHKe42H9uqB5OY8r8EfDdkGvTKNubNfk6Up1asR/CCvEWZf8i48LXoUxmj1t9
         qDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088044; x=1781692844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3jlqzJxwyyOz+TTO8ePaEkjcMI/7Wb1YHmnGXvlUUc=;
        b=aurNuB1BV2Saxfk5h879+hEiXBNKL5AIbXqW2AdGUWH2m+E/ACsyneo3ML52GkEIlh
         3PJpbkG3yOomsGqm/YnS3HdqEpaOOC45uzWNmNMyyLqWobF0ad5u1vrWUhejJQBE7QaO
         Y2Dbwg/FgiD5GrYTqCOw7keCp+oJEQ8s8rUZBrDgfO2dcqNaO66KJddlrB/EjLzpeyWQ
         eg+ef2QSrTTyTzkWmJKIfH0H75Nqwx3peXI19BXB+z1SCBB94wufwhMGayra5YQSt1V6
         9Pff6Uzjsoymdn05o+zDWYNFgGaFbsBWjyDmu5NZ3LGLL8sIl3IwjQueA4J9BOImdFQj
         a1rQ==
X-Forwarded-Encrypted: i=1; AFNElJ97mAr8oofDr6lb6TTXpVs7DZyMZX9EUYKeGsWa+qAxeed0vCPQI36vxuzhIQR4hnuU4c0oAPSagRu1AHHTOjSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlEhNpRP8KIQk2hPeAiMCpADzoGB5oGryRo+UYnlpvmEqRi8w
	2cJuVC/MxQtRFhe3RrNPoGxbMHFEo9Rl7PNNXg5hZjB2HD5/XYNiy4aaX1OhzOs3oSc=
X-Gm-Gg: Acq92OGovGU2Km+VMgYLJTRwetkakLoQAY5B09KjCWP4LXzt38m3EPn+oAiYviK1sqL
	dektifStOfNjbgLGQSSbVbxZfTIJj50TcIWiMKYv9XdNcFENdUsE77uCE7CT+8lbl5TPdX26/7v
	bAQo4M89gYWBeLWCGDUw1JlCUbCEvvqbZAaBNvW/rpdmES/kQ1foU0mVWG9+maO72PT3tPEV2U0
	Kd6EtKQpBkhLXNP1IgajwupfVPsr7D0dgbIH2QzO1m7WA58DGslnWtoDvN5RQu8G/MSHDwLNJs9
	byOq6JTGtaol7bowbvfIEwCDJQhS3nqK2Sdsv4pqSD+17rbg5wy8NpE6nULNqiSXKxYRri9J2GJ
	8lmH0RmaOddw6pL8ppxU/WAJUmKlObACN1gr3G4rwnlf1df1UMRYQL2F2pN64n82c1A8wJ5+sPV
	odMZz2EuVR4Bk4XQJY75ZOXflzu4RujkGs2Gd+us0=
X-Received: by 2002:a17:907:e113:b0:bfa:f563:9298 with SMTP id a640c23a62f3a-bfaf5639aa1mr67578966b.8.1781088043964;
        Wed, 10 Jun 2026 03:40:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051770994sm1189399066b.13.2026.06.10.03.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 03:40:43 -0700 (PDT)
Message-ID: <23aa52ba-9712-4fdd-99cd-cc14929aaa3c@linaro.org>
Date: Wed, 10 Jun 2026 11:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] perf maps: Add maps__mutate_mapping
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, gmx@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
References: <20260506004546.3140141-1-irogers@google.com>
 <20260508082726.2795191-1-irogers@google.com>
 <20260508082726.2795191-4-irogers@google.com> <agGALmRbvBcJS9sM@z2>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <agGALmRbvBcJS9sM@z2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/05/2026 8:07 am, Namhyung Kim wrote:
> On Fri, May 08, 2026 at 01:27:23AM -0700, Ian Rogers wrote:
>> During kernel ELF symbol parsing (dso__process_kernel_symbol), proc
>> kallsyms image loading (dso__load_kernel_sym,
>> dso__load_guest_kernel_sym), and dynamic kernel memory map alignment
>> updates (machine__update_kernel_mmap), the loader directly modifies
>> live virtual address boundary keys fields on map objects.  If these
>> boundaries are mutated while the map pointer actively resides inside
>> the parent maps cache array list (kmaps) outside of any lock closure,
>> an unsafe concurrent window is exposed where parallel worker lookup
>> threads (e.g., inside perf top) can mistakenly assume the cache
>> remains sorted based on stale parameters, executing binary search
>> queries (bsearch) across an unsorted range and triggering lookups
>> failure.
>>
>> Fix this by introducing a thread-safe, atomic transactional framework
>> routine maps__mutate_mapping() that explicitly acquires the parent
>> maps write semaphore lock, executes an incoming mutation callback
>> block to perform the field updates under full lock protection, and
>> invalidates the sorted tracking flags prior to releasing the write
>> lock. This guarantees absolute atomic synchronization invariants,
>> completely closing the concurrent lookup race window. The adjacent
>> module alignment pass inside machine__create_kernel_maps() is safely
>> preserved as a high-performance lockless pass, as its invocation
>> lifecycle bounds remain strictly single-threaded by contract during
>> session initialization construction. There is a potential for self
>> deadlock if maps__mutate_mapping is called with the lock held, such as
>> with maps__for_each_map but this problem also existed with the
>> previous remove and insert approaches.
>>
>> Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>   tools/perf/util/machine.c    | 32 +++++++++++++++++-----------
>>   tools/perf/util/maps.c       | 26 +++++++++++++++++++++++
>>   tools/perf/util/maps.h       |  2 ++
>>   tools/perf/util/symbol-elf.c | 41 +++++++++++++++++++++++-------------
>>   tools/perf/util/symbol.c     | 17 +++++++++++----
>>   5 files changed, 87 insertions(+), 31 deletions(-)
>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index e76f8c86e62a..8d4452c70cb5 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -1522,22 +1522,30 @@ static void machine__set_kernel_mmap(struct machine *machine,
>>   		map__set_end(machine->vmlinux_map, ~0ULL);
>>   }
>>   
>> -static int machine__update_kernel_mmap(struct machine *machine,
>> -				     u64 start, u64 end)
>> +struct kernel_mmap_mutation_ctx {
>> +	u64 start;
>> +	u64 end;
>> +};
>> +
>> +static int kernel_mmap_mutate_cb(struct map *map, void *data)
>>   {
>> -	struct map *orig, *updated;
>> -	int err;
>> +	struct kernel_mmap_mutation_ctx *ctx = data;
>>   
>> -	orig = machine->vmlinux_map;
>> -	updated = map__get(orig);
>> +	map__set_start(map, ctx->start);
>> +	map__set_end(map, ctx->end);
>> +	if (ctx->start == 0 && ctx->end == 0)
>> +		map__set_end(map, ~0ULL);
>> +	return 0;
>> +}
>>   
>> -	machine->vmlinux_map = updated;
>> -	maps__remove(machine__kernel_maps(machine), orig);
>> -	machine__set_kernel_mmap(machine, start, end);
>> -	err = maps__insert(machine__kernel_maps(machine), updated);
>> -	map__put(orig);
>> +static int machine__update_kernel_mmap(struct machine *machine,
>> +				     u64 start, u64 end)
>> +{
>> +	struct kernel_mmap_mutation_ctx ctx = { .start = start, .end = end };
>>   
>> -	return err;
>> +	return maps__mutate_mapping(machine__kernel_maps(machine),
>> +				     machine->vmlinux_map,
>> +				     kernel_mmap_mutate_cb, &ctx);
>>   }
>>   
>>   int machine__create_kernel_maps(struct machine *machine)
>> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
>> index 81a97ac34077..91345a773aa2 100644
>> --- a/tools/perf/util/maps.c
>> +++ b/tools/perf/util/maps.c
>> @@ -575,6 +575,32 @@ void maps__remove(struct maps *maps, struct map *map)
>>   #endif
>>   }
>>   
>> +int maps__mutate_mapping(struct maps *maps, struct map *map,
>> +			 int (*mutate_cb)(struct map *map, void *data), void *data)
>> +{
>> +	int err = 0;
>> +
>> +	if (maps)
>> +		down_write(maps__lock(maps));
>> +
>> +	err = mutate_cb(map, data);
>> +
>> +	if (maps) {
>> +		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
>> +		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
>> +	}
>> +
>> +	if (maps)
>> +		up_write(maps__lock(maps));
>> +
>> +#ifdef HAVE_LIBDW_SUPPORT
>> +	if (maps)
>> +		libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
>> +#endif
>> +
>> +	return err;
>> +}
> 
> Could be simplified by checking 'maps' once.  But I'm not sure if
> there's a case it doesn't have the maps.
> 
> Thanks,
> Namhyung
> 

Hi Ian,

The multiple maps checks after mutate_cb() still seem to be in V19.

I noticed because I still get the -Wthread-safety-analysis error on x86 
clang 15. Not sure why the compiler isn't able to see that maps doesn't 
change, and no amount of re-arranging made it go away. The only way to 
fix it is to have the lock and unlock in the same block, but I don't 
think it looks bad:

	if (maps) {
		down_write(maps__lock(maps));

		err = mutate_cb(map, data);

		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;

		up_write(maps__lock(maps));
	} else {
		err = mutate_cb(map, data);
	}

Thanks
James


>> +
>>   bool maps__empty(struct maps *maps)
>>   {
>>   	bool res;
>> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
>> index 20c52084ba9e..de74ccbb8a12 100644
>> --- a/tools/perf/util/maps.h
>> +++ b/tools/perf/util/maps.h
>> @@ -61,6 +61,8 @@ size_t maps__fprintf(struct maps *maps, FILE *fp);
>>   
>>   int maps__insert(struct maps *maps, struct map *map);
>>   void maps__remove(struct maps *maps, struct map *map);
>> +int maps__mutate_mapping(struct maps *maps, struct map *map,
>> +			 int (*mutate_cb)(struct map *map, void *data), void *data);
>>   
>>   struct map *maps__find(struct maps *maps, u64 addr);
>>   struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 7afa8a117139..dc4ab58857b3 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -1341,6 +1341,24 @@ static u64 ref_reloc(struct kmap *kmap)
>>   void __weak arch__sym_update(struct symbol *s __maybe_unused,
>>   		GElf_Sym *sym __maybe_unused) { }
>>   
>> +struct remap_kernel_ctx {
>> +	u64 sh_addr;
>> +	u64 sh_size;
>> +	u64 sh_offset;
>> +	struct kmap *kmap;
>> +};
>> +
>> +static int remap_kernel_cb(struct map *map, void *data)
>> +{
>> +	struct remap_kernel_ctx *ctx = data;
>> +
>> +	map__set_start(map, ctx->sh_addr + ref_reloc(ctx->kmap));
>> +	map__set_end(map, map__start(map) + ctx->sh_size);
>> +	map__set_pgoff(map, ctx->sh_offset);
>> +	map__set_mapping_type(map, MAPPING_TYPE__DSO);
>> +	return 0;
>> +}
>> +
>>   static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>>   				      GElf_Sym *sym, GElf_Shdr *shdr,
>>   				      struct maps *kmaps, struct kmap *kmap,
>> @@ -1371,22 +1389,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>>   		 * map to the kernel dso.
>>   		 */
>>   		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
>> +			struct remap_kernel_ctx ctx = {
>> +				.sh_addr = shdr->sh_addr,
>> +				.sh_size = shdr->sh_size,
>> +				.sh_offset = shdr->sh_offset,
>> +				.kmap = kmap
>> +			};
>> +
>>   			*remap_kernel = false;
>> -			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
>> -			map__set_end(map, map__start(map) + shdr->sh_size);
>> -			map__set_pgoff(map, shdr->sh_offset);
>> -			map__set_mapping_type(map, MAPPING_TYPE__DSO);
>> -			/* Ensure maps are correctly ordered */
>> -			if (kmaps) {
>> -				int err;
>> -				struct map *tmp = map__get(map);
>> -
>> -				maps__remove(kmaps, map);
>> -				err = maps__insert(kmaps, map);
>> -				map__put(tmp);
>> -				if (err)
>> -					return err;
>> -			}
>> +			maps__mutate_mapping(kmaps, map, remap_kernel_cb, &ctx);
>>   		}
>>   
>>   		/*
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index fcaeeddbbb6b..09b93e844887 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -48,6 +48,13 @@
>>   #include <symbol/kallsyms.h>
>>   #include <sys/utsname.h>
>>   
>> +static int map_fixup_cb(struct map *map, void *data __maybe_unused)
>> +{
>> +	map__fixup_start(map);
>> +	map__fixup_end(map);
>> +	return 0;
>> +}
>> +
>>   static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>>   static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
>>   static bool symbol__is_idle(const char *name);
>> @@ -2121,10 +2128,11 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
>>   	free(kallsyms_allocated_filename);
>>   
>>   	if (err > 0 && !dso__is_kcore(dso)) {
>> +		struct maps *kmaps = map__kmaps(map);
>> +
>>   		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
>>   		dso__set_long_name(dso, DSO__NAME_KALLSYMS, false);
>> -		map__fixup_start(map);
>> -		map__fixup_end(map);
>> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
>>   	}
>>   
>>   	return err;
>> @@ -2164,10 +2172,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
>>   	if (err > 0)
>>   		pr_debug("Using %s for symbols\n", kallsyms_filename);
>>   	if (err > 0 && !dso__is_kcore(dso)) {
>> +		struct maps *kmaps = map__kmaps(map);
>> +
>>   		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
>>   		dso__set_long_name(dso, machine->mmap_name, false);
>> -		map__fixup_start(map);
>> -		map__fixup_end(map);
>> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
>>   	}
>>   
>>   	return err;
>> -- 
>> 2.54.0.563.g4f69b47b94-goog
>>

