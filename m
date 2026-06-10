Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F415746F;
	Wed, 10 Jun 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130144; cv=none; b=qvrTDlRb8HtGaQuO2qgWA3722KWeRMr1jbxm74Ps6JVX77oPEhAqJDEZvElHdvkN27Y1Jqkb0+v9mbaW/pcLBM8RtI4b3+b2bHuQfKxNQC++EYNg98rFcmoAPLaK5AlOhoXEahR6WLqC130t9/yAJhcaaIbJt5kl/hsfYQWAWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130144; c=relaxed/simple;
	bh=qWftYTEeAgM5cyyUe5/DYjYeUFcZ7kvb6YVHJDe5u4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i80Aa7tMCrjf4u0hY8FwBe1wnvmho+SZzqAQ1tiDrD68yqlqi95gydx22vDNhPDurrEHmugSBm44v7kKJWQT6DyG9NwG9hw5qcxYGH0PyyJXhz9inSX2uIqiC2ellcUlhu8mrtQ3ZzaH0NRgd98nxV6unzAR2VUYm32N0lDwZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3hsLvTY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3hsLvTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j+sE8nOh+9/EO+xK5fHjJoRmFR1wuFGoh0f0o4+gR5Y=; b=M3hsLvTYRGw0BsuPlRDV8D75wr
	zKBKeoXB+m2pPP6melr3Q3SBkcgZ58qoGXyjSZlLwm6LCziA1o5y+B2pR2hk1M+uSm9z12Z0sekpp
	IIcWBsdvOJaxs6afiDzV118kVa4iOuQAzqevUd3/TN6DGgNyfYu57b6LfcAgjaAtNhu8elyatQWWN
	ZOuXdsKoNJ9JQ5d2ZHELgywEGy1u+pxvyQ1DZ37SEGYlDiTXaAEiZD2ieza5/7wQETYeFUiQHHByM
	ra6KZYhvFsWmXMYIBHnLRRPr2wJLVPI5eb4IRpxXYuqKXIPAbM+Zj33ABqy0BhtdHTBGfbgdp4e33
	TS7zTfng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXRJL-00000000jYg-28Pc;
	Wed, 10 Jun 2026 22:22:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F07493002F0; Thu, 11 Jun 2026 00:22:09 +0200 (CEST)
Date: Thu, 11 Jun 2026 00:22:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
Message-ID: <20260610222209.GF48970@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
 <20260610082051.GF49951@noisy.programming.kicks-ass.net>
 <b3485f13-039d-44d9-af02-5cea084ca304@linux.intel.com>
 <20260610112114.GD187714@noisy.programming.kicks-ass.net>
 <0636b71e-acb8-4e9e-bf55-2343471e52bd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0636b71e-acb8-4e9e-bf55-2343471e52bd@linux.intel.com>

On Wed, Jun 10, 2026 at 07:42:16PM +0800, Mi, Dapeng wrote:

> >> including fixed counters (what the flag "PMU_FL_PEBS_ALL" indicates), like
> >> the below code shows.
> >>
> >> ```
> > Why the markdown nonsense? You're not an LLM, right? And you all know
> > I'm reading this in mutt. Its just visual noise.
> >
> > Anyway, please clarify the Changelog.
> 
> Sorry for the visual noise. I'm using the thunderbird mail client,  not
> sure why the markdown doesn't work.

How is it supposed to 'work'? LKML is plain text, there is no markup.

From what I can tell, there is this thunderbug markdown plugin to more
'easily' write HTML mail, but that is explicitly forbidden on LKML.

On top of that, markdown is utter garbage, the idiot that 'invented' it
explicitly ignored the pre-existing standard of: *bold*, /italics/,
_underline_ and -strike-through-, a convention that has existed longer
than markdown is even is a thing (heck it pre-dates computers!).

And yes, clearly I'm a dinosaur. But dammit, we stare at code and
comments (and email) in text editors, not some web render bullshit.

</rant>
