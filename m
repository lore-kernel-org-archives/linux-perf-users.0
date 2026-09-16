Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A54A7CB9;
	Wed, 16 Sep 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584154; cv=none; b=pkIjSbsVwIciTnJzUyMzJDpXPudfVOcQ2QzIz+Wq1u72sS1J/zqHtY2/4P+ZBGLr3EWMhBCtc6xHMoMbJB3qJ7edIpU9m2EQKa3pvWo2Bd933TofeflrNe8Pn9yPbKiBIB21G74Aj4M2e8EaIKPHM11d5EVLL/APmwZWaWPN/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584154; c=relaxed/simple;
	bh=7bh3nNgJbQQeHRZorZspKjhN8bcaKUUlFaPNrGyjImQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCt3YPAOlfEaaEPSCL3MOo4LXL4qDcWISATiV37fEc7EJhZpAsd0S9uRVqpop3Jd6n7qqvecC1GcwIjgu7eQU/b0yyK+3ElwCuwivgcFI5Ux6z3r3o2CMuZFNjg/ThkLUFLVI2YxI7c+uk49h5SpsacifwM2MtocjkTnJZ+1Zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXbnfihY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXbnfihY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBA1F000FF;
	Wed, 16 Sep 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584132;
	bh=YdmLW1HBPDmt3hkp/ixZNU+VKWfUfzbUM/zWZxSsHbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXbnfihYXJAIhQFCqmZ85umYmPinwmzwzLfa9k6sNfC+e535CAbuL+9NZc5mE/zMV
	 tt8Vf2dqBxQfJtZpW95mTWqZDNa6TS/grVGyzt0n0af/k60akKJ9dkgTS7qbdmftAJ
	 YZ2XRrB4joUfjX87drTFzzjp3nr6y9ydEqIkiKaXY7XJT1trORw48Gxw3UJFFmkx70
	 uDAkEe/3q4Dmb4c7iyZ3nY5pJM47ZRikanNK1H2DmTYb241JylfqaI7SJ5H1fmttQa
	 mXJ95cZJsgakwdTU7jntVPkgHdvRyK4LKP8/0qQbjqg8ZR10CbsjZk+jyvrexLM0+m
	 BzlGDolbFo4MQ==
Date: Wed, 16 Sep 2026 11:42:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Message-ID: <aqrjA6UCNId2Vebq@google.com>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-3-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916114740.48230-3-acme@kernel.org>

On Wed, Sep 16, 2026 at 08:47:29AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf already uses debuginfod to fetch source files when annotating
> (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> which queries debuginfo keyed by build ID when a module's debuginfo
> isn't found locally, largely the same thing this adds; eventually
> that one could be moved over to the new helper.  For the analysis
> tools there was no way to obtain the debuginfo for a DSO in a
> profile when it isn't available locally under the name the DSO was
> opened with, for instance the vmlinux for the kernel a profile was
> recorded on when processing it on another machine, or after the
> kernel and its debuginfo package got upgraded in between.
> 
> Add debuginfo__find_build_id(), that uses the debuginfod client to
> locate a debuginfo file keyed by the build ID, checking its local
> cache first and then querying the servers in DEBUGINFOD_URLS, and
> debuginfo__new_build_id(), that opens the DWARF in the file it finds.
> 
> The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
> what it wants is in its local cache, and the distro setup scripts that
> populate it from /etc/debuginfod don't reach cron jobs, systemd services
> and other environments that don't source the profile scripts, so also
> set it from the .urls files in /etc/debuginfod when not set.  That has
> to happen before any thread that can call getenv() is started, as
> setenv() is not thread safe, and there are getenv()s outside the fetch
> lock: libdebuginfod reads DEBUGINFOD_URLS in every debuginfod_begin(),
> which perf also does in build-id.c, probe-event.c and probe-finder.c,
> so do it from symbol__init(), on the single-threaded setup, and not
> lazily from the fetch path.

I think it's better to split the URL handling into a separate patch.
Also it seems we have "buildid-cache.debuginfod" config option.

Thanks,
Namhyung

> 
> Querying servers, possibly third party ones, sends off-box the build
> IDs of the binaries being analysed and a fetch can take a while, so
> this is opt-out: on by default, off with --no-debuginfod, with
> core.debuginfod=false, per tool with report.debuginfod and
> top.debuginfod, and, since users that set buildid.dir to /dev/null
> (e.g. Linus) or otherwise turn the local build-id cache off clearly
> don't want fetched files stored on the box, off too in that case.
> 
> The opt-outs also cover libdwfl's own debuginfod client, that reads
> DEBUGINFOD_URLS in every query: when debuginfod is off, be it with
> --no-debuginfod, core.debuginfod=false or by disabling the build-id
> cache, the variable is set to the empty string, that the client treats
> as an opt-out and fails the query without even looking at its cache,
> instead of being exported from /etc/debuginfod.  Tools that manage
> DEBUGINFOD_URLS themselves, such as 'perf record --debuginfod', keep
> doing so.
> 
> The fetches are serialized, as the lookup state they use is process
> global, so two concurrent fetches would race for it, and serializing
> also means that a request for a build ID that is being fetched doesn't
> start a second download of the same file: it waits for the fetch to
> finish and is answered from the entry the fetch published, keyed by the
> build ID, with the path of the file that came back, checked before
> being handed out in case the debuginfod client cache is cleaned from
> under us.
> 
> Make dso__debuginfo() use debuginfo__new_build_id() as a fallback,
> keyed by the build ID recorded in the perf.data file, so that
> consumers such as the data type profiler can resolve the types of
> DSOs whose debuginfo can be fetched this way.  Do the fetch outside
> dso__lock, a fetch from a remote debuginfod server can take a while
> and would otherwise block anything else using this dso, and remember
> the build IDs that were a miss, so that consumers revisiting a set of
> DSOs repeatedly, such as the data type profiler on every hist entry
> DSO switch, don't pay server round trips per attempt.
> 
> debuginfo__new_build_id() needs libdw to open the DWARF, so it lives
> in debuginfo.o, built only with CONFIG_LIBDW, while the libdebuginfod
> feature check is independent of NO_LIBDW; keep the new build ID
> prototypes under HAVE_LIBDW_SUPPORT too, with stubs otherwise, so
> that make NO_LIBDW=1 on a system that has the debuginfod client
> keeps linking.
> 
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
