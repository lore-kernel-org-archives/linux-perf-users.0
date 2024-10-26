Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9272F36;
	Sat, 26 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962992; cv=none; b=HfK4afPhRBdHUJUgE1lVokm9gCk0q0Bm9nxNTsjKOgy/fYz8cOtwWqMFipkJY5pmtC1Ph7pFFTrN2WkJYEcgS4mlO7zjQzY0tiJibWyrVdJmdg0+3YXdUSMOFF2gfMj/wo4yUwKa+pYZWyCx5DGYPLsK+D1dJ4bFIsBw8vgP5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962992; c=relaxed/simple;
	bh=8txkN2m2sqsivt14SB6UYV4uqJtOyu6Sm0vklh4XQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMyg7sB2O+/ATJXCGdzXh0BOnVzrvWYRPGsXgDDYTVGegeo5F/lOBA9GDlON9PGNHC7JporAc/B8gEM+eUplSFiEtwVCcbG2cV9jUX9xAKbplGrQIouR/rzhSX8yk5ekRQtwRuj26FmyRj2thz2BGhIEFWN6/Dqam9UKei3Ee+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm11r5ni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm11r5ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64523C4CEC6;
	Sat, 26 Oct 2024 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729962992;
	bh=8txkN2m2sqsivt14SB6UYV4uqJtOyu6Sm0vklh4XQvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lm11r5niSSleCUXRb+0LhOYVZn/2+Q7wl+cv7wmG7xnMclBJzMyZN/gEsADFp8FHJ
	 pRL8wlBguAQzVg1/iqQFddE617XXZg1H3kgMoe09kNHErrxR18KCrGwWf3Y/s+6IgB
	 0LED5TS4XDV4r50tMM+b/H1sscEats6IlzkuQLlgLNT7UgLRA4n+frvMkYCXY8C01y
	 H5es9A3EwEvDXk82rS3+dbIGiPR4JLC3b/b8woReAb8ZbRXzOuRfxRy5quFHGx40WO
	 3skUyG4+RyIgVEloVqhc1pBfSHesuth6YtIvinbkDhc0YH/RsWBD3iBME4oitwP8jC
	 ceyIwQEKKvzoQ==
Date: Sat, 26 Oct 2024 10:16:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
Message-ID: <Zx0j7tIsDB6Ao44c@google.com>
References: <20241022180623.463131-1-irogers@google.com>
 <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
 <Zxp4mbzsFyO5nUh7@google.com>
 <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
 <ZxvVuFqef2CLwtCs@google.com>
 <CAP-5=fVTU8nUfadXgpUd4my9emsY4c_7znMa9_RWD6VZbGYhZA@mail.gmail.com>
 <ZxwHHWbjIbGh1RU8@x1>
 <CAP-5=fX+m3KOR_c8v5=tzSbrsfE-C7_5B83ORjRoH2SQuJNA-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX+m3KOR_c8v5=tzSbrsfE-C7_5B83ORjRoH2SQuJNA-g@mail.gmail.com>

Hello Ian,

Thanks for your email explaining the concerns.

On Fri, Oct 25, 2024 at 04:07:47PM -0700, Ian Rogers wrote:
> On Fri, Oct 25, 2024 at 2:01 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Oct 25, 2024 at 11:26:26AM -0700, Ian Rogers wrote:
> > > On Fri, Oct 25, 2024 at 10:30 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Thu, Oct 24, 2024 at 06:33:27PM -0700, Ian Rogers wrote:
> > > > > So I think moving the enum declarations into one patch is okay. But as
> > > > > the enum values have no bearing on hardware constants, or something
> > > > > outside of the code that uses them it smells strange to me. Ultimately
> > > > > this is going to do little to the lines of code count but damage
> > > > > readability. I'm not sure why we're doing this given the kernel model
> > > > > for adding a driver is to add it as a large chunk. For example, here
> > > > > is adding the intel PT driver:
> > > > > https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alexander.shishkin@linux.intel.com/T/#u
> >
> > > > Maybe others can understand a big patch easily, but I'm not.
> >
> > > My understanding is that we make small patches so that the codebase is
> > > more bisectable. When there is something new, like a driver or here a
> >
> > That is super important, having patches being super small and doing just
> > one thing helps in bisecting problems.
> >
> > If two things are done in one patch, and one of them causes a problem,
> > then bisection is a very effective way of finding out what exactly
> > caused a problem.
> >
> > But bisection is not the only benefit from breaking down larger patches
> > into smaller ones.
> >
> > We want to have more people joining our ranks, doing low level tooling
> > and kernel work.
> >
> > Writing new functionality in a series of patches, growing in complexity
> > is a way to reduce the cognitive load on understantind how something
> > works.
> >
> > As much as trying to emulate how the kernel community works is a good
> > model as that community has been producing a lot of good code in a
> > frantic, athletic pace, and as much as I can agree with you that adding
> > a new piece of code will not affect bisectability as its new code, I
> > think having it broken down in multiple patches benefits revieweing.
> 
> Can you explain how, as asked, can separating the declaration of a
> function from its definition aid in reviewing? As a reviewer, I want
> to know the scope of a function and its documentation. Placing them in
> 2 separate patches doesn't benefit my reviewing.

No, it's my fault.  Please move the declaration into the same patch.

