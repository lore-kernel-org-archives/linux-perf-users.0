Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8E3876C0;
	Mon, 12 Jan 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244182; cv=none; b=Yx6fmt3JY8GMpBScjYd78bnncUFttx/tGMMATUyvbjTfhkla3ZXeCiGgxNQbIwoHs1lmfWt/2pdMad3YJevR6cVha9E9H9ba3ik4QV29oUpUnrnys+I9Q/5HPk2Ymerd97fj7Gw/Yu9nQGdwFggED8YrZBBc9na6IEbkk7Lsz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244182; c=relaxed/simple;
	bh=10zbVmXh+AgSoutBMEQ95LDSxgXRm4CIbSnHOFJZa9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5SG56YVlcU8OdqlFWoe3TadEHeLeFycjRgHMczbaq4afM9M/SXjcmYa1hHJx1mXZqGifSoEaXCyRl3IVXzRG62CwOBDr0rmGrzT/4GoF8O2kb7TKTiUT+7x+WT5zqdSGnWmoEVRDRLvLXcV1Cycov0YsfQrNQXiaez0vTXar04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax/qc6SN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax/qc6SN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC1C116D0;
	Mon, 12 Jan 2026 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768244182;
	bh=10zbVmXh+AgSoutBMEQ95LDSxgXRm4CIbSnHOFJZa9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax/qc6SNUenHiiLHjRogO/9KPcBQ1qLPPqWkzrQYlV4cAfPwyY2w+oD8yZScNETOA
	 lqvCRWPSMKfdZf5+F0lnMBqpserfriuKjzM4cssSDR/mS/DLdBq+HGmQ810MzsH1eS
	 hkRJmn64skL43BF1vi2kyIIFqeBck+eDnJBsRUi2o6YW6LnyyKBjj/V5BBqtKkQ7iL
	 eK+SI8udOZKrulTZZQmQ0HfEOAPVzceOgSQ+pVDnLn6lfXJlnXao3iNVY3HIlgNdAG
	 ReNiMqH/eThVc1cnBXtpyxjcM+Y2KbTSAHpWYDO7ja1zbbRaERt4EkoQTUKlxxdv2J
	 B1WTbIj5u384g==
Date: Mon, 12 Jan 2026 15:56:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1] perf stat display: Make %f precision consistent
Message-ID: <aWVD0zctSqflXKdU@x1>
References: <20251209173610.2033973-1-irogers@google.com>
 <aThgIB2VQdAtEXKm@gmail.com>
 <CAP-5=fVf=Db9+9gxmfoRPDZvp_jz3bwG9FqLwAnKVHjaHbe4MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVf=Db9+9gxmfoRPDZvp_jz3bwG9FqLwAnKVHjaHbe4MQ@mail.gmail.com>

On Thu, Jan 08, 2026 at 11:25:17AM -0800, Ian Rogers wrote:
> On Tue, Dec 9, 2025 at 9:45 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Ian Rogers <irogers@google.com> wrote:
> >
> > > Commit bc22de9bcdb2 ("perf stat: Display time in precision based on
> > > std deviation") added multirun workload elapsed time. There was an
> > > effort to make the precision in the output most useful for the user,
> > > however, when gathering over runs it means the formatting varies. This
> > > change just makes the output format fixed.
> > >
> > > Before:
> > > ```
> > > $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
> > >           0.101140 +- 0.000149 seconds time elapsed  ( +-  0.15% )
> > >          0.1011396 +- 0.0000218 seconds time elapsed  ( +-  0.02% )
> > >           0.101331 +- 0.000124 seconds time elapsed  ( +-  0.12% )
> > > ^C
> > > $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
> > >           1.001317 +- 0.000146 seconds time elapsed  ( +-  0.01% )
> > >           1.001377 +- 0.000172 seconds time elapsed  ( +-  0.02% )
> > >            1.00253 +- 0.00131 seconds time elapsed  ( +-  0.13% )
> > > ```
> > >
> > > After:
> > > ```
> > > $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
> > >        0.101406408 +- 0.000064778 seconds time elapsed  ( +-  0.06% )
> > >        0.101367315 +- 0.000027253 seconds time elapsed  ( +-  0.03% )
> > >        0.101434164 +- 0.000084750 seconds time elapsed  ( +-  0.08% )
> > > ^C
> > > $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
> > >        1.001525467 +- 0.000051703 seconds time elapsed  ( +-  0.01% )
> > >        1.001375093 +- 0.000116200 seconds time elapsed  ( +-  0.01% )
> > >        1.001141025 +- 0.000046361 seconds time elapsed  ( +-  0.00% )
> >
> > Perfect, thank you!
> >
> > Tested-by: Ingo Molnar <mingo@kernel.org>
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo
