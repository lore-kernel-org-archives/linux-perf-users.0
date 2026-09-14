Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538791A9F97;
	Mon, 14 Sep 2026 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349687; cv=none; b=o4a43mGxreYocT124VeV9UAXj9Z4ub7sal2Wfx2iUm0tGOxTL6CCOp1SbAi8KR2EyaHTMzY0FD0CUAL/J+pmuJM5eOR7vXM0oAAudkLNhibzI6i9XSP5VvmKP0hZCaOISMp6G545YHbWHBztS/BDciWmb4yRi+KflHdfiMliLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349687; c=relaxed/simple;
	bh=XJT/lYfe0AwnsxomWOLm3ztk0tUYFH7ZjSabGVGsxFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnntQeLh/BTPg5jpSiaqozKIUtKfFc0vuxwZu4E4I2bVZjMH/WSYDX0ZmufQa9g4NL1BDU2tiST5ppbaxfh+SJC1ZOUka0OZbkj/AREPvgJTDF1X8UjCht7L6lLbm4oQn09IjDzwf5MOSKeSns6N+fsS5Ol/VlvAsIfzTgV4hFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj43aCWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj43aCWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20531F00893;
	Mon, 14 Sep 2026 01:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789349686;
	bh=+is87NApxduqbcdoN/S/oLEQPywvyp1ZlMkRNBz2270=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kj43aCWUyVUcvYkXdDMB7Qlo1ntGWZqICuScW6bHviadRNBnbNZT0rW7WlRU9u4kU
	 7DUpUNLgduZnXFcZuoee4bq0yXAXdrr0oosrNszfzdhABn7fgY8FSJu17GOQL/dxvG
	 kjYeY6WkR5JsrUYG15rb0uuhCaojU8M645cQF0PBUiiZ0zwu8x0OjQTeMj7vw19RlK
	 6ETaGFXD2kPuTuhrzaEFIpCzol4x+pVpKOohmpoVzNwyNGmbfj4XlI70VtrS0dXEXb
	 M6n12kPJKl/FHxdQEDRjpBxonq0b1Ybw8TrbgfB5JWBG2uVb7R7tvEddD8GSpJO5bK
	 BAn2scO/SKSNg==
Date: Sun, 13 Sep 2026 18:34:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/8] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Message-ID: <aqdPNG6szS6YJjOi@google.com>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-3-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913222821.3353-3-acme@kernel.org>

On Sun, Sep 13, 2026 at 07:28:14PM -0300, Arnaldo Carvalho de Melo wrote:
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
> set it from the .urls files in /etc/debuginfod when not set.
> 
> Querying servers, possibly third party ones, sends off-box the build
> IDs of the binaries being analysed and a fetch can take a while, so
> this is opt-out: on by default, off with --no-debuginfod, with
> core.debuginfod=false, per tool with report.debuginfod and
> top.debuginfod, and, since users that set buildid.dir to /dev/null
> (e.g. Linus) or otherwise turn the local build-id cache off clearly
> don't want fetched files stored on the box, off too in that case.
> 
> When a fetch is in progress in a terminal, stdio, the way it prints
> progress is how one gets out of it: 's' aborts the current fetch via
> the debuginfod client's progress callback protocol and remembers the
> build ID, so that the rest of the session doesn't ask for it again,
> the user may have skipped it for being too big; 'd' additionally
> disables debuginfod for the rest of the session and points at 'perf
> config core.debuginfod=false' to make that permanent -- rewriting the
> user's ~/.perfconfig from a keypress would silently drop its comments
> -- and SIGINT/SIGTERM are intercepted while the terminal is in raw
> mode, so that it is restored and the signal is re-raised when the user
> interrupts a fetch.
> 
> Make dso__debuginfo() use debuginfo__new_build_id() as a fallback,
> keyed by the build ID recorded in the perf.data file, so that
> consumers such as the data type profiler can resolve the types of
> DSOs whose debuginfo can be fetched this way.  Do the fetch outside
> dso__lock and remember the build IDs that were a miss and the ones
> whose search the user cancelled, so that consumers revisiting a set
> of DSOs repeatedly, such as the data type profiler on every hist
> entry DSO switch, don't pay server round trips per attempt and a
> cancelled download, maybe a file the user found too big, isn't
> restarted by the next request for the same build ID in the same
> session.
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
> ---
[SNIP] 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 4638e6fdc39bb6b7..d14ae7d1c345cb79 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -733,6 +733,8 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
>                      "don't load vmlinux even if found"),
> +	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> +                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),

I'm not sure what would be the good default.  But with this, it can slow
down the process especially when the binary is not in the debuginfod.

Thanks,
Namhyung


>  	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
