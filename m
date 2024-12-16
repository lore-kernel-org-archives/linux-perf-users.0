Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3F207A0D;
	Mon, 16 Dec 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367448; cv=none; b=aI1JqT8KmEwehgHBw8YtjVPU+mJaCbrvIB4u4SlIRnByOtebEj9YiKGwdgRQvXJ07pmFdr0NwsFbuqXpwdFS0ZLANl4vrPc2d6Sfo+IYRDHtdfL0+pv9rsoYVF8VHfnmj6eudc/28wKX5tUmwm7p+vgy26mliq7oqOQ+gs0OAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367448; c=relaxed/simple;
	bh=snoRALQ5vLKqq7mcGrwha2X8wlly0uvi69XAMV3T24I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFHI+5PP+atz8qWUSgsGdkH/3BHYBWeR/xpcVrOOE2RJd4kFGe9l7d9a/0xkvYKrvmKJ/LtHkyO9MkhbQeVlWlak89drGH+UH7suV1tVnJSteiJTj1Dixp3qvRxXLeaRFl05i+q4YBEkQ+GPVfOfpktn+4sgpxXCpuDRenN6hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoGule4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoGule4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D09C4CEDD;
	Mon, 16 Dec 2024 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367447;
	bh=snoRALQ5vLKqq7mcGrwha2X8wlly0uvi69XAMV3T24I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoGule4W8NC54k6omoNdAcSoIQCDpvbkNrSTqK/DeRrMi3iI3GnkFObkz1RziCW1H
	 IlE9xrGWHSXT09NGOXsXJDrTRzFBkqJntfObOnK5m4CHqDjgR+SV5FSsGxF8WktAqo
	 9N3NBUEInaWpvdNV9Q4O3fP7VqZbpJE4nFeIEmoSyhT7G/QbEAIy3ez5jP6PU9uY4x
	 JkMOaMngYBfWlXwXzUcnuCjQCvitx7gX3N08r+oW7rUw9qmdPFTKfhQ8suVMvsgARw
	 nfawuBjHyOXedAvgWS2jT0PDg1wDJqVZoUMs/kpVqgLLV4GpoXbUVwJf3Pbp3MPWyq
	 fb7WHk4irLjbg==
Date: Mon, 16 Dec 2024 13:44:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH] perf ftrace latency: Fix compiler error for clang 12
Message-ID: <Z2BY1MAUrXPJs1Ak@x1>
References: <20241214002938.1027546-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214002938.1027546-1-namhyung@kernel.org>

On Fri, Dec 13, 2024 at 04:29:38PM -0800, Namhyung Kim wrote:
> I noticed this error on CentOS 8.
> 
>     CLANG   /build/util/bpf_skel/.tmp/func_latency.bpf.o
>   Error at line 119: Unsupport signed division for DAG: 0x55829ee68a10: i64 = sdiv 0x55829ee68bb0, 0x55829ee69090, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]Please convert to unsigned div/mod.
>   fatal error: error in backend: Cannot select: 0x55829ee68a10: i64 = sdiv 0x55829ee68bb0, 0x55829ee69090, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
>     0x55829ee68bb0: i64,ch = CopyFromReg 0x55829edc9a78, Register:i64 %5, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
>       0x55829ee68e20: i64 = Register %5
>     0x55829ee69090: i64,ch = load<(volatile dereferenceable load 4 from @bucket_range, !tbaa !160), zext from i32> 0x55829edc9a78, 0x55829ee68fc0, undef:i64, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
>       0x55829ee68fc0: i64 = BPFISD::Wrapper TargetGlobalAddress:i64<i32* @bucket_range> 0, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
>         0x55829ee68808: i64 = TargetGlobalAddress<i32* @bucket_range> 0, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
>       0x55829ee68530: i64 = undef
>   In function: func_end
>   PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.
> 
> It complains about sdiv which is (s64)delta / (u32)bucket_range.
> Let's cast the delta to u64 for division.
> 
> Fixes: e8536dd47a98b5db ("perf ftrace latency: Introduce --bucket-range to ask for linear bucketing")
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Committer testing:

Tested on:

  $ head -2 /etc/os-release
  NAME="Fedora Linux"
  VERSION="40 (Toolbx Container Image)"
  $ clang --version |& head -1
  clang version 18.1.8 (Fedora 18.1.8-1.fc40)
  $
  root@number:~# perf ftrace latency --use-nsec --bucket-range=200 --min-latency 250 --max-latency=5000 -T switch_mm_irqs_off -a sleep 10
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -  250 ns |         28 | #####                                          |
     250 -  450 ns |         12 | ##                                             |
     450 -  650 ns |         10 | #                                              |
     650 -  850 ns |          9 | #                                              |
     850 - 1050 ns |         20 | ###                                            |
    1.05 - 1.25 us |         14 | ##                                             |
    1.25 - 1.45 us |         16 | ###                                            |
    1.45 - 1.65 us |          8 | #                                              |
    1.65 - 1.85 us |         11 | ##                                             |
    1.85 - 2.05 us |          7 | #                                              |
    2.05 - 2.25 us |         11 | ##                                             |
    2.25 - 2.45 us |         10 | #                                              |
    2.45 - 2.65 us |          7 | #                                              |
    2.65 - 2.85 us |          8 | #                                              |
    2.85 - 3.05 us |          7 | #                                              |
    3.05 - 3.25 us |          7 | #                                              |
    3.25 - 3.45 us |         10 | #                                              |
    3.45 - 3.65 us |          5 |                                                |
    3.65 - 3.85 us |          9 | #                                              |
    3.85 - 4.05 us |          2 |                                                |
    4.05 - 4.25 us |          6 | #                                              |
    4.25 - ...  us |         23 | ####                                           |
  root@number:~#

Thanks, applied to perf-tools-next.

- Arnaldo
