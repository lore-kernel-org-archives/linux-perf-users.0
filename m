Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687429406;
	Thu, 10 Oct 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523566; cv=none; b=l/TXaVJB2PkKR1RDS5TV/FUhJ8f1j59GtrqaOhxuKynvdpJsB/nkHELHpwdJa8+in5GYe/cHnXm/CpXCctCL+qvBi+tr4u48+BItBzLLps/PIkxKRen7WDv2OGDOOJlo7QR70IQnyAuiAFr1p+3ed6ltURRkq+6JoeUBBXZ+9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523566; c=relaxed/simple;
	bh=dEREbm6dYtCVd6LR3SJ8L2iV7sYDhFU1rpH4ZQVyJMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdVw/NYWc4rR/Hspe6wvTtHgwx70Ldyh9/UFe0rQl2U8cBozct/K3C5t4DO1sgS6SWXA0shhEI5BdNrhQ+BuXjazs+X4zYXBW9Vzlfp+5jE7z9owbg2BHfMBP5fiJXTj7sf1PJTHGL22ETDFcH7sGXhWu56MOovGo504UJLSphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEz1vB3Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEz1vB3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B1BC4CEC3;
	Thu, 10 Oct 2024 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523566;
	bh=dEREbm6dYtCVd6LR3SJ8L2iV7sYDhFU1rpH4ZQVyJMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEz1vB3ZHtw92VDQ95YXMq8CKKs2EJdjCg5Cm5mpUacfelSJGnP+X4vYdzmEmI3o6
	 LUmKoZTANQKsoonSjQhdtDYU+DCGw/VHCqB6tdA4HErmzuIioIXZPDQzZg8ikVBt/5
	 a1IKXeVvf1vChOrgi84AwswJmh9C0oEDfBZ99dbbjskjZtXxVORVUKLdhGmsknkxZU
	 2th4x9a1OB/fsgkiOHJjcZkyCU4zJt1v43p95Ov60RK9c1aSqyWOgvqq0QwpdjKyEJ
	 gErNsfkxEi5jyP1T6ALPNZLZJ/xwostOHqV5hrCEQzjiU4U8PNiFyB0FnT+q56eMuT
	 fF7h2fEyQOZXA==
Date: Wed, 9 Oct 2024 18:26:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
Message-ID: <ZwctLNCL_fcVjc-S@google.com>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo>
 <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
 <ZvsXl2g6kYDi6F9o@google.com>
 <ZvvbiY1NjTZxWvG7@tassilo>
 <CAP-5=fV-_MkAjnB-2C7m=ENRknorJx4TZ6p4GWp56ySXoFO3-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV-_MkAjnB-2C7m=ENRknorJx4TZ6p4GWp56ySXoFO3-Q@mail.gmail.com>

On Tue, Oct 01, 2024 at 06:47:47AM -0700, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 4:22 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Mon, Sep 30, 2024 at 02:26:47PM -0700, Namhyung Kim wrote:
> > > On Thu, Sep 19, 2024 at 06:45:23AM +0200, Ian Rogers wrote:
> > > > On Thu, Sep 19, 2024 at 3:29 AM Andi Kleen <ak@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > > > > > Python2 was deprecated 4 years ago, remove support and workarounds.
> > > > >
> > > > > Nacked-by: Andi Kleen
> > > > >
> > > > > I don't see any advantages of breaking perfectly fine existing setups
> > > > > for no benefits.
> > >
> > > Well, I think the benefit is in the maintenance.  The EOL of Python 2
> > > was 2020/1/1 [1] and we are targeting this release (v6.13) in 2025.  So
> >
> > AFAIK it's still widely used, and supported by third parties. And even
> > if not it's not that the python usage in perf needs any external support.
> >
> > In Linux deprecation is generally tied to nobody using something
> > anymore, and that is clearly not the case here.
> >
> > > I think it's reasonable to consider removing Python 2 support now.
> >
> > That's code that practically never changes, so I don't see any
> > maintenance benefit. I mean it needs to be compile tested / perf tested,
> > but Arnaldo's container collection will do that practically
> > for free.
> 
> So of the Linux distributions that supported Python 2, the versions
> that did stopped being supported in June this year.
> The hypothetical person who cares about python 2 support needs to be
> building their own kernel tree, they've had to upgrade GCC, etc. but
> GCC isn't particularly relevant here.
> The hypothetical person wants to build on their unsupported
> distribution the latest and greatest perf tool. Now the perf build has
> required python 3.6 for json events for 2.5 years. So this
> hypothetical person who wants the latest perf tool on their
> unsupported system must not care about json events and metrics but
> does care about python 2 integration for scripting.
> I really don't see such a person existing and if they did they can:
> 1) install python3
> 2) use an older perf tool
> 
> There is a constant cost in the code base trying to know whether
> python means 2 or 3. Keeping dead code around at the very least
> creates poor code coverage numbers. We want to add to the python entry
> points into the code with parse_events. We want to make python a
> dlopen dependency (as done in uftrace) rather than something that's
> linked against. In other words python development is somewhat active
> and trying to carry around python 2 support when no one we can name
> wants it is just burdening us down, costing us in time and code
> coverage for no gain.

Yeah I think it's time to consider sunsetting Python 2.  As Ian and
James said, it was bothering some development.

Andi, do you still use it with Python 2?  Or do you know anybody who
might suffer from this change?  Is it hard to upgrade the system?

I'm inclined to pick up this change unless there's a specific reason.

Thanks,
Namhyung

