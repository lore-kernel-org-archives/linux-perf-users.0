Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627620;
	b=Q/npZB3s5WXO3gNe++zvUCiS4K5WwUfImux/WDemHuiGkJso3x4m3eqghW+wbnUh/r+I
	 k/YXd7RpAmyuGFn7nGywB5VEHWsVxTYoBMx57JpRoRtHtq7GE7lv5rQpuC36p1M7W1fe8
	 PycNSEDsUSUVjKnhHWNNhRSmDFM9tFl/kXchvf0rglBuhJ75Isgq9iUx/KP6jUPABotd8
	 kTQQzs9vY1pJJwK1SYYcqjiCP2yEzY4gZqUHQk1aWR0g1Wojxo4mHMKd5Isrm//eZONyZ
	 E+OhWxvW3IgNz6o4CkSsAgjz1KabXa4pPenNWhe4xNrvatS3D2/YFbr2pqEc/F+Ad4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KEusKZgs4I1FiIlMpmR/n6ZbwE2/VKSPmeBC68K0sDM=;
	b=FoFb5x0jgWq1JATg63FBWehPUdqWqEYhXf/a8rQ94y/XNwdmbv8DwIPbnYLziK0P8S16
	 oTHsovB/DOh+BBB/1FLeDN8jKQYcQ49keHWhmWfPDz6SlIcFdq/Pe27gdC4uA9BhfnBQ6
	 Aajplc8OmyO/HrKFlmeGzZ8YE4kKLB33Rj2gciNywunSylgsA0v7o1TzJX4h6qyoL4Fsd
	 NRLOgbXPOmioBMhEfpZNwx91uhhsm5cSHXrlX2n6BfrxN0qwMENYQmC38mEw5OPZAw7DK
	 1/QJjYSZztsXmo00qPB3oX53GaRDuQMEgcBqeUmR/N/DXc6qaQfqSOwH8/KLY/ShlQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zlb1/owS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA76606A321;
	Wed, 25 Nov 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlb1/owS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EAA1F000C4;
	Wed, 25 Nov 2026 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627619;
	bh=KEusKZgs4I1FiIlMpmR/n6ZbwE2/VKSPmeBC68K0sDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zlb1/owSKLzii+qMfzcGINpVNJRIQZZ4ZP/rHSvXt6fyAzHeAkwAfE/NHuokKkuhz
	 ivy8GrkCw7WkneMfeWyPBgFt8ErT0MSd91wak9rtOkD2AnTkswnOuAwYHDjNmN/M2z
	 htOv32BnO5002YVHi7Kk8itswiTaxREDc+GlI5UqTMhtBcgfZQA0s7Mhah81E9apLW
	 CADawnd5myEn/rlh4QWN/cMscO+IWNYSxJudTivn091P9zB7hfVmumr8jmp027F4Jd
	 4fSmGjTl8v78ypkwzPIQ+V60Ls8wb8a4ctmxKPidBifkiokpTLu35VetMtuAd1WNbc
	 p50iO0+na2fpA==
Date: Wed, 25 Nov 2026 14:26:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23
 or later
Message-ID: <awcaYIe2dmLDb6T_@phoenix2>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
 <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
 <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
 <awSu48pUIh942Zm4@google.com>
 <46a896ba-cd45-4747-837d-50ea4b4dbed9@linaro.org>
 <0E9F372C-C100-41EC-B5B3-46FEDC813E01@gmail.com>
 <ceaea0f9-6f17-4626-bd55-fbc7366905ce@linaro.org>
 <awXewmptfc1za12c@phoenix2>
 <79ec2b9d-ee11-45df-b579-2d9aca5031d0@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ec2b9d-ee11-45df-b579-2d9aca5031d0@linaro.org>

On Wed, Nov 25, 2026 at 10:18:20AM +0000, James Clark wrote:
> On 24/11/2026 19:00, Arnaldo Carvalho de Melo wrote:
> > > > The script:
> > > >     3. Copies the kernel header into the tools/ tree, skipping it when only
> > > >        the tools/ copy changed (it is ahead) or when it carries intentional
> > > >        edits, and stopping for manual investigation when both sides have
> > > >        content the other lacks.

> > > > acme@number:~/git/perf-tools-next$

> > > > I.e. the limitation in point number three, about intentional edits, needs to be lifted.
> > > Oh nice I hadn't noticed sync-headers.sh. What's the plan to support tools
> > > side edits? Something like exporting the kernel change as a patch and trying
> > > to apply it on top of the tools copy? Or I suppose you could do it the other
> > > way around and try to apply the tools diff on top of a new clean kernel
> > > copy.

> > I think the script should diff the current state, save that, copy the
> > new header, apply the patch to get the perf tools changes, then ask
> > opencode (or the coding agent used most frequently by the developer) to
 
> Interesting, didn't think about having an agent invoked from the script.
> Despite what people say about them being unreliable, for things like
> resolving conflicts and digging out commit messages to add context to the
> resolutions, I find them much more reliable than myself. And faster as well.

Well, the script will produce a draft, leave it at that for the
maintainer to decide what to change, if anything, and then do the usual
steps, so it is just automating boring parts. Finding a new maintainer
becomes easier, probably ;-)
 
> > check if what was done is sensible, then ask the developer to do a last
> > check and amends, sign off and commit.

See?

> > My plan is to have this in tools/perf/scripts/ so that whoever comes
> > after me and Namhyung, if this ends up being needed, don't have to go
> > thru such boring processes that were not automated due to lack of time
> > even being in my mind since forever as tech debt :-\ :-)
 
> This feels like its turning email into an API that you can attach any front
> end to. I wonder if it would give websites like github any ideas to add a
> "send as a signed linux PR" button :D

Well, e-mail is what we've been using since forever, but having some
button that would essentially do the same via a TUI, GUI, github or
voice interface/whatnot, would end up being equivalent, we still need to
look at what was done by contributors, make sure it was tested
extensively in as many distros and architectures as possible, that
reviewers had enough time to say something if they so think it is in
order do do so, and then send it upstream.

Whatever we can do to make this painless and effective, I'm interested
in.

I did lots of these things manually trying to adhere to what Ingo and
Linus expected from me, there are plenty of examples of me doing so for
these LLMs to have been trained on, now I just want to reap the benefits
and have more time to do interesting things :-)
 
> It's a great documentation of the actual process which despite all the
> documentation is not always that obvious how to do in practice.

Yeah, that too, that is a very effective, I'd say, way to document what
we've been doing.

- Arnaldo
