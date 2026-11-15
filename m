Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714446;
	b=TzltkWzCmeaMmYqrkCo87TpRHb7/+pdmtNIcBqFg4tLWJZIY/QBD/6KWWJKBX0v0gs93
	 fng2MTUK90E377xkNMiBnfdI1SWBxCLK2qDoauxNdQ26H/u/Z9JYeTDmQAi6H+zT3Wu3x
	 zby09lb5mSx2pia8ObsI0mTYt1X+RMYfRro6tA43cPq2E9tEsr0eVoZhrCFxHh2WFnzLV
	 SllPKfd2vnX842JT7oddGahmmmVEgg6mITl7c2HNqRBFUA/3KN8mE5jG83q6WhlUxNYj5
	 Vy79GptuhUDHsa2SVBuBepUTlUZP1/+XUnTb2FmAsM+xE5c796gEvSVG2Rx75E2RDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4ldjyaGmvMVLM4Vlq8OFYR8G7/wmGOfpzraKbwpWmR4=;
	b=a35kUruG2CsXAoGIC6Z4dw6ZjEiuOhgviDhZW19vW5PqJ8ZKB/cojyTN7S2vqpNX/BIj
	 M0c/2WOZHFxy+lPObGv6wt+V5BAMwjg04f/2pBtr4BQH9s/MDYcb1Wdjzla7haR8K8qMn
	 8kEXl2ioAEKFAf18CD8cQFWy8V1+KH8kY3yqVACaV9EyPCWvffnoinuaTwUNzS+TYsggb
	 JHjnrPXzsAreM6bBuIAS+QnM95isSwP41fDZUlSS11mGSKqRUAmmjXe3+Z+Y1fP9i4QuC
	 +GGOOOK4UdMB9PjbeC8dEeAo5FpEmzodfUv1FEZwqvbGdSKHY4pkNStvLgr6YHl7qcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn4vBdex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC5606A323;
	Sun, 15 Nov 2026 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dn4vBdex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90341F000C4;
	Sun, 15 Nov 2026 03:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714446;
	bh=4ldjyaGmvMVLM4Vlq8OFYR8G7/wmGOfpzraKbwpWmR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dn4vBdexOC5DTUD2zdya29Swqmnph+JjXeuIZT2PUlgCnG/8lpOVCLRYWKO+q+KS2
	 W18fpOwp73jvcGk52ZQcwJziCKpCt7VQhYIAJF8sB3tn3KRIcbex/jPHk6uOq4eRgv
	 +vcA49OHhi3KkRrWEIK9Ba9JUg/aq8Imd85K6DVKgONt8oyikhICsLL3hHFOq7Lzg5
	 lZUz9Klgnfj+tpLjGa0kyvjcxSuRnOb3/8axaRFI9ew+RMu4xGvfzT/7XmFfr9R15Y
	 A3fGe0d+hOx7jNvuGUlMnF41xv7FneEJnI1rb8GHFvzuT/Uax++UKJ71qKtCabjXpj
	 +Yoy6EbuSgt5Q==
Date: Sat, 14 Nov 2026 19:47:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Message-ID: <avkrTBAE08wB5Qy1@z2>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
 <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com>
 <auacxQZKtlFa9Pc3@z2>
 <CA+w=M=S-H4d_-KCZJqdPoUCyfYtNDsKLd8t37kT134bwpKD7qw@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+w=M=S-H4d_-KCZJqdPoUCyfYtNDsKLd8t37kT134bwpKD7qw@mail.gmail.com>

On Fri, Nov 13, 2026 at 08:00:55PM -0800, Alireza Haghdoost wrote:
> On Sat, Oct 31, 2026 at 6:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Oct 30, 2026 at 08:55:55AM -0700, Ian Rogers wrote:
> > > I'm thinking this option should really be the default, requiring
> > > people to opt out.
> >
> > Agreed on making it default.  I'm not sure what's the case that needs
> > eager loading.  We can change the code to load all symbols just before
> > it (oh, it seems the patch already handles the cases) then no option
> > would be needed. :)
> 
> Sorry for the slow reply. I wanted to have v7 ready before answering.
> I agree that lazy loading should become the default, but I would like
> to keep it opt-in in v7 and flip it in a separate patch later.
> 
> While checking what default-on would change, I found that a binary
> replaced during the run gave wrong names. Lazy loading reads a name
> later, at the offset the symbol table had at load time. If a deploy
> replaces the binary in between, or the path resolves to another file
> because the process of a mount namespace exited, perf read the names
> from the new file. I reproduced it by swapping the binary under gdb;
> perf printed names of the other build. Eager loading reads every name
> at load time, so it is not affected. I fixed that in v7 and kept the
> device, inode,
> size and modification time of the file and checks them whenever it opens
> the file again. If they changed, perf warns once and shows the
> remaining symbols of that DSO as [unknown].

We have struct dso_id to identify the binary.  The build-ID is the
preferred method to check it.

> 
> Also, each batch of names opens the file again, resolves its name and
> enters the mount namespace. On my test profile this is cheap (1.3 s
> lazy vs 2.9 s eager, identical output), but I have not measured it for
> containers or debuglink layouts. The type-aware data cache that we
> discussed on v5 would remove most of that cost.

Right, having a fd in the cache, would solve many problems.

> 
> So my plan is to run lazy loading in our continuous profiling at scale
> first, and then send a patch that makes it the default. By that time,
> hopefully we will have already added the type-aware data cache.
> Does that work for you?

Sounds good.  A real world testing would be great.  I'll find time to
work on the DSO access.

> 
> > > I'm curious if this is global just to avoid the expense of a mutex per
> > > symbol or it needs to be global? [...] but perhaps the dso__lock works?
> >
> > Probably.  dso__load() already takes the dso lock.
> 
> It was global because dso__named_symbols() and dso__sort_by_name()
> already hold the DSO lock when they load names, and the mutex is not
> recursive. Nothing that holds the DSO lock looks up symbols, so v7
> uses it: a lookup takes it only when the symbol it returns still needs
> its name, and the batch loader requires it held.
> 
> > Nit: I'm hesitate to argue about naming, but it seems a bit confusing.
> > Why does it skip to load when it doesn't have a (lazy) name?  Probably
> > symbol__needs_lazy_name() would be a little better...?
> 
> Agreed, renamed in v7.

Thanks,
Namhyung

