Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83061B0F23;
	Mon, 15 Sep 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955782; cv=none; b=NziSDHaMWPlTiELBAvXNoxDVZ8sjeGDOIZQDhyoZZKvlRq0D9iB9bVgYXvt38/zhg6Z4rzUSUHdoPmYl9WAKk26/wuVkbyVIrOIRt+sRQdaA+e3X2UbmIH+bWltXGnBd8UvV18lsRsLFpL/d/4YF0mSZnXApz8MEStaQzXOFOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955782; c=relaxed/simple;
	bh=tZFiStB2M4gGwMQOc1ppNjyCSdSM5uqdwEG3ZLUByrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+SK8IknwWXorQX1fOnYSlJUKUHX3Q57ZDAE1sUgHWkXbfltFZ1IygTjH0tBOuRLzoM2+2ntr02RpvhfwpXcCBsPhaq9QYuCA6zlcy6Uqle/GpWrC+aOVlZ/W1dyz2ceishUxL6HB1k0fPmgr+GdTXWq3N4TGwhz5DBA/7qTR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OromX4Dz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OromX4Dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B188EC4CEF1;
	Mon, 15 Sep 2025 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757955782;
	bh=tZFiStB2M4gGwMQOc1ppNjyCSdSM5uqdwEG3ZLUByrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OromX4DzaAswBcBGOC+ZKJiUuCBGsVPtLV5RAaTmfpp+afskvWWQkMaxczTnq1ioX
	 pKzPscPYqBYhe0We3jYszK/rffZXYJSX7YT60ra+pk/imAs4sMud5Sxt3V47LjdxZ3
	 q3N5sdC8T1SxlNfrD340hRU/+SkX9rP0TO+nqulsPo//I04Fko5q+0ruSOUjWBEn3n
	 NKY59whOD/ZcUA6Ph10UhN+RpgH2++h0rYh2UQz9m5bomD4ssU03dKPmcu/EyryEDf
	 jAFYIf/XgTYlh4b7+amR4zW70kxoy28eLqIioUSPUp8BmgA7mQkf0FRyA87zu/Wx1B
	 7DGsFLgO2V5Fg==
Date: Mon, 15 Sep 2025 10:03:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf maps: Ensure kmap is set up for all inserts
Message-ID: <aMhGxKz3qYSNJC35@google.com>
References: <20250914181808.1957729-1-irogers@google.com>
 <CAP-5=fWz9Put0QznfXSf1ATXjcfQj1T2toZmXrXp502qU4fRSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWz9Put0QznfXSf1ATXjcfQj1T2toZmXrXp502qU4fRSw@mail.gmail.com>

Hi Ian,

On Mon, Sep 15, 2025 at 08:00:53AM -0700, Ian Rogers wrote:
> On Sun, Sep 14, 2025 at 11:18 AM Ian Rogers <irogers@google.com> wrote:
> >
> > __maps__fixup_overlap_and_insert may split or directly insert a map,
> > when doing this the map may need to have a kmap set up for the sake of
> > the kmaps. The missing kmap set up fails the check_invariants test in
> > maps, later "Internal error" reports from map__kmap and ultimately
> > causes segfaults.
> >
> > Similar fixes were added in commit e0e4e0b8b7fa ("perf maps: Add
> > missing map__set_kmap_maps() when replacing a kernel map") and commit
> > 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel
> > maps") but they missed cases. To try to reduce the risk of this,
> > update the kmap directly following any manual insert. This identified
> > another problem in maps__copy_from.
> >
> > Fixes: e0e4e0b8b7fa ("perf maps: Add missing map__set_kmap_maps() when replacing a kernel map")
> > Fixes: 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel maps")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> This may be worth picking up for v6.17. It was a fairly regular source
> of crashes on basic commands like `perf record` for me on certain
> kernels. `perf record` by default is processing the whole perf.data
> file and if there were overlapping maps, from BPF symbol events
> typically, the broken kmap would trigger assertion failures and seg
> faults.

Sounds good, will queue it to perf-tools.

Thanks,
Namhyung
 
> > ---
> >  tools/perf/util/maps.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index 85b2a93a59ac..779f6230130a 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -477,6 +477,7 @@ static int __maps__insert(struct maps *maps, struct map *new)
> >         }
> >         /* Insert the value at the end. */
> >         maps_by_address[nr_maps] = map__get(new);
> > +       map__set_kmap_maps(new, maps);
> >         if (maps_by_name)
> >                 maps_by_name[nr_maps] = map__get(new);
> >
> > @@ -502,8 +503,6 @@ static int __maps__insert(struct maps *maps, struct map *new)
> >         if (map__end(new) < map__start(new))
> >                 RC_CHK_ACCESS(maps)->ends_broken = true;
> >
> > -       map__set_kmap_maps(new, maps);
> > -
> >         return 0;
> >  }
> >
> > @@ -891,6 +890,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >                 if (before) {
> >                         map__put(maps_by_address[i]);
> >                         maps_by_address[i] = before;
> > +                       map__set_kmap_maps(before, maps);
> >
> >                         if (maps_by_name) {
> >                                 map__put(maps_by_name[ni]);
> > @@ -918,6 +918,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >                          */
> >                         map__put(maps_by_address[i]);
> >                         maps_by_address[i] = map__get(new);
> > +                       map__set_kmap_maps(new, maps);
> >
> >                         if (maps_by_name) {
> >                                 map__put(maps_by_name[ni]);
> > @@ -942,14 +943,13 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
> >                                  */
> >                                 map__put(maps_by_address[i]);
> >                                 maps_by_address[i] = map__get(new);
> > +                               map__set_kmap_maps(new, maps);
> >
> >                                 if (maps_by_name) {
> >                                         map__put(maps_by_name[ni]);
> >                                         maps_by_name[ni] = map__get(new);
> >                                 }
> >
> > -                               map__set_kmap_maps(new, maps);
> > -
> >                                 check_invariants(maps);
> >                                 return err;
> >                         }
> > @@ -1019,6 +1019,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
> >                                 err = unwind__prepare_access(dest, new, NULL);
> >                                 if (!err) {
> >                                         dest_maps_by_address[i] = new;
> > +                                       map__set_kmap_maps(new, dest);
> >                                         if (dest_maps_by_name)
> >                                                 dest_maps_by_name[i] = map__get(new);
> >                                         RC_CHK_ACCESS(dest)->nr_maps = i + 1;
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
