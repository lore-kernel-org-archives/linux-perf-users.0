Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C671FBCA7;
	Wed, 10 Dec 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381392; cv=none; b=JW5MNaK0RQB/8QWXrQ6nvfztXxNlrit3JAP5cDMe23cnVEVJ64dVLR5OaTJ92e8hhixZ6eS52p6UZc2xKHjuzaEqzDex7aMNYSDjNq77RFYeACBwF5UvOUkyFPPEPMqW08D8vVl4nBjY5LuLZ1QsVE9bqDOin8NBkUovMLtkiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381392; c=relaxed/simple;
	bh=e+bzzvKW6w7/9rgS0Xvy0xmPlpQQ01jm7WH1y8o52e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1rPLeemLRr6Y1rXt2tHXkkoLulGjFwvzxIfEE5+/P+lUBcXTV9B2dnn6LzAVs8bLI1SyzUxO601PH+nYblGKTQTEgqTAVuGbJw1wM/4wCFUl87Xpgwzt9uPHtJmaexI1VkMGEWZrLd5Nl0wB69XZ+RqNeHh7++8bR2RBfoRq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 848B8153B;
	Wed, 10 Dec 2025 07:43:03 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE623F740;
	Wed, 10 Dec 2025 07:43:10 -0800 (PST)
Date: Wed, 10 Dec 2025 15:43:08 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
Message-ID: <20251210154308.GZ724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
 <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>

On Tue, Dec 09, 2025 at 01:37:39PM +0000, James Clark wrote:

[...]

> > +	if (!is_trbe_running(trbsr))
> > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> > +
> 
> Do we need the complexity of COLLISION (changed to PARTIAL in a later
> commit) and TRUNCATED at the same time?

> From my understanding, TRUNCATED would be when Perf is too slow and we want
> to disable the event for it to catch up, and PARTIAL is when there was some
> buffer error so technically we don't need the event to be disabled, but Perf
> still needs to be notified if we want to start only resetting the decoder
> when a flag is set rather than on all aux records?

The main difference between the TRUNCATED flag and the COLLISION/PARTIAL
flags is that the TRUNCATED flag implicitly asks the event core layer to
disable the PMU event.  In contrast, the COLLISION and PARTIAL flags are
only stored in AUX record and no additional action in the event core
layer.

Setting the TRUNCATED flag would be a over-killer if the buffer has
free space, as it would run the expensive sequence of disabling both ETE
and TRBE and then requiring userspace to re-enable them.

> There is no happy path where there is a buffer error, so I'm not sure why we
> need the complexity of an extra case? There's no harm in disabling the event
> on a buffer error. Also it's hard to see what the exact scenario for PARTIAL
> is, because we set truncated anyway for fatal statuses. The comment in the
> later commit for the PARTIAL change just says "trace was stopped", but not
> why.

The trace can be stopped on Fill mode (stop on wrap) or Stop on trigger, so
it is not (only) about buffer error.  In these cases, even though the trace
unit is stopped, the buffer may still have space available, tracing can be
directly re-enabled in interrupt handler, thus the COLLISION/PARTIAL flags
are better choices.

Only when the buffer is actually used out (i.e., handle->size == 0), it is
appropriate to set TRUNCATED flag, since at that point we must wait for
userspace to read out the data.

Thanks,
Leo
