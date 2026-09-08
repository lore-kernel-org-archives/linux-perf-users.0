Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8253FC5AE;
	Tue,  8 Sep 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857364; cv=none; b=SlIhupDNQkvR8hKzLOCP6Ez2AgDhCJnuKkTe07jsYbAXV1+jdlxxbsus5oHZIrVobOMPcmuBzfWqJ2Kfh0CUODJj4bqIXsssOEuI2jW3prj5pXQ6Dprx96/vMF7NtENIxPXA7+gMNFA1V9PHs1JjumDJeFLvOumRjp84K5614qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857364; c=relaxed/simple;
	bh=gNHzMN3JECBVPKQwmeyXmUgz2mtrHKiT6Zr4tUg175E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqwvJBgC3PxKIkCRP78I+Kb0EBNyP+EH1CtWbEqPXcrlibP6lRkQ2qg0MzrObPHR4Xtm8BIM/dsrxzImmI1oOsEMR9u6qPY5fTK8VR79kZPjW+XciTaTyvOwvJNjtRf3cDzbRyQSeYPRZo8ej/gxiZAzmd4XzI+nEsLhE+4PbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mugbHeEY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mugbHeEY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bzK/+JpPwiiwFWSylwYDH0BN4/y4WDnsnhFnKvspve8=; b=mugbHeEYClUjx/rp13mv0X8SzF
	aRKdFQtk/Y2OtKHgwc6fQEI0tJ6bK/dRz+gDAgQMEShj/oLESd/B79GJ6x9ls8wHnjTShFcX6doSE
	/jd6FC8A3h3cq5VbGYMr2jW4icjbz1PY7wVx24uSP30VH13hbUn5BGEc+bjcdzUCcfyeATP/TP+Dd
	+hiyaq2kERtroAEfDu5MiMWNA1+Daww6GryI5iax/BPO3OjMvV+NnChwaEiM2BUm/D2OecqV/QV9a
	rQcXlaLnviocQwJFMzj4OurCF3AkromfI+tX0aJpIahrfy+WR1ZGGvNxkVwX8mM+RK6vVbcMxPnvB
	Isz3lRuw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3rVr-0000000H9Jb-2OCK;
	Tue, 08 Sep 2026 08:49:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A27A53005AF; Tue, 08 Sep 2026 10:49:06 +0200 (CEST)
Date: Tue, 8 Sep 2026 10:49:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Xudong Hao <xudong.hao@intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Message-ID: <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908075102.540715-2-dapeng1.mi@linux.intel.com>

On Tue, Sep 08, 2026 at 03:51:02PM +0800, Dapeng Mi wrote:
> PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
> to user space when the PMI exits. Since the skid from the PEBS/IBS sample
> and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
> can diverge from the user stack at PMI return. That mismatch breaks DWARF
> unwinding.
> 
> Precise sampling provides no benefit in this case, so disable PEBS/IBS
> precise sampling and allow only PMI-based sampling when
> PERF_SAMPLE_STACK_USER is requested.
> 
> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

This breaks long standing existing behaviour.

