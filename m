Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D541DC1AB;
	Mon, 28 Jul 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728247; cv=none; b=SGM0Q4Ira9ssS5XRJBQgmvtBfhpgmJ2TMthC40HxnH1Z5xV9kbURS8dTzLhC3dCZZLBuqj9MS11Ir02PAfCE0dmMCHdWA1SrOko72a5QGGfh3r8DfNbyr/GTwuW8zvQICBMv/ad7LfnYpTxiHtzYBhVmnCzZrq6qqW8mFQXoLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728247; c=relaxed/simple;
	bh=HMiNWszKPFxlJnq/c0XE4CkHijpzQunzfLGbsLOK6js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ldB4g7K5OnGVZIXqeiIzmZQrv5g5bXWWxKc5mzAdvUZ/5rO0LdBXF++qv+gMnEM6/kGet9EdyvliWhfAGX3F6199Bs1OHWl473ojrJ29DwjdrfF6AMpceVWvIH8iNIK8aKupBJceu3V+Rs7j4md0+nC6mfWIiUAPjTX/4d9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bThxI2Bs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bThxI2Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F1AC4CEE7;
	Mon, 28 Jul 2025 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728246;
	bh=HMiNWszKPFxlJnq/c0XE4CkHijpzQunzfLGbsLOK6js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bThxI2BseDzqW8lKXV6+4ASzHNoxp/iW6NVCcGsKOMe0kvY8gIKJHuG6cGXpmNYal
	 GZ39uW+Enjb7muoQQ9d4b5fywP6Wl5oDhDHnJ0cwN60AkwzM0vj35qan2K90UiUP0X
	 zmy7LjJLSOfC/sITiru8kPyhM3RWK/nWxl5xg3Rv0oTtMEEvBZu68rTA/HmN1PoHRE
	 XZ3AFGx6mkZo4bFgqxJ/hx/nlQzbntC93xh2/US4vYk131Ru531XoUXDflLXHiYQhL
	 6q5qgS0Z4FLk7mxEeuC0MhaiiZmnQYJKWMeYuKdOUSVVNr1PEOf5OX26siBAzP5V/u
	 Diqydf8WqsurA==
Date: Mon, 28 Jul 2025 11:44:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 3/9] perf annotate: Pass annotation_print_data to
 annotation_line__write()
Message-ID: <aIfE9VWrRzPJD314@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-4-namhyung@kernel.org>
 <CAP-5=fXUyA=kgTTMDUmeOF9hURhQQxfYOFk5_HZEkQsdh7QqSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXUyA=kgTTMDUmeOF9hURhQQxfYOFk5_HZEkQsdh7QqSg@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:23:00PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
[SNIP]
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index 0f640e4871744262..8fad464a870a2b8e 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -199,8 +199,18 @@ struct annotation_write_ops {
> >         void (*write_graph)(void *obj, int graph);
> >  };
> >
> > +struct annotation_print_data {
> > +       struct hist_entry *he;
> > +       struct evsel *evsel;
> > +       struct arch *arch;
> > +       struct debuginfo *dbg;
> > +       u64 start;
> > +       int addr_fmt_width;
> > +};
> 
> nit: As the scope of this is now global, is it worth commenting it?
> For example, where is start relative to?

Sure, I'll add comments.

> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Namhyung

