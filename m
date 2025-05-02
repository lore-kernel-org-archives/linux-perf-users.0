Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13A25D203;
	Fri,  2 May 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202692; cv=none; b=R8wq9mdfyrA7uYn2s2NlqK4zlak3/A2AjnCTjXCjH5mEt9qrV+6AruaFzZ4vO8Cwe0ymDsGTVCOIbTe4DDkuGzXj4rN0JM30nCcJFvsJCYGulih4/AWXpf3r/pdAYvfqtdKMqNAgeo5BIU+0QeduFDCxoTxgfhQD6tz73JXiag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202692; c=relaxed/simple;
	bh=NUuvAkF9Yp4UdF79uBK6uSEGxsRQE3x35b21NmErHh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZwRNCK80mz/Dg2G6nsnIvPq7qUxKvMELBIwBIvrBHn3QX4GACKER+DkdDUzWJI3x028xfj9w3/HvjEZsnqZASIUJ1Yt4R1Z1v1IKRXEg/RZqD2KiT20Om1DkV9DE2hm05lTGk9J23B18cs/P/1LdvqHJO84SX4Xu0t5xKSZLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2wwG93D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2wwG93D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB21FC4CEE4;
	Fri,  2 May 2025 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746202692;
	bh=NUuvAkF9Yp4UdF79uBK6uSEGxsRQE3x35b21NmErHh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2wwG93DNB5pyTNJMkIfTTGx+OwnKLxbz5opmCaM5I9NyPPh8mTzFWuStoALRPdM8
	 fJeqsx4W+CckDRdOBm2+YKrEQVvjosN4mZBsPv+vPZ/gX5Y6TdTvziOA2RTDzgwQE1
	 JGX0yAW9hjct4bYssQWr1L4499Fu382V4xm0XYlTcn9TZtUexIIuAhUvhCYvRJ92aL
	 nYCY9MAf8PixMw/sEj6sRnfTQBydpGdXNwlO+teGkRKf6TuN498rSljcPWApEopoEs
	 WHCZUBK+kIykvNnSeygjG5oYxvN8WRuD/QKgHf+QlqY+hAqtniEqa5l8a/i7jcoLgv
	 XCgVEjb4uHpmw==
Date: Fri, 2 May 2025 13:18:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 08/11] perf hist: Hide unused mem stat columns
Message-ID: <aBTwQeO1RwS7_jLk@x1>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <20250430205548.789750-9-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430205548.789750-9-namhyung@kernel.org>

On Wed, Apr 30, 2025 at 01:55:45PM -0700, Namhyung Kim wrote:
> Some mem_stat types don't use all 8 columns.  And there are cases only
> samples in certain kinds of mem_stat types are available only.  For that
> case hide columns which has no samples.
> 
> The new output for the previous data would be:
> 
>   $ perf mem report -F overhead,op,comm --stdio
>   ...
>   #           ------ Mem Op -------
>   # Overhead     Load  Store  Other  Command
>   # ........  .....................  ...............
>   #
>       44.85%    21.1%  30.7%  48.3%  swapper
>       26.82%    98.8%   0.3%   0.9%  netsli-prober
>        7.19%    51.7%  13.7%  34.6%  perf
>        5.81%    89.7%   2.2%   8.1%  qemu-system-ppc
>        4.77%   100.0%   0.0%   0.0%  notifications_c
>        1.77%    95.9%   1.2%   3.0%  MemoryReleaser
>        0.77%    71.6%   4.1%  24.3%  DefaultEventMan
>        0.19%    66.7%  22.2%  11.1%  gnome-shell
>        ...
> 
> On Intel machines, the event is only for loads or stores so it'll have
> only one columns like below:
> 
>   #            Mem Op
>   # Overhead     Load  Command
>   # ........  .......  ...............
>   #
>       20.55%   100.0%  swapper
>       17.13%   100.0%  chrome
>        9.02%   100.0%  data-loop.0
>        6.26%   100.0%  pipewire-pulse
>        5.63%   100.0%  threaded-ml
>        5.47%   100.0%  GraphRunner
>        5.37%   100.0%  AudioIP~allback
>        5.30%   100.0%  Chrome_ChildIOT
>        3.17%   100.0%  Isolated Web Co
>        ...

  # grep "model name" -m1 /proc/cpuinfo
  model name    : AMD Ryzen 9 9950X3D 16-Core Processo
  # perf mem report -F overhead,op,comm --stdio
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'cycles:P'
  # Total weight : 2637
  # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc
  #
  #           ------ Mem Op -------
  # Overhead     Load  Store  Other  Command
  # ........  .....................  ...............
  #
      61.02%    14.4%  25.5%  60.1%  swapper
       5.61%    26.4%  13.5%  60.1%  Isolated Web Co
       5.50%    21.4%  29.7%  49.0%  perf
       4.74%    27.2%  15.2%  57.6%  gnome-shell
       4.63%    33.6%  11.5%  54.9%  mdns_service
       4.29%    28.3%  12.4%  59.3%  ptyxis
       2.16%    24.6%  19.3%  56.1%  DOM Worker
       0.99%    23.1%  34.6%  42.3%  firefox
       0.72%    26.3%  15.8%  57.9%  IPC I/O Parent
       0.61%    12.5%  12.5%  75.0%  kworker/u130:20
       0.61%    37.5%  18.8%  43.8%  podman
       0.57%    33.3%   6.7%  60.0%  Timer
       0.53%    14.3%   7.1%  78.6%  KMS thread
       0.49%    30.8%   7.7%  61.5%  kworker/u130:3-
       0.46%    41.7%  33.3%  25.0%  IPDL Background
