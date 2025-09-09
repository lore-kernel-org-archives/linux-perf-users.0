Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48636308F38;
	Tue,  9 Sep 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412842; cv=none; b=FbfXqG/+71R31BlBhFg4syJBPsfaebx5oTOGu6MDwv4o3HpahzUp9hs6yg8Omcfb92rUFWD03YlRoaaamF45CMMBbTmPNLtGIoBIKqbS4WCrBTr+VvCFvEYlWHEpRAv+kH7wbmWCJ7f8J8iBfZQZ3rG0fSiPqghYP0ET5PDHfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412842; c=relaxed/simple;
	bh=rDOvX1jXD3xLt+87NPZeuOJJsiKulXU/pJNwH4i3Ol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoD1MuHCKb0qY0Q6fsM/tRMCakj/UQ0ITg4C6uALvdvEvhjkRCgH1+eapHmBjZVE0WyFXInMqKBxTBsMAdPryZmofKdtW0a3PZiXT/pn53PCCqw9t7X6N8TJ0MDTIKLYtm/kz99md8fwY4PWjdPQT1mitTTLwZHK01LPUy1Sffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D11113E;
	Tue,  9 Sep 2025 03:13:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101DC3F66E;
	Tue,  9 Sep 2025 03:13:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:13:57 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	George Wort <George.Wort@arm.com>,
	Graham Woodward <Graham.Woodward@arm.com>,
	Ben Gainey <Ben.Gainey@arm.com>,
	Michael Williams <Michael.Williams@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf arm-spe: Improve --itrace options
Message-ID: <20250909101357.GB12516@e132581.arm.com>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>

On Mon, Sep 08, 2025 at 01:10:17PM +0100, James Clark wrote:
> Most people also want all the SPE samples (instructions group), not just
> the flagged samples that are put into the various memory groups. These
> should have been shown by default but weren't because the default
> interval type wasn't supported.
> 
> Also when looking at this, it appears that the downsampling was behaving
> in a way that would discard samples from one group but not another.
> Improve that and the warning messages.
> 
> I don't want to put fixes tags on these because it's only changing the
> defaults and the behavior, but I don't think the previous behavior was
> incorrect necessarily, just copied from tracing techs but not ideal for
> SPE.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

I ran the commands below, and the results are good for me.

  ./perf report
  ./perf report --itrace=i100i
  ./perf report --itrace=i100iM
  ./perf report --itrace=i100ib
  ./perf report --itrace=i100ibM

Tested-by: Leo Yan <leo.yan@arm.com>
