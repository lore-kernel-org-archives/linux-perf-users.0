Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EC31BC8E;
	Tue, 16 Sep 2025 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055132; cv=none; b=p1pOEqI+HUQup7ex9f7IbhhKwNt/ru052X5cVZavkIZzdv9tvfssHk6rfKzpMy31UKWMwX5K7AaD2hWHWzfdxVIHhakb9gtHJu/EAysWTxBXtkpSLSdqFWf6i6DS5q6HFB05c+OMTjIIVZfOt2hDxdSCiyi47MBeWm90aYFVxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055132; c=relaxed/simple;
	bh=hJyIPXfNJ1aunH4FVAYee6rlV40lzbNU3+JYVrCnYpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRmM3Rm4+gRggx1bAx+mmQfkzoLp+PXJSUmMiAFHq/OA81OT9tZCCTUIu8Uae7a5SVU3I0974o0bkHpF9ZZhemp6+nXnKYp1/wfAMr5CRwzMyfYlps3uMqV3QZdkdq4sq/UGT9kxdHqHEpVIP6KnvRJh8jv1CdwvdfrN8p6ox7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhWPBu1J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhWPBu1J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hJyIPXfNJ1aunH4FVAYee6rlV40lzbNU3+JYVrCnYpc=; b=PhWPBu1JkXx81hXaEuPiJUtrWc
	tLuXIsYDUR1mNdJlEtdyFtn9oX2PN2YW1aR3MF0q5Fk+v7IwI4nNuxdqmFK4BSvUkQxDSRIhv3yy7
	JDm+ZeoJ0L5F/ezTS3RAJFhBeJjs5wPMJatvGx3wHK794TgaKJKWtrXP6Hbzbzz6Fei6nTfZYWkol
	6qiIOo213NmHQPaUKNaIcLkR4V1tjEoEOnlRBLUz+Ujdvs2hVm/TMnUgD1l/3AH/HBCt3v+LHVEe5
	asbCRvsgw9mNtTEeiF6tYMWITfWfxv1ll9sWWCyx0AQ1YeZ9chDWpXO66XN9DwYlvJ5XK1Jo7TViU
	yoZWYoCA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uycRk-0000000Cj0C-2bRq;
	Tue, 16 Sep 2025 20:38:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B515300230; Tue, 16 Sep 2025 22:38:39 +0200 (CEST)
Date: Tue, 16 Sep 2025 22:38:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Yuzhuo Jing <yuzhuo@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/7] perf bench: Add qspinlock benchmark
Message-ID: <20250916203839.GB2800598@noisy.programming.kicks-ass.net>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <aJDDfCKFXFQOJ134@J2N7QTR9R3>
 <20250916141811.GK3245006@noisy.programming.kicks-ass.net>
 <CAP-5=fVec0Wp-d489aWE6Tk=W4dz-r6O+JUiqSPLcEZ7TK6FJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVec0Wp-d489aWE6Tk=W4dz-r6O+JUiqSPLcEZ7TK6FJA@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:00:13AM -0700, Ian Rogers wrote:

> The inspiration for adding a benchmark this way comes from the
> existing perf bench memcpy benchmark. The reason to care is that, as
> with memcpy, there are subtle effects from things like RISC-V's
> non-temporal atomics (ARM near-far atomics) and the size of CPU cores.

But the patch as proposed was very much x86 only. No RISC-V or ARM64
support.

> In general queued spinlock is preferred in the kernel, a benchmark of
> queued spinlock and ticket spinlock may reveal that ticket spinlock
> would be a better default for certain configurations.

And didn't do ticket, even though we have a generic implementation in
the kernel too (IIRC I have a few patches for that as well.. someday I
might have time).

And yeah, ticket is very good and hard to beat for 'smaller' systems.

There is a reason for commit: a8ad07e5240c :-)

> Does it make sense to have this in perf? It makes it easier to tune
> the implementations, keep code in sync with the kernel, etc. Does it
> make sense for perf to have a memcpy benchmark? Maybe not these days
> of having a more reliable rep movsb. Anyway, in general the bar to
> getting things into perf bench hasn't been hugely high and I don't see
> disagreement that on some occasions a benchmark like this is useful.
> As someone who cares about this kind of performance tuning, I care
> about having the benchmark.

Yeah, not convinced we should stuff all that in perf. But also, the
benchmark doesn't actually seem to do what you say you wanted, so meh.
