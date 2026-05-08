Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CA33F5A4
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237858; cv=none; b=OykW36D4hssA7b3NX9hg4Lth/+3UtGCVxP3huTUAGVqSCRTe2rTVDZHCOG06RHS5EUUCtFqeS8d/BM0tZKe2YbHZ9FkhFliMB4kT4WYUhKPbJMVJK+z047lhaN4dNqD3cyPS2k/lr/g5pVY1nt9u0NibIZClL4RpN3DtqU7kB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237858; c=relaxed/simple;
	bh=XvDB3iM+/dZHmCzZq7PCu176v87aHIOOgEnStF7mKMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpIRjCJeEl3VUz4WXgVxspAt9oI0aKLld0krgFla4uFiUQS/kxuJm9rFHYmvPJcmIK3xbKOA5st1xQgX6oeNWlrqNbxZWWqL9u1y67GwN+mq2VzBLPQ36nz4UghvHjWwZRECKGFU8RZQ/rKtj2Pu9zcNjgCWJT8OKwvTxt2DvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vIT+A+gI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIT+A+gI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso21576795e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778237855; x=1778842655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/VySIry+4g8mwwKuwdamLZ2z6m1pymi2bDmKrxQjKA=;
        b=vIT+A+gInrEpzSzfcsh8NY20o79jKJMRIoWWCA841yDuTnNfmDDMCdbcqf+1bSGdXZ
         xydo0VX7nxUbGwZ06XC1KXXBT60gujU//m6lXg8palirzTS/r+9Wcw4Qyto+jV4Wa+8s
         maInQDjkabbwiRkyUHJOfDGl+QzrDVlryxIkVnxqu/PuOm/EjqcqAsxUAasWnpt43CZs
         sIg2tWvu9mqm/ppTWNoXBMl6+whDPKlX2oQrctjL+QpUKEDfXjZw4SH1NEjr6KZjEN2e
         iAGJQr8n41zQnVMkxIgdS7cGyiT3lJNAs1uHI3ebS+GVyzvA6aioWzO+23VRsjsrR7Hs
         2BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778237855; x=1778842655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/VySIry+4g8mwwKuwdamLZ2z6m1pymi2bDmKrxQjKA=;
        b=I2bIN2Fua230m49pa+2Slv++yCKWept2ok+SXPlwot76uApEic3T46BUkqrElwDh8+
         fYw60BG2gV3RNmjJm8BwFUjjqzMnOa6HEzJyPUa3TN7xRnojyjqvhLhe1zlVPgMWLiky
         PFlTtm5+6S2x29uDnGErXH24Rw2TZ0JPFqEKACF5rrGOp4Z+f7pt3QlSw8qitzhVNdhb
         ypmzShl4KBjos6Od7q8Sjl/PoCWR5ew15CwmmAk6vBf7fGLKDid3kIjHNbE0e7opfhE+
         39Az+Q9a5BvT5dD3B5XbMaaN2U5UAbdzsikrkb3GPOSGhUzMC9Wwy7d70QOjTVW3YFW1
         /L3Q==
X-Forwarded-Encrypted: i=1; AFNElJ89VcN74yhZwLu1lyBY2R8eJQibXRM0c+cSkJsgnmZbCEojD/DtgoGCFYogdfGd7Qa6iJA3mcbpQKmGKC+MzZaX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/cBKKwEEbC4Fmj5jgEDcGS9Z9ER/IEshLNfLluYsLysyZ7Qc
	+CDb6ORzSDCWI4Daap5rIH/hEoY/ZcpHhUjTaKRtiMMKvpiTHvZkm9dRErw/MBNzyX4=
X-Gm-Gg: AeBDieuSJ8P7RLPU5eB+L+DJxxHrXcoNIJVOzOreGDqdmMflt7kh4tI07dAX1oWM05U
	lmWU9IVJbwJN3cvJ5BKqDtoE1rM0fi58lPlAoQPkgaCS9vGnxRvgcPUBuOwaIfAR7ER10x8IZeu
	0aCRe30p65EyPEw9qm6gpTQmzX+UbB/acGqaU+F9T/1YrxCWHSKWWhLSo0Fc41PF1aR+b+XeR5I
	ev3biTR7cZaZDMP1GlO4/Jttu7DXK5/5y+GDtsT3G83YA/XAH4SS6xnTk5wecHqEafu1aL1Pu5y
	q2ErWKuUM1SNQI7rtWzcBasbSGjKvVcB2FXIYxqmnZslcmmhiO7Rcdn5QZ51tWy7APS18ceduKy
	8C2Qe6+3yjHhRalZghFjpRBlaOPBgkE76F/sIAxMges8fs2QHG7ZLIshNdyOE3la7U5lAuUvw9x
	RKvqcENxDA/ilD6WG2yakXbupWbKe/
X-Received: by 2002:a05:600c:46d2:b0:488:b187:3c with SMTP id 5b1f17b1804b1-48e51f32c65mr185449755e9.14.1778237854848;
        Fri, 08 May 2026 03:57:34 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e65c0492dsm15233645e9.18.2026.05.08.03.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:57:34 -0700 (PDT)
