Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B217F4F6
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921568; cv=none; b=UhilWEtRwmS5/kmG/xFPgpVeQb0i5rV+IsKVy6IXY+yOY5QfLL/HIwMEwMtTyYySmN+Qx/9umlkMefhySAFcnIY/LJXm3Q0d7UPz8sRPGFqikUx0Wz9/qhUpCzKnlEfjKYAZ2oLbd2arp6bLJjoCS7FX8O3PppeZ7Pk+rykFUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921568; c=relaxed/simple;
	bh=FNO1aPu3maetdCOeeSVReiHOM/AJcCD967TpylWGtNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE4GNSd/wZiYK4EOaHFmUzuAYgmF53GCsjv9XNPSKtdaVrQvP+ptEboyQa3uP1GALhIsvwGIp46jqdmGv9WSoRvqRP/d1WEYMSKQUH6iGWuJwLQTSpZqcQXsCWDo4NYw86H4o8oBiK+mWavuK9S3NPYlF/niOI/LQT0dG9MihyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raK2CMNt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raK2CMNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A7CC4CECE;
	Fri,  3 Jan 2025 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735921568;
	bh=FNO1aPu3maetdCOeeSVReiHOM/AJcCD967TpylWGtNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raK2CMNtpTCknYHkbdsmzLKP0TtHuNpjqa+WmyzJgF4EzR1l14zQ4DpHwxzx077a4
	 U1TKOwTsNrdprShmPozXwer+bY3J7PXMUNJwRxCcRkZWeISHZriwseX/CkKYVkLrb5
	 sTdGN3eFYWfm0mUXMyvlsbVSgc4kNN+/Y7XhanG/DqoPykOS3xRsg4O7LbfH9rHER/
	 LakRUgbhAjqVPzCO0HrgDT+HMW8FCR0m8h7e0tUcVwn2y8dChZ0S+TaaGWfBqf2PxA
	 W0RAorDoq0/7AfFjjtqAn8dz6ZxZ41A7iumyte1LZF72KYuGVqvC1H5z91swS5IhNx
	 x+UqS74oZEgxw==
Date: Fri, 3 Jan 2025 13:26:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Message-ID: <Z3gPncBcCnZiNy57@x1>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
 <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
 <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu>
 <Z3c4nupM-UENN5LM@x1>
 <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu>

On Fri, Jan 03, 2025 at 01:40:24PM +0100, Christophe Leroy wrote:
> Le 03/01/2025 à 02:08, Arnaldo Carvalho de Melo a écrit :
> > >     PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 drop: 0/0
> > > [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> > > -------------------------------------------------------------------------------

> > >      17.18%  [unknown]      [k] 0xc0891c14
> > >       7.63%  [unknown]      [k] 0xc005f11c

> > I think I hadn't notice this '[unknown]' one bit before :-\ the [k] is
> > there, so having unknown is odd
 
> Problem found, it's in maps__find_next_entry(), this leads to both
> map->start and map->end of kernel map being set to 0xc0000000, which leads
> to the failure of bsearch() in maps__find().

Right, and since you don't have any module (CONFIG_MODULES not set),
and most machines do, that is when the buggy function is called:

machine__create_kernel_maps()
	if (!machine__get_running_kernel_start(machine, &name, &start, &end))
<SNIP>
        if (end == ~0ULL) {
                /* update end address of the kernel map using adjacent module address */
                struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
                                                         machine__kernel_map(machine));

                if (next) {
                        machine__set_kernel_mmap(machine, start, map__start(next));
                        map__put(next);
                }
        }
<SNIP>

So machine__get_running_kernel_start() doesn't manage to fill end with
either because it doesn't find the ref_reloc_sym, one of:

const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL}

And returns -1, so that first if block fails, and then start also
doesn't get set and remains 0, which doesn't seem to be the case, as you
get 0xc0000000 in it, or this fails:

        err = kallsyms__get_symbol_start(filename, "_edata", &addr);
        if (err)
                err = kallsyms__get_function_start(filename, "_etext", &addr);
        if (!err)
                *end = addr;

So machine->vmlinux_map->start is set to 0xc0000000 and
machine->vmlinux_map->end has ~0ULL, as

   ret = machine__update_kernel_mmap(machine, start, end);

Was called and it calls

  machine__set_kernel_mmap(machine, start, end);

With 'end' equal to ~0ULL.

Now with your patch maps__find_next_entry() returns NULL and ->end
doesn't get set to ->start, remaining at ~0ULL, which makes the search
to work with just one map, the machine->vmlinux_nmap, got it.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Second problem is a build issue in perf-tools-next due to commit
> e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS"), see
> commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at compile
> time") to know why this is needed.
 
> By the way I'm wondering why we need a duplicated definition of MAX_NR_CPUS
> with different values. Second definition was added by commit 9c3516d1b850
> ("libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions")

I think that Ian's intention is to clean this up from what I can
remember from the discussion that lead to this initial set of patches.

I was going to work on this to make everything dynamic, i.e. not use a
MAX_NR_CPUS define but instead get the number of possible processors on
the machine and use it instead, but since Ian started working on it I
moved to other stuff.

Now we need to have this patch from you turned into two patches and with
a summary of the above analysis, would you do it, please?

The Reviewed-by tag I provided above applies to both patches,

Namhyung, I think this can go via perf-tools-next, as it is for a rare
situation, i.e. no CONFIG_MODULES and has been in the codebase since:

⬢ [acme@toolbox perf-tools-next]$ git tag --contains 659ad3492b913c903 | grep '^v6.[[:digit:]]$'
v6.9
⬢ [acme@toolbox perf-tools-next]$

I.e. its not a regression added in this cycle, ok?

Thanks!

- Arnaldo
 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index fcc47214062a..12eaa6955121 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -13,7 +13,9 @@
>  #include "internal.h"
>  #include <api/fs/fs.h>
> 
> +#ifndef MAX_NR_CPUS
>  #define MAX_NR_CPUS 4096
> +#endif
> 
>  void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
>  {
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 432399cbe5dd..d39bf27a5fdd 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1137,7 +1137,7 @@ struct map *maps__find_next_entry(struct maps *maps,
> struct map *map)
> 
>  	down_read(maps__lock(maps));
>  	i = maps__by_address_index(maps, map);
> -	if (i < maps__nr_maps(maps))
> +	if (++i < maps__nr_maps(maps))
>  		result = map__get(maps__maps_by_address(maps)[i]);
> 
>  	up_read(maps__lock(maps));
> 
> 
> Christophe
