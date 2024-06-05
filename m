Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1B1C27
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547509; cv=none; b=qRmBAecp9XXhVs5gHq2Xu2KYAlgICWYSUBdKWYTC4RErfq8wttn0f3PqFW8+70hKyfET6ktps6oooVDRtJ4qRVdaVTto551Dch6JjLPmXjOcgmd/tekzRjpFxnHsh7coBynpM/q/iQ4Mfx7LVfAsJx7JFcA2i2KL33VLUME4fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547509; c=relaxed/simple;
	bh=Gsr/bnTcp1ZQFE15Sl1IbRcVTqIuOXHvpSA70xrH90Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBG0zMdkaCpBTrip33Korbr7zC6gzkVb3ymeEiAWMfZIj/r/xX1yuXvPDB6u1ZA0joR4yuaZeYVYmA4HbGkI+ADhXDdONdljKWlXPr15Nm9FxiHAKED0bPob55rKAJQ+/ih7Vzz5PvoAvI9NeRsRpIAldKSdYeo3e54NmxfYAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3Wpl14H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3Wpl14H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62ADC2BBFC;
	Wed,  5 Jun 2024 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547509;
	bh=Gsr/bnTcp1ZQFE15Sl1IbRcVTqIuOXHvpSA70xrH90Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3Wpl14HmhYsRwivXc+xE6TOj1Em3yFsJIx+sJmIVkNZNfQjFvupQeC2/vY++WL4/
	 HCAvIDU9PLCANsY5Cotj13rAOQEIAAf5Qh6P2kuNL848qdFZtaDGRCEdF0mDBapOyF
	 VcPK1gsGE1EZFFHVDVAXK5Atfe32q8ovfyuQGqSTHh3GtBQ/gT3L4fUSo3LyX9H7kT
	 XEeL0QsAFTYnhXBasr6d89CPZY5Pyop4Yf0jorpAbyyASQk1Xruvuumqbhxeihv8c7
	 rR19/Jd9V/cdRxFKYVFeBcKxuHrQDwp/DAhaAfv/bjtARaIcGCV5LDPJPgld8uzC35
	 wK2gkiptc4syw==
Date: Tue, 4 Jun 2024 17:31:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com
Subject: Re: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of
 separate runs
Message-ID: <Zl-x8uob6NT3HlfT@google.com>
References: <20240604153111.105548-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604153111.105548-1-vmolnaro@redhat.com>

On Tue, Jun 04, 2024 at 05:31:11PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The test has been failing for some time when two separate runs of
> perf benchmarks are recorded and the counts of the samples are compared,
> while once the recording was done with option --bpf-counters and once
> without it. It is expected that the count of the samples should within
> a certain range, firstly the difference should have been within 10%,
> which was then later raised to 20%. However, the test case keeps failing
> on certain architectures as recording the same benchmark can provide
> completely different counts samples based on the current load of the
> system.
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
> From the testing point of view, it does not make sense to compare two
> separate runs against each other when the conditions may change
> significantly. Remove the comparison of two separate runs and check only
> whether the stating works as expected for the --bpf-counters option. Compare
> the samples count only when the samples are recorded simultaneously
> ensuring the same conditions.

Hmm.. but having a test which checks if the output is sane can be
useful.  If it's a problem of dynamic changes in cpu cycles, maybe
we can use 'instructions' event instead (probably with :u) to get
more stable values?

Thanks,
Namhyung

> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index 61f8149d854e..873b576836c6 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -6,19 +6,19 @@ set -e
>  
>  workload="perf bench sched messaging -g 1 -l 100 -t"
>  
> -# check whether $2 is within +/- 20% of $1
> +# check whether $2 is within +/- 10% of $1
>  compare_number()
>  {
>  	first_num=$1
>  	second_num=$2
>  
> -	# upper bound is first_num * 120%
> -	upper=$(expr $first_num + $first_num / 5 )
> -	# lower bound is first_num * 80%
> -	lower=$(expr $first_num - $first_num / 5 )
> +	# upper bound is first_num * 110%
> +	upper=$(expr $first_num + $first_num / 10 )
> +	# lower bound is first_num * 90%
> +	lower=$(expr $first_num - $first_num / 10 )
>  
>  	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
> -		echo "The difference between $first_num and $second_num are greater than 20%."
> +		echo "The difference between $first_num and $second_num are greater than 10%."
>  		exit 1
>  	fi
>  }
> @@ -44,7 +44,6 @@ test_bpf_counters()
>  	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
>  	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
>  	check_counts $base_cycles $bpf_cycles
> -	compare_number $base_cycles $bpf_cycles
>  	echo "[Success]"
>  }
>  
> -- 
> 2.43.0
> 
