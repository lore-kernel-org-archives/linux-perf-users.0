Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825242750F2;
	Tue, 15 Sep 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431551; cv=none; b=oxHQ/yyYG3AP6n14aIHZN9FK0/o8nRkU5coYS8Qgq7t4HH7y9uJwv4Wt8SMbeXsYFgUL0pv7rgincPDnh2d58BWk5PIA9h480SW3KEo/5b+ziw9jpFe+zK+23ODQkxu2NNBxi5i6uW3KK/grsJl/VhRf1Iew74llU67yDIJVmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431551; c=relaxed/simple;
	bh=hjmboASB7gfoy6fk7Sh/jntGPFpYeGIyDg8Omc6V9AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgmAzQ8ROI6TERHudVYjFg22CHL7kCSwfZjTZMgXmw2d5ti62K6KLIvJMiuesAN6n3TkBbIDY868556OcRs90GIeQZqIMkJIZdrLpNyUvwGkAkelPY3gfb0M4cUtP4fUbiTxakcxciFrgniPE2upqRhGs2xzryEbNyaHB9itK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9WI4Nu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9WI4Nu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB19E1F00893;
	Tue, 15 Sep 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789431550;
	bh=CtmjpGBsYzPeRXUbTravZfHooFXvO8YHWNaLYFRJmJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T9WI4Nu6kOROkuqZe3p2P7HD+n7YlpYyH2rQ70GNgv6SiOgjX20horwM17TlDGSPz
	 Osaq860haVDRzFkQPdiaBQIyxBRUlcM25evfFKj5ZKR2QfiaYnicmi/k6pkOyDZN7h
	 05nxCg13F11fPc0JRtN0Wk+vYLWY27JO0gJ5cBrzdV31HUVnFHHUIjM1vr0NCsmnUi
	 sDzSUecZt7Wn6xRae4Vy3RLsrzn+LcOYOMZAb2S6D037lwQBnDqOSKjJuZ0qZc3lPG
	 T1kXI4+ozpdkhbSkq3hzplOVzQsk8NWSPWnSZ/DHxQfZdFSLUa/8tzKcs7r7EAMzfo
	 +8PQp0lKrVbLw==
Date: Mon, 14 Sep 2026 21:19:06 -0300
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
Message-ID: <aqiO-i5WTJbNxQtu@x2>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-3-acme@kernel.org>
 <aqdPNG6szS6YJjOi@google.com>
 <aqdTC_3In8ymE-RS@x2>
 <aqhYUQgaf-UHDnLK@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqhYUQgaf-UHDnLK@google.com>

On Mon, Sep 14, 2026 at 01:25:53PM -0700, Namhyung Kim wrote:
> On Sun, Sep 13, 2026 at 10:51:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Sep 13, 2026 at 06:34:44PM -0700, Namhyung Kim wrote:
> > > On Sun, Sep 13, 2026 at 07:28:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > +++ b/tools/perf/builtin-annotate.c
> > > > @@ -733,6 +733,8 @@ int cmd_annotate(int argc, const char **argv)
> > > >  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
> > > >  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> > > >                      "don't load vmlinux even if found"),
> > > > +	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> > > > +                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),

> > > I'm not sure what would be the good default.  But with this, it can slow
> > > down the process especially when the binary is not in the debuginfod.

> > That is why it allows the user to press 's' to skip it or 'd' to do a
> > one-time only disablement of this feature.

> > This is similar to gdb, that at session start asks if the debuginfo
> > files for the binary and its libraries should be downloaded, well, a bit
> > better because it allows the user to completely disable this at first
> > sight by pressing 'd'.

> > It also already honours configs that disable the ~/.debug cache.

> Oh.. I overlooked the details.  But then it'd be nice to separate the
> logic for the user interaction from the debuginfo fetching.

I will do that tomorrow, as well as have it not just in --stdio, but
also in the TUI.

I need to be more concise and granular, sorry about that.

- Arnaldo
