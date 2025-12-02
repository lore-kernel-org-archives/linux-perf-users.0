Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4F2C21C1;
	Tue,  2 Dec 2025 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710783; cv=none; b=rnPBeozDLPJqiSn2RShgzCrhqKE3BPYAfy1ItgSpJK7vJ0Oev/mczPLYU9frLEJ/fsdVu+5+eGu8h4dScdYjlmF1ra3e+eheNfIYw1194f0rwOMTqyrmOkvJJ1aZWF64XfGrgOgXjZxBmOstu0U0e7Dg4Lx3htkbXgPwZ9u81X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710783; c=relaxed/simple;
	bh=lzbCcolJw3gbpFNtY05e0rIhyPbenmMDafbBKzZ+KWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FukIZ16Q6HaCDoQhsAUo5ko+Li8oXQLZyQ9TlDW8NQCPDQtXCLbFjSUCNg1uQPkPt2tx1IOYSxLDPOQbv9Jr8xM1QRed+bJoxx4QZWMv3sVGSsqGEw9yE71PjXmB+5kBxAZol9C72dBsuh/9XiRZl7X1wdtVrcUCL6r2OKQXBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU/Bye8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU/Bye8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F5AC4CEF1;
	Tue,  2 Dec 2025 21:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710783;
	bh=lzbCcolJw3gbpFNtY05e0rIhyPbenmMDafbBKzZ+KWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU/Bye8txHMeigrCia4db6f2rFdXhZ0D5SFhps7DdP/+qY0nFntPscPL0Sgo/vnie
	 KcHwE6uOiTJbk6bNN3gFZyED/IVpHZNftRVytP7wB5vaR/aOOUVvyudNwJRuwCkPnX
	 0Wy7mG4w1GZZerd0wcOWVvm41gPtctURlWkN5Q9W6kOOPx48kAMMa9PY2kOhDs3LWb
	 LUZq37bBNplOYaDIXRJ4WU9SFJb6zYK5mvAuEl1Lavs16eQpF57DodGZMt/ZhdzwU4
	 6VkMuwizJTRo0/obnqE3DtJ4V4W4/RHAlpaFNL9+SfpjnMWVZw4h7tbkZViVtMR4tv
	 LXLAE7Bkb6ohQ==
Date: Tue, 2 Dec 2025 13:26:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/5] perf tools: Use machine->root_dir to find
 /proc/kallsyms
Message-ID: <aS9ZfAd3CDh5wboJ@google.com>
References: <20251202081645.931527-1-namhyung@kernel.org>
 <20251202081645.931527-5-namhyung@kernel.org>
 <CAP-5=fXWwQjdAQHNxVoz1=AF83g75Yd=L32owxCfyiXKL+mVeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXWwQjdAQHNxVoz1=AF83g75Yd=L32owxCfyiXKL+mVeA@mail.gmail.com>

On Tue, Dec 02, 2025 at 12:53:48PM -0800, Ian Rogers wrote:
> On Tue, Dec 2, 2025 at 12:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > This is for test functions to find the kallsyms correctly.  It can find
> > the machine from the kernel maps and use its root_dir.  This is helpful
> > to setup fake /proc directory for testing.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/symbol.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index b533fbf17a8b19a3..e90ecfd286043aa4 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2002,6 +2002,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
> >         char sbuild_id[SBUILD_ID_SIZE];
> >         bool is_host = false;
> >         char path[PATH_MAX];
> > +       struct kmap *kmap = map__kmap(map);
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> nit: perhaps just use map__kmaps here to avoid testing two values below.

Right, will update.  Thanks for your review!
Namhyung
 
> >
> >         if (!dso__has_build_id(dso)) {
> >                 /*
> > @@ -2038,8 +2039,13 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
> >                 return strdup(path);
> >
> >         /* Use current /proc/kallsyms if possible */
> > -       if (is_host) {
> >  proc_kallsyms:
> > +       if (kmap && kmap->kmaps) {
> > +               struct machine *machine = maps__machine(kmap->kmaps);
> > +
> > +               scnprintf(path, sizeof(path), "%s/proc/kallsyms", machine->root_dir);
> > +               return strdup(path);
> > +       } else if (is_host) {
> >                 return strdup("/proc/kallsyms");
> >         }
> >
> > --
> > 2.52.0.158.g65b55ccf14-goog
> >
