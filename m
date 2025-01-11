Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D621FC8;
	Sat, 11 Jan 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555397; cv=none; b=ZQo71q+PyGxgoG/7W7kjFrNO/Pt8JHgOcGyvsX3GGH/N9QxxOHfz+Ehlmz19uxKSMTC0q+KOU6jmh/ncZ4jd/3etoXX4G2k+NKYtzQfWOeFdxZviSp7LAQ1479e/Ytbe6dIkjM0k1RPBRbCoWO+0Kvu7rz2VGlxE2XqL9gkMzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555397; c=relaxed/simple;
	bh=VLL2f6FOPcb9/JMDc1ho5huHsIr2C9XS9DV4/ubQ8rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGp/pnj/GDGe+f0KEyhYxP2buy99AGg32E881wBgOsbOQWevTIKpgtBIf7Ijy7j3AXZNDqiaU4oc6vaJYQnv853sdF3bjY+q3Fzj/Bfb95md7f8ojl3bH1B+XJ8pm8c3t/JyQLMM04aw1u9X5GaXb7xxXqiSJLvBenol3bbQJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg3YdjCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg3YdjCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6EBC4CED6;
	Sat, 11 Jan 2025 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736555396;
	bh=VLL2f6FOPcb9/JMDc1ho5huHsIr2C9XS9DV4/ubQ8rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gg3YdjCoxjcuLthBiJo6pCqvH3L+Myf9s0OObF8pYa6mjT9lDOBwMjG8X39zX5ZUs
	 EJAZRg8tpMDx+Qj5h3Foi6m7LVzCWrMeVhLnTr3kNOwh3VT4/5416xYcquQ7EM84ci
	 /mmDPWznGmKDp9b/37UH/4VzwFbNx4t+cylzZRuAJgUKtBLPVWOG7Pj1PjZtzBoVIO
	 qqktYTh2s1BKE7p0e853psVN4GDpmZ/+xpOCySsuUCZmgJUKqgT/LxMVyA59byu+GK
	 A3eIFf1ykwYJ0jwa1Jzf9b29qeDWKsGcPiUBemEuCpgcbeB5UzVyejJ1tdGqbUirNN
	 XD6TdusZCva0g==
Date: Fri, 10 Jan 2025 16:29:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf hist: Fix bogus profiles when filters are
 enabled
Message-ID: <Z4G7giaGtvTAhBou@google.com>
References: <cover.1736321686.git.dvyukov@google.com>
 <177603055d58e3d82e38f236f3be9fa52dc2d2c5.1736321686.git.dvyukov@google.com>
 <Z4BGuYG-V9H4wk9i@google.com>
 <CACT4Y+YwLy903AHPQ43gm7iM4Hn-ZroG=HHFvFo9Pk1_ko+cOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YwLy903AHPQ43gm7iM4Hn-ZroG=HHFvFo9Pk1_ko+cOg@mail.gmail.com>

On Fri, Jan 10, 2025 at 01:59:54PM +0100, Dmitry Vyukov wrote:
> On Thu, 9 Jan 2025 at 22:59, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 08, 2025 at 08:36:54AM +0100, Dmitry Vyukov wrote:
> > > When a filtered column is not present in the sort order, profiles become
> > > arbitrary broken. Filtered and non-filtered entries are collapsed
> > > together, and the filtered-by field ends up with a random value (either
> > > from a filtered or non-filtered entry). If we end up with filtered
> > > entry/value, then the whole collapsed entry will be filtered out and will
> > > be missing in the profile. If we end up with non-filtered entry/value,
> > > then the overhead value will be wrongly larger (include some subset
> > > of filtered out samples).
> > >
> > > This leads to very confusing profiles. The problem is hard to notice,
> > > and if noticed hard to understand. If the filter is for a single value,
> > > then it can be fixed by adding the corresponding field to the sort order
> > > (provided user understood the problem). But if the filter is for multiple
> > > values, it's impossible to fix b/c there is no concept of binary sorting
> > > based on filter predicate (we want to group all non-filtered values in
> > > one bucket, and all filtered values in another).
> > >
> > > Examples of affected commands:
> > > perf report --tid=123
> > > perf report --sort overhead,symbol --comm=foo,bar
> > >
> > > Fix this by considering filtered status as the highest priority
> > > sort/collapse predicate.
> >
> > Do you mean when you specify filters not in a sort list?
> >
> > I guess it's an undefined behavior.. probably better to warn users not
> > to do that and exit.  The hist entries are built using only the fields
> > in the sort list.  Filtering by unspecified fields would be meaningless
> > and won't work well IMHO.
> 
> We could warn as well, but I do want this feature for:
> https://lore.kernel.org/linux-perf-users/CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com/T/#t
> I think it may be useful for other cases as well, let's discuss the
> feature below.
> Why won't it work well? At least in my local manual testing, it worked
> well. This does make hist built using filtered fields as well.

I thought hist entry was constructed only for the fields in the sort
list and then apply the filter on the hist entry.  But looking at the
code, I've realized that the filter is set before the hist entry is
created.  Then it would work..

> 
> 
> > > As a side effect this effectively adds a new feature of showing profile
> > > where several lines are combined based on arbitrary filtering predicate.
> > > For example, showing symbols from binaries foo and bar combined together,
> > > but not from other binaries; or showing combined overhead of several
> > > particular threads.
> >
> > I'm not sure I'm following.  I'm seeing this even with your change.
> >
> > Without filters:
> >
> >   $ ./perf report -s dso --stdio -q
> >       98.41%  perf
> >        1.11%  [kernel.kallsyms]
> >        0.41%  ld-linux-x86-64.so.2
> >        0.05%  libLLVM-16.so.1
> >        0.03%  libc.so.6
> >
> >
> > With filter:
> >
> >   $ ./perf report -s dso -d '[kernel.kallsyms],libc.so.6' --stdio -q
> >        1.11%  [kernel.kallsyms]
> >        0.03%  libc.so.6
> >
> > You said you want to have them combined together, right?
> > But I think the current behavior makes more sense.
> 
> 
> If you add a field to both sort and filter, then this change does not
> affect anything (filtered fields already participate in
> sorting/merging). It affects things when the filter field is not in
> sort.
> 
> Consider the following queries:
> "What symbols consume time in this subset of binaries (but not in the rest)?"
> Naively, one would try:
> perf report --sort=symbol --comm=cc1,ld
> And this deceptively works and shows something, but as far as I
> understand these are random numbers now.

Right, that's what I expected.  But I agree with you that this type of
filtering can be useful and intuitive.


> With this change you can actually do this (you will see things like
> malloc/free in both of these binaries, or if one profiles e.g. Go
> programs, then there will be lots of common symbols from
> runtime/stdlin).

Yep, by not merging the filtered entries you can get the precise profile
of symbols from the specified binaries only.

> 
> Another example: profile for this particular subset of threads/cpus
> (but not for the rest).
> 
> And in particular for:
> https://lore.kernel.org/linux-perf-users/CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com/T/#t
> I want to enable: --parallelism=1-8 filter.
> Currently you will either see random garbage numbers, or if you add
> 'parallelism' to sort order, then you will see each symbol/comm
> duplicated 8 times for each separate value of parallelism (which is
> not useful). But currently you can't see symbol/comm for these 8
> parallelism levels combined, but not for the rest.

Interesting, I'll take a look at it later.

> 
> All-in-all, this looks like a change that defines behavior that's
> currently undefined in a useful and intuitive way, without changing
> any of the currently defined behaviors.

Makes sense.

Thanks,
Namhyung

