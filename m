Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D24218AB9;
	Fri,  5 Dec 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969530; cv=none; b=fk63TpprZp1LwCrhntjvymJxWSIf8AnSRuruXqO4LPeVT38AtUvxHLsv9n6DuZFojbpd6lNHFrN+LXMA9iyADKBwkRFWxd+lSafkDcvZ9kvrWlS6m+DYXH1J8LtbpjvT88cGaTk9QlRjs/VIXEf4EGP2x4bhvEh6WXLw9mn/adY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969530; c=relaxed/simple;
	bh=SXB30LyP0LGkVRol0MG5YPtGUqVHkoYrdVPNUC1XVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPQcxDdMObvVcG9w/eTSu1APAR6meTer7OqpTcYJenONfLWhQtzUB/Zt68DRRum5Mcg9klRat8DQ7NgVV6TERYVMJYHyGoJZXhjieV8DPIcxvJbWaEtTFwm8gPanWli/vDOGO0JnTn0u/4hE6V4v404SSFUkDsOLmQPkNL1l+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eETYfGiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eETYfGiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06D4C4CEF1;
	Fri,  5 Dec 2025 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764969530;
	bh=SXB30LyP0LGkVRol0MG5YPtGUqVHkoYrdVPNUC1XVWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eETYfGiExS0Nby03XAR67pggOaB4aTW+1OEnBCuCW3FqnM1tvco87u/rnUpR6gOjB
	 qb1vwe1udXOutLYhb8YZr+65xfS4WInplgVauJi8K6Ui0bssHe4GAzhKlOUiYWXKK0
	 5ybtnyXbT8mnObOdRb+ElINlbE0hIdmm2eT7z6WGEP7/O3lJfgf2HqoCCVks4rA7Ha
	 iONCdFyqrFYS8W4cV33qcTLkzQUHxwOWUYtR9qRrLSOj0JFoExABDskzYoVMZTkFwM
	 jCS6H3LjwDPE03r2QPny+ay5ECgs4HVF1HPA87yuaIstjekhSaAN24uKGQqWOTeA7q
	 cyCERb54pKkfA==
Date: Fri, 5 Dec 2025 13:18:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Athira Rajeev <atrajeev@linux.ibm.com>,
	tanze <tanze@kylinos.cn>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 10/10] perf symbol: Fix ENOENT case for
 filename__read_build_id
Message-ID: <aTNMNt4wIZJ0q_lR@google.com>
References: <20251201205509.195451-1-irogers@google.com>
 <20251201205509.195451-11-irogers@google.com>
 <CAP-5=fWe-Aax42D_9goaX3e-QFpSQBagqWh6ZD+JgLkrMLSe8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWe-Aax42D_9goaX3e-QFpSQBagqWh6ZD+JgLkrMLSe8w@mail.gmail.com>

Hi Ian,

On Fri, Dec 05, 2025 at 11:40:12AM -0800, Ian Rogers wrote:
> On Mon, Dec 1, 2025 at 12:55 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Some callers of filename__read_build_id assume the error value must be
> > -1, fix by making them handle all < 0 values.
> >
> > If is_regular_file fails in filename__read_build_id then it could be
> > the file is missing (ENOENT) and it would be wrong to return
> > -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> > reported if other errors with stat haven't occurred.
> >
> > Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular files")
> 
> We might want to prioritize this fix.

Sure.

> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-buildid-cache.c | 6 ++++--
> >  tools/perf/util/symbol.c           | 3 ++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> > index c98104481c8a..539e779e3268 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
> >  {
> >         char filename[PATH_MAX];
> >         struct build_id bid = { .size = 0, };
> > +       int err;
> >
> >         if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
> >                 return true;
> >
> > -       if (filename__read_build_id(filename, &bid) == -1) {
> 
> This check here is clearly wrong when -EWOULDBLOCK is returned from
> James' change.
> 
> > -               if (errno == ENOENT)
> > +       err = filename__read_build_id(filename, &bid);
> > +       if (err < 0) {
> > +               if (err == -ENOENT)
> >                         return false;
> >
> >                 pr_warning("Problems with %s file, consider removing it from the cache\n",
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 76dc5b70350a..f43e30019e21 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2008,8 +2008,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
> >         if (!filename)
> >                 return -EFAULT;
> >
> > +       errno = 0;
> >         if (!is_regular_file(filename))
> > -               return -EWOULDBLOCK;
> > +               return errno == 0 ? -EWOULDBLOCK : -errno;
> 
> I've made the fix after the other changes as it is simpler to fix in
> one filename__read_build_id rather than all the libbfd, .. variants.
> If we don't want the series in the short-term perhaps we still want to
> carry some parts of this fix.

Yeah, I hesitate to merge a big series at this moment unless it's a
critical and obvious fix.  Can you please separate this change and send
it out?

Thanks,
Namhyung


> 
> >
> >         err = kmod_path__parse(&m, filename);
> >         if (err)
> > --
> > 2.52.0.158.g65b55ccf14-goog
> >
