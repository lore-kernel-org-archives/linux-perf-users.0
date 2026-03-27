Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C63DD526;
	Fri, 27 Mar 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607751; cv=none; b=gvysTxRy3wIcjPiUmlAI0tWab9jv+ZLwXDPn3jcrEueMJRej/OBm9zGjqrfLkv0NtSBTXx31TUaNgcPslMQErRJ8fUsR1zke6aW/clkDZzijEnnRtGkTFeKRpbjRLdEEwvrALH6W5qQYsoDO23B+jAvfrlJUgDkwBEwk/KOrLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607751; c=relaxed/simple;
	bh=iCuO05cXDj8nJodWCHKZ+HKSc7xpKk8IhrcD05Kby2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtxow/y7LozVN1p0DtTAZs2j5s5e4YLfb/0fw7b3HXy67kVMCWgs+ffFEASbdRccq3I8CjPJgOlJsSvgvS7Os/g7L2wuquP3MLyhfg62tkCfMfH2+eX8Cq6YXIdJnz3lAmsJ2mYBogNAdw4g/kBohwDWLmuZLCcd0iZ6rlcWKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dCyXatM3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dCyXatM3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GwcgDFrapX4IPbQGR4vJCqt4IJ21ygC1fvu5AsBMXoU=; b=dCyXatM3dPktdyqvVYvjp3fUu0
	dh3URBQfPFWrmPSeDzVvOzhjgatdz/Sb+59kPfuYSWJrT3CoUMnnyo7QXJIiWvZVYm0RB4BjIcNV7
	erR7t440V8afLyjx38WAaq4Qe5Z/xTtIjVyaLVLg6jmYHFyg4S4BvDYDjX0uznCRKSBD+Cb4dB2cD
	AN8FUFwP2h85adAYLB0i/SEsP4VM8auo2ZKgUUvp73KhGEztsFFSCBGvdvQ8wEdDNkyQ03vcmgKpH
	9eJUhr7sYH9X3D2ewBmrSs3EEfh5EZjFt31PIOdWJ/X3YLRMlidXm3ZzB/cyOJE85VDMCMbGzEd6v
	aGIQyIQw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w64XF-00AZ8M-Cw; Fri, 27 Mar 2026 10:35:25 +0000
Date: Fri, 27 Mar 2026 03:35:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Leo Yan <leo.yan@arm.com>, irogers@google.com, cme@kernel.org
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-ID: <acZcG634vXs2_EWj@gmail.com>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com>
 <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
 <20260326163926.GB356832@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326163926.GB356832@e132581.arm.com>
X-Debian-User: leitao

On Thu, Mar 26, 2026 at 04:39:26PM +0000, Leo Yan wrote:
> On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:
>
> > From the stack trace I don't see anything that should allow this.
> > Either the list of metrics is broken, or the struct metric_event's
> > evsel is NULL. But that should never happen as we wouldn't have a
> > metric at that point. The sorting shouldn't affect that. If you can
> > reproduce the issue, verbose logs may help.
>
> I believe I encountered a different issue, which is irrelevant to this
> patch.  So Breno's patch is fine for me.

That said, are there any concerns about merging this patch in its
current form?
