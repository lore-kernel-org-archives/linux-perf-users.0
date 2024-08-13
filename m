Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CAED8;
	Tue, 13 Aug 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512280; cv=none; b=P/C0Noo1js0hMkmM9Fq4u36XDCeA6fpjyBjpRV0gqwQaCt2qPpsRi2/FUgJKfSgpEytmJkWyH4wKlLbdjQ2fa2+4TSxse1Yu9yDnaFCEScR31602gZNbOpT7f3rP6uy2Or/jeZleou1bIx6tYj4uzuLVXGy1imqxj5x7Htpc9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512280; c=relaxed/simple;
	bh=wUxCzrCIeH5EsuXlc9E10wURZDzPqv38hYSppWQHjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ/3Nm42Bd21bLMzTSexpR0Iyog0XurZsvfo3ngIV0kGap8ENUKfq92248VSB+Uir0ApwgvI564Q5zJGr4uvFvqCMl72XjnwNJ9qCnavw5UCls6olVn0gdgeZgJWOFoBt63gGYLrxVjNALFKh6twwpWlcRwHNzGzGX88iJpWliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzn+nSCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzn+nSCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D37C4AF0D;
	Tue, 13 Aug 2024 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723512280;
	bh=wUxCzrCIeH5EsuXlc9E10wURZDzPqv38hYSppWQHjZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dzn+nSCkUFpa5bMqkMI7nXV1ATpk2Kr0gSGR415u2TCz26484w2N1YJGFXJSa5Mzn
	 zUntar3zElgEbMdUWeopOrP19LUQoMnZ7LzcGfpboVr1ciBcLYITpfH5ZtodNV/KnF
	 hUcNMSrJm/+l/t2ZwyBPFL1z325glU4uiQhpL4aMJAdvSGNOaF6Z3mgOdQrF8NNXaJ
	 8/vBjYwj0ftaz6pB5GE8N42X6rXep+ReLk6IQb4eVjyRC3at/iwbrr926oePRwLNuJ
	 AD1VFk/DPjAbasZCocT+45l4F4/JIFWhrSyvX+TjJaYFkNeQiKAMnM56Jkz6O/v8tP
	 ag7DZD1khGaqg==
Date: Mon, 12 Aug 2024 22:24:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <Zrq11fq_F9vImsQh@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-9-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720062102.444578-9-weilin.wang@intel.com>

On Sat, Jul 20, 2024 at 02:21:01AM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Intel TPEBS sampling mode is supported through perf record. The counting mode
> code uses perf record to capture retire_latency value and use it in metric
> calculation. This test checks the counting mode code on Intel platforms.

root@x1:~# perf test -vvvvv 123
123: test Intel TPEBS counting mode:
--- start ---
test child forked, pid 2600160
Testing without --record-tpebs
Testing with --record-tpebs
---- end(-1) ----
123: test Intel TPEBS counting mode                                  : FAILED!
root@x1:~# grep -m1 "model name" /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~#

What am I missing?

The current codebase is in tmp.perf-tools-next

- Arnaldo
 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> 
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..c60b29add980
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
> +
> +# Use this event for testing because it should exist in all platforms
> +event=cache-misses:R
> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --record-tpebs"
> +result=$(perf stat -e "$event" true 2>&1)
> +[[ "$result" =~ $event ]] || exit 1
> +
> +# In platforms that do not support TPEBS, it should execute without error.
> +echo "Testing with --record-tpebs"
> +result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
> +[[ "$result" =~ "perf record" && "$result" =~ $event ]] || exit 1
> -- 
> 2.43.0
> 
