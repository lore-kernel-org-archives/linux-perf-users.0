Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9221FF35;
	Thu,  2 Oct 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420010; cv=none; b=dMCSvWbjbduEo7IDuTnJTNK/SawdGuhOFW/T0TVpO3sZwOPRxUhxaO3qXbvTabzJGKOC8yW5gSADGeSJi3WOT0LXclOV5FZjfmODTMgEqsu1rK6e++CltOT/zW01qhWRexLLIHaXAaoJL2NXMX7JY2CQ8gW6HNgGzmMW53O6QpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420010; c=relaxed/simple;
	bh=vTByBXfCKWKL4w/SkIWsVQzLzQmBKq+SHLl0fRsPJ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REvLOhNdiJRL00gJS/3gD8vD69MAgiwf3mVjH6PJAMcSmE8fSiCbZiBlUj4OiWzl1QK2QMCnMV49aCiCH2jhjPqZ88DsCtSkRxOmQf7N3lGFr3UQAeaRAhPqY3p2mr3p6OlXO7inLUX5GqWxV4c6vqhmUwq6QGD2b+/OMlxMcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGvL2RMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGvL2RMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A01C4CEF4;
	Thu,  2 Oct 2025 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759420009;
	bh=vTByBXfCKWKL4w/SkIWsVQzLzQmBKq+SHLl0fRsPJ/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGvL2RMfwMtPU841O7bgzbDTW/GNSudWMtpYgDq1vvF1SyfwThZjIyZ73P37qwxyd
	 8Wg6xmxXTpfKlI1UOqRShEBlnanuSzrDGCW9DbtKzzYQMmuikf9O14oCc8sZyq5TQV
	 JA/D3C1kkqDIOvBvlgyEjAcNn/aCc+2DdbtNi1wVT+ErtyxHvWQIHmdzWcVgktzYcM
	 ZxikXwyzaUfHl/2/xKnNGVfFB1mH5iOt4/RV7QIXGb/MCzbpivd6GxYMEAWt82gPr0
	 d9Ga1LiWSrjUJc0r7zXk0XUmEqMFGwIjO5rvBJwhQJHL97PUfOUKLUiBEuJkw26VhQ
	 JL4g/yyFQMIcQ==
Date: Thu, 2 Oct 2025 12:46:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always
 available
Message-ID: <aN6eZby8fc8PyClB@x1>
References: <aN54leQ54ozcUXBO@x1>
 <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
 <CAP-5=fUfBzUTOJG7t7nwvZkcf+LKVakGnNqgVLSW8CjsLxFkDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUfBzUTOJG7t7nwvZkcf+LKVakGnNqgVLSW8CjsLxFkDw@mail.gmail.com>

On Thu, Oct 02, 2025 at 08:21:08AM -0700, Ian Rogers wrote:
> On Thu, Oct 2, 2025 at 7:13 AM Tomas Glozar <tglozar@redhat.com> wrote:
> >
> > čt 2. 10. 2025 v 15:05 odesílatel Arnaldo Carvalho de Melo
> > <acme@kernel.org> napsal:
> > >
> > > perf doesn't use libtracefs and so it doesn't make sense to assume it is
> > > always available when building test-all.bin, defeating the feature check
> > > speedup it provides.
> > >
> > > The other tools/build/ users such as rtla, rv, etc call $(feature_check
> > > libtracefs) to check its availability instead of using the test-all.bin
> > > mechanism, stopping the build and asking for libtracefs-devel to be
> > > installed.
> > >
> > > Noticed after applying Ian Roger's removal unused libtracefs
> > > configuration in tools/perf/.
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Gabriele Monaco <gmonaco@redhat.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tomas Glozar <tglozar@redhat.com>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Acked-by: Tomas Glozar <tglozar@redhat.com>
> >
> > Perhaps it would also make sense to clarify in a comment that
> > test-all.c is to speed up perf build rather than rv, rtla etc. (which
> > don't use most of the dependencies listed there)?
> 
> There's a big comment in Makefile.feature:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/build/Makefile.feature#n24
> I think that FEATURE_TESTS_BASIC tests are covered by test-all.c so I
> think this change needs to remove libtracefs from FEATURE_TESTS_BASIC
> otherwise  $(feature-libtracefs) will evaluate to 1 even though no
> libtracefs testing has been performed.

Done, thanks for catching this.

> We can't just remove the tracefs feature test as there are
> dependencies in rv, rtla, etc.

And those, as noted, don't rely on test-all.bin to detect the presence
of libtracefs:

⬢ [acme@toolbx perf-tools-next]$ git grep feature.*libtracefs tools/
tools/tracing/latency/Makefile.config:$(call feature_check,libtracefs)
tools/tracing/latency/Makefile.config:ifeq ($(feature-libtracefs), 1)
tools/tracing/rtla/Makefile.config:$(call feature_check,libtracefs)
tools/tracing/rtla/Makefile.config:ifeq ($(feature-libtracefs), 1)
tools/verification/rv/Makefile.config:$(call feature_check,libtracefs)
tools/verification/rv/Makefile.config:ifeq ($(feature-libtracefs), 1)
⬢ [acme@toolbx perf-tools-next]$

Can I have your Reviewed-by or Acked-by?

Thanks,

- Arnaldo
