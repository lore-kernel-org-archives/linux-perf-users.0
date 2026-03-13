Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140323D7DC;
	Fri, 13 Mar 2026 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444681; cv=none; b=Pydf0w94O2CWh2Z5eBipcULLBzaTKBQM3vp8NCO/zNGgDtOPwqaTM1IOIdYrve/KlQMSpgX8lz6ZYBjQbQX/tEpaA0FIxSzFDRgQqtSiNPR2ABvqy9aNs2+mDYObXIWQn2trRnpjSry5wlWZ/gz1+fvDucoHNqWhnchzKp1WLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444681; c=relaxed/simple;
	bh=xD/hORZ0Xgax55bxVvKY319qdvTy7ugLqcBnXsKLcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1eMHDheYW4Vo+/sUZ/L5Stmz6UKpsg/GO5xx60Czv+K4C9j/cmmR6C6sD+i0K/gi1qUfYZnvjFNuc8zfWxuWajJzl7SFGJDjCqfjjWvkrW0s2uMBNcsjBvaR0zavgGIMJRByQ+fUu6i9wp8o86npNH4OOPjOwF/aOG1lDeFgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DVcApizP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVcApizP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dRutPzVXVNbE+BRKCy7eYXiswPh98ATdgdttul2AGEo=; b=DVcApizPHd3HTUthKXLR8uyrPA
	Qbi9vsfw0YUHwtU87HgXFlY/n7yJOJbTZS2vXuUv9pOwfuRr+sPFgSPg+QWCCvzfHhNUcOdZ8od1+
	lYnkCo63RoIdN68WtqiZ3D8FIbFryGaHfRLC+17xqY8jwvux5uyzuyZVxpPj5UGTL9LMSZli5jUCt
	RcH46WLo7ku0Czc0wbn+8/QGMy+yjAJ1CjGN/t/44Rkmhel3zkrV2XlJPJbO5RpGCejSBUyRU/Pt1
	k8pKUI7qmbSUal3MiWGdOGDSnp0qrYv802ChPINSujTG7xmeLxusYTU12D/tCuHiwsdU7bX+gi3hU
	mNoFqiFQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1By5-00000004K20-2vUs;
	Fri, 13 Mar 2026 23:31:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1C703032C7; Sat, 14 Mar 2026 00:30:55 +0100 (CET)
Date: Sat, 14 Mar 2026 00:30:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v1] perf build: Revert "enable -fno-strict-aliasing"
Message-ID: <20260313233055.GD2872@noisy.programming.kicks-ass.net>
References: <20250904174430.1414548-1-irogers@google.com>
 <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
 <20250904205924.GO4068168@noisy.programming.kicks-ass.net>
 <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>

On Thu, Sep 04, 2025 at 02:33:24PM -0700, Ian Rogers wrote:
> On Thu, Sep 4, 2025 at 1:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 10:41:17PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 04, 2025 at 10:44:30AM -0700, Ian Rogers wrote:
> > > > This reverts commit 55a18d2f3ff7 ("perf build: enable
> > > > -fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
> > > > -fno-strict-aliasing is no longer necessary as memcpys are assumed to
> > > > possibly alias.
> > >
> > > I don't think this is a good idea. Much of tools/ includes kernel
> > > headers and various kernel code, all of which is written in the
> > > understanding that this (often called broken) C language feature does
> > > not exist.
> > >
> > > As such, I would strongly suggest all of tools is built with
> > > -fno-strict-aliasing.
> >
> > Similarly I would strongly suggest having -fwrapv on all code that
> > includes kernel headers.
> 
> Given we can build and run with sanitizers, ubsan covers fwrapv and
> type sanitizer is in development to detect strict aliasing violations.
> So we can have correct code without hamstringing the compiler.
> 
> There's lots wrong with C, a particular favorite of mine is:
> ```
> void foo(const int *p) {
>    int x = *p;
>    if (x == 10) {
>       mutex_lock(&global_mutex);
>       if (x == 10) {
>           // Code should always run ...
> ```
> The compiler can save registers by re-loading from p in the code
> above, meaning the second "if" may not always run.

mutex_lock() should imply barrier() which should very much inhibit this.
