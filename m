Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4E1B3925;
	Tue, 13 Jan 2026 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335401; cv=none; b=CGZDOgYCQ133TUXr2VihaJhwwQV9JoJIZR5xyGAtqE1deTf0ijvGuES/zBTU6iFkeXPWZ39Z8t9wpyFwv0nGarsQBvdnXConxAnBbhYp2IzpckKQjCHJDw32e/a5k/tI32fa6Ua7qLLwQTQ9knssMwvljm+5PTAggnbMSU3ZVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335401; c=relaxed/simple;
	bh=4HzTrpIOp55onGLggelYVy7XG7BCYE51MUtk16kMFqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITpIpHLpx1r2eXrdcHXuBpX1FeD0m0NbV/QgFpC5GpU6OUjC1kNoMysU6FvaUitOhEJ/KCB+wjWqllKbqtxAEGBJFeYjH8QSUJL9bRlxQluw3k68/xTX1I7iC5VXoeujHtKRgas7QUDxIAflyNeQWjkzVD2r7Ih8e9PVoAEcvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH8UA8FY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH8UA8FY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD01BC116C6;
	Tue, 13 Jan 2026 20:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768335401;
	bh=4HzTrpIOp55onGLggelYVy7XG7BCYE51MUtk16kMFqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kH8UA8FYstLmg8MF4rURb13PXpMBbWQOrGE1LKzHazZGNaNQJP+NjnZPfAK+PkKiH
	 PRO3MBp0jNJguKaAVbSl058w0MrayW2aMKQ1kp7EI8HKPUaA/AJ2zIbP0KfxdnVxsq
	 PsPCyabP3yNHm5qfVgAiOSGbBCJpMJPm2lr2OW7EGJ2A8T+ugIYMBAKrQJDk8JK8n/
	 c1XNLadtKIyEVPX0/EKgiBk81qx3jk/3h8+o2Qyzke2o0nsbJChzl44yfVyKHsx/0I
	 CFy5mS0c+gko0PRL/b+mdj4qpWe67QpqF79GDEyg1mYC+YfC6HpDtbZGOPaLwyLz20
	 smHjcWhPE20yw==
Date: Tue, 13 Jan 2026 17:16:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Gabriel Marin <gmx@google.com>
Subject: Re: [PATCH] perf inject: Keep build-ID data if no option is used
Message-ID: <aWaoJSBA22pFyQCs@x1>
References: <20251217183927.2259237-1-namhyung@kernel.org>
 <CAP-5=fXShAb9Ez-j64fY8c_XDpRUp33Z1Z75jS9=+UaTKa68HQ@mail.gmail.com>
 <aWBEaNVsoizw4Aax@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWBEaNVsoizw4Aax@google.com>

On Thu, Jan 08, 2026 at 03:57:28PM -0800, Namhyung Kim wrote:
> Hi Ian,
> 
> On Wed, Dec 17, 2025 at 10:57:01AM -0800, Ian Rogers wrote:
> > On Wed, Dec 17, 2025 at 10:39 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The keep_feat() determines which header features will be kept or
> > > discarded.  Usually perf inject will add build-IDs based on -b, -B or
> > > other related options.  But it lose build-ID when none of those options
> > > are used.  This is meaningful only when --buildid-mmap is not used.
> > >
> > > The following example shows the impact of this change.
> > >
> > >   $ perf record --no-buildid-mmap true
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.037 MB perf.data (5 samples) ]
> > >
> > >   $ perf inject -i perf.data -o perf.data.inject
> > >
> > >   $ perf buildid-list -i perf.data
> > >   08cccc2a9388d5247ccb3e864f3063b975b0a15d /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> > >   fd5c4d5673256cd6bda51725dba048dabb0f854e [kernel.kallsyms]
> > >   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
> > >
> > >   $ perf buildid-list -i perf.data.inject
> > >   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
> > >
> > > With this change, perf.data.inject would show the same list (of course,
> > > you need to run perf inject again).
> > >
> > > Reported-by: Gabriel Marin <gmx@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks for the review!
> 
> Arnaldo, any chance you can pick this up soon?

Thanks, applied to perf-tools-next,

- Arnaldo
