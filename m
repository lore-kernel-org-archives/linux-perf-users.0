Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BD3EC6A0;
	Wed,  5 Aug 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959154; cv=none; b=r5NqYX68fsjXWze4AONBnWftWfEFgkyz5gfSvOsHMPH/PTOoL6KcKHPuLvlN0nHiJ6MmsI2azrW1EUKdrTevXJuojVPadWJLApd2g+rrx0WMiLTJA/6CRVVEtokVc5X6KugPgQYKYXF6b+4VPYBct/taSCX0+MlF8sgHeLDez6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959154; c=relaxed/simple;
	bh=Lto9LemTF7YFEZGPlOwzFRot0oUz/OM7dG16Z5p2I4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFI9VI9y9S9fGqCYWahMNyH2K1WcGnw+RrnBslEV5Lff9T/URvlXhVJj9K+KjJQ7cFzMljgF1hAA+YXwQwgbA0+CiPIuDhXkGT1ao573n81y9xIoCHW0R9xAF1SHyZFuftclcbzcEiNN8VEAK9moL/TtvjHcBWapqviodiW1bUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLOej4ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLOej4ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADBD1F000E9;
	Wed,  5 Aug 2026 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785959150;
	bh=nA91Q4vc1KfG1YA9OFQZeOB92WRjBFsMHuSYBSz/uzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLOej4ibMgX8Qhr6XuP4gRTKgXrA7QBvbIdzI9+M95ex4VbTN4No21niJmoss52Uy
	 3pOVP49yaomlKiYxE0DBXJC2duiTA8QAmCgMDBj2L9z8T4TcufZSGshqod6jkU5z0i
	 31mtgvrv4H2PxjrVymeFDScsXptwudHBqFcNI4oen/Ko/n3V/bagpQ+ybhYQwMohWq
	 0Y1vXFCvm73e4yCJwgLNR4OhvpvXPWBwpSLlf2gI3mnCSE6vkFOMWrbLG5CJt7itTI
	 33NiQZSn1oDqiQI4+XAgnatrqSsM7SKR9E2zVRnAQFez8RSNbtVqW3UqFWAAAFBEZH
	 wWyEV+VjjGn+A==
Date: Wed, 5 Aug 2026 16:45:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
Message-ID: <anOS6oYhAKJkAQdh@x1>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-6-acme@kernel.org>
 <CAP-5=fXRei4AivX_RcqR4xjmLtbYuNsJALOzJMAWvy7HCU09Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXRei4AivX_RcqR4xjmLtbYuNsJALOzJMAWvy7HCU09Dg@mail.gmail.com>

On Wed, Aug 05, 2026 at 12:07:23PM -0700, Ian Rogers wrote:
> On Wed, Aug 5, 2026 at 6:31 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > snprintf() returns the would-have-been length on truncation.  When the
> > jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
> > sizeof(event->mmap2.filename) - size into a massive underflow, causing
> > the header.size computation to write an oversized header.  The
> > subsequent write to 'id = event + header.size - idr_size' then corrupts
> > the heap.
> >
> > Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_load()
> > and jit_repipe_code_move().
> >
> > Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Cc: Stephane Eranian <eranian@google.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/jitdump.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > index 078d3304d2b7ebce..fd11e07bf00b7978 100644
> > --- a/tools/perf/util/jitdump.c
> > +++ b/tools/perf/util/jitdump.c
> > @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
> >                         jd->dir,
> >                         nspid,
> >                         count);
> > +       /* snprintf returns would-be length on truncation, clamp to buffer */
> > +       if (size >= PATH_MAX)
> > +               size = PATH_MAX - 1;
> 
> Given the recent fixes to reading /proc/pid/maps where it was assumed
> the file paths would be limited to PATH_MAX and it turns out that
> PATH_MAX doesn't really do that and we had potential buffer overruns
> during synthesis, I wonder it would be more intention revealing here
> to use "sizeof(event->mmap2.filename)" rather than PATH_MAX. Other
> than the constant used, I agree with the change and using PATH_MAX
> isn't wrong.

We need to go on having our tools/perf/AGENTS.md with all those rules
:-)
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo
 
> Thanks,
> Ian
> 
> >
> >         size++; /* for \0 */
> >
> > @@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
> >                  jd->dir,
> >                  nspid,
> >                  jr->move.code_index);
> > +       /* snprintf returns would-be length on truncation, clamp to buffer */
> > +       if (size >= PATH_MAX)
> > +               size = PATH_MAX - 1;
> >
> >         size++; /* for \0 */
> >
> > --
> > 2.55.0
> >
