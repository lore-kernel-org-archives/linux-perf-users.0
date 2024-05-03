Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FB158D82
	for <linux-perf-users@vger.kernel.org>; Fri,  3 May 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767940; cv=none; b=n0PP9A0skkxe086cEyUGy5q/e31K2Te4dTRWn8ir7J+3YClWC8wenOQCHcoDPCUjVQPqwcCKWNTBrmxNMqm8W6L3xYO730UAGGZSdMtHCQEp3TWxvxrN+8BViCVy/q5j6UwSsVbQ5rWrYcs05cd4bjA8jPDQxL4htrrZhNno1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767940; c=relaxed/simple;
	bh=AitfYvvPL/DcJQjasTJxcGQP7m5daTZXLYSVel8zwDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSBKwpmJGK8aibTZGZOJyeMA8aqmBQk4zmRrCoBdUjHaCAyzn+j4o8MSeT5M8EO1uNPS6/N7Jt4LBFev2lkWCZXuMxqFRhGGtg72upKHH2rPbGKddA4s44d9Tsq8nm61++dMa7KqxHM3jPFUHSWFt9EZ/T5n6HY5w2DFeLNEHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+TvX6IJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+TvX6IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E4C4AF1A;
	Fri,  3 May 2024 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714767940;
	bh=AitfYvvPL/DcJQjasTJxcGQP7m5daTZXLYSVel8zwDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+TvX6IJzYKh4G7UXejHNNfTBOQ87wuoV+htQ9OVnO5u5GdkUC9ZqzqLatklHGxz/
	 rPhhibyyIpnbIvSeBZ2DwA3XLwznvcEVqF8RgGi78goGdWLFf86zeifJ/r5EedneP5
	 bUSpG4yeApdM3x+WRszay32LWyRt5Bi4p2yW4wcDbVngTiW4Zn5iEMfrI4hIjsqME0
	 NAKPhcBKCHNJl+eu6q///UDzukys/qNN/datxW420VYmDvPiwMGh+VtJCI0t/FsQlj
	 7mvCCThbvVMMVhwSdzYq3DZO8FpSek3LMesBy5lG7RZWZZ7P2iUOw2VGcadUBAP1H2
	 hiLyt1/7gGzCg==
Date: Fri, 3 May 2024 17:25:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <ZjVIQa3JouJde7I1@x1>
References: <Zh6ZEGOfgcEfwha4@x1>
 <20240429110439.17362-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429110439.17362-1-vmolnaro@redhat.com>

On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> stat for hv_gpci events without required permission set returns an
> error value of -1 to differentiate the output from the unsupported
> events. The stat_all_pmu test was designed in a way, that if any
> command exits with a non-zero value the test exits with an error
> value without any information provided due to the 'set -e' option.

Is this v2 or v3? Kajol, can I have your tested-by?

Thanks,

- Arnaldo
 
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
> Link to the MR !3916 of commit ad86d7ee43b22aa2:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
> Fixed the issue with applying due to a fixed comment typo upstream and
> added Ian's suggestion for the 'device busy' issue during parallel
> testing.
> 
>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index c77955419173..a75beddda4db 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,38 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e
>  
>  # Test all PMU events; however exclude parameterized ones (name contains '?')
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
> +    # return value 0 if counters get printed either if the event is supported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required permission for the event is not set
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> +        echo "no permission to enable"
> +    # return value 255 in case of resource busy during parallel testing of events
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
> +        echo "resource busy"
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
