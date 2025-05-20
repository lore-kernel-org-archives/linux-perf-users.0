Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66825E440;
	Tue, 20 May 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747779267; cv=none; b=uDsBpAwQ2piSxaTiEn69jEaw0J4SwOgpjProx/na936uAxRkgnOsgEgq805odd1KNa62UKwd0pJ8hAk4XQzj9rMOmYMW2x2ETidzWgGjSRYkon/bE4ybi7TajAa516ce8gwUc+k/QkQG/hsO6HnjDSfOIOmID/sMhqr9hgg2GlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747779267; c=relaxed/simple;
	bh=1a+y93hIub8/pSVvLmPKFLuPjxNtRlTjBHf2JqedxYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNiCg2v2qX5982l9gjFWwTzX02J76Qw8vJ350aQBXibAZoc0lQP+NRrPfhUMgeRViozssPmkXPU37VCqai8QcLUz/fiHphI1JSjWUKppQe1DQQWcLWsnTxLKytqeBHO9+9fMl4e2/bvzKAik25R4ffGGKvCmIQgBFphhTG5sk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGm0uLxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGm0uLxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03409C4CEEF;
	Tue, 20 May 2025 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747779266;
	bh=1a+y93hIub8/pSVvLmPKFLuPjxNtRlTjBHf2JqedxYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGm0uLxc4vwvkdSvImwL4uPLradBjvvRNXTO93ScNuVgibIzAJ7IBVYlwrbcQP/ui
	 1ueIGgPBHVZNlcSg7zqQ9pGi4G5UyyOu381/gKPXWaGbTObfK8SaKnyyVhCTrLatYc
	 DBO3TEsh9pj7WZ1xGEMyRRx5cVd+cpR6CPJa4rujmaAs8PuOklZMa5IOPsfQJfqN1p
	 BfknnVpPpRNMKtp1m4Vw2+Q4lm3eq1CNWqvYtE1uknaB4nBukdKxmj6NJO81IDHk0p
	 C2kfjgacAAG89NivGN0R99a2QUfiJD2Mm5Ci5MYfMAmuJlOrhUC6lxXHtsB5BTKw4S
	 B4CCG6iQnnMkg==
Date: Tue, 20 May 2025 15:14:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
Message-ID: <aCz-wD2Syq8mj2_0@google.com>
References: <20250519232539.831842-1-namhyung@kernel.org>
 <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>

Hi Ian,

On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> On Mon, May 19, 2025 at 4:36 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hello Namhyung,
> >
> > On Mon, May 19, 2025 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> > > max entries of 512.  Usually syscall numbers are smaller than this but
> > > x86 has x32 ABI where syscalls start from 512.
> > >
> > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
> > > of the loop when it accesses those keys.  As the loop iteration is not
> > > ordered by syscall numbers anymore, the failure can affect non-x32
> > > syscalls.
> > >
> > > Let's increase the map size to 1024 so that it can handle those ABIs
> > > too.  While most systems won't need this, increasing the size will be
> > > safer for potential future changes.
> 
> Do we need to worry about MIPS where syscalls can be offset by 1000s?
> https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/

Argh..

> We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> calls of BPF_MAP_TYPE_PROG_ARRAY.

Right, it'd complicate things but I think it's doable.

Thanks,
Namhyung

