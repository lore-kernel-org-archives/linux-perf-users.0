Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13E19C574;
	Thu,  3 Apr 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657981; cv=none; b=QediZEXtKJCN5ISPH7RRuQeNGWLR214pkrILj7jOoR+gEO0MGsM9YpFLfuQgRRegAGcWHFv40jBqzliw58MBWMFrufgt+RSDDIpaXupSG0rmK7yVEVnoJksQajdmXhogMPDChG+p899VIiHmRsdfmoUPIkFuCRLlhhsOLQJ9k4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657981; c=relaxed/simple;
	bh=I2GtHCnDHyec5laEz1xtQumP0JPrYKybMlXAzGNEVKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyMuIhBIz80pTF3aPCNkqz7sThskRZh+bKkzCxMdB9yuVp7ok53cYSL4hZ7J1J1imxXNbMqkLqho+jbFD6WEXz52DY8GSgbHNv4HUmAWDP5VYVB6eZ8xyBkZcIUH9FfdOcu/AFtLa40OKnUb3w6fj1SMIn0WCCalYv/IlhvenWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBF95GZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBF95GZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B2AC4CEE3;
	Thu,  3 Apr 2025 05:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743657980;
	bh=I2GtHCnDHyec5laEz1xtQumP0JPrYKybMlXAzGNEVKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBF95GZYG5lN8gg4y88Sr1P2AA8YVeQHrUw+1WfUJJWhSIYQwUtMf8epATOhjiXvK
	 /RvVo0JYBmIm53xWNtoTL3YdhB2YTvqDdUBXTVRKtGCUNdzB4oGB/k7bX7cNXInXlG
	 5J1NH+yGxpYvr049rzEcDqOI1VoVni7N1m+RObsqwBmt6gIoAMpnZfNBSUV6k3raWh
	 siGfLgvCWj/OneVQzFVnFDZHdpEoJsykXDIyrqdazPl2Z3IWvsdWOnQ/y4UeTV07NT
	 Wjw5fOU8G0sbabLiNxJDLPNfJg72IyTIOudTqsVJjQxEHsa13L4aE1DAWJGv5B+Suj
	 hnriT/N4IoLmg==
Date: Wed, 2 Apr 2025 22:26:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	james.clark@linaro.org, dapeng1.mi@linux.intel.com,
	vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Allow tolerance for leader sampling test
Message-ID: <Z-4b-sVycH2LM8y6@google.com>
References: <20250401172302.1442092-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401172302.1442092-1-ctshao@google.com>

Hello,

On Tue, Apr 01, 2025 at 10:22:39AM -0700, Chun-Tse Shao wrote:
> There is a known issue that the leader sampling is inconsistent, since
> throttle only affect leader, not the slave. The detail is in [1]. To
> maintain test coverage, this patch sets a tolerance rate of 80% to
> accommodate the throttled samples and prevent test failures due to
> throttling.
> 
> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index ba8d873d3ca7..1bbe16fb3420 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -238,22 +238,35 @@ test_leader_sampling() {
>      err=1
>      return
>    fi
> +  perf script -i "${perfdata}" | grep brstack > $script_output
> +  # Check if the two instruction counts are equal in each record.
> +  # However, the throttling code doesn't consider event grouping. During throttling, only the
> +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> +  # let's set the tolerance rate to 80%.
> +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>    index=0
> -  perf script -i "${perfdata}" > $script_output
> +  valid_counts=0
> +  invalid_counts=0
> +  tolerance_rate=0.8
>    while IFS= read -r line
>    do
> -    # Check if the two instruction counts are equal in each record
>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent cycles count]"
> -      err=1
> -      return
> +      invalid_counts=$(($invalid_counts+1))
> +    else
> +      valid_counts=$(($valid_counts+1))
>      fi
>      index=$(($index+1))
>      prev_cycles=$cycles
>    done < $script_output
> -  echo "Basic leader sampling test [Success]"
> +  if [[ "$(echo "scale=2; $invalid_counts/($invalid_counts+$valid_counts)" | bc)" > 1-$tolerance_rate ]]

Shouldn't it be double parenthesis to use numeric comparisons?
Also I'm not sure if bash supports floating-point arithmetic.
It'd be better to compare the value in bc and use its return value.

Thanks,
Namhyung


> +  then
> +      echo "Leader sampling [Failed inconsistent cycles count]"
> +      err=1
> +  else
> +    echo "Basic leader sampling test [Success]"
> +  fi
>  }
> 
>  test_topdown_leader_sampling() {
> --
> 2.49.0.472.ge94155a9ec-goog
> 
