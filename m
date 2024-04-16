Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAD12AAE6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278035; cv=none; b=Z0Y3f5jOVFMgcvergZ73PHxuBKH3IF37SbZjyyZpeeOj+zRw8EZrRYr09eTcXvfdmC8Q5dL9Hob5BrrCGdunbphsAZIdYBCO+D4xgvBQlNajfjGFkFWIodnfQzkD12+RgiOA4cfLrKMpSwwiq/Q/KAph4imQJuAJx59TKhszaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278035; c=relaxed/simple;
	bh=wAsvofFflubp6L5RHB53M7bmkilrLru7UNjFTUBsq60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH41L6OfeH6nAVFKsvaAMv9BG3WV0cX6UeSWHKTHzitMyA/wYiqB0Yo7vrt6k2GCFgEtutGal7YFDny3O8AFWiH3IBMsVtG2y/52vdli9nS8dSSufND9CZC1oBrefxAocuZrQgxSOmxwHdGsLWFHcCj9TJc66nIz3bt6iUy9i6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUXFr3oL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUXFr3oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21401C4AF07;
	Tue, 16 Apr 2024 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278035;
	bh=wAsvofFflubp6L5RHB53M7bmkilrLru7UNjFTUBsq60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUXFr3oLeWyH/95YTEF5BQrgpEmLcMRNfcxwaAlB58b7qsagTZzWEYE3D9FS2vOOq
	 w1FXVMYlePRSMEd0p71MCr1GOyFK65EcH2fCR0pPARXL/aFFuUnHrrEwvlut/cLDfN
	 c7Ub2P95FIK8SpnGyZgZypc0J9bbSdRg8ObtFft7EMvzke/hK0/3z5YTlmrxS2JNYD
	 N7PYKjky96E3obdoJertr3pOM8vjYGXNLVsqWkaSjA7uToGJtbdD2SUGLy/sSPXVw9
	 yylAUzVK1V5rn8UwUij1yGISUJ9uHjt5NHc8lY1yw0forp9akpRb+ryjLmyyLVcI71
	 IPtSIv3OTL2EQ==
Date: Tue, 16 Apr 2024 11:33:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <Zh6MUJAGDEHxsAL_@x1>
References: <ZhgpWkUAto8nzvle@x1>
 <20240415094220.11639-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415094220.11639-1-vmolnaro@redhat.com>

On Mon, Apr 15, 2024 at 11:42:20AM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:
> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf

Athira/Kajol,

	I don't have access to such machines, since you did work on this
area, could you please take a look and maybe test it?

	The upstream patch mentioned is in fact:

  ad86d7ee43b22aa2 ("powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks")

Thanks,

- Arnaldo

> stat for hv_gpci events without required permission set returns an
> error value of -1 to differentiate the output from the unsupported
> events. The stat_all_pmu test was designed in a way, that if any
> command exits with a non-zero value the test exits with an error
> value without any information provided due to the 'set -e' option.
> 
> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
> event causes failure after the MR as the zero return value was required.
> The issue propagated upstream as the list of the files that affected perf
> did not cover the changed files and was updated after the issue was
> discovered. It was caught by CKI testing where it was triaged to stop
> blocking further MRs, as most of the powerpc machines do not support
> some of the hv_gpci events.
> 
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with the appropriate action.
> 
> Link to the MR !3916 of commit a381bd3615de6:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
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
