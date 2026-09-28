Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF4483815;
	Mon, 28 Sep 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632310; cv=none; b=Na5i+cLo8nvEingZlJarLd2SZ/oUj/qnuDUDYQ2iklARTY3qrAapJvm7hoFZw7foQSv3+dI1sFyjhQJThB8NL6L1keKm2JvToJy6IGn4wqDbhCsViL381vioUL7DiEKb8JJBXZwZqM7/uzF/T6V0Vt0nh3fIbTxe5NfTlU0gNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632310; c=relaxed/simple;
	bh=YNV2TjQ3fNzU3IEWfZKsKKvzGf4oNnun3xAAjr85XXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP9Tavn+0RuhXOpeSJTRdHvw95VFu1BDvBHywA6WsvxvuCV7HA+l2W3WPkawPfCa1uBzsmhSSGCyRENrg8z4LwUGMN9rLR0sjOQMLH1ulqfisPEB7Or4xi++XMEBmt65D6tUJLJGn7HWyfbP5ejCUxKcER7ty2mr+KiaM5UV+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PleYIYH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PleYIYH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC521F000FF;
	Mon, 28 Sep 2026 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632308;
	bh=p1j68afqazmcySKuGIaZ6064wUscTp4V/7bSvxWW6Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PleYIYH2o3MkD5ojOftQvbzMo8CNBQ3vxoh6yio7FVuHuf/m33LGiztVtM9Z4tXwc
	 Ac6Kiecic+sUXyCU2lgVFH3T9gHhteVi6w7ym8f+p5xU/vGdgEofiMbOn0AhGjQGAG
	 iAOAUkxZLlEaY1TIKTWx2XetmfhRHvIPzj3aeuK2IRCkhIoTIjGpXnsrPwIrQDWmqz
	 j5PielmMQaCBrCen39huSfiGfCLNj55+71k6KUonTZksbio+A0O/1liYvmfqLd77O4
	 2fw3QtpAtauh0uo8KH2WNNCr2jaw47IDlGLrknpV4Cb4QTBkjjFUAfCXbXlnnEeTDs
	 cHluaeemZlXZw==
Date: Mon, 28 Sep 2026 14:51:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
Message-ID: <arrhc_7jvX_W2uXS@google.com>
References: <20260928075237.3055101-1-irogers@google.com>
 <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
 <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>

Hello,

On Mon, Sep 28, 2026 at 01:55:26PM -0700, Ian Rogers wrote:
> On Mon, Sep 28, 2026 at 12:45 PM Alireza Haghdoost <haghdoost@uber.com> wrote:
> >
> > On Mon, Sep 28, 2026 at 12:52 AM Ian Rogers <irogers@google.com> wrote:
> > >    annotations. Saves 48 bytes per struct symbol (two rb_nodes) and provides
> > >    cache-friendly binary search (bsearch) and callback-based iteration.
> >
> > Hi Ian,
> >
> > Thanks for posting this and for Cc'ing me. I built it on edd8a9fe2eca0,
> > the same base as the v3 series I sent last week, and compared it with
> > v3 in eager mode (today's behavior) and with --lazy-load-symbols.
> >
> > All runs use perf script --no-inline --max-stack 127
> > -F comm,tid,time,ip,sym,dso, with one warm-up and three runs; the
> > median is shown below. Peak anon is the maximum RssAnon from
> > /proc/PID/status, sampled every 10 ms.
> >
> > 1) Production: 120 s cgroup profile of a storage service on an 80-CPU
> >    host (perf record -a -g -F 99 -G <cgroup>). 54k samples, 11 DSOs,
> >    5% of lines [unknown].
> >
> >                   time     max RSS    peak anon
> >    v3 eager      4.5 s    386 MiB     314 MiB
> >    v3 lazy       3.7 s    151 MiB      80 MiB
> >    this series  95.9 s    309 MiB     275 MiB
> >
> > 2) A sample fixture from my v3 cover letter, a worst case with 73% of
> >    lines [unknown]:
> >
> >                   time     max RSS
> >    v3 eager      3.2 s    334 MiB
> >    v3 lazy       1.9 s    106 MiB
> >    this series 205.3 s    449 MiB
> >
> > Most of the time goes to reloading. On the fixture, a profile shows it
> > under map__find_symbol() -> dso__load() -> dso__load_sym(). After each
> > shrink, the first miss in a shrunk DSO re-parses its whole symtab, and
> > addresses that resolve to [unknown] miss every time.
> >
> > The peak is still set by dso__load(), since the whole symtab is
> > materialized before a shrink can run. That is the main blocker for us
> > running perf script at scale: we can't bound how much memory it will
> > use, so we have to contain it with memory.max, and then the profiling
> > job fails with an OOM kill instead of degrading.
> 
> Hi Alireza, and thanks for the feedback! I'll see what can be done
> about dso__load in v2.

Thanks for the patches and the analysis.  

I think many of this memory overhead come from the symbol string.
Probably we don't use most of them.  Then would it be nice if we can
lazy-load the strings?  Then it'd have an union of a pointer and a file
offset for symbol strings.  The find-by-name API is used rarely for
user DSOs and the kernel symbols should be fully loaded anyway.

Without the string (and the priv part), now it has a fixed size so it
should be saved in an array directly.  Probably we can add a limit there
and print it with offset when it doesn't have the name.

I'm a bit skeptical about the refcount approach here.  It may be hard to
determine when it reclaims memory.  I guess the lazy-load strings with
an array would give similar savings like Alireza's work.

Thanks,
Namhyung

