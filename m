Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CA25D55C;
	Wed, 26 Feb 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606029; cv=none; b=uGJFTc9MCvBzcijnohIZ0GgXhbdY5KBt/gNAMV049iL7TkshB64AYwK6o6W7zvfFG7LIZeEXQbNGu5is1CZKFrIAO2KHieZN/7ufb5ITpheZJngB/7Sv/aNaMopdVAFtMElyosuUdR29UO7w8RYcigBdNNSk8IAVALcMaHF/ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606029; c=relaxed/simple;
	bh=rsinQTDikxMDKEeW17oGITcDhmuWhxvdqqHbb2cJnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZpY20egT5lquGVUM4u2Z1cZtnQojWQxLB1mLZuqIFAUVZw/vtXi/io5ab2EKS9bpjlW65q6ecVAYCXjvf1/vYNkePqh11IryzZA8g9o82PenRhijr5big3WXdtM+yEYS+7i1/xJiTHFVhTopUmyUYqFa3n64bQ7aOOsyk6IPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8HSj5y8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8HSj5y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A77EC4CED6;
	Wed, 26 Feb 2025 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606028;
	bh=rsinQTDikxMDKEeW17oGITcDhmuWhxvdqqHbb2cJnfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8HSj5y8v/aADV3XAJLJQilENfospSp7aqeuqHoQhn5xSG4Ht03u3/MZp8JpaOOEN
	 oTTEcSpwHFyhkdxJ9TjaySiv40kosFnFigOp4G6Hv1VKU+Q7MNNTcycMYh66Q7hRkF
	 Kj9onOqVIUR1+6L+x0ENFJMfuLwY2aeHX1PrtrKLoHnDS9iWbiKCDhswoYOBljIKwm
	 PKeBpcm+7vnNtwkKPTzunBPYLx3oSAFVsv+lLW6TT15yDy5y77dfnpWSGnbko/NDZS
	 dTuLFvAMk1twRxyxejFsZ79OBob4Zs2qx5MwMK3+zHGz6PrkioNnBVMi7uRN0cpcLA
	 kUE6XsZqI5Lpw==
Date: Wed, 26 Feb 2025 18:40:25 -0300
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
Message-ID: <Z7-KSRttQLImuWtJ@x1>
References: <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
 <Z74V0hZXrTLM6VIJ@x1>
 <Z74ZL6SUwWL_a5EK@x1>
 <Z74eqEiyrzuoL6uz@x1>
 <Z79std66tPq-nqsD@google.com>
 <Z7-Jte2ImGa93VUD@x1>
 <Z7-J5vHqHF4kc1HB@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7-J5vHqHF4kc1HB@x1>

On Wed, Feb 26, 2025 at 06:38:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 26, 2025 at 06:38:00PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Feb 26, 2025 at 11:34:13AM -0800, Namhyung Kim wrote:
> > > On Tue, Feb 25, 2025 at 08:48:56PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Feb 25, 2025 at 08:25:35PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Feb 25, 2025 at 08:11:17PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > > > > > > > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > > > > > > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > > > > > > > [SNIP]
> > > > > > > > > > > I thought the real-time processing had to use
> > > > > > > > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > > > > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > > > > > > > Shouldn't doing this change be the simplest fix?
> > > > > > 
> > > > > > > > > > Make sense.  How about this?
> > > > > > 
> > > > > > > > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > > > > > > > to get pushed later?
> > > > > > 
> > > > > > > > I just noticed it would add extra kernel maps after modules.  I think it
> > > > > > > > should fixup end address of the kernel maps after adding all maps first.
> > > > > > 
> > > > > > > > Arnaldo, can you please test this?
> > > > > >  
> > > > > > > Trying it now.
> > > > > > 
> > > > > > Now we have something different:
> > > > > > 
> > > > > > root@number:~# perf record sleep
> > > > > > sleep: missing operand
> > > > > > Try 'sleep --help' for more information.
> > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
> > > > > > Aborted (core dumped)
> > > > > > root@number:~#
> > > > > 
> > > > > __maps__insert() does:
> > > > > 
> > > > >         if (dso && dso__kernel(dso)) {
> > > > >                 struct kmap *kmap = map__kmap(new);
> > > > > 
> > > > >                 if (kmap)
> > > > >                         kmap->kmaps = maps;
> > > > >                 else
> > > > >                         pr_err("Internal error: kernel dso with non kernel map\n");
> > > > >         }
> > > > > 
> > > > > while maps__fixup_overlap_and_insert() doesn't.
> > > > > 
> > > > > It calls __maps__insert_sorted() that probably should do what
> > > > > __maps__insert() does?
> > > > 
> > > > Ok, so I did the following patch but this case fails:
> > > > 
> > > > @@ -910,6 +928,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> > > >                                  */
> > > >                                 map__put(maps_by_address[i]);
> > > >                                 maps_by_address[i] = map__get(new);
> > > > +                               map__set_kmap(new, maps);
> > > >                                 check_invariants(maps);
> > > >                                 return err;
> > > >                         }
> > > > 
> > > > With:
> > > > 
> > > > perf: util/maps.c:110: check_invariants: Assertion `refcount_read(map__refcnt(map)) > 1' failed.
> > > > 
> > > > As:
> > > > 
> > > > 106				/*
> > > > 107				 * Maps by name maps should be in maps_by_address, so
> > > > 108				 * the reference count should be higher.
> > > > 109				 */
> > > > 110				assert(refcount_read(map__refcnt(map)) > 1);
> > > > 
> > > > Since it is just replacing the map in the maps_by_address and not
> > > > touching on the maps_by_name? Thus the refcount is just 1:
> > > 
> > > Sounds like it.  Can you add this on top?
> > 
> > Trying, but somehow its not applying cleanly, checking:
> > 
> > ⬢ [acme@toolbox perf-tools]$ patch -p1 < ~/wb/1.patch 
> > patching file tools/perf/util/maps.c
> > Hunk #1 succeeded at 815 (offset 18 lines).
> > Hunk #2 succeeded at 826 (offset 18 lines).
> > Hunk #3 succeeded at 846 (offset 18 lines).
> > Hunk #4 succeeded at 893 (offset 18 lines).
> > Hunk #5 succeeded at 919 (offset 18 lines).
> > Hunk #6 FAILED at 923.
> > 1 out of 6 hunks FAILED -- saving rejects to file tools/perf/util/maps.c.rej
> > ⬢ [acme@toolbox perf-tools]$
> > 
> > ⬢ [acme@toolbox perf-tools]$ git log --oneline -5
> > 4a9f5d76130b707f (HEAD -> perf-tools) wip: acme
> > d5ba0f5af35937c7 wip: namhyung
> > 42367eca7604e16e (perf-tools/tmp.perf-tools, perf-tools/perf-tools) tools: Remove redundant quiet setup
> > 293f324ce96d7001 tools: Unify top-level quiet infrastructure
> > 9fae5884bb0e3480 (tag: perf-tools-fixes-for-v6.14-2025-01-30) perf cpumap: Fix die and cluster IDs
> > ⬢ [acme@toolbox perf-tools]$
> 
> ⬢ [acme@toolbox perf-tools]$ cat tools/perf/util/maps.c.rej
> --- tools/perf/util/maps.c
> +++ tools/perf/util/maps.c
> @@ -923,6 +936,10 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
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
> ⬢ [acme@toolbox perf-tools]$
> 
> Fixing this up by hand

I see, I had tried this after sending that patch:

     map__set_kmap(new, maps);

Before check_invariants(), but that doesn't make sense, I should've
dropped that, doing it now.

- Arnaldo
