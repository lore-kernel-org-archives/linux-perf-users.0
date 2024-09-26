Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2581D5AA2;
	Thu, 26 Sep 2024 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727326353; cv=none; b=GoPg2I/v94ar9GnqeNKKtZWo2FPsXnoXuL66sqM+KZ98LGaQ1xS8qXav3QFZfQvD1/PqooYGbuLwuJAdyXXOdtN3/z5Cgts6RL6bgmcsdESDGJBIT2bpvXFvRpCsiZUIp0Dh1wdGhAGUJUs489V6MrKtSAgoxQH7/CVV1cYDfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727326353; c=relaxed/simple;
	bh=ftxAnprtNb1V/YF54Dv4gL2PRZ5qQPHdZZulQzDHasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNg2qoc+HlGXU+ocTh2FX12v5OgoWHIi6XahteYgdVPAVEjZwmV4UD9SC1mUv51Fh8DrrWPfZ/00GEn5T0U1T5yvlfoLKKIKacSAUkGw+gCJM9lkaEvT067cVs0tHcrmFjjFGVpXokfo7Dj2ND+HH3G/FxhnBrrfPJjSBHqp4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLKif1aO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLKif1aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79763C4CEC5;
	Thu, 26 Sep 2024 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727326353;
	bh=ftxAnprtNb1V/YF54Dv4gL2PRZ5qQPHdZZulQzDHasw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLKif1aOrGnPI/MtT7K+UXcrYE7n37b2OdILHPYFH3+41jZd/Sd9Pr/CGgXuoA3qw
	 0CRhgvb2K6BPkY1Nt/SqwuQsSqoGWwsfHUyGx0XLt3tOdkLhZnSArHIZzqMbepDeM6
	 b2mqzHaiqxUuCPLJyffyP7v8H/AMwGPtw8cPgP950OUQ5AxGWczdOqrimwS//fONgH
	 5nWTvlpEyN5WXbOKv0pz/3pS0tbKKzK/bQ637yQtXkVZ5evSzGFya91EbneRUA1yJS
	 iYHGq+DYBESoOmjJWqXVANM3NviXjmim/iQ7v+eFDHn4FfZT4wMBjtgZMmocY89q9x
	 A6T+HfDtj7PSQ==
Date: Wed, 25 Sep 2024 21:52:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Ignore security failures in all PMU test
Message-ID: <ZvTojjciV9pFbGJi@google.com>
References: <20240925173013.12789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925173013.12789-1-irogers@google.com>

On Wed, Sep 25, 2024 at 10:30:13AM -0700, Ian Rogers wrote:
> Refactor code to have some more error diagnosis on traps, etc. and to
> do less work on each line. Add an ignore situation for security failures.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 52 ++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index d2a3506e0d19..42456d89c5da 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -1,23 +1,51 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
>  set -e
> +err=0
> +result=""
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  echo "$result"
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
>  
>  # Test all PMU events; however exclude parameterized ones (name contains '?')
> -for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> +for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
> +do
>    echo "Testing $p"
>    result=$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workload was
> -    # too small so retry with something longer.
> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> -    fi
> +  if echo "$result" | grep -q "$p"
> +  then
> +    # Event seen in output.
> +    continue
> +  fi
> +  if echo "$result" | grep -q "<not supported>"
> +  then
> +    # Event not supported, so ignore.
> +    continue

I'm curious about this case.  It'll show up even if it's not supported
right?  Then the first condition would match and it doesn't reach here.

  $ perf stat -e LLC-loads true
  
   Performance counter stats for 'true':
  
     <not supported>      LLC-loads                                                             
  
         0.001213558 seconds time elapsed
  
         0.001373000 seconds user
         0.000000000 seconds sys

> +  fi
> +  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
> +  then
> +    # Access is limited, so ignore.
> +    continue
> +  fi
> +
> +  # We failed to see the event and it is supported. Possibly the workload was
> +  # too small so retry with something longer.

Ok, maybe we want to check "<not counted>" events specifically.

Thanks,
Namhyung


> +  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> +  if echo "$result" | grep -q "$p"
> +  then
> +    # Event seen in output.
> +    continue
>    fi
> +  echo "Error: event '$p' not printed in:"
> +  echo "$result"
> +  err=1
>  done
>  
> -exit 0
> +trap - EXIT TERM INT
> +exit $err
> -- 
> 2.46.0.792.g87dc391469-goog
> 
