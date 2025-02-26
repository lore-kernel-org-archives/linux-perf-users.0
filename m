Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55D266EE8;
	Wed, 26 Feb 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605881; cv=none; b=rbsLBbdaKvSI7qOZtsxuK2Vt2wFE9Cd5WNJlrqvetYE73E2J8LWcTLNDiKtOQZoC5YKzB0YOOdxkZXtV7ezMOgFQEQmJEAa7ni4TqszeNXT5S8IzzZDq1/WfDCqkajOoV+k1GrRJ/xCPvk04vyFkF8gImS6R3v4tY9NnjABUeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605881; c=relaxed/simple;
	bh=1HxTySRGFLapXwQ4iFlnjdpTnd4Uf8TTpcFXhntBvcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpzL256twtmwP3TGLs3xmvIdHDqVtK7c04HLZQND9y4oJyc9HYJ1eFs2Siz80xWkOFrqcwiwYHaemSXJh5rZPsfPwLgjjqDlTtoAfVzzxxhjQAacG9pOSBfisC5iyo5nKSuQR1z6I/DR4EfDLxG1SWTCoFBz07qWaqly/CaOmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgq6SPlj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgq6SPlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA53C4CED6;
	Wed, 26 Feb 2025 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605880;
	bh=1HxTySRGFLapXwQ4iFlnjdpTnd4Uf8TTpcFXhntBvcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hgq6SPljsxPh3c6H7xtRy7lT/2+9yq3u5qEpNLwE97LZXB6PW3NvP2d7VjKUjfYPR
	 9OBjN2LRHMdvEnU2e4N+UpuPyShnCp30v11yl0KgDvC/+ZBoaPYZa72qTCVse4jz5D
	 Hs9msFgRTbHnz+3qxnZehJOccPmggjHXDrSa3DZ3yTNKIGZiu4TK8/di5HKNLerckQ
	 K07gnUi4adbcl39e8Ew39di2573zb1vBVDQI0GcVyHLn6UXN3+2fxHPSh5hm317doF
	 z92cDwYuzXuqGURo8v+a0yUfnSyGmFc9zyMdwD3tExFRG/LAFymV+IKJ8fkpFmxJmZ
	 J4ve065LFcH5w==
Date: Wed, 26 Feb 2025 18:37:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z7-Jte2ImGa93VUD@x1>
References: <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
 <Z74V0hZXrTLM6VIJ@x1>
 <Z74ZL6SUwWL_a5EK@x1>
 <Z74eqEiyrzuoL6uz@x1>
 <Z79std66tPq-nqsD@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z79std66tPq-nqsD@google.com>

