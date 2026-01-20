Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F90427A16;
	Tue, 20 Jan 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911853; cv=none; b=CG1/MMF2cAhNiIM750xyH3DAclYnm2lTimfAePQx8cfpmCxnXWURVaAeI6faN+quyUIRSsDgehrRM6JS+S0K0tzcpMlCb5/5eGuZ4zWkDgmcTH/+mBC5jSr83jFzaFQPbPXFgN6eYXkymXRe5Kx8MZ1mDADmJxmISwMOBlLNWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911853; c=relaxed/simple;
	bh=pAj8Xy7WRNluVSDSB23qgwVxGX259vxhOEai0oeHhDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfUs0s9NoFyy7mtzyz6ELLcemQImKTVeKf14yLKsojUnQ1R1JudBCDr+qazrHHWoyWlqPZcv1IlvwpHW6eJQbPYx8UHVtqf07RJ/mTG4wOH/9i3YE5k98dPiiet04Bk6+effqPPRYqNSrEXO0lKyosnu07RGhXdpiMMS3t0X47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NyCycZDt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NyCycZDt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A32w9AWVglkrvicm99KWIzhWv+XxqGyzhDaMbJ/YCIg=; b=NyCycZDtLDhmz47jznrgVcVsNL
	rZikBVSG/yzjsXPD4MuHKMslONcyU3568k0NhA6E9uXKuTrmq60lvWd3uleRb8XCOISbJW5X7uP/M
	V0A5xYwUMW0TQv9igd98mJdcDqx/EWZRWJDscpazw1f9kUcIQ80/cwwPTwjrBdGzRHVVsSdyhaCeF
	RqL8S8wAAvapDINzCIoVsBqTojcxS6v50FSoGYuRoP8flN8LjahBD1SaJuTpqgBnhYZMcPTSb0kxa
	bdh0kisQdyXwyrE1ntiTuIcw9NKb+F+mH23J43TciYl2+AiEc11hAcJieTFTieHNkcev8E5vHkjye
	dLYHtG6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viAm0-0000000ElJX-00y0;
	Tue, 20 Jan 2026 12:23:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BAE3C301C52; Tue, 20 Jan 2026 13:23:50 +0100 (CET)
Date: Tue, 20 Jan 2026 13:23:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: yi1.lai@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND] perf: Fix refcount warning on
 event->mmap_count increment
Message-ID: <20260120122350.GK831050@noisy.programming.kicks-ass.net>
References: <20260106203547.38354-1-whrosenb@asu.edu>
 <20260119184956.801238-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119184956.801238-1-whrosenb@asu.edu>

On Mon, Jan 19, 2026 at 11:49:56AM -0700, Will Rosenberg wrote:

> 
> Notes:
>     v2 -> v3: Update patch to error out instead of incrementing.
>     
>     Thank you, this is a much better solution. I was not thinking
>     that the mmap itself was unintended.
>     
>     I believe you are missing a "!" in your patch. After adding
>     that, I tested the patch, and it fixed the bug.

D'0h indeed. Sometimes typing is so very hard ;-)

>     I also wanted to check my understanding of the race with
>     perf_mmap_close() to double check this patch will not cause
>     an issue. perf_mmap_rb() should always hold the
>     event->mmap_mutex, so there should be no race on
>     event->mmap_count with perf_mmap_close()'s
>     refcount_dec_and_mutex_lock(). If there was a race, we would
>     risk returning -EBUSY when we should "continue as if !event->rb."

Since we're failing perf_mmap_rb(), it won't call ->close(), right?

Also, we already have an error path on data_page_nr() mismatch.

The caller of perf_mmap_rb() has if (ret) return ret; nothing is
modified before calling perf_mmap_rb() and perf_mmap_rb() itself hasn't
modified anytyhing yet at the point of failure.

So afaict we're good.


Anyway, thanks for the patch, I'll get it applied!
