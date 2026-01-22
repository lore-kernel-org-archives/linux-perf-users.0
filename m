Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2B313554;
	Thu, 22 Jan 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044223; cv=none; b=njcAJ28DNplnq9eB8Kvuba80CNgsdmBy/FhbqcZhNEU/uAg+qzVCzjHy3VJyO4h+eJS0V8B6Q9pa2e1j/YienCrkXRs0LbvU5Tp5RnLDo435UryNtTYt0ydB6MGckfDf55Cv2Ie+X+VmcR/FIvJbC9juKmPxBRYs7XGlfC8fTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044223; c=relaxed/simple;
	bh=hrOHBakHr2eq48KDg5NIU00AjzRvKCXAg0ATc4N28Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdCVprzmePumlGrYrTsJXtcY63sOgSYMxFxQMsU367EZnL8FrJG7F8syYV92j5rlrftLYw9F33Fhgd1FAOxSEVBY3DZsih33e8WtYbwRiNNPDunXrChCD3pHdnh9ZRYhCVXx3Ipz5W45VXa4aQkjgzxA+eRCHQBC3rGLzqB/MEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJk0aAGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJk0aAGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DCFC4CEF1;
	Thu, 22 Jan 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769044222;
	bh=hrOHBakHr2eq48KDg5NIU00AjzRvKCXAg0ATc4N28Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJk0aAGKo72fPLjVJjj9KV69ekJm6Z6exCOQlaDVG+tV3RrqhtnmhLQHvKUFbx8Qr
	 JG0dR6mCQQJSvfQuXhuPGWLoNkOr5F9VUSlJdMI9q0mXxDGXIKPqvN14C+ZQoCSx+c
	 xdzrO0drSQRudkgp5jRWZb5uqX2KdhFZd2GlBQ/VUO+glW/iroEFfl8/66TmCEisyP
	 1CKaA6QgIUFx+MCpkX6OK6f0MG7Hi3BTPuimBJTJitckQVKS1UrA+JYwz/34Ej85ab
	 74ZpKvbr3DqlgAqA+/CZ41PA8Yt3iNj1Y1aJcgzA/99MdHnjW1MIpzoqP2rEOv3zEI
	 13/77o56YDydw==
Date: Wed, 21 Jan 2026 22:10:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
Message-ID: <aXF4-vLA9DvhsPdc@x1>
References: <20260120220900.366451-1-acme@kernel.org>
 <20260120220900.366451-4-acme@kernel.org>
 <20260121221713.1e7e0cf9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121221713.1e7e0cf9@pumpkin>

On Wed, Jan 21, 2026 at 10:17:13PM +0000, David Laight wrote:
> On Tue, 20 Jan 2026 19:08:59 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Something now detected on fedora 44, where strchr() returns const if it
> > is passed a const pointer:
> > 
> >   util/print-events.c: In function 'print_sdt_events':
> >   util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> >      89 |                 char *bid = strchr(sdt_name->s, '@');
> >         |                             ^~~~~~
> > 
> > Fix it by using strnchr() if strchr finds the separator instead of
> > temporarily scrubbing it with '\0'.
> 
> I've just looked at the full function to see WTF it is doing.
> You've fixed the second strchr() not the one the compiler bleated about.

It complained about both, no?

> Line 89 is followed by:
> 	if (bid)
> 		*bid++ = 0;
> but if it is NULL there is a fair chance the code will just explode a bit later on.

Why, can you elaborate?

> I suspect it is an error if the strings aren't "name@bar"
 
> 'show_detail' seems to be set if either the previous or next entries in the
> list/tree have the same "name" - which seems strange to me.

All this is strange, a corner case, it looks as if we may have multiple
binaries, differentiated by buildids, that would have different SDTs.

The code seems to be trying to reduce the amount of info (not showing
the buildid if there are no more at that point multiple versions of a
DSO with SDTs in place).

Further analysis of the changesets that put all this in place is needed
to clarify, but looking just at fixing what the compiler is complaining,
do you think the patches are bad?

- Arnaldo
 
> The while thing needs more work :-(
> 
> 	David
> 
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/print-events.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> > index 8f3ed83853a9e468..898cf426509790cd 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
> >  		} else {
> >  			next_sdt_name = strlist__next(sdt_name);
> >  			if (next_sdt_name) {
> > -				char *bid2 = strchr(next_sdt_name->s, '@');
> > -
> > -				if (bid2)
> > -					*bid2 = '\0';
> > -				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
> > -					show_detail = true;
> > -				if (bid2)
> > -					*bid2 = '@';
> > +				const char *bid2 = strchr(next_sdt_name->s, '@');
> > +
> > +				show_detail = bid2 ?
> > +						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
> > +						strcmp(sdt_name->s, next_sdt_name->s) == 0;
> >  			}
> >  		}
> >  		last_sdt_name = sdt_name->s;
