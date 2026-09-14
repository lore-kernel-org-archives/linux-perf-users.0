Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8224CEEA;
	Mon, 14 Sep 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350673; cv=none; b=suFuWsyPBw7i8E+p5FuO28AriK+37lUWu+Wq4cwULe2Fx05EkEtyGoCz9lmh83oED9MqtRaoyF5UEVRU57NVK0QUWGs4ds5+tsMYMwYFS8ovDyIP7HWXa3sgKECGtSFBngXUiLe89sRXn2f4yx4w1nZfsY9XmrMMCOWhq+m0yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350673; c=relaxed/simple;
	bh=KdlsEklJ5vdbA8EoEXv0S+x0JlBDMmeMJMOIe1vRhdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPTrd3XS5RZJsU/LefzRGuCDN2FfMaOF9ll/U4jv8bjqIXq+95hqYR/5BB+yv3NvmQWdeG+XGn7FcADmQHbk3E6YwftD7hx9MmqlGp04jaFIB/PpfMgAO0rKTT/0UtPs0usTcInM8TqflRV3QGNbcbKA6juPOYynvyI7L/6H/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHdDZy0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHdDZy0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3DC1F000FF;
	Mon, 14 Sep 2026 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350671;
	bh=FkGggBiNEoM4E05N7m+fXcki4JXWmzxjF3H2CMCLEyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CHdDZy0P3gO7KhO56PXUCsnUzWugSnmXAAgELRmp7IA8BHEtglemlULn241W6Kw6J
	 8/G6iM8HZrhiqw2u7vP9zKw7EAhz1BgWFlFVYXekE8BaSobFyeof8gtZmRNzkyiyyJ
	 WXipdshnSc745wJvbGBt+K6wCitAPx9DuZDQTohubKlfEE1v7raKI8RDkM0/Zgu0Br
	 eOy4VKE8bLVlxhrfJoW4gImSoFywDAYEtYbHKlyzbuLTqxwnNZOX1WYakdzTTVwyQ9
	 FWc3GwSdt95wZk7RUvOisi8emFnftk1MeS9uqDxI8g6O7o7W5u5pzV0LgqTY91DI5E
	 XWObAHikjlo5Q==
Date: Sun, 13 Sep 2026 22:51:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/8] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Message-ID: <aqdTC_3In8ymE-RS@x2>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-3-acme@kernel.org>
 <aqdPNG6szS6YJjOi@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqdPNG6szS6YJjOi@google.com>

On Sun, Sep 13, 2026 at 06:34:44PM -0700, Namhyung Kim wrote:
> On Sun, Sep 13, 2026 at 07:28:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>

<SNIP>

> > Querying servers, possibly third party ones, sends off-box the build
> > IDs of the binaries being analysed and a fetch can take a while, so
> > this is opt-out: on by default, off with --no-debuginfod, with
> > core.debuginfod=false, per tool with report.debuginfod and
> > top.debuginfod, and, since users that set buildid.dir to /dev/null
> > (e.g. Linus) or otherwise turn the local build-id cache off clearly
> > don't want fetched files stored on the box, off too in that case.
> > 
> > When a fetch is in progress in a terminal, stdio, the way it prints
> > progress is how one gets out of it: 's' aborts the current fetch via
> > the debuginfod client's progress callback protocol and remembers the
> > build ID, so that the rest of the session doesn't ask for it again,
> > the user may have skipped it for being too big; 'd' additionally
> > disables debuginfod for the rest of the session and points at 'perf
> > config core.debuginfod=false' to make that permanent -- rewriting the
> > user's ~/.perfconfig from a keypress would silently drop its comments
> > -- and SIGINT/SIGTERM are intercepted while the terminal is in raw
> > mode, so that it is restored and the signal is re-raised when the user
> > interrupts a fetch.

<SNIP>

> > +++ b/tools/perf/builtin-annotate.c
> > @@ -733,6 +733,8 @@ int cmd_annotate(int argc, const char **argv)
> >  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
> >  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> >                      "don't load vmlinux even if found"),
> > +	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> > +                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),
> 
> I'm not sure what would be the good default.  But with this, it can slow
> down the process especially when the binary is not in the debuginfod.

That is why it allows the user to press 's' to skip it or 'd' to do a
one-time only disablement of this feature.

This is similar to gdb, that at session start asks if the debuginfo
files for the binary and its libraries should be downloaded, well, a bit
better because it allows the user to completely disable this at first
sight by pressing 'd'.

It also already honours configs that disable the ~/.debug cache.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> >  	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
> >  		   "file", "vmlinux pathname"),
> >  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
