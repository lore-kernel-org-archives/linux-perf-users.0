Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22D18FDDC
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424189; cv=none; b=lhDjsfLNBgXNdMG8dLAGU7s18kJ6Dd86SFJN5dZniuX02MinUFY/2IlBIalo9aMK/2MZxdINAHfkdjAkXqs332PStPlsi4+sZSfoZC35mPA8OWlIi7Oe93QTEuGDP9xVl7+buEHykblK2GIO0Ek8gGMzDxpWm/zAGqtspbdy1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424189; c=relaxed/simple;
	bh=Shq9hHfG2PkGBg7xzAVXfDyXDMOKZ0EJ8aRzq1Nfbzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTYqE8t7UYOtyDnhPY7kCndAvUitxS8nJHs5yVegEWUCpwLsdmh3Uv3r4jMM1Ruhz1OWZhFxKX7kus0mcMmCjMx7ekXYY6xFLk6gZqzvkCrKSk83yiRFUBTqY/c1XgHCPtxYzsoeIRcpSXaEIa8WYfMfh4DiGHzsarY3zzO9UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrcX3HY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrcX3HY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F69C116B1;
	Wed, 26 Jun 2024 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424189;
	bh=Shq9hHfG2PkGBg7xzAVXfDyXDMOKZ0EJ8aRzq1Nfbzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrcX3HY7WTLsw/j5hVAY+x0Ap2jiLz54Gld0WG5EHlme4x1aWWOZdbibYumJsXMno
	 eVMKxNM07B2aBLgrykFwipXW28tHo1INP4MGKtx5ZEPHhdA1MM7fN1xySL8NZWlWSI
	 gqLklRQ7OfTnP7O6tdFsUeJA9LxhDmBscXYorLiIWkCT01N9RtaOWjWkPCFNNRg4lc
	 KtFQIwr5JVAxDPpS9PWEW65uPkOc0IRVKK2pwTO8bN8Qk7L2XYSbg5yFqYoxD3laDx
	 sqYuBnvBDW1TomYsLbIYopOretltjPhHrayQHvMigJ7fmOU9jRSkFDyyAtT0qw/Ii3
	 Ud1fJZoziUz3g==
Date: Wed, 26 Jun 2024 10:49:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com
Subject: Re: [PATCH v2] perf test stat_bpf_counter.sh: Stabilize the test
 results
Message-ID: <ZnxUuw65gtF07v72@google.com>
References: <20240625092001.10909-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625092001.10909-1-vmolnaro@redhat.com>

Hello,

On Tue, Jun 25, 2024 at 11:20:01AM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The test has been failing for some time when two separate runs of
> perf benchmarks are recorded for cycles events and their counts are
> compared, while once the recording was done with option --bpf-counters
> and once without it. It is expected that the count of the samples
> should be within a certain range, firstly the difference was set to be
> within 10%, which was then later raised to 20%. However, the test case
> keeps failing on certain architectures as recording the provided
> benchmark can produce completely different counts based on the
> current load of the system.
> 
> Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
> --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":
> 
>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> 
>          396782898      cycles
> 
>        0.010051983 seconds time elapsed
> 
>        0.008664000 seconds user
>        0.097058000 seconds sys
> 
>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> 
>         1431133032      cycles
> 
>        0.021803714 seconds time elapsed
> 
>        0.023377000 seconds user
>        0.349918000 seconds sys
> 
> , which is ranging from 400mil to 1400mil samples.
> 
> Instead of recording the cycles use instructions event, which provides
> more stable values. At the same time change the tested workload to one
> of the provided testing workloads by perf that is not based on a
> scheduler, which can provide another dependency on the current load.
> 
> Sampling instructions event with the new workload provide much more
> stable results on intel-eaglestream-spr-13 of "perf stat --no-big-num
> -e instructions -- perf test -w brstack":
> 
>  Performance counter stats for 'perf test -w brstack':
> 
>           64584494      instructions
> 
>        0.009173945 seconds time elapsed
> 
>        0.007262000 seconds user
>        0.002071000 seconds sys
> 
>  Performance counter stats for 'perf test -w brstack':
> 
>           64672669      instructions
> 
>        0.008888135 seconds time elapsed
> 
>        0.005018000 seconds user
>        0.004018000 seconds sys
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 36 ++++++++++-----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 61f8149d854e..f250b7d6f773 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -4,7 +4,7 @@
>  
>  set -e
>  
> -workload="perf bench sched messaging -g 1 -l 100 -t"
> +workload="perf test -w brstack"
>  
>  # check whether $2 is within +/- 20% of $1
>  compare_number()
> @@ -25,15 +25,15 @@ compare_number()
>  
>  check_counts()
>  {
> -	base_cycles=$1
> -	bpf_cycles=$2
> +	base_instructions=$1
> +	bpf_instructions=$2
>  
> -	if [ "$base_cycles" = "<not" ]; then
> -		echo "Skipping: cycles event not counted"
> +	if [ "$base_instructions" = "<not" ]; then
> +		echo "Skipping: instructions event not counted"
>  		exit 2
>  	fi
> -	if [ "$bpf_cycles" = "<not" ]; then
> -		echo "Failed: cycles not counted with --bpf-counters"
> +	if [ "$bpf_instructions" = "<not" ]; then
> +		echo "Failed: instructions not counted with --bpf-counters"
>  		exit 1
>  	fi
>  }
> @@ -41,29 +41,29 @@ check_counts()
>  test_bpf_counters()
>  {
>  	printf "Testing --bpf-counters "
> -	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
> -	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
> -	check_counts $base_cycles $bpf_cycles
> -	compare_number $base_cycles $bpf_cycles
> +	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
> +	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> +	check_counts $base_instructions $bpf_instructions
> +	compare_number $base_instructions $bpf_instructions
>  	echo "[Success]"
>  }
>  
>  test_bpf_modifier()
>  {
>  	printf "Testing bpf event modifier "
> -	stat_output=$(perf stat --no-big-num -e cycles/name=base_cycles/,cycles/name=bpf_cycles/b -- $workload 2>&1)
> -	base_cycles=$(echo "$stat_output"| awk '/base_cycles/ {print $1}')
> -	bpf_cycles=$(echo "$stat_output"| awk '/bpf_cycles/ {print $1}')
> -	check_counts $base_cycles $bpf_cycles
> -	compare_number $base_cycles $bpf_cycles
> +	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
> +	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
> +	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
> +	check_counts $base_instructions $bpf_instructions
> +	compare_number $base_instructions $bpf_instructions
>  	echo "[Success]"
>  }
>  
>  # skip if --bpf-counters is not supported
> -if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
> +if ! perf stat -e instructions --bpf-counters true > /dev/null 2>&1; then
>  	if [ "$1" = "-v" ]; then
>  		echo "Skipping: --bpf-counters not supported"
> -		perf --no-pager stat -e cycles --bpf-counters true || true
> +		perf --no-pager stat -e instructions --bpf-counters true || true
>  	fi
>  	exit 2
>  fi
> -- 
> 2.43.0
> 