> 
> > Reviewing is something we should do more, but its very taxing.
> >
> > One would rather try to write as much code as possible, leaving to
> > others the reviewing part.
> >
> > But its a balancing act.
> >
> > Whatever we can do to help reviewers, like taking into account what they
> > say they would prefer as a way to submit our work, even if it isn't
> > exactly of our liking, is one such thing.
> >
> > So if Namhyung says that it would be best for you to try to break down
> > your patches into smaller ones, like I did say to you in the past, even
> > taking the trouble to do it myself, in the process introducing problems,
> > later fixed, I think you should try to do what he says.
> >
> > He is the maintainer, try to address his comments.
> 
> I think I've written long emails addressing the comments. Just saying
> too big (1) doesn't match how existing drivers are added (although
> I've split the code many times so the addition is the smallest it can

I think it's different than drivers which can be separated by a config
option easily and highly hardware dependent.  Or maybe it's just a
maintainers' preference.


> be) (2) as I've pointed out makes the code harder to bisect, work with
> compilers and understand.

I don't agree.  The intention is to help other's understanding of the
code.  Well I agree it will require more effort for the author, but I
believe that having the code more digestible size would benefit in the
long run.

I feel like the whole perf code base is getting bigger, harder to know
all the details.  So I'm asking contributors to do more work to reduce
the burden in some way.

> 
> I think there is far too much developer push back going on, it feels
> capricious, I'm lucky as I'll just go push into Google's tree. I'm
> only persisting here for upstream's benefit and ultimately my benefit
> when I pull from upstream. Perfect shouldn't be the enemy of good, but
> frequently (more often than not for me) reviewer comments aren't
> improving the code they are significantly stalling it:

I'm sorry that you felt that way.  I was trying to improve the code and
keep the code simple and concise.  But it's sometimes hard to draw the
line where it's acceptable.  Probably my previous decisions were bad,
but I tried to be reasonable as much as possible.

> 
> 1) parallel testing
> https://lore.kernel.org/lkml/20241025192109.132482-1-irogers@google.com/
> 1.1) pushed back because it used an #ifdef __linux__ to maintain some
> posix library code (a now dropped complaint)

I don't know we have that in other place.  So I was curious if we care
about other platforms.  Probably we can just delete the unused code, but
as I said, I can live with this.


> 1.2) pushed back for improvements in test numbering, addressed in:
> https://lore.kernel.org/lkml/20241025192109.132482-11-irogers@google.com/
> not an unreasonable thing to do but feature creep. Hey we'll only take
> your work helping us if you also add feature xyz

Well I think you changed the numbering in the parallel testing and I
asked to keep it continuous as of now.

> 
> 2) libdw clean up
> https://lore.kernel.org/lkml/20241017002520.59124-1-irogers@google.com/
> Pushed back as more cross architecture output would make the commit
> messages better. Doesn't sound crazily unreasonable until you realize
> the function that is being called and needing cross platform testing
> is 6 lines long and only applies when you do analysis of x86 perf.data
> files on non-x86 platforms. We heavily test the code on x86 and the
> chance that cross platform testing will show anything is very small.

I think we're fine except for the register naming.  I haven't reviewed
that part yet and I'll do that next week.

> 
> On the other hand I can point at unreviewed maintainer code going into
> the tree and code where I've pointed out it is broken, from a
> fundamental CS perspective, it is also taken into the tree.
> 
> RISC-V has been damaged and now in the driver they are trying to
> workaround the perf tool. There were already comments to this effect
> in ARM breakpoint driver's code.

It's sad we broke some arch.  But it should be easy to fix the tool
than the kernel driver.  Let's find a way to fix the problems in a
better way.  Sorry if I missed some previous discussion.

> 
> On Intel we now have TPEBS (which took far far too long to land)
> behind a flag which means we've made accurate top-down analysis
> require an additional flag on all newer Intel models, something I
> pushed against.

This is a new code that requires complex and non-intuitive operations
like mixing perf record and perf stat together.  I remember some people
doubt about the approach so it may deserve stricter and longer reviews.

Even then, I tried to review quickly and accepted some minor
disasgreements.  It's unfortunate it took too long but it happens.

> 
> So the reviewing is inconsistent, damages the code (a maintainer may
> disagree with the reviewer and developers saying otherwise but the
> maintainer has to be followed to land) and is constantly stalling
> development. Fixing reference counting took years to land because of
> endless stalling, any reasonable developer would have just given up.
> It is hard to imagine the state the code base would be in without it.

Right it works great, thanks for your effort.

But I think any collaborating work needs some kind of burden (or
stalling) for coordination.  If said patches touch a lot of area, there
is a high chance of rebase, more arguments on the interface, etc.

> 
> Of the patches I've mentioned how many are code health and how many
> are a feature I can say working on is part of my day job? I see a
> deliberate lack of understanding of what a developer needs. To say
> I've not tried to address comments, I'd say 90% of the noise on
> linux-perf-users is me resending patches, mine and others, to address

Thanks for your hard work.  Maybe I'm the bottleneck of your
productivity.  But I cannot take patches without review, and reviewing
patches take time.  Having more active reviewers would help.


> comments. Here I've made the patches a size that makes sense. I can
> move the enums, which feels like a compiler error along the lines of
> "static function defined but not used" but beside this, changing
> evsel's name meaning to make it part of the event encoding is imo
> wrong, having separate patches for a function declaration and then 1
> for its definition, can you imagine taking this to its extreme and
> what the patches would look like if you did this? In making things
> smaller, as has happened already in this series, it is never clear you
> will hit a magical maintainer happy threshold. Knowing how to make a
> "right" patch is even harder when it is inconsistent with the rest of
> Linux development.

At least for this case, I don't think moving the declaration would cause
you a lot of trouble.  Please take a look at my updated 'perf/hwmon-pmu'
branch again.

For the magical maintainer threshold, I admit it can be different to
each maintainer.  But I think it's the review process to find a point of
agreement.  I don't know where it is even by myself but we can argue
each other.

Thanks,
Namhyung