On Wed, Feb 26, 2025 at 11:34:13AM -0800, Namhyung Kim wrote:
> On Tue, Feb 25, 2025 at 08:48:56PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Tue, Feb 25, 2025 at 08:25:35PM +0100, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Feb 25, 2025 at 08:11:17PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > > > > > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > > > > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > > > > > [SNIP]
> > > > > > > > > I thought the real-time processing had to use
> > > > > > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > > > > > Shouldn't doing this change be the simplest fix?
> > > > 
> > > > > > > > Make sense.  How about this?
> > > > 
> > > > > > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > > > > > to get pushed later?
> > > > 
> > > > > > I just noticed it would add extra kernel maps after modules.  I think it
> > > > > > should fixup end address of the kernel maps after adding all maps first.
> > > > 
> > > > > > Arnaldo, can you please test this?
> > > >  
> > > > > Trying it now.
> > > > 
> > > > Now we have something different:
> > > > 
> > > > root@number:~# perf record sleep
> > > > sleep: missing operand
> > > > Try 'sleep --help' for more information.
> > > > [ perf record: Woken up 1 times to write data ]
> > > > perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
> > > > Aborted (core dumped)
> > > > root@number:~#
> > > 
> > > __maps__insert() does:
> > > 
> > >         if (dso && dso__kernel(dso)) {
> > >                 struct kmap *kmap = map__kmap(new);
> > > 
> > >                 if (kmap)
> > >                         kmap->kmaps = maps;
> > >                 else
> > >                         pr_err("Internal error: kernel dso with non kernel map\n");
> > >         }
> > > 
> > > while maps__fixup_overlap_and_insert() doesn't.
> > > 
> > > It calls __maps__insert_sorted() that probably should do what
> > > __maps__insert() does?
> > 
> > Ok, so I did the following patch but this case fails:
> > 
> > @@ -910,6 +928,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >                                  */
> >                                 map__put(maps_by_address[i]);
> >                                 maps_by_address[i] = map__get(new);
> > +                               map__set_kmap(new, maps);
> >                                 check_invariants(maps);
> >                                 return err;
> >                         }
> > 
> > With:
> > 
> > perf: util/maps.c:110: check_invariants: Assertion `refcount_read(map__refcnt(map)) > 1' failed.
> > 
> > As:
> > 
> > 106				/*
> > 107				 * Maps by name maps should be in maps_by_address, so
> > 108				 * the reference count should be higher.
> > 109				 */
> > 110				assert(refcount_read(map__refcnt(map)) > 1);
> > 
> > Since it is just replacing the map in the maps_by_address and not
> > touching on the maps_by_name? Thus the refcount is just 1:
> 
> Sounds like it.  Can you add this on top?

Trying, but somehow its not applying cleanly, checking:

⬢ [acme@toolbox perf-tools]$ patch -p1 < ~/wb/1.patch 
patching file tools/perf/util/maps.c
Hunk #1 succeeded at 815 (offset 18 lines).
Hunk #2 succeeded at 826 (offset 18 lines).
Hunk #3 succeeded at 846 (offset 18 lines).
Hunk #4 succeeded at 893 (offset 18 lines).
Hunk #5 succeeded at 919 (offset 18 lines).
Hunk #6 FAILED at 923.
1 out of 6 hunks FAILED -- saving rejects to file tools/perf/util/maps.c.rej
⬢ [acme@toolbox perf-tools]$

⬢ [acme@toolbox perf-tools]$ git log --oneline -5
4a9f5d76130b707f (HEAD -> perf-tools) wip: acme
d5ba0f5af35937c7 wip: namhyung
42367eca7604e16e (perf-tools/tmp.perf-tools, perf-tools/perf-tools) tools: Remove redundant quiet setup
293f324ce96d7001 tools: Unify top-level quiet infrastructure
9fae5884bb0e3480 (tag: perf-tools-fixes-for-v6.14-2025-01-30) perf cpumap: Fix die and cluster IDs
⬢ [acme@toolbox perf-tools]$
 
> Thanks,
> Namhyung
> 
> 
> ---8<---
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 09c9cc326c08d435..3aee0c9e8d421cef 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -797,7 +797,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  {
>  	int err = 0;
>  	FILE *fp = debug_file();
> -	unsigned int i;
> +	unsigned int i, ni;
>  
>  	if (!maps__maps_by_address_sorted(maps))
>  		__maps__sort_by_address(maps);
> @@ -808,6 +808,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  	 */
>  	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
>  		struct map **maps_by_address = maps__maps_by_address(maps);
> +		struct map **maps_by_name = maps__maps_by_name(maps);
>  		struct map *pos = maps_by_address[i];
>  		struct map *before = NULL, *after = NULL;
>  
> @@ -827,6 +828,9 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  			map__fprintf(pos, fp);
>  		}
>  
> +		if (maps_by_name)
> +			ni = maps__by_name_index(maps, pos);
> +
>  		/*
>  		 * Now check if we need to create new maps for areas not
>  		 * overlapped by the new map:
> @@ -871,6 +875,11 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  		if (before) {
>  			map__put(maps_by_address[i]);
>  			maps_by_address[i] = before;
> +			if (maps_by_name) {
> +				map__put(maps_by_name[ni]);
> +				maps_by_name[ni] = map__get(before);
> +			}
> +
>  			/* Maps are still ordered, go to next one. */
>  			i++;
>  			if (after) {
> @@ -892,6 +901,10 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  			 */
>  			map__put(maps_by_address[i]);
>  			maps_by_address[i] = map__get(new);
> +			if (maps_by_name) {
> +				map__put(maps_by_name[ni]);
> +				maps_by_name[ni] = map__get(new);
> +			}
>  			err = __maps__insert_sorted(maps, i + 1, after, NULL);
>  			map__put(after);
>  			check_invariants(maps);
> @@ -910,6 +923,10 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  				 */
>  				map__put(maps_by_address[i]);
>  				maps_by_address[i] = map__get(new);
> +				if (maps_by_name) {
> +					map__put(maps_by_name[ni]);
> +					maps_by_name[ni] = map__get(new);
> +				}
>  				check_invariants(maps);
>  				return err;
>  			}
