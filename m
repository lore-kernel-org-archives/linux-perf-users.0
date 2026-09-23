Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE33101A2;
	Wed, 23 Sep 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157027; cv=none; b=nqUDbPlTdB4NSpP+cSEjot11y/hrOuRYM2WylIxlq6LqTvKRvxjLzvn4r4547oBfw0B/hGu9CvKKbVZfAZB9icZLf57Rb5AYRnuvNjjya1vXKr7cQkpVhUTe0sbcfo97wTI4kOiEF9xgihHP7u2+GCV27I7LRilyKkyY9pLE5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157027; c=relaxed/simple;
	bh=Rt3/NFZZz4cdcRpxs53KVqUFllGatzRwcr/YgEZsSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdsESxvMDl+2dZTSJHHZiEJZF7c6wQDN62KTyxpiOcRbSp76yzh+2qp4ktIjYz9BIyQVxfjz1VqgEYaVxn0QYb1VYdkML4vdftlDM0Uu6hoBRQNu/rF444AXyOQXLHIIv8wuNTOhKX7+Jea9/6mkZD8NcEy9GSke7VJ8FeMtrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kzg3VwFy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kzg3VwFy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VpSnW0tcXE8Wun87Oph/D5qXO4sz73FbBK/xJn2RUgs=; b=Kzg3VwFyyKI/FWYmFCkZYosU9V
	zolreXvN16jBEa1HkB2teV12avbKUQRJVEjMlteAjzaHwpVq+0EbS56/AjuSl/dt1ZQFJZvWFt3c1
	i0XffPnfGfCQhFIgnzz2duWaux+zYCW94fVZMobEGdpZ1CexZEzD7NNdlOshFN2OVrZ1QvJkp4E4b
	755nYmLVcIeKXZ2Fs1SdMpiYwRNZ6gMtTjsPFnhDuESqROBp3IO6KO+3r/zxrsLG+JaPGqsnkjau8
	Q4okzdCqx/AHDaUodRfNEHqnLkRC31/DAZZUS0TqdycO6SdPFQmdemwzglKF5NneGkJiFIiwcRdpP
	yNkwuo2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9Jc5-0000000Ebo0-2WA3;
	Wed, 23 Sep 2026 09:50:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 428313005E0; Wed, 23 Sep 2026 11:50:04 +0200 (CEST)
Date: Wed, 23 Sep 2026 11:50:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>, Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry
 fixes
Message-ID: <20260923095004.GG2009045@noisy.programming.kicks-ass.net>
References: <20260810133540.1947118-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810133540.1947118-1-puranjay@kernel.org>

On Mon, Aug 10, 2026 at 06:35:33AM -0700, Puranjay Mohan wrote:

> Puranjay Mohan (3):
>   perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
>   perf/core: Run sched_task() for PMUs with only CPU-wide events
>   perf/core: Fill branch entries with a single assignment
> 
>  arch/x86/events/amd/brs.c   |  9 +++--
>  arch/x86/events/amd/lbr.c   | 16 ++++-----
>  arch/x86/events/intel/lbr.c | 65 ++++++++++++++++++++-----------------
>  drivers/perf/arm_brbe.c     |  2 +-
>  include/linux/perf_event.h  | 17 ----------
>  kernel/events/core.c        | 15 ++++++---
>  6 files changed, 58 insertions(+), 66 deletions(-)
> 

Found this series ... I'll feed it to the robots and barring them
screaming I'll push it out to -tip.
