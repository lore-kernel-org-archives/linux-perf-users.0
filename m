Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C64C62E;
	Thu, 18 Jul 2024 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721281381; cv=none; b=sJvk89LNfHKrPqN0rcXKCcoFH38p8z7kFaEt6JDmU9CjFpGwWu0X0YAG+iUGjCZdvAnF0vF42A797wDBAquym3s7EfgEHUS0pnRmgzpx78hlwcVwM7OZ3y7thijclph5AND99fKxl62yqPdy6ht94CpzR5slewmROeg94cBZkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721281381; c=relaxed/simple;
	bh=H1BYFegyfwEdBmaHbZc52OMrYQozazJ1FwXONNUISyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj/Xk0ZKCXmgl8TwoMOkp8C6uyQTgemtIcoZQAFsU0IUpHM7Wr8NSGBkoFrigQmLBbIodsiWPXIrvO9v3UXKrB+JUVZ6DjL75JDL5nbsrMn/XRUnIAHAfMZZIEuVbTtWmwZswshPiI3VxLzXjNlz+36M4XgwU95WDMUHIiCB59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+ATkKOq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+ATkKOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381E5C4AF0E;
	Thu, 18 Jul 2024 05:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721281380;
	bh=H1BYFegyfwEdBmaHbZc52OMrYQozazJ1FwXONNUISyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+ATkKOqgS7CCqQh5jitOwVOXqXsXWSNRSu5ThKegyQWHm/J/OS4y05NbnGGIINZ+
	 QGQFUQBVN4MVGupURs8p66JAMpD4U0tjdnygySOIObTB9PKKinOkbwttDiwgTKDDSa
	 74uMkF6iqj5vtWldeetueB913E4AuiJfquL7038uITx3FKH+9SIHE+8MGE4KfFEq9M
	 B/KGwmHNTiL6LdbnW84IHSQ3aHAg0TYbxKfLU97A/8G1rhmLVnUtBq8YxhtqObw/d8
	 yxeLw8vCJoP6jAUaw2TtyrfNydp83OAEvLvDWoA8RYPRFaDquORm43oGVBFQ9dbAn3
	 xnwIh798QZwFA==
Date: Wed, 17 Jul 2024 22:42:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [RFC PATCH v17 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <ZpirYuwlzSv2ubHN@google.com>
References: <20240712190932.417531-1-weilin.wang@intel.com>
 <20240712190932.417531-9-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240712190932.417531-9-weilin.wang@intel.com>

Hello,

On Fri, Jul 12, 2024 at 03:09:30PM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Intel TPEBS sampling mode is supported through perf record. The counting mode
> code uses perf record to capture retire_latency value and use it in metric
> calculation. This test checks the counting mode code on Intel platforms.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> 
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..773fcc5c35d6
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 0; }

You should exit with 2 when skipping the test.

Thanks,
Namhyung

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
