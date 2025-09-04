Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221D283FE0;
	Thu,  4 Sep 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018488; cv=none; b=utJwU7Zvb0k9LDRcd0AeFCmHtF7as8XOf3YtlK+Dmjj70dFD3ZevVBjnS8Q3phdhyObaCSG/6l8rv8wGva8qGlBqythd9RNfYd0A7kqPbjpP41lvG1quWFXV798AtL7WnYLJ4Kv79ESryaYXB1eDE4rlkCm1GeY1305ISr0Y8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018488; c=relaxed/simple;
	bh=7NlxVxrUFLXMa6eTik+qh4oyZVc2MJmJxeFt7s7o8HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmr4B7DIL2DtY5ICWAjnUfhPGmNKbjGCc9gODYPFZ8NSQo34Er1qOmCMmuksiB3eWmrWe6VNv1DrZO6i8VjnlYQaBjktb0RUnNBL1EjXtsZpYZFm5i4YlzUMtnkriCKRRCejM4KqvMsxBBUUkRltK84v1Kpp0L/Lp5uukrCwH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VrwqXBbk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VrwqXBbk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ehH1eUx008m5MVJTxOKYqVtqxBplrIOaivTvD49Nq0Y=; b=VrwqXBbky4VoLSvwMPttpVzFeB
	z3CqLptYdktmb9NVPIAZ+Rw+WEiZANptCjsclvs+qTOjhmcPXtJIICTD6i0Uyi05rm0I+fe++tfj9
	cSWE8FJ9gHSy4EijGNhoHdvdzQrOS/xli29vyl+p9uJ0dy7EIsoxt2se1e5+QDcK2R9y/QQP2Wk+a
	QKVWxyNedJQGcGc345ArjXYga2vhfbqE63YmA0gwHR6VTUTdNHG5NbZVfYuaPythz1acs7Zr5dMl1
	StfKjJQmio6v3LHqUSDwqENjqftRIP8gy/g0n3e27dkZsQMHClj8H1e/SH6ttn15YMXzikgpkE8Tj
	kCJnFlaA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGli-00000006ly7-0YwG;
	Thu, 04 Sep 2025 20:41:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5CA8300220; Thu, 04 Sep 2025 22:41:17 +0200 (CEST)
Date: Thu, 4 Sep 2025 22:41:17 +0200
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
Message-ID: <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
References: <20250904174430.1414548-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904174430.1414548-1-irogers@google.com>

On Thu, Sep 04, 2025 at 10:44:30AM -0700, Ian Rogers wrote:
> This reverts commit 55a18d2f3ff7 ("perf build: enable
> -fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
> -fno-strict-aliasing is no longer necessary as memcpys are assumed to
> possibly alias.

I don't think this is a good idea. Much of tools/ includes kernel
headers and various kernel code, all of which is written in the
understanding that this (often called broken) C language feature does
not exist.

As such, I would strongly suggest all of tools is built with
-fno-strict-aliasing.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This patch needs:
> https://lore.kernel.org/lkml/20250722215754.672330-1-irogers@google.com/
> which have been merged into the tip timers/vdso branch.
> ---
>  tools/perf/Makefile.config | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5a5832ee7b53..306b8334b788 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -19,10 +19,6 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  
> -# This is required because the kernel is built with this and some of the code
> -# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
> -CFLAGS += -fno-strict-aliasing
> -
>  # Enabled Wthread-safety analysis for clang builds.
>  ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -Wthread-safety
> -- 
> 2.51.0.355.g5224444f11-goog
> 
