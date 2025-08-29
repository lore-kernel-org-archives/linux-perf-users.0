Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E6261B8F;
	Fri, 29 Aug 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504777; cv=none; b=Y92w3Mb3znS19sgYtuu2RrjDfRk5zpj2t/ARUePZ32/IlM0FAqnGf8nXE2W5qeyJUFMrENNhnhk5387Bv9NiEaT5EGit/fqqstMxW0ORxJOYW0m2xuYWWIoI7BMPtI6pdpMs7C9jowEDY0pe/pwuAt0spjqxt0CqpcMxraQP7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504777; c=relaxed/simple;
	bh=cFAA4SZK0e0ADYm34jdaLmr5RXVYxybFAkJwwLtUHGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQFf6Ee++Bq3CG7DoyosmdvkAdo5XRVOSo2UkbcMowUy2azZv8xgroTvWqThNzL8tFWajDIbC7SgRtUwdHQZxkT5UY/ExHCAqxIUCy616iPSluaYsLVhK6em34SEQclZ1bGJ+u1VU/49M3eCOJ7fr/CN5t40NDGYsMC7ORAZb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa3ZdiVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa3ZdiVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0158C4CEF0;
	Fri, 29 Aug 2025 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756504777;
	bh=cFAA4SZK0e0ADYm34jdaLmr5RXVYxybFAkJwwLtUHGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sa3ZdiVvlmX8G+S1CLmrOUmczhmjP59H4+erHrIZwYmkq9tgjnLEOCMayA1NKsKTW
	 oIxnrjEPhHUVkpJyjbn1egGOqgVRemnmh1gjvplO9IxRdjMYoHnb9uBcb7Dqf2taP0
	 llu+AHZs3ZTiHsANsX0zqd0yd+5VuNzn6CrwXyNgbJbY+khJyW/vpLlr0m07Ucqx47
	 HHKKWnYkNpFN26BHatrO5b1NC3moFgA/4c6sZwwcScv+t82xFoGC8Zh6d4h0Of/5vO
	 nFXwb9I0VqFHo8t8t7aFpwJL70YwLpV1z3aEemW5Eyl74ZXsOd9K4JWDoi+F0yDIFP
	 Q5PQ+60Y9uVsA==
Date: Fri, 29 Aug 2025 14:59:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
Message-ID: <aLIixyZOYD3ZE1gh@google.com>
References: <aKYEpf7xp3NnkBWm@x1>
 <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
 <aKv_FjtkPIR86inu@google.com>
 <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:59:19AM +0200, Dmitry Vyukov wrote:
> On Mon, 25 Aug 2025 at 08:13, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> > > On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > >
> > > > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> > > >
> > > > Not combining entries in 'perf top', so we're getting multiple lines for
> > > > the same symbol, with the same address.
> > > >
> > > > To test it, simply run 'perf top', then do /acpi to see just symbols
> > > > starting with acpi_ and notice that there are various lines with the
> > > > same symbol, press V to see the address and its the same.
> > >
> > > With this revert, does it show 1 entry but with a wrong percent?
> > > I am not sure why there are 2 entries for the same symbol, but if we
> > > merge them, we can sum of percents. Is it the right thing to do?
> >
> > I don't think it'd have a wrong percent.  The hists maintain stats for
> > filtered entries separately.
> 
> I still don't fully follow.
> 
> If we merge a filtered entry into non-filtered entry (with the
> revert), now we attribute what was filtered out to the non-filtered
> entry, and the non-filtered entry has wrong overhead, no?

Oh, my bad.  I thought we track both periods in the hist_entry, but it
seems it's only in the hists for total.

> 
> If we merge the other way around: non-filtered entry into filtered
> entry, then we won't show it at all.
> 
> > Based on the position of filtered entries in the RB tree, I think it
> > might not merge correct samples together and create multiple entries
> > with the same info.
> 
> The second thing I don't understand: without this revert we don't
> merge filtered and non-filtered entries, top shows duplicate entries,
> does it mean it shows filtered out entries? This also looks wrong...

I checked those duplicated entries all non-filtered (filtered = 0).
I suspect an entry can miss existing one (to be merged) when it sees
unrelated filtered entries in the middle of RB tree traversal.

> 
> > Filtering by unused sort keys would be undefined.  We probably want to
> > warn users instead.
> 
> Do you mean that the filtered=1 is set incorrectly in this case?
> Do you mean that with this revert 2 bugs just compensate each other by
> luck: we wrongly set filtered=1, and then wrongly merge them together,
> so it all works out in the end?

I mean you should not allow users to use filters not listed in the sort
keys.  For example, `perf report -s comm --tid=123` would return error.
They can use `perf report -s tid` or `perf report -s comm,tid -H`.

Thanks,
Namhyung

