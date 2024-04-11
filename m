Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629520DE7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859485; cv=none; b=NhM7FIrUg0czkgi+RF3Nn60ewmg/ZyOuJE1qNFjtmfCfZsoUr9kSI4HI6qd3tmGQ+f1lNK/sTDUNp9SGs+yYaZINKgbKDmLwY8fQBVu3tWLRus3APMnYZEDjQTT2tJ2uckwqQ2/BkD51Y9uy6fp2GGbvvi0Oocv2ctUnS6RD1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859485; c=relaxed/simple;
	bh=PkGVLHhsoYzTbUJVCAOGheqJ23uTE0asCiXJ7kSb1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUUoyFsaaSXxqYhCQ49LkJA6UTn/GfyZq/R0YpIw9p+68fl8o87bVbUjIbh8P1IPvpGl9DwilYvswIAX4TaVXQ8ZQFV1ilStmV6eP0yh9H2IsxYXLqjt3Oz0lHkV+txX0I9gVhtvhm9IjTUvfCmL5vM9OY/r1bCUESCjDrQ5fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhP2q8qz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhP2q8qz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF9EC072AA;
	Thu, 11 Apr 2024 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859485;
	bh=PkGVLHhsoYzTbUJVCAOGheqJ23uTE0asCiXJ7kSb1sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhP2q8qzNUohw7MRv3JL/a3C4jW6ZC9XHqr/rh+O9BP8KMJyHFN1lkPQDqc7C7OIj
	 Ab//38ve+fCT95vb5BpWivHFw81HKozj3/TODCPCKM849q0qMNAhBeNOGshyIHJHRG
	 IesVxwTtwbNJ4RM1ZgDZj0utl+EPy6ZB5a2Vd9g+OlLuwamNHrIA+DHnwjS+c+TS/z
	 prjDicPOef4n+x1y5Bcti8VFFISPSxn7OsWcILfEYhLAaIE3oqIpk5mYOnccaOA5u1
	 FXyMbdQWY35sdVgptx55/Y8GbFJOb+KR7a/14rfa764R3VtHwE3wjBBk+w+LqS86fl
	 dDdAISRTNaGVQ==
Date: Thu, 11 Apr 2024 15:18:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <ZhgpWkUAto8nzvle@x1>
References: <20240409130240.13973-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409130240.13973-1-vmolnaro@redhat.com>

On Tue, Apr 09, 2024 at 03:02:40PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the MR a381bd3615de6 ('powerpc/hv-gpci: Fix the

Is this MR publicly accessible? If so, please provide an URL, otherwise
it will be interesting to state if this problem takes place upstream and
how to reproduce it, do we need a specific environmnt (I assume so, from
looking at "powerpc" in the mentioned MR, etc.

- Arnaldo

> H_GET_PERF_COUNTER_INFO hcall return value checks') the perf stat for
> hv_gpci events without required permission set returns an error value
> of -1 to differentiate the output from the unsupported events. The
> stat_all_pmu test, however, exits immediately if any command exits with
> a non-zero value due to 'set -e' option.
> 
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with appriopriate action.
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index c77955419173..d9f0d2100baa 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,35 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e
>  
>  # Test all PMU events; however exclude parametrized ones (name contains '?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> -  echo "Testing $p"
> -  result=$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workload was
> -    # too small so retry with something longer.
> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> +  echo -n "Testing event '$p' -- "
> +  stat_output=$(perf stat -e "$p" true 2>&1)
> +  stat_result=$?
> +  if echo "$stat_output" | grep -q "$p"; then
> +    # return value 0 if counters gets printed either if the event is supported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required pemission for the event is not set
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> +        echo "no permission to enable"
> +    # return value 129 when trying to run 'perf stat' with a non-existent event
> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> +        echo "Fail: Bad event name"
> +        echo "$stat_output"
> +        exit 1
> +    else
> +        echo "Fail: Unknown return value $stat_result"
> +        echo "$stat_output"
> +        exit 1
>      fi
> +  else
> +      echo "Fail: Event '$p' not printed in:"
> +      echo "$stat_output"
> +      exit 1
>    fi
>  done
>  
> -- 
> 2.43.0
> 
