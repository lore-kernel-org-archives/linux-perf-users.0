Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E6214A64;
	Fri, 13 Mar 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773437173; cv=none; b=lb2nAR208WVIq6ItM1lC8Ne8SIi8PaPsDNoAvIogX47VIQZnJjMTKKD+yk6WYVpWnct9nv4SdVLXV7XItCykGWpamUI1h+wDzsDEEvyT/J1Y01qRTAwNdtn4JmmPchYOHlI3C0raiHF7lWUJ6MasLSRVIxO1tcj3rpfVe6eVzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773437173; c=relaxed/simple;
	bh=kR00w5U/3GJtL6Jfncm6TsO9AykrNjV6m3qxIGGtp6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFygAl87dwXBCyhwkeYsMglm85WwaTSukemvQR4hkEJMtPtgkdar/MkgGSKjJNZtLGfbTgvpDtdAB7rUMMtdltER9i6I7awhYJJE8WIxjoh9rdoMlR21zhyBBE7SqIeWxwOi5jDRzGkORAZAp/Pvil6FYM9Jb609ncaGFNvHzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neME76Vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neME76Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31664C19421;
	Fri, 13 Mar 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773437172;
	bh=kR00w5U/3GJtL6Jfncm6TsO9AykrNjV6m3qxIGGtp6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neME76VxleI2Oie5elXmFjIF/5yqX+jKNoB5/FtXkhzye7YH4X5/BO88RFQrHUcHH
	 ohc9sU0m3I6k3fzx+0mnAGyjpO8ZeDH+LIVEV2GY/o9fV8+J4TC0kuV2Fm81HskZVQ
	 rqtvUlguqmIIFfzIxw7Ej8TGNJZQkErN/ymnRgHmwP8E3qSt67t7GsQczJw1OCWGT/
	 fFBlFEsit3wRkJ+990LSyq8gkneJ9ZQBWbsUUJbiCQMPo/ZiO8hKNHmFkLguW8kK7F
	 OS8/7ha8gbNI625Wp1zun5tZ/jAKr9aVuB9v0WtyjAYBXbgl7lnDaRAIbTvcyYTdC+
	 LqXMsACz2pisg==
Date: Fri, 13 Mar 2026 14:26:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf tool: Minor code clean ups
Message-ID: <abSA8h6GoTW_CD0g@google.com>
References: <20260207082428.1742209-1-irogers@google.com>
 <CAP-5=fWUk4pwHpgSQbrCuXKDu_wZDjmLd6kbtQ9zqCkNdJZGmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWUk4pwHpgSQbrCuXKDu_wZDjmLd6kbtQ9zqCkNdJZGmw@mail.gmail.com>

On Thu, Mar 12, 2026 at 01:40:53PM -0700, Ian Rogers wrote:
> On Sat, Feb 7, 2026 at 12:24 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Remove some unused functions, files, etc. Reduce scope of variables
> > and functions. Constify arrays in perf.c.
> >
> > Ian Rogers (5):
> >   perf symbol: Reduce scope of elf__needs_adjust_symbols
> >   perf dump-insn: Remove dump-insn.c
> >   perf tool: Constify the command and option arrays
> >   perf bpf_map: Remove unused code
> >   perf record: Remove unused cpu-set-sched.h
 
Sorry for the delay.  Looks fine to me.

I'll test and process them soon.

Thanks,
Namhyung


> >  tools/perf/builtin-record.c     |  1 -
> >  tools/perf/builtin-trace.c      |  1 -
> >  tools/perf/perf.c               | 12 +++---
> >  tools/perf/util/Build           |  2 -
> >  tools/perf/util/bpf_map.c       | 70 ---------------------------------
> >  tools/perf/util/bpf_map.h       | 23 -----------
> >  tools/perf/util/cpu-set-sched.h | 50 -----------------------
> >  tools/perf/util/dump-insn.c     | 23 -----------
> >  tools/perf/util/symbol-elf.c    |  8 ++--
> >  tools/perf/util/symbol.h        |  1 -
> >  10 files changed, 10 insertions(+), 181 deletions(-)
> >  delete mode 100644 tools/perf/util/bpf_map.c
> >  delete mode 100644 tools/perf/util/bpf_map.h
> >  delete mode 100644 tools/perf/util/cpu-set-sched.h
> >  delete mode 100644 tools/perf/util/dump-insn.c
> >
> > --
> > 2.53.0.239.g8d8fc8a987-goog
> >