Message-ID: <297c2b38-fe04-4c02-bd92-d4f56b6b726f@linaro.org>
Date: Fri, 8 May 2026 11:57:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] perf maps: Add maps__mutate_mapping
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 acme@kernel.org, gmx@google.com, namhyung@kernel.org
References: <20260506004546.3140141-1-irogers@google.com>
 <20260508082726.2795191-1-irogers@google.com>
 <20260508082726.2795191-4-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260508082726.2795191-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/05/2026 9:27 am, Ian Rogers wrote:
> During kernel ELF symbol parsing (dso__process_kernel_symbol), proc
> kallsyms image loading (dso__load_kernel_sym,
> dso__load_guest_kernel_sym), and dynamic kernel memory map alignment
> updates (machine__update_kernel_mmap), the loader directly modifies
> live virtual address boundary keys fields on map objects.  If these
> boundaries are mutated while the map pointer actively resides inside
> the parent maps cache array list (kmaps) outside of any lock closure,
> an unsafe concurrent window is exposed where parallel worker lookup
> threads (e.g., inside perf top) can mistakenly assume the cache
> remains sorted based on stale parameters, executing binary search
> queries (bsearch) across an unsorted range and triggering lookups
> failure.
> 
> Fix this by introducing a thread-safe, atomic transactional framework
> routine maps__mutate_mapping() that explicitly acquires the parent
> maps write semaphore lock, executes an incoming mutation callback
> block to perform the field updates under full lock protection, and
> invalidates the sorted tracking flags prior to releasing the write
> lock. This guarantees absolute atomic synchronization invariants,
> completely closing the concurrent lookup race window. The adjacent
> module alignment pass inside machine__create_kernel_maps() is safely
> preserved as a high-performance lockless pass, as its invocation
> lifecycle bounds remain strictly single-threaded by contract during
> session initialization construction. There is a potential for self
> deadlock if maps__mutate_mapping is called with the lock held, such as
> with maps__for_each_map but this problem also existed with the
> previous remove and insert approaches.
> 
> Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/machine.c    | 32 +++++++++++++++++-----------
>   tools/perf/util/maps.c       | 26 +++++++++++++++++++++++
>   tools/perf/util/maps.h       |  2 ++
>   tools/perf/util/symbol-elf.c | 41 +++++++++++++++++++++++-------------
>   tools/perf/util/symbol.c     | 17 +++++++++++----
>   5 files changed, 87 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e76f8c86e62a..8d4452c70cb5 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1522,22 +1522,30 @@ static void machine__set_kernel_mmap(struct machine *machine,
>   		map__set_end(machine->vmlinux_map, ~0ULL);
>   }
>   
> -static int machine__update_kernel_mmap(struct machine *machine,
> -				     u64 start, u64 end)
> +struct kernel_mmap_mutation_ctx {
> +	u64 start;
> +	u64 end;
> +};
> +
> +static int kernel_mmap_mutate_cb(struct map *map, void *data)
>   {
> -	struct map *orig, *updated;
> -	int err;
> +	struct kernel_mmap_mutation_ctx *ctx = data;
>   
> -	orig = machine->vmlinux_map;
> -	updated = map__get(orig);
> +	map__set_start(map, ctx->start);
> +	map__set_end(map, ctx->end);
> +	if (ctx->start == 0 && ctx->end == 0)
> +		map__set_end(map, ~0ULL);
> +	return 0;
> +}
>   
> -	machine->vmlinux_map = updated;
> -	maps__remove(machine__kernel_maps(machine), orig);
> -	machine__set_kernel_mmap(machine, start, end);
> -	err = maps__insert(machine__kernel_maps(machine), updated);
> -	map__put(orig);
> +static int machine__update_kernel_mmap(struct machine *machine,
> +				     u64 start, u64 end)
> +{
> +	struct kernel_mmap_mutation_ctx ctx = { .start = start, .end = end };
>   
> -	return err;
> +	return maps__mutate_mapping(machine__kernel_maps(machine),
> +				     machine->vmlinux_map,
> +				     kernel_mmap_mutate_cb, &ctx);
>   }
>   
>   int machine__create_kernel_maps(struct machine *machine)
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 81a97ac34077..91345a773aa2 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -575,6 +575,32 @@ void maps__remove(struct maps *maps, struct map *map)
>   #endif
>   }
>   
> +int maps__mutate_mapping(struct maps *maps, struct map *map,
> +			 int (*mutate_cb)(struct map *map, void *data), void *data)
> +{
> +	int err = 0;
> +
> +	if (maps)
> +		down_write(maps__lock(maps));
> +
> +	err = mutate_cb(map, data);

Hi Ian,

I get this error when building with LLVM=1 on Ubuntu clang version 
18.1.8 (11~20.04.2):

util/maps.c:586:8: error: mutex 'maps__lock(maps)' is not held on every 
path through here [-Werror,-Wthread-safety-analysis]
   586 |         err = mutate_cb(map, data);
       |               ^
util/maps.c:584:3: note: mutex acquired here
   584 |                 down_write(maps__lock(maps));
       |                 ^
util/maps.c:594:3: error: releasing mutex 'maps__lock(maps)' that was 
not held [-Werror,-Wthread-safety-analysis]
   594 |                 up_write(maps__lock(maps));
       |                 ^
2 errors generated.

> +
> +	if (maps) {
> +		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
> +		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
> +	}
> +
> +	if (maps)
> +		up_write(maps__lock(maps));
> +
> +#ifdef HAVE_LIBDW_SUPPORT
> +	if (maps)
> +		libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
> +#endif
> +
> +	return err;
> +}
> +
>   bool maps__empty(struct maps *maps)
>   {
>   	bool res;
> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> index 20c52084ba9e..de74ccbb8a12 100644
> --- a/tools/perf/util/maps.h
> +++ b/tools/perf/util/maps.h
> @@ -61,6 +61,8 @@ size_t maps__fprintf(struct maps *maps, FILE *fp);
>   
>   int maps__insert(struct maps *maps, struct map *map);
>   void maps__remove(struct maps *maps, struct map *map);
> +int maps__mutate_mapping(struct maps *maps, struct map *map,
> +			 int (*mutate_cb)(struct map *map, void *data), void *data);
>   
>   struct map *maps__find(struct maps *maps, u64 addr);
>   struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 7afa8a117139..dc4ab58857b3 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1341,6 +1341,24 @@ static u64 ref_reloc(struct kmap *kmap)
>   void __weak arch__sym_update(struct symbol *s __maybe_unused,
>   		GElf_Sym *sym __maybe_unused) { }
>   
> +struct remap_kernel_ctx {
> +	u64 sh_addr;
> +	u64 sh_size;
> +	u64 sh_offset;
> +	struct kmap *kmap;
> +};
> +
> +static int remap_kernel_cb(struct map *map, void *data)
> +{
> +	struct remap_kernel_ctx *ctx = data;
> +
> +	map__set_start(map, ctx->sh_addr + ref_reloc(ctx->kmap));
> +	map__set_end(map, map__start(map) + ctx->sh_size);
> +	map__set_pgoff(map, ctx->sh_offset);
> +	map__set_mapping_type(map, MAPPING_TYPE__DSO);
> +	return 0;
> +}
> +
>   static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>   				      GElf_Sym *sym, GElf_Shdr *shdr,
>   				      struct maps *kmaps, struct kmap *kmap,
> @@ -1371,22 +1389,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>   		 * map to the kernel dso.
>   		 */
>   		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
> +			struct remap_kernel_ctx ctx = {
> +				.sh_addr = shdr->sh_addr,
> +				.sh_size = shdr->sh_size,
> +				.sh_offset = shdr->sh_offset,
> +				.kmap = kmap
> +			};
> +
>   			*remap_kernel = false;
> -			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
> -			map__set_end(map, map__start(map) + shdr->sh_size);
> -			map__set_pgoff(map, shdr->sh_offset);
> -			map__set_mapping_type(map, MAPPING_TYPE__DSO);
> -			/* Ensure maps are correctly ordered */
> -			if (kmaps) {
> -				int err;
> -				struct map *tmp = map__get(map);
> -
> -				maps__remove(kmaps, map);
> -				err = maps__insert(kmaps, map);
> -				map__put(tmp);
> -				if (err)
> -					return err;
> -			}
> +			maps__mutate_mapping(kmaps, map, remap_kernel_cb, &ctx);
>   		}
>   
>   		/*
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..09b93e844887 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -48,6 +48,13 @@
>   #include <symbol/kallsyms.h>
>   #include <sys/utsname.h>
>   
> +static int map_fixup_cb(struct map *map, void *data __maybe_unused)
> +{
> +	map__fixup_start(map);
> +	map__fixup_end(map);
> +	return 0;
> +}
> +
>   static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>   static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
>   static bool symbol__is_idle(const char *name);
> @@ -2121,10 +2128,11 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
>   	free(kallsyms_allocated_filename);
>   
>   	if (err > 0 && !dso__is_kcore(dso)) {
> +		struct maps *kmaps = map__kmaps(map);
> +
>   		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
>   		dso__set_long_name(dso, DSO__NAME_KALLSYMS, false);
> -		map__fixup_start(map);
> -		map__fixup_end(map);
> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
>   	}
>   
>   	return err;
> @@ -2164,10 +2172,11 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
>   	if (err > 0)
>   		pr_debug("Using %s for symbols\n", kallsyms_filename);
>   	if (err > 0 && !dso__is_kcore(dso)) {
> +		struct maps *kmaps = map__kmaps(map);
> +
>   		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
>   		dso__set_long_name(dso, machine->mmap_name, false);
> -		map__fixup_start(map);
> -		map__fixup_end(map);
> +		maps__mutate_mapping(kmaps, map, map_fixup_cb, NULL);
>   	}
>   
>   	return err;

