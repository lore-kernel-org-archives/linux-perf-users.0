Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30C27A928;
	Thu,  4 Sep 2025 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019575; cv=none; b=N4VrDec+SrNd30IwW5oCW0XgzVN78NUzO1s7hI0aB+K1xtZ1t6MYBT6Fzode6EMxGSXZSsTlACwWGRTCg5UT3d2CpzrqQpl/zb1W+4BdoI9x8aRFvMlPvdK48YnZUR88AQVMBR0ElgLaFEAGGM+lfVO2vi+QpfNVVXDu20m6R/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019575; c=relaxed/simple;
	bh=Rdp4rjTFIuVTiDFMr4xdCW6FDS030ywSPM3wO4u6fJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieEpIoFiFUJoQcENlA6XE7t5KzLZveVTja/NVPuCLrr2sXpL80bbldv+aUCOTEuzOTilRJRCvWaR4Ka2NC/i7tOmeZie/Xch7wawROxSgNCtInfruP61O1cnxDCV+492RiqR0vZKvtHrje26MuE8oSrjwLflw4sDMA5VA00J8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vTGrkSdi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vTGrkSdi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uc6KWhjG3fIIsshsHXRYa4oPr+EqT9YgadIb5TShV9Y=; b=vTGrkSdivi/ttQvTKZGpMGcwk3
	iEVwolX0AwEph2soeoKOCRYG7Ssc99bJhxK6N+we5Tuk0745USNEIvakmyVvDU7RprxgYaB+PJvDA
	6g6yIONxmPik4r2y9p/36z5Oe6wCLTzrVLBm+ybX8o9sejJsDEPBwA7n8HOH94QAgjmFYhve2ft1O
	HUVZqqicLlJTD8PnXlby6HetPzTrjPJbu3xCfZTBaI47/6TAKZ0QNjjh/XMsvHv/oK4V2hNb90kmI
	2cWCTWzaksFT/p7ytrG1Tov8wd/a0RvoFIPPaOW2Hf20jfkhjP8PVlBs7TrsmPD2+MdNttKtMcwja
	GPBtNxcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuH3E-00000006xaf-2BtI;
	Thu, 04 Sep 2025 20:59:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B404E300220; Thu, 04 Sep 2025 22:59:24 +0200 (CEST)
Date: Thu, 4 Sep 2025 22:59:24 +0200
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
Message-ID: <20250904205924.GO4068168@noisy.programming.kicks-ass.net>
References: <20250904174430.1414548-1-irogers@google.com>
 <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904204117.GC4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 10:41:17PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 10:44:30AM -0700, Ian Rogers wrote:
> > This reverts commit 55a18d2f3ff7 ("perf build: enable
> > -fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
> > -fno-strict-aliasing is no longer necessary as memcpys are assumed to
> > possibly alias.
> 
> I don't think this is a good idea. Much of tools/ includes kernel
> headers and various kernel code, all of which is written in the
> understanding that this (often called broken) C language feature does
> not exist.
> 
> As such, I would strongly suggest all of tools is built with
> -fno-strict-aliasing.

Similarly I would strongly suggest having -fwrapv on all code that
includes kernel headers.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > This patch needs:
> > https://lore.kernel.org/lkml/20250722215754.672330-1-irogers@google.com/
> > which have been merged into the tip timers/vdso branch.
> > ---
> >  tools/perf/Makefile.config | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 5a5832ee7b53..306b8334b788 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -19,10 +19,6 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
> >  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> >  HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> >  
> > -# This is required because the kernel is built with this and some of the code
> > -# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
> > -CFLAGS += -fno-strict-aliasing
> > -
> >  # Enabled Wthread-safety analysis for clang builds.
> >  ifeq ($(CC_NO_CLANG), 0)
> >    CFLAGS += -Wthread-safety
> > -- 
> > 2.51.0.355.g5224444f11-goog
> > 
