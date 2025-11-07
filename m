Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9322F5A26;
	Fri,  7 Nov 2025 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479556; cv=none; b=Q3GC5RcSEgYAy4vlLwTgRp1nBsyslV2iSOBhXyCigbRZRDvtfqvEIp+JGo6/VNTWL5jjAznGB8SxC8pCUjdYvBHm56NnmDEEDxVbVYfxfFSzQwYO/aumn8WmA4Oj4xppVdn9OEpZiHck4UW6PzNZ2o1wGonoc+1tGS7Djjx/0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479556; c=relaxed/simple;
	bh=BPAKudae5k1OcIVZU1GMTAO6vPioIYL0JFIIjWG5Nl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoHTGQvIhyCre3b93KaKIM0oEopWs4P6wdydwkdc3m2W3obUhLSgtE41nHmaimFBWIpGGcOjAwbyIUVWniwQE7bOHn9Lsy/1wfzP6h1i05xziOF6aE49GJH6k5KrfzhSAVSSj8gKksHfG1RP2YryH2rcTnRAbRNQE3IDQ+tXbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj9NZLTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj9NZLTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99207C116C6;
	Fri,  7 Nov 2025 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762479556;
	bh=BPAKudae5k1OcIVZU1GMTAO6vPioIYL0JFIIjWG5Nl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj9NZLTkAHAD7A5L2XvR9EykNxJMSVofNKHydN82UTAOCs2Q5u2YHQ+8PVRmjWMbA
	 fczWWDVeNMIFAIdstsfIQimN7OZBj6oN+u79GAgMyi7yOlk+0MexfS9kOdZ/PcDLlQ
	 K7tF/TLInzxnXdutt99SXcEAhnpaRrJWZBoyILcYw3pe5SpBACZcX6X362ceOcZJ6R
	 kVv0ovfv0Z9YTBZH2T44FONiu03yNtnh7L8FxQayNbTde2T3tLBZZG1qG61Y9cX0uF
	 VnfnY5VYHPqFmPxN3fxViJ+aipBZheOPkq7kGFTFobpj3Yzqh06TtnYNOvUvdJQ/8P
	 xHQCAgye6aHsQ==
Date: Thu, 6 Nov 2025 17:39:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Add test that command line period
 overrides sysfs/json values
Message-ID: <aQ1NwHzzBjA75w5G@google.com>
References: <20251106233710.463949-1-irogers@google.com>
 <20251106233710.463949-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106233710.463949-2-irogers@google.com>

On Thu, Nov 06, 2025 at 03:37:10PM -0800, Ian Rogers wrote:
> The behavior of weak terms is subtle, add a test that they aren't
> accidentally broken.

I've got this error.

  $ sudo ./perf test -v 'record weak terms'
  --- start ---
  test child forked, pid 4014275
  Testing that for cpu/event=0..0xfff,edge,inv,.../modifier the period is overridden with 1000
  Fail: Unexpected verbose output and sample period
  ---- end(-1) ----
   92: record weak terms                                               : FAILED!

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Add more comments to the test code and reduce the line length (Namhyung).
> ---
>  tools/perf/tests/shell/record_weak_term.sh | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> 
> diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
> new file mode 100755
> index 000000000000..ee4bcc792aeb
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_weak_term.sh
> @@ -0,0 +1,36 @@
> +#!/bin/bash
> +# record weak terms
> +# SPDX-License-Identifier: GPL-2.0
> +# Test that command line options override weak terms from sysfs or inbuilt json.
> +set -e
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/setup_python.sh
> +. "${shelldir}"/lib/setup_python.sh
> +
> +# Find the first event with a specified period, such as
> +# "cpu_core/event=0x24,period=200003,umask=0xff/"
> +event=$(perf list --json | $PYTHON -c '
> +import json, sys
> +for e in json.load(sys.stdin):
> +    if "Encoding" in e and "period=" in e["Encoding"]:
> +       print(e["EventName"])
> +       sys.exit(0)
> +sys.exit(1)
> +')
> +if [[ "$?" != "0" ]]
> +then
> +  echo "Skip: No sysfs/json events with inbuilt period."
> +  exit 2
> +fi
> +
> +echo "Testing that for $event the period is overridden with 1000"
> +perf list --detail "$event"
> +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> +  grep -q -F '{ sample_period, sample_freq }   1000'
> +then
> +  echo "Fail: Unexpected verbose output and sample period"
> +  exit 1
> +fi
> +echo "Success"
> +exit 0
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
