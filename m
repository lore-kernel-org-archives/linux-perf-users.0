Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC2276030;
	Fri, 18 Apr 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744981867; cv=none; b=L5azEW296QEDsqqZLcdpaPSFTxSxZ/oO6Ir+U38hbipN+Sp9S83C+TFC1t8aD6iMDyGP4iv1cDZwZYPNSCZPMch4Da3CX5APD9wZV/OQtd+M1QTBr1nB6t6WmEkHsMo+n3oVzmftcSVyUaCTtsv8pwhHorQTkIGWrTmv3G6ZVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744981867; c=relaxed/simple;
	bh=b/qjTHYUlPuXTBOX0HOYHg04CUK/04jjhZcMnxxjqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbLkSaC1xX0CMaSYEgqFsjcH2lrdTd7S7vAiyiwu/EkZQngM/eO9vbo/brHF9Ldf1Iy8S+52rLDnfvKamijZ0F9RSFd847vGK1o/4AXW0/gQ+lGmhY/XjCYrZZdBdfobPD9zH5VvJUAblcCfItsfmwwUCEGfx+MhntmO4R7l0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CO5GmuOX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CO5GmuOX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b/qjTHYUlPuXTBOX0HOYHg04CUK/04jjhZcMnxxjqZA=; b=CO5GmuOXzwJylTDYCZcbR87yN5
	b9Mz1mCKtOEcwSLCk7YHkLBl4MK7z6HhLpwkjWolGi34EkaRa4rWXfBoPcg+W8FEbN8zcgHCAlaAX
	71n9HV4QMRIVaeWxHRCtLW7XCG7ju6FMr4i1wwJn2rJu2mY5W3AIEMp2jB8Z/TlZTtUg91ejfiHS7
	BiTz2PxcR9gvMiNZv03GvYHPaVGJMDQ0KwMfYDPjKzUW1qELybtk8r45r8oGuHXlUt9RQxEIbBali
	8ddzcWBdSlqnnnhXAdefB7jjus225yNqSiwI9BMbg6IfedIj22Db7Yoj1Yylt4gvr3VQC/RChkoHP
	Q9PqTZaQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u5lUf-0000000AW5B-0q95;
	Fri, 18 Apr 2025 13:10:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC098300619; Fri, 18 Apr 2025 15:10:56 +0200 (CEST)
Date: Fri, 18 Apr 2025 15:10:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH 2/2] perf/core: Fix broken throttling when
 max_samples_per_tick=1
Message-ID: <20250418131056.GF17910@noisy.programming.kicks-ass.net>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
 <20250405141635.243786-3-wangqing7171@gmail.com>
 <20250418090302.GO38216@noisy.programming.kicks-ass.net>
 <ca94f413-4e35-41fd-9554-c80d6e2707ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca94f413-4e35-41fd-9554-c80d6e2707ac@gmail.com>

On Fri, Apr 18, 2025 at 09:08:30PM +0800, Qing Wang wrote:
> Thank you very much for your review. Do you need me to reorganize the patch
> and send it out? Because if only the second patch is accepted, its context
> won't match the current mainline code.

I've stomped on it a bit and pushed out to queue/perf/core.

If all looks well, and the robots don't have a fit because I failed to
compile test the thing, it should eventually make its way into tip.
