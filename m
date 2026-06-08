Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B1330B01;
	Mon,  8 Jun 2026 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961161; cv=none; b=O0XCPqQBm7VghMoXNRbTzlMUngMTS/rfoLd3lGTaOPS8ffkFSTIYqB0M8VnUQ5SlcE1bCnYyNcd+dvkAour9lPAeZhhn8y/5KTzcGHZ3XxLs5KtXYROLE3yQtp7XIH1k2d6k+3wHtdwjKFn7gbeot+HpBDY1o+Zfi2ksz+30xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961161; c=relaxed/simple;
	bh=JUS0ICAVAF9RYE2ROA9QkOX+VzG4KlGhTIclxGdWXeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTp7Vx/4+YLdeDc4a3I1PIFeSHfALh2RN0klpIpKXfE744Q0Fb6EjAbovHR4U84XwUtTZKtMShyPgACgoZ15ff3UagrZIizfInky58j47PbgW9OrezV1An0v+gjjqNHHYpp+g6ZiBPhySijvOlED1Bw1AeIbBhNICEWwOQaeGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkFbdyZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkFbdyZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A861F00893;
	Mon,  8 Jun 2026 23:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780961160;
	bh=enxUvSPCxVvflLa994FixX+vf/f8QgYhP8NWrGszHXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkFbdyZWkSv+QjsvJYjCOW8W9qMXOwjCeQ+q6oqFF95uWYd0Ly69kyC4alcZfSR3x
	 kffqtZuepJms0Nf30ns6eRgLzVpS6BHdxGDBBoju9OjxBWjKt+KOsBoSPToGWH6e+2
	 xmkmNeGRQ7Gixpf/2dPPZh8k7PTeZPriDLYzD22yErslL9/dBnx7odQ4cPoiZbuyDe
	 m4qWg5cVGe6VyCTaMQJFC9McvTAR+e1wfSs7v38aEVtEaB7ZMmBEzWcl4IVoqygv+F
	 RLfwjEI/XkIA6ZW71Vy/fU6ordsTYkVxVcpRDWz5TD2UtL2hPrLl8s4zNft6ifGRte
	 1rRrwNIbEyQ8A==
Date: Mon, 8 Jun 2026 20:25:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/11] libperf: Document code simplification case for
 widening struct perf_cpu
Message-ID: <aidPhIBhQ-wTsY0o@x1>
References: <20260608201753.1979464-12-acme@kernel.org>
 <20260608204539.0E0C91F00893@smtp.kernel.org>
 <CAP-5=fV+trJGAEKhS2YTea0A39VgoYUxbcp=E0csPepD751N3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+trJGAEKhS2YTea0A39VgoYUxbcp=E0csPepD751N3A@mail.gmail.com>

On Mon, Jun 08, 2026 at 03:04:40PM -0700, Ian Rogers wrote:
> On Mon, Jun 8, 2026 at 1:50 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The documentation added to `tools/lib/perf/TODO` incorrectly states that narrowing values > 32767 to `int16_t` wraps them to 'small positive numbers'. In two's complement arithmetic, values from 32768 to 65535 wrap to negative numbers (-32768 to -1) when truncated to a signed 16-bit integer.
> > --
> >
> > commit e8f5b26d672396c3173a77e6aaeee613f6d309bd
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > libperf: Document code simplification case for widening struct perf_cpu
> >
> > Add a bullet point to the libperf ABI TODO explaining the code
> > simplification benefit of widening struct perf_cpu.cpu from int16_t
> > to int.
> >
> > > diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
> > > index 486dd95dc5720..1a3644aa1f38d 100644
> > > --- a/tools/lib/perf/TODO
> > > +++ b/tools/lib/perf/TODO
> > > @@ -11,6 +11,13 @@ together.
> > >       (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
> > >       growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
> > >       safety net.
> > > +   - Code simplification: the int16_t forces defensive truncation
> 
> I think Sashiko just wants this to be uint16_t :-)

That would buy us some more decades, maybe. :-)

- Arnaldo
 
> Thanks,
> Ian
> 
> > > +     checks at every boundary where a wider CPU index (int from
> > > +     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
> > > +     Without these checks, values > 32767 silently wrap to small
> > > +     positive numbers, bypassing bounds validation.  Widening to int
> >        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > [Severity: Low]
> > This isn't a bug, but is the arithmetic description accurate here?
> >
> > In two's complement arithmetic, truncating values between 32768 and 65535
> > into a signed 16-bit integer (int16_t) wraps them to negative numbers
> > (-32768 to -1), rather than small positive numbers.
> >
> > The overall conclusion remains correct since negative values trivially
> > bypass bounds checks, but the description of the wrapping behavior appears
> > mathematically inaccurate.
> >
> > > +     eliminates this entire class of silent truncation bugs and
> > > +     removes the need for the INT16_MAX clamp in set_max_cpu_num().
> > >     - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260608201753.1979464-1-acme@kernel.org?part=11
> >
