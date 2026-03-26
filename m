Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13252DF707;
	Thu, 26 Mar 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563427; cv=none; b=ojCQ3eNIEmTnJB654INHKh91l9UaZ711JWLZ44CkIt+b+TIu+2+XbzB/061T9vTJ4Ic6/A7AOZoO63Lg4tv//4lXKDtzW6D3AaMc0QmKoVjEtFmY0tpdbiCAwntcWV+99vd66XcpzyNCQrOXTjFNnZjgO4edBS9YG2CTLofe1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563427; c=relaxed/simple;
	bh=0Pwt+rO6OsFNN5h5KMkxEfyuwSQF+emiQKruEarJj0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7jRglFUI35N1whkratUKUWGCmFvRuI4di8rucB7V73QD4eYDWCrfvHS97CnxVsOr9LW+JPS0zHvjJwhQxxoy4wZeTFJH3tj0raq1oW3nfby99p8tsfdto+nTD0O+TLo6UVorjDPiitNJN/bmX3COkOin+9c3tzyadBNqwxpE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6GB4skY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6GB4skY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8A4C116C6;
	Thu, 26 Mar 2026 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774563427;
	bh=0Pwt+rO6OsFNN5h5KMkxEfyuwSQF+emiQKruEarJj0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6GB4skYj4JeICc0QmDD9guUtkiv5/feswjTmRm+67sjHMpPNuJUeEZGwCuD+XyYO
	 mFOqwMEiRFwBQ9RJaleYZrVJh+DQjeMqRaDmLwnAsYOYlXzzGJN1opKy02SfUIBn5y
	 9tchyL5sUIE/DYfY+zZImWrtfLZknuhac2Q8ihKVgwFnEx6OpGw+aEf1ddaLO4hlrP
	 0Em+oZXveKDz4JViSO6/gT4OMxAaUqXgRsKarx+/nEMseM9E3U1t3kgt7TT0LiRe89
	 sHGtqCOTaCnKNzc2zuCDUpDX0NnQPKMG37uUyWD8SKM0gH/OIgvP8vkFueERb+e9B0
	 eczi3UhNK8LbA==
Date: Thu, 26 Mar 2026 15:17:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
Message-ID: <acWwYcn3QAznaw4x@google.com>
References: <20260306191908.2065682-1-irogers@google.com>
 <CAP-5=fUWOKFwHZKYUv3ntxaPb1aFEEmSdo4npfe9oG3EPn7qBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUWOKFwHZKYUv3ntxaPb1aFEEmSdo4npfe9oG3EPn7qBA@mail.gmail.com>

On Fri, Mar 20, 2026 at 04:00:56PM -0700, Ian Rogers wrote:
> On Fri, Mar 6, 2026 at 11:19 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
> > chars unsigned by default in the Linux kernel. To avoid similar kinds
> > of bugs and warnings, make unsigned chars the default for the perf tool.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>

Do you know what the actual bug was?

Thanks,
Namhyung

> 
> > ---
> >  tools/perf/Makefile.config | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a8dc72cfe48e..3820bdf73f43 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -349,6 +349,7 @@ CORE_CFLAGS += -fno-omit-frame-pointer
> >  CORE_CFLAGS += -Wall
> >  CORE_CFLAGS += -Wextra
> >  CORE_CFLAGS += -std=gnu11
> > +CORE_CFLAGS += -funsigned-char
> >
> >  CXXFLAGS += -std=gnu++17 -fno-exceptions -fno-rtti
> >  CXXFLAGS += -Wall
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
