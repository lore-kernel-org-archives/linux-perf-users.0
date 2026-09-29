Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093103A257C;
	Tue, 29 Sep 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707202; cv=none; b=T3Qi7IlzzP25tPFZk+AjX+EpwILPxX+DLiSjALJiX/tP//aqxwRVEa2iIwdS9fYYTojBtChLGTVF4wLCH3GVn8HVD8t+P71LX1uY4Ray7Lle/1c/OD6CF6LB8nLsjS76Zz1RY7ruzmgmUm3VG7pxn0U6am3cCCz78995F8yrBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707202; c=relaxed/simple;
	bh=8W3+/xo9Gn/jbFdhqOev6Xyd9anH3iet/EsJU96tzvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaZLxlHQ1QmhgYkE6a5XC4sYlmVWU+wdOWdpR7dHAW5aJKqEvmdn7DObetrcrt98Wpi+nVplfuK4g0EY1Cj/Aw1gZ7F66LABQkOlLtwxGNPNcQ65YpPGt+9JeyU12cgfziJAS6dFwKavmjKl56Uq74NdATGSP8MPrllZcIM8hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ6hA5aS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ6hA5aS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E065B1F000FF;
	Tue, 29 Sep 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707200;
	bh=3LfD9MzjTfhl3+bTEOPV+6Z6Y1Bi4IoJYOgpesG71ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZ6hA5aS0FLxUjOmUF+6ZzuZfUi7vSOg42WS34HoILWrQ9jHEiF/zf6ApG/ZlvQpG
	 +The80c6gZy/6Dr+y7sFThzA5dTvQn5YHMd6pd5lLQSTP85nIjxqm9bpAeES2azIig
	 G3jogervk6d+rXgsNRwMBgs9RnmptBxcy+hEjHLVBtBnxscRmednYvz7ANjHN5fl60
	 k/GzV0BfKk74UJ0OPiyFtUItIieGxy7zuVmlJS3G0K3ddx9X0aGTBOAB873iiwkWCq
	 FwopGeCEe9vWoO+t/PiZ12IYpt3E0ugHbu5wSWLGGNhg6pEnNYoh0Prb7vGkxKUjv1
	 Xd0Cr3hplQCXw==
Date: Tue, 29 Sep 2026 20:39:55 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	bwicaksono@nvidia.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf jevents: Add NVIDIA Tegra410 uncore DDR and
 PCIe metrics
Message-ID: <arwF-9Optt_gsPJb@x2>
References: <20260928175127.1032535-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928175127.1032535-1-ctshao@google.com>

On Mon, Sep 28, 2026 at 10:51:25AM -0700, Chun-Tse Shao wrote:
> Add DDR bandwidth/latency and PCIe bandwidth metrics for the NVIDIA
> Tegra410 SoC to arm64_metrics.py. The metrics use the sysfs events of
> the Tegra410 UCF, CMEM latency and PCIE PMUs, and follow the formulas in
> Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst.

Ian,

	Can you take a look and please provide your Reviewed-by?

Thanks,

- Arnaldo
 
> Patch 1 adds the DDR metrics and makes pmu-events/Build also run
> arm64_metrics.py for the nvidia vendor models. Patch 2 adds the PCIe
> metrics, in total and per PCIe Root Complex (RC).
> 
> Tested on a 2-socket Tegra410 system:
> 
>  - memcpy with multiload (from multichase) on socket 0 CPUs and memory:
>    lpm_ddr_bw is 740-744 GB/s at steady state (perf stat -I 2000),
>    multiload reports 708063 MiB/s (742 GB/s).
>  - Read only (stream-sum) and write only (memset) loads on socket 1:
>    lpm_ddr_rd_bw is 608 GB/s with 2.4 GB/s of writes, lpm_ddr_wr_bw is
>    628 GB/s with 1.1 GB/s of reads.
>  - memcpy on socket 0 CPUs with memory on socket 1: socket 0's
>    lpm_ddr_rem_rd_bw and socket 1's lpm_ddr_rd_bw count nearly the same
>    bytes (258.03 vs 258.73 GB).
>  - lpm_ddr_lat idle is 150 ns in the default aggregation, and 132 ns and
>    194 ns for socket 0 and 1 with --per-socket. Under the memcpy load it
>    is 555 ns by default and 563 ns for socket 0 with --per-socket, and
>    stays at 551-558 ns per interval with -I 1000.
>  - 8 GiB O_DIRECT dd read from an NVMe drive behind RC 0 of socket 0:
>    lpm_pcie_wr_bw_0 counts the 8 GiB at 8.7 GB/s (dd: 8.7 GB/s). With
>    the buffer on node 0 it shows up in lpm_pcie_loc_wr_bw_0, with the
>    buffer on node 1 in lpm_pcie_rem_wr_bw_0. With --per-socket, socket 0
>    shows the same and no metric of either socket is nan.
>  - With the nvidia_t410 metrics forced on a machine without these PMUs
>    (PERF_CPUID=0x000000004e0f0100 on an x86 JEVENTS_ARCH=all build), the
>    PCIe metrics read 0 rather than failing to parse, also with
>    --per-socket.
>  - "perf test 10" (PMU JSON event tests) passes on the Tegra410 system
>    and with the x86 JEVENTS_ARCH=all build.
> 
> Chun-Tse Shao (2):
>   perf jevents: Add NVIDIA Tegra410 uncore DDR metrics
>   perf jevents: Add NVIDIA Tegra410 uncore PCIe metrics
> 
>  tools/perf/pmu-events/Build            |   2 +-
>  tools/perf/pmu-events/arm64_metrics.py | 126 ++++++++++++++++++++++++-
>  tools/perf/pmu-events/metric.py        |   2 +-
>  3 files changed, 126 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
