Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469515B97E;
	Wed, 23 Oct 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720017; cv=none; b=BK428aaYZwV7C2mP3Pm2gHg6RJaFhJtaPqmzU4BRSNeDUmZ1q3ln9TZ77kGYGrSEIKNhZLNrPkni6u+LjNOA6FOWzBm9+03QQWXAH8FCWBuj8nE0EwQs2j13ZAS0OnYvLdk20oAkOSe9m51Rpum7NaU5B2CZ0IrQ0O4dLK1tvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720017; c=relaxed/simple;
	bh=gZB4nODnmHdyZKrCUN/l8MegW/xwB7TdOC4Vl1hL4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAMAkZ/ahgpF47xOh2ArPhXBrOOR16RoLuZhHOAudO0WVKWw64mAIrbjZC8DuhC3Ck7XB6ZYoyW6fsh0JepM0tspqYJs1yG6zSQ+wqUhRr2A90adI8g9SZHv5hEmcVZXLYln2AAAnTZKJST1B6D484eZDwTEvxSCjWUZwhXqaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOXE4W5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOXE4W5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E1C4CEC6;
	Wed, 23 Oct 2024 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720016;
	bh=gZB4nODnmHdyZKrCUN/l8MegW/xwB7TdOC4Vl1hL4xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOXE4W5b+rh27pgcy+Vduawz9jqRHTvvy2h5MbB8Lbhjet0mDpLmru+slbZ+e8qcy
	 5Fw5J5MwJzZCywz58qe78sSBnRqi5ep5ShWlYq4/zqg57BOFec3hOnF218NUDP1TIH
	 Pllf+V+AL28wmPZgWkoLrTudaZhabfpbsF9DN21fCVnyDVAUiidGvp/D8bzaaRbNU0
	 Fir5rs/CudRWMdqxnZefG85lxRggI5BzARQOLUZ17X6ZchNjeLNk/VCgO3e/Zzl7qI
	 0PbcDtlaFvy7wH+cW4S+jXEkUuOOQkH0Orquh7f0XZY2lhAGUa1GndV5U4+31MeF2s
	 0X6waqinw4y5w==
Date: Wed, 23 Oct 2024 18:46:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
Message-ID: <ZxluzQ3wN1aTcEXt@x1>
References: <ZxllAtpmEw5fg9oy@x1>
 <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>

On Wed, Oct 23, 2024 at 02:40:45PM -0700, Ian Rogers wrote:
> On Wed, Oct 23, 2024 at 2:05 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Noticed while building on a raspbian arm 32-bit system.
> >
> > There was also this other case, fixed by adding a missing util/stat.h
> > with the prototypes:
> >
> >   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1396:6: error: no previous prototype for ‘perf_stat__set_no_csv_summary’ [-Werror=missing-prototypes]
> >    1396 | void perf_stat__set_no_csv_summary(int set __maybe_unused)
> >         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1400:6: error: no previous prototype for ‘perf_stat__set_big_num’ [-Werror=missing-prototypes]
> >    1400 | void perf_stat__set_big_num(int set __maybe_unused)
> >         |      ^~~~~~~~~~~~~~~~~~~~~~
> >   cc1: all warnings being treated as errors
> >
> > In other architectures this must be building due to some lucky indirect
> > inclusion of that header.
> >
> > Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libraries from building source")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> So this will at least conflict with:
> https://lore.kernel.org/lkml/20241022173015.437550-6-irogers@google.com/
> where the #ifdef-ed out functions are removed. Does that series fix
> the ARM32 issue? Could we land that?

I'd prefer to have what I posted for perf-tools, as it is smaller, and
to land the patch removing those functions on perf-tools-next.

I'll try to switch testing to a librecomputer board, the rpi3 is super
slow :-)

Thanks,

- Arnaldo
