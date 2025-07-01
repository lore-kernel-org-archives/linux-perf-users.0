Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A71200112;
	Tue,  1 Jul 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399867; cv=none; b=oz1pTlwehpBF5r8qSmlPZNsNkqIRzdC0NE/E0/6xH2yTwKXVI0Z14A9qK8BsQXPSx9NwMqNZrONJpUXcFQrzZy4gVUFmnWuEeHpN5FgNq6014GkBNxE4pftiGy7RakVK7N1kkjUfdfYuecehLn3JMtRvr4KPRh0dkbj+Wj0A8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399867; c=relaxed/simple;
	bh=0igIbsYRDJ4ikXElfzH2ZGmh65imsO7g2KECAnovxGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk04HhpiOQf0mKXNJgCplG+rhb3wkqSu/9+9x6tIzdxGEc/4P3/13BS9LGgGtol9/nE4b/PxtNP+cz33qXF6LLFwvDNj8ST2cv7dOR7tpXm37r+boLEOn4mlBuDyB5LaY/xuq7kfajWQB5sCSmtRVOkxJml5/J+8JcwFbKwDD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfcmXu46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfcmXu46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6C5C4CEEB;
	Tue,  1 Jul 2025 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399867;
	bh=0igIbsYRDJ4ikXElfzH2ZGmh65imsO7g2KECAnovxGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfcmXu463TES9eJP4H5eQX9Ze+uyBsQq7D2+m2DR5tFBHmjBL08ZU/U7XOIET3Sgp
	 Q5edD3HhmiITpQC05R0n0ORVsfWDLN7p3Hn1N91U6IuqiYndAQ/bc0eoGTLjYWkNqM
	 6lQWRGm8qkpK8AO1lR23FGK6nx1nCWzS/Dxl1Djcoux7nB9vx7XcITwuV0FWpaVKc/
	 yprVHimCou8kuszd3EnCzWhqcdO24MxEv/QqTnI7ORmuRRScaZoi0MXIOroUmMgit7
	 NJbZPa67YgJibuxpV/caWp0tNziEpckuFiPB/G9iD7f4vtU8w6B+W9oWSW6jwngMlz
	 xO6hw/D9vrzHA==
Date: Tue, 1 Jul 2025 12:57:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf tools: Fix use-after-free in help_unknown_cmd()
Message-ID: <aGQ9ucA3BH1OXzlf@google.com>
References: <20250630233246.1063977-1-namhyung@kernel.org>
 <20250630233246.1063977-3-namhyung@kernel.org>
 <CAP-5=fXdzL1ZQQCFFU0crNpT7wiW4gtfbN1=p89BnmzWBU4mHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXdzL1ZQQCFFU0crNpT7wiW4gtfbN1=p89BnmzWBU4mHw@mail.gmail.com>

On Tue, Jul 01, 2025 at 09:03:46AM -0700, Ian Rogers wrote:
> On Mon, Jun 30, 2025 at 4:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Currently perf aborts when it finds an invalid command.  I guess it
> > depends on the environment as I have some custom commands in the path.
> >
> >   $ perf bad-command
> >   perf: 'bad-command' is not a perf-command. See 'perf --help'.
> >   Aborted (core dumped)
> >
> > It's because the exclude_cmds() in libsubcmd has a use-after-free when
> > it removes some entries.  After copying one to another entry, it keeps
> > the pointer in the both position.  And the next copy operation will free
> > the later one but it's the same entry in the previous one.
> >
> > For example, let's say cmds = { A, B, C, D, E } and excludes = { B, E }.
> >
> >   ci  cj  ei   cmds-name  excludes
> >   -----------+--------------------
> >    0   0   0 |     A         B       :    cmp < 0, ci == cj
> >    1   1   0 |     B         B       :    cmp == 0
> >    2   1   1 |     C         E       :    cmp < 0, ci != cj
> >
> > At this point, it frees cmds->names[1] and cmds->names[1] is assigned to
> > cmds->names[2].
> >
> >    3   2   1 |     D         E       :    cmp < 0, ci != cj
> >
> > Now it frees cmds->names[2] but it's the same as cmds->names[1].  So
> > accessing cmds->names[1] will be invalid.
> >
> > This makes the subcmd tests succeed.
> >
> >   $ perf test subcmd
> >    69: libsubcmd help tests                                            :
> >    69.1: Load subcmd names                                             : Ok
> >    69.2: Uniquify subcmd names                                         : Ok
> >    69.3: Exclude duplicate subcmd names                                : Ok
> >
> > Fixes: 657a3efee43a ("libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Fwiw, it seems a shame we're doing this and the code in git is drifting apart:
> 
> https://github.com/git/git/blob/83014dc05f6fc9275c0a02886cb428805abaf9e5/help.c#L204

Maybe we can send a fix for them too.

Thanks,
Namhyung

