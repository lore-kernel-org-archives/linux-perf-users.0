Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F221EFFB4;
	Wed,  7 Jan 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773286; cv=none; b=FPpYy09VfDALcYN63UZzLbRAUaQ9U5QNBTrThzZr6QCr9bTbYxaePTjfk4UDD6fiFKM/uiWIGrVfGYrpTGgHnAKAPipPfuPtPYYjdUXelRd+2Kliw6FzHczDKRipaYJBV7DCc2OQmPlL62SHoKtGFDxk+cBe3Pv+9GL8ou5lh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773286; c=relaxed/simple;
	bh=8VsPOcXwdkALy85Ny+QOC1MBzv447OWUwmSgomb+Ubk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhiW7VzkyM3dTsHid9yGKGcKQfwd3oKH/5xPb+rskersPItodXw5YNzPRfVr8OS6R9utQ8scX0Y8PYvoUR1ehgyOEqapY8MlelE0ID286e54SDXBxnWqrbnhM9hfELSHdh/YL+pSRjF1VjuYnj2ExtpjXkvwftMbpGz7zV83rR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWUtGsG7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWUtGsG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D337DC4CEF7;
	Wed,  7 Jan 2026 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773286;
	bh=8VsPOcXwdkALy85Ny+QOC1MBzv447OWUwmSgomb+Ubk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWUtGsG76FBmKKTFZ9PnQXyIKxlh0hwsIbjixFAwle+Y6QSdSiXk3VRzsOtdGfZxt
	 a7sVEyHf7ykz3cFNEii5nbGPmqmXUzXbX3indmyErBDpFLaQxQ5LdBAPs47KCU2w7L
	 N5OIZG3iy8Y3M7hwhHJnicWBkxYOn1poEvME2+cn9e7GaGVEBIZhGw61QZheXMxpC3
	 TBKTS6c6kbGm6TuN8lyBCP42oew+EyBmAJ0WFuHRp/8U9PBShviVg1lvS1yEomj44A
	 nS5IKakMDvK+r7n26sR4nX7xTrhDYxCgR8ls7JW/5W3MTA0LE0jezjWzYcY91wUZEY
	 Lon9AVWhDaBuw==
Date: Wed, 7 Jan 2026 00:08:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
Message-ID: <aV4UZCCc2QOhdeSE@google.com>
References: <20260104011738.475680-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260104011738.475680-1-irogers@google.com>

Hi Ian,

On Sat, Jan 03, 2026 at 05:17:36PM -0800, Ian Rogers wrote:
> Add events for memory use and network activity based on data readily
> available in /prod/pid/statm, /proc/pid/smaps_rollup and
> /proc/pid/net/dev. For example the network usage of chrome processes
> on a system may be gathered with:
> ```
> $ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_carrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo,net_tx_packets -p $(pidof -d, chrome) -I 1000
>      1.001023475                  0      net_rx_bytes
>      1.001023475                  0      net_rx_compressed
>      1.001023475         42,647,328      net_rx_drop
>      1.001023475        463,069,152      net_rx_errors
>      1.001023475                  0      net_rx_fifo
>      1.001023475                  0      net_rx_frame
>      1.001023475                  0      net_rx_multicast
>      1.001023475    423,195,831,744      net_rx_packets
>      1.001023475                  0      net_tx_bytes
>      1.001023475                  0      net_tx_carrier
>      1.001023475                  0      net_tx_colls
>      1.001023475                  0      net_tx_compressed
>      1.001023475                  0      net_tx_drop
>      1.001023475                  0      net_tx_errors
>      1.001023475                  0      net_tx_fifo
>      1.001023475                  0      net_tx_packets
> ```

Interesting.

> 
> As the events are in the tool_pmu they can be used in metrics. The
> json descriptions they are exposed in `perf list` and the events can
> be seen in the python ilist application.
> 
> Note, if a process terminates then the count reading returns an error
> and this can expose what appear to be latent bugs in the aggregation
> and display code.

How do you handle system-wide mode and sampling (perf record)?

Thanks,
Namhyung

> 
> Ian Rogers (2):
>   perf tool_pmu: Add memory events
>   perf tool_pmu: Add network events
> 
>  tools/perf/builtin-stat.c                     |  10 +-
>  .../pmu-events/arch/common/common/tool.json   | 266 ++++++++-
>  tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++----
>  tools/perf/util/tool_pmu.c                    | 514 +++++++++++++++++-
>  tools/perf/util/tool_pmu.h                    |  44 ++
>  5 files changed, 1026 insertions(+), 120 deletions(-)
> 
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 
