Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D81F3FE2;
	Sat, 21 Jun 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499030; cv=none; b=GMdvveXRVXLzLpnYzCuKEiasO17oJU1iE0h/dwgtbBMIiaVIdj1vrpZp3ezszTovqfImc1L7zvyb2jLN+OMQ7IIHjpkpcO+J61PyOiJNuOgSXAtHqAfLrH8Kd0UHwb87BxmwjaZSPUOdcXeUchZeP/UVXDcx9f8hd97lmsaUES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499030; c=relaxed/simple;
	bh=ffbNxgpOKvf281WhBccu7KyQlAKq2ILH5jdDQNCbOnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfHHpG0+QLiPlBBpl5vQGaWODtiitlU197cmpf7DNYggGJRgXwFgmM/adjBEDgCpVFecd00D3ajyKceYkhI/5Yq6nP/Pn1aLyEPO5OH+oh+MY1KrbiBvjLxGmlXKyoDCSPeofmt+rTZN7ry9YL6CUdC9olhFt/1HH1O2Ya67hIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qiTGoo4H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qiTGoo4H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zmAq7HGZLVbDEt7lvz/S/aJJLYAju8H/HDm67PyTXKI=; b=qiTGoo4HeOjnzjRyJVZ/IctsiS
	aqollM0W3kTQ/nMqN8cv2wur3MvEX/2SaJ1ZkDajp0V0Q6+n+fCDg0sBs4PupZ1gsI74wr34vdSYE
	rORIrBjSk9MoT6Rre66/jrCd9y0T8DCjbI3SLRjE8w25SJqy8eVGADPFOl4dZdQLQdxYSdd9Kj9Sx
	KZ+prkxBLnMeyu6i1CChavDwQkWxhYRCxO+VGlVlc1VLTgVhYMH86uawvbzXyJ56gr/Xh3Oc+NoDc
	1MzoI5Yvu2KJK/bOaJW3UvgZjLAsZPANmXifzcouMD+mOr4oHNOD1rSfU2sgbAEAyqDeOL9E4Rnss
	jNjSatSQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSulD-0000000Ewyh-25cU;
	Sat, 21 Jun 2025 09:43:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13DBF30BC49; Sat, 21 Jun 2025 11:43:43 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:43:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
Message-ID: <20250621094343.GY1613376@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>

On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:

> +		if (cpuc->n_pebs == cpuc->n_large_pebs)
> +			index.split.thresh = ARCH_PEBS_THRESH_MUL;
> +		else
> +			index.split.thresh = ARCH_PEBS_THRESH_SINGLE;

> +	if (cpuc->n_pebs == cpuc->n_large_pebs)
> +		index.split.thresh = ARCH_PEBS_THRESH_MUL;
> +	else
> +		index.split.thresh = ARCH_PEBS_THRESH_SINGLE;

> +/*
> + * The largest PEBS record could consume a page, ensure
> + * a record at least can be written after triggering PMI.
> + */
> +#define ARCH_PEBS_THRESH_MUL	((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_BUFFER_SHIFT)
> +#define ARCH_PEBS_THRESH_SINGLE	1

Can we please do something like s/MUL/MULTI/ or so. My brain keeps
trying to make it MULtiply and that doesn't really work.
