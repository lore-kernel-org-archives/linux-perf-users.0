Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1261CA690;
	Tue,  3 Sep 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369592; cv=none; b=qq/VuZcnOZOuIl2UGR3bypIIemI0ucH5t4oJDCEtPbsWsrKu7UEWX2vqNAzZk4kSsNQvJz4SyklLpm1txtuqln4N1XrAX/Xmt9Wh1big583uoHkDSv3XwOLEoXMPzaFTzkTMUvm62qRcaTsigOKkt8icGSEbbH9+buQI4MbIivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369592; c=relaxed/simple;
	bh=3LR3Vo9v2/QVlM+YnzJyne6t1WkJKy2brUL9jdJJwBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFWPTqFYQBJzB1uer2JDj2FAQy+VSfgW/2Q/tzx0gE3BpBbxB2tIkbfMCvD/o4LejeaFYU0ctLweLNuxyPQGsx7B761EktQYMxl8ibZ89dsE2QOOooy0gD2SLZZ+emso2x21va3weNChe5ARQGPs2Kf+/YG2yvxHJzmfQ+4LgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uCGeMNJG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCGeMNJG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TsaUv6YEUP780d6OnVVT9+ukNJLw+wgrbrBaulCO8zU=; b=uCGeMNJG+s/fz3IDPcONf0HvTZ
	Yuvj+TDzZHA40rkeoM9cDza1uYcnFIzPjpswsENZnMRgAuKm8D3tbNSXFhfJujuUAuBLQuqazf/0F
	NYECsdtRsUMwpvTBDXsBEUOjESEe2MN25fzzoKvG7j2qsLqoJnjKiZ97EsjQFfACPWqjU10YKAfh9
	C9SNsnpbB6muzsaWpjN17uJ+lWS83NY3CUco2WunfKHTx8gydYHDqq5vE5DwLMxCyVmS1GiZKnebB
	rpXU2msJTBfvMpV8ICCnYAuIjLAEv02vC+Hg1d5DsUE6VhfPLF/E+jfIQvcoDWGcmlOZ/ynOTjOng
	Y7wL7eeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slTRU-00000008Fud-1NdN;
	Tue, 03 Sep 2024 13:19:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6E60630050D; Tue,  3 Sep 2024 15:19:31 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:19:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: use kzalloc to allocate xol area
Message-ID: <20240903131931.GU4723@noisy.programming.kicks-ass.net>
References: <20240903102313.3402529-1-svens@linux.ibm.com>
 <20240903124607.GB17936@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124607.GB17936@redhat.com>

On Tue, Sep 03, 2024 at 02:46:07PM +0200, Oleg Nesterov wrote:
> On 09/03, Sven Schnelle wrote:
> >
> > To prevent unitialized members, use kzalloc to allocate
> > the xol area.
> >
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> and since this looks easily exploitable, I'd sugest
> 
> Cc: stable@vger.kernel.org
> Fixes: b059a453b1cf1 ("x86/vdso: Add mremap hook to vm_special_mapping")

Thanks, will queue in perf/urgent
