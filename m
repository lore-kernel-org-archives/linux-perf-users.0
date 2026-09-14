Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7F3914EB;
	Mon, 14 Sep 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417556; cv=none; b=N2PrVe2cpwum7Ab3v4gXodwkOikrzWQzq5SlTTHfh7bZNbc3H4QY/kEXAuvmxo0iuoNTomTtmvq/yE5pEvLNFvibd3cr9KfAlWkqXm9DWWASJv7WLSFH/CvHLu2wGPU5m3fGwqRrn03j4GNYEdoSsxyZcnzL/yjeZG/PwYj7Q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417556; c=relaxed/simple;
	bh=wdOS57nGmOvy7CX80n9wJv6WYZxli/eZvfgVEtEHrNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDCRdkY3s+qX5llGJhV5xmnr6LpJQPgj0tMjGXtu473itfT0TNMLjlATVLLHXDwug4DVDxxf76eJuvW31rhP3QBG3/3gMVVMNTdXyJzRzrKlxbtYTAWmEL3eKzZjP1i149PjJXUjN9dJj9OKg3z8X8BTVOcQvREUQqocPm2CYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRsE7KXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRsE7KXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ED21F000FF;
	Mon, 14 Sep 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417555;
	bh=XNK6XtE5gSBy4gZV/B/+7V+HQahvA2rQo4yPLTAv54c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bRsE7KXwKiapgQ92C4EnJ8X/ZTpFMnYoZfumn6ttyGqNLM7PzXb1jNv6kLEatZgWD
	 3lvUfNCwJqPsJOPXXMOK3M8NN4dJVo6O/VNqEaZxNGpAJY7W3d+UM78VC2HUJAJEEx
	 hTnglfLfeFXjbJrteuj9Ktg4YK0Q5eOxCuNZ9Ld5Mnp5gBzla9W1RnEYTLwDLJcVa9
	 sgGbo8Bpuu867QcyfBK70lIWaToo/ERPgKWmWm6B0m+g7Ouc9TgQcy5xvkLGY6Deq2
	 z9aUKul0SC326AUnwdNLm4SM9Jz1g/BhqewwjjbphMnF7SOeaqz41E9DKt86wDIDhJ
	 mxolkGBz5CNcQ==
Date: Mon, 14 Sep 2026 13:25:53 -0700
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
Message-ID: <aqhYUQgaf-UHDnLK@google.com>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-3-acme@kernel.org>
 <aqdPNG6szS6YJjOi@google.com>
 <aqdTC_3In8ymE-RS@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqdTC_3In8ymE-RS@x2>

On Sun, Sep 13, 2026 at 10:51:07PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Sep 13, 2026 at 06:34:44PM -0700, Namhyung Kim wrote:
> > On Sun, Sep 13, 2026 at 07:28:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> <SNIP>
> 
> > > Querying servers, possibly third party ones, sends off-box the build
> > > IDs of the binaries being analysed and a fetch can take a while, so
> > > this is opt-out: on by default, off with --no-debuginfod, with
> > > core.debuginfod=false, per tool with report.debuginfod and
> > > top.debuginfod, and, since users that set buildid.dir to /dev/null
> > > (e.g. Linus) or otherwise turn the local build-id cache off clearly
> > > don't want fetched files stored on the box, off too in that case.
> > > 
> > > When a fetch is in progress in a terminal, stdio, the way it prints
> > > progress is how one gets out of it: 's' aborts the current fetch via
> > > the debuginfod client's progress callback protocol and remembers the
> > > build ID, so that the rest of the session doesn't ask for it again,
> > > the user may have skipped it for being too big; 'd' additionally
> > > disables debuginfod for the rest of the session and points at 'perf
> > > config core.debuginfod=false' to make that permanent -- rewriting the
> > > user's ~/.perfconfig from a keypress would silently drop its comments
> > > -- and SIGINT/SIGTERM are intercepted while the terminal is in raw
> > > mode, so that it is restored and the signal is re-raised when the user
> > > interrupts a fetch.
> 
> <SNIP>
> 
> > > +++ b/tools/perf/builtin-annotate.c
> > > @@ -733,6 +733,8 @@ int cmd_annotate(int argc, const char **argv)
> > >  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
> > >  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> > >                      "don't load vmlinux even if found"),
> > > +	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> > > +                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),
> > 
> > I'm not sure what would be the good default.  But with this, it can slow
> > down the process especially when the binary is not in the debuginfod.
> 
> That is why it allows the user to press 's' to skip it or 'd' to do a
> one-time only disablement of this feature.
> 
> This is similar to gdb, that at session start asks if the debuginfo
> files for the binary and its libraries should be downloaded, well, a bit
> better because it allows the user to completely disable this at first
> sight by pressing 'd'.
> 
> It also already honours configs that disable the ~/.debug cache.

Oh.. I overlooked the details.  But then it'd be nice to separate the
logic for the user interaction from the debuginfo fetching.

Thanks,
Namhyung

