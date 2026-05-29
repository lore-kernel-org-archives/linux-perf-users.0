Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D583D75CF;
	Fri, 29 May 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054713; cv=none; b=eIQP3nTKAzOZ+hxURJL4zYHqC6vwo4z7/ZEHt/L4q/ZvJhTMB+0L+RPJeX9X6uruGkhks9GUUYsM3YFZTmX0aWifnEiN4T96+69WfmRa45mf2KbwJNg/ilXBKO1XtYY0zLmZW2M476XD/LX5C0pHvft1rkE8n0km4h1OCHvzAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054713; c=relaxed/simple;
	bh=paQIHevfyhfY55MNtkjl2WSNCnbbzhYQJgRU0+XOSMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUqhhuV2MZQgG6GmVVJPdo/i7oII4jN04NhnNldhMhMVX+2GqgKNNGBOgDDqKA0Bg/2OuB55aFBn0Uzu8cB4yhOJg2ctYKC7+0Ks2Fe2tQkygPl/cHJv+DTqF8/3vfN5xWNn2fFgiX7DUy8c7qk0fHKjxOsMnco+ZAZsF2ICUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G3jUsdmJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3jUsdmJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQUjr0Cu/Myy39gE7Z7xByL5jdglAZNNAKmlAsomwHU=; b=G3jUsdmJ2H6MOQYkaixCgziYZ+
	5iSnj0BaQzkaikGkAHwzSlIKAVXXWbuPEcG+hAUmFT6AmcQRBE5HByMpWyCNOE2ArWFMGXVxqADI6
	GcUkroOuzXOQeMa/02n31iI8svY9HfJW1ZRfT/LXv+Pq50dMMi4PfOug/Unal8dqvgruoIT8VSuAE
	p2mUuUlymW4lz5KQDVah32BkZaM91HkDY3LwNVMimsWObCVn/ptXnu8NMnLbLQoQiQLpkjj0uC8WW
	imK+kGQ4nbwMYSQjECLFi7H9wT4hsCGlLyxnn3Bs3KN6JBqUlLM/F2mFx9BWF8AXTDgofTh899UfW
	E6A0X8EQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSvXl-000000062g3-1Yn4;
	Fri, 29 May 2026 11:38:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 492B330036F; Fri, 29 May 2026 13:38:24 +0200 (CEST)
Date: Fri, 29 May 2026 13:38:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v8 10/23] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
Message-ID: <20260529113824.GK3493090@noisy.programming.kicks-ass.net>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529075645.580362-11-dapeng1.mi@linux.intel.com>

On Fri, May 29, 2026 at 03:56:32PM +0800, Dapeng Mi wrote:
> Previously, XMM register sampling was only available for PEBS events
> starting from Icelake. Currently the support is now extended to non-PEBS
> events by utilizing the xsaves instruction, thereby completing the
> feature set.
> 
> To implement this, a 64-byte aligned buffer is required. A per-CPU
> ext_regs_buf is introduced to store SIMD and other registers, with an
> approximate size of 2K. The buffer is allocated using kzalloc_node(),
> ensuring natural and 64-byte alignment for all kmalloc() allocations
> with powers of 2.
> 
> XMM sampling for non-PEBS events is supported in the REGS_INTR case.
> Support for REGS_USER will be added in a subsequent patch. For PEBS
> events, XMM register sampling data is directly retrieved from PEBS
> records.
> 
> Future support for additional vector registers (YMM/ZMM/OPMASK) is
> planned. An `ext_regs_mask` is added to track the supported vector
> register groups.
> 
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

I suspect Sashiko's last point is valid and using XMM sampling on older
PEBS will not do the right thing.

Creating PEBS events with XMM reg sampling should fail if the hardware
doesn't support it. That said, I could easily have missed a check for
this, this code is a bit of a maze :/
