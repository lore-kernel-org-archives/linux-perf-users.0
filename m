Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6378F40;
	Fri,  9 May 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821731; cv=none; b=m4Jarq2K300ubznNIzPMo9zMwjTNxn5hwsjUmwke/iwV/ZWwrQbwh+ESloJbdxCZVgQwcQFyGbjLMIg9rDa939dA242qmcbs0L6uByxtSg8XSMLC2COdsT378r13UaKPxbkua0Qjub2LPYwkcyHtikLH7pVEiLFdVm1Nafw35mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821731; c=relaxed/simple;
	bh=hraG5Vv2A6f1zZkHsHgNvWLVkQqe5hXiyFn5QxJZRuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIc2ex3bivbCLzuyv/aHRCrWmP94R8Mi2JxTbqv4HetdTAIwHrhPiLMlpZvbfhdp6rRD1FedJvC6rOZuFNGnLJ/zk4iRCXF9OSTs/+5LjbdlpO7sTo+OCSB71M8BuLHK9ls2YrHlDmhsp4E7aMFI+wc/2OyHXH8tSXMr88bU1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnUElRnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnUElRnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D5CC4CEE9;
	Fri,  9 May 2025 20:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821731;
	bh=hraG5Vv2A6f1zZkHsHgNvWLVkQqe5hXiyFn5QxJZRuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnUElRnwI5obN5bwQ9uGQIIenQ1mnQEfWf0iAbNBYqii+ALHf13JK9AuALDcauFcA
	 l6yN2iQqgFxqqGe6zcb0Z2INKQT2eyAuy2vUwu0k7+wym+cH9W+SWR5lWcmV84dkz9
	 /AOfvl1FCmOnM2WQz7v36YaXO7NokESxsjEqPyGa9U8CdW1/j9eAWHzbpIRVT/HovW
	 MdaOfo5YS0Qu/iuiv34FUjQm5bd4Qeojy2mRfZd93EFQglJGFOuioRTgSqimwpmoBH
	 j5FfKOy/GaB2/mo+O//Mgg4GRebfFl1QNHOhFLTUhKqPGDYvvTl41JrFqBPG42OzSN
	 ErXKkcW1eUJqA==
Date: Fri, 9 May 2025 17:15:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf lock contention: Add -J/--inject-delay option
Message-ID: <aB5iXwMTs85nrioq@x1>
References: <20250509171950.183591-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509171950.183591-1-namhyung@kernel.org>

On Fri, May 09, 2025 at 10:19:50AM -0700, Namhyung Kim wrote:
> This is to slow down lock acquistion (on contention locks) deliberately.
> A possible use case is to estimate impact on application performance by
> optimization of kernel locking behavior.  By delaying the lock it can
> simulate the worse condition as a control group, and then compare with
> the current behavior as a optimized condition.

Thanks, tested and applied.

- Arnaldo
