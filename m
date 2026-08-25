Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C63CA4B3;
	Tue, 25 Aug 2026 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696369; cv=none; b=WRL7DCqsfM+25EZiW71ix10muMXKJk9YxApAu5xML01n6N97QyCow9qpLZUptUFDOgUd1hoTwx3lsxvkj9GfN6dWHI1rSplrMK/jQnLPkGtGC+V+TqrOJZDwNEsfCLO4L/v5t0KPIZEazKXm/Fx7U4xQCi8vc7TidFyCFHRFuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696369; c=relaxed/simple;
	bh=BDdU3YAKSJ4wstkOzgeo3mNdSvSfY9q9W6gZDk+7RLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLZdK+21DdOQ2weyReGUyl1BxnSog5+TCAOkhbJqRlq57D6RHE0iGY6mRzrcyDF4NLN8oB+Klwo2u4oNq/Z9ZPgbAKBF66x248DwCkIIrXmvyt8SIELJlnv9QdzS7IY0BLQ/H1hwAh+fimdETL7lJiqEBoIVeSRWZzXcIWWpCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HolGtccG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HolGtccG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D0B1F000E9;
	Tue, 25 Aug 2026 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787696367;
	bh=kJVDn5HVR8ujzWtuJSyYXo2h0wSfRbjpR1rpsc8daQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HolGtccGy8+h9FPBUOQYKcAzL3UdkSRNguzZQOfn2D5Yy/KZzsV6S9Smzq287bVUI
	 aQVFusnLh8FIZhG7xjbU/t4dbXilpzL+iJRITZbPRy3EzXdFbK1ZzG1w9HaSre3Pvj
	 Yi5Sekr+XtyGtuIUUPUdOk988RW9iAvhk6dGnv/xqk5aQN49xtENE8cNHH5an51TAB
	 yBD7jdENRFg/sJ5AzxvyIvP6rvEcFiVqEHwxcsyRQ2UpcD4B9v/cYCRllMOgI2MBCt
	 lEn4uLfeOgySaV1SemvP+vNgemqSlNzRPlk5OSdGKSr/M/NuvjOphKf6w0YMEfSef/
	 yQjZI0DuJ/gMQ==
Date: Tue, 25 Aug 2026 19:19:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, ak@kernel.org, ak@linux.intel.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge
Message-ID: <ao4U7OX54mMRZoNa@x2>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-5-irogers@google.com>
 <aozIZLYvv78jX-3u@firstfloor.org>
 <CAP-5=fU25BLS9bpShaY=akjK1nURV0PXw54KNqefYhKUvi6DSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU25BLS9bpShaY=akjK1nURV0PXw54KNqefYhKUvi6DSg@mail.gmail.com>

On Mon, Aug 24, 2026 at 08:33:02PM -0700, Ian Rogers wrote:
> On Mon, Aug 24, 2026 at 3:40 PM Andi Kleen <andi@firstfloor.org> wrote:
> > On Sun, Aug 23, 2026 at 11:37:41PM -0700, Ian Rogers wrote:
> > > Add --hybrid-merge flag to explicitly trigger event merging
> > > non-interactively
> > > for both perf-top and perf-report.

> > Well it should be default on.

> > I don't want another option I have to always specify like
> > --no-children.

Picking defaults is difficult...

Linus doesn't like the buildid cache, so he can pick something different
than the default of saving binaries that will be useful immediately
after when doing annotation, etc.

I don't like having to specify --no-children either, but lots of people
like it.
 
> I agree we should be able to change defaults. Just over 2 years ago, I sent out:
> https://lore.kernel.org/linux-perf-users/20240516222159.3710131-1-irogers@google.com/
> That switches the histogram behavior in perf top to zero after every
> refresh rather than decaying the values. If you filter perf top by

See? Ian has his preferences, like Andi, how come?

> user, it can be common to get no samples. Note that around this time,
> we fixed this behavior to work really nicely by using BPF instead of
> horrible /proc scanning. In the default decay mode, a symbol that ran
> in the past will appear in perf top even if the process with that
> symbol has terminated. This happens frequently in user mode, resulting
> in many ghost symbols and lingering processes. The zero mode, which
> ironically matches top's behavior, isn't the default because it would
> be a noticeable change in the defaults.
 
> Anyway, this is a long winded way of saying that Namhyung and Arnaldo
> pick the defaults. I didn't choose to change the defaults in this

I wish I could pick defaults wisely (or that the maintainer du jour do
it), its a hard call, and when I _do_ pick some default eventually I end
up very disappointed with myself when I find out that my thinking was
flawed.

> series because I think if you test the changes, you'll see that
> hitting 'M' at startup really isn't that much of a chore and it gives
> a clear signal that you are doing something special. Perf top also
> hints at the 'M' key along the bottom of the screen when hybrid events
> are present. If this is too much to live with, I think we could make

I don't think this is too much to live with and I I like being able to
have this switch, perhaps having a "do it permanently" after one thinks
it is the right default, should be made available.

> it a config file value. I think this matches the principle of least
> surprise, while the decay mode default, I'd argue, is the opposite.

This hybrid situation is one that is indeed a source of way too many
problems with how to properly aggregate counters from different types of
cores, having a way to go back and forth from aggregated (taking into
account freqs and whatnot) and the current per event type, which is
utterly sub-optimal for a system wide view seems to be an improvement.

Doing it just for cycles seems a step in the right direction, doing it
in a way that takes into account all types of events seems like a worthy
goal, lets make some sort of progress here with, I think, Ian's attempt
at taking into account all sorts of events while making the simple case
Andi cares to work, can we go with that?

- Arnaldo
