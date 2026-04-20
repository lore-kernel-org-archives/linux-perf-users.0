Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0782D7DDD;
	Mon, 20 Apr 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685292; cv=none; b=FdEtwV502XSuCnNPBIrTuJiDSmc8mkp//O0YaT+RQhdudSQEwSvXMn7qcm/VGQ1aBzy+CPxiVnRuaHmXrS4A0z3uFaDQWPh9LE4pV6wbZwrrhdEzgrc4pCPQmyGAwuJ9Ev+eRWmj67L1Xz5VZvZDJnH4PRSVT9CAZOdHvHP4U/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685292; c=relaxed/simple;
	bh=geEhx5opg/GjRcdrqH700twIU396nMsUul9wT9Y6Gko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDGT+BUMq2hnhCU0Q2ktD7rBwbCmx/yQV+pOOoXn8/tstJDjdT2IysXsgQ01tt8QPGAP+II1oAP9py3T8qeyCz8ykq3rgCXxNlfzXtKiNldJL2GZg1OkUG42ExRuemjRtkI/QX2OxDdHvfWFS0MNMLkEWbZAQjhkche7fuPaGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yu9gvq0m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yu9gvq0m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cdVxaYZ2E2yrNVajyAiVgLj5QX8bDri5Xi0+5Q5QvWs=; b=Yu9gvq0mY1uGEqIt65gZkamU4w
	O33bHdWZ0n0gFBh15Hiqf0Ox2yy0PZ3q8FaeoyGi9pz2+X42QPcSipFN6T9YS+SRbnlldTnecebaP
	nfGXOWbn8zv+qn42nJJxxgOUEhnlcoDSCcO2HtxoFDkcwJVUEBfvL8VCEO6bcDMt09zkvP7Y5Lgx/
	3AN2Kia+66DlSPr38A4Xzy0v+j89OuiCTqdTpNn5zqkyzpG/5bTbaDgHL+rByr6LsqxNdkmUmqiF3
	TNukAEiAT3jeNWlI4w47k48aPpiP2ZtESPYXGubg2LT7i80mfM7RID2N8PnTAJKB4dMk7LlgZQbc3
	/btmPERg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEn0A-00000008LF7-3GX5;
	Mon, 20 Apr 2026 11:41:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1112F301BDE; Mon, 20 Apr 2026 13:41:17 +0200 (CEST)
Date: Mon, 20 Apr 2026 13:41:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
Message-ID: <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420113512.GG3102624@noisy.programming.kicks-ass.net>

On Mon, Apr 20, 2026 at 01:35:12PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:
> 
> > - Use functions instead of macros for accessing MSRs, which will drop
> >   modifying variables passed as a parameter.
> > 
> > - Eliminate multiple accessors doing exactly the same thing (e.g.
> >   rdmsrl() and rdmsrq()).
> 
> So far so sane.
> 
> > - Instead of having function names based on the underlying instruction
> >   mnemonics, have functions of a common name space (msr_*()).
> 
> Not sure on this one. The whole msr_{read,write}_{safe,noser}() thing is
> a royal pain. Also 'noser' reads to me as the noun that goes with 'to
> nose' [he that noses (around), like baker: he that bakes].
> 
> I would much rather we just stick to the mnemonics here. All of this
> really is about wrapping single instructions, no need to make it an
> unreadable mess.

Also, the _safe suffix should just go away. All MSR accessors should be
'safe'.
