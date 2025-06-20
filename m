Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C41862BB;
	Fri, 20 Jun 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451480; cv=none; b=L9D1y7TFcFv5NBoLtAF7vmP/yfEdDia8il8dtJlTRZF98RTe8m9AmrpX+Rk8l0RgmOUgdmfiFWk1hG5AOrhnIScabdOnuss+TF5fFH9ES03CK3oh2ZUF+zPCra954CFkn9Q6wbokmnDhZrjwyuJnvOT3/Qpga3LReZXWriDYQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451480; c=relaxed/simple;
	bh=z2CBDTFaNkEb8wXZSali4WmCkEEPu1SJGj4x57/JJe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2OuehXFM93gp+0heiyhS+CZ5xStz187xxAxzvEdtNJCGvmH7RlxjcmxF7AVOpDA0LLqm0UiPUc6HY/GiM1ssCxaRlNv+e8UsEc+L4m/jVKd8gwUa2jnCVa3TWVmIrryRls0XaR95ikXzIg3XDzmRUsFXwWasGCqqsHv2AWtSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apPZ2Q5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apPZ2Q5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA011C4CEE3;
	Fri, 20 Jun 2025 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750451480;
	bh=z2CBDTFaNkEb8wXZSali4WmCkEEPu1SJGj4x57/JJe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apPZ2Q5jFjH0lxby9i/X7QSLCPOpDSRFlLE7rAWY+2nPbuZgn4J7bAN2IHEgDhIWP
	 8Tl2wxoQds47Gq/UI88QSigXruXNSQdAeqhFzOQ+xfoZUdFhi73vsmnVuwv5ujY4n6
	 8nn8GSR1Zw8s94g5fOunAuOaU/zqtQiIBeqxr4XmQh8FSHRyXBy6aPG/sR3zisTjSe
	 NraUvpUq22U6tTpTOM7rqd2W5GBDbx+FEzsUcTdd6hmWdPkfIDZvDcTiVYFr5LfyYw
	 I8AF5ErTsq9OULYYa/y0gfob9zAL7nt4AbZ/VwDxwGFZOAZ8sO49DI7rLBCiaSZiLV
	 g3hs4RdkE/5pQ==
Date: Fri, 20 Jun 2025 13:31:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Set default GH modifier properly
Message-ID: <aFXFFktxXbV87lh2@google.com>
References: <20250606225431.2109754-1-namhyung@kernel.org>
 <CAP-5=fVoQXwFFdqY7ne0ZLJk+aTzm9knHqgVbvhJtb44doqe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVoQXwFFdqY7ne0ZLJk+aTzm9knHqgVbvhJtb44doqe-g@mail.gmail.com>

On Fri, Jun 06, 2025 at 04:50:13PM -0700, Ian Rogers wrote:
> On Fri, Jun 6, 2025 at 3:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Commit 7b100989b4f6bce7 ("perf evlist: Remove __evlist__add_default")
> > changed to use "cycles:P" as a default event.  But the problem is it
> > cannot set other default modifiers correctly.
> >
> > perf kvm needs to set attr.exclude_host by default but it didn't work
> > because of the logic in the parse_events__modifier_list().  Also the
> > exclude_GH_default was applied only if ":u" modifier was specified -
> > which is strange.  Move it out after handling the ":GH" and check
> > perf_host and perf_guest properly.
> >
> > Before:
> >   $ ./perf kvm record -vv true |& grep exclude
> >   (nothing)
> >
> > But specifying an event (without a modifier) works:
> >
> >   $ ./perf kvm record -vv -e cycles true |& grep exclude
> >     exclude_host                     1
> >
> > After:
> > It now works for the both cases:
> >
> >   $ ./perf kvm record -vv true |& grep exclude
> >     exclude_host                     1
> >
> >   $ ./perf kvm record -vv -e cycles true |& grep exclude
> >     exclude_host                     1
> >
> > Fixes: 35c8d21371e9b342 ("perf tools: Don't set attr.exclude_guest by default")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Code is more understandable than before and reads as correct.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!

> 
> Perhaps consider adding test coverage in tools/perf/tests/parse-events.c ?

Yep, will add it later.

Thanks,
Namhyung
 
> > ---
> >  tools/perf/util/parse-events.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 7f34e602fc080881..d1965a7b97ed6b97 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1830,13 +1830,11 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
> >                 int eH = group ? evsel->core.attr.exclude_host : 0;
> >                 int eG = group ? evsel->core.attr.exclude_guest : 0;
> >                 int exclude = eu | ek | eh;
> > -               int exclude_GH = group ? evsel->exclude_GH : 0;
> > +               int exclude_GH = eG | eH;
> >
> >                 if (mod.user) {
> >                         if (!exclude)
> >                                 exclude = eu = ek = eh = 1;
> > -                       if (!exclude_GH && !perf_guest && exclude_GH_default)
> > -                               eG = 1;
> >                         eu = 0;
> >                 }
> >                 if (mod.kernel) {
> > @@ -1859,6 +1857,13 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
> >                                 exclude_GH = eG = eH = 1;
> >                         eH = 0;
> >                 }
> > +               if (!exclude_GH && exclude_GH_default) {
> > +                       if (perf_host)
> > +                               eG = 1;
> > +                       else if (perf_guest)
> > +                               eH = 1;
> > +               }
> > +
> >                 evsel->core.attr.exclude_user   = eu;
> >                 evsel->core.attr.exclude_kernel = ek;
> >                 evsel->core.attr.exclude_hv     = eh;
> > --
> > 2.50.0.rc0.604.gd4ff7b7c86-goog
> >
