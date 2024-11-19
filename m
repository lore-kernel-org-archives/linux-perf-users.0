Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914DDDAB;
	Tue, 19 Nov 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977687; cv=none; b=dFI1KgJcNMQ1UTISQAv5Mfg8D0KPA9HWv8DYO/jJQEJLaoichBT0RxfSswi/HUXHj8/OtFHanonTcFqYABhIfhTC7HGWyagg8W1P2Z4Ni84tBKMyIytDCAkIh420n0QjT93CD3gwYc0o/v72UZgNtlnM8mglwb+emWJFwbR52fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977687; c=relaxed/simple;
	bh=mCsUESeGqYyManR/66muUfpuIv8qL0U9c/qMPXLc8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smbMXlDEJI7E7S4/EALnsAslFMaww0zGxnZOT7MtL0HwThC6Cskg5C9Hr4z3L/dWFnDg15cqLg39OGrnuVXmEsTrcfwmQxxLMvrtNJd+BivxZdyYMcJBg1y5kahOvrdIFeklDqFOZXfC8u2FjlU3/dzgpDVidcMyk0o6+OV3sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCWLYQk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCWLYQk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA33C4CECF;
	Tue, 19 Nov 2024 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977687;
	bh=mCsUESeGqYyManR/66muUfpuIv8qL0U9c/qMPXLc8r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCWLYQk+pUd10TssCLOvIpAG922iHwQ1fO5pTzwKmLEWiYIUKuzZPYSPbf14V7Wib
	 cBD1aazSqYSqj4Cj2BQwLTfsUC2TPCnhe/G3VE/CfSNHVUrIONp6d1XPX72SoFkA78
	 NMjycgRC3FuddN+Rk7Gdzsy95Yu9MD9oR+lCyFn24o4y13CvpDqBREDaUcmzqvx4kj
	 oBoXl5ucqxDwcqK7Kx73lvdP6NERwI+pczWf2akS9YisRCn7nCUS5T9OhvVybP0Zy6
	 xWqQ9hTzppfj12hgcp2chQuiC+lPPAtTJhP166z6pTOX/nSM0vZ4+8gt+hZqTlMI39
	 TCMWMFZ/DzLKg==
Date: Mon, 18 Nov 2024 16:54:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, james.clark@linaro.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] perf/test: fix perf ftrace test on s390
Message-ID: <Zzvh1XZzxXrUdhG-@google.com>
References: <20241115065735.2753032-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115065735.2753032-1-tmricht@linux.ibm.com>

On Fri, Nov 15, 2024 at 07:57:35AM +0100, Thomas Richter wrote:
> On s390 the perf test case ftrace sometimes fails as follows:
> 
>   # ./perf test ftrace
>   79: perf ftrace tests    : FAILED!
>   #
> 
> The failure depends on the kernel .config file. Some configurarions
> always work fine, some do not.  The ftrace profile test mostly fails,
> because the ring buffer was not large enough, and some lines
> (especially the interesting ones with nanosleep in it) where dropped.
> 
> To achieve success for all our tested kernel configurations, enlarge
> the buffer to store the traces complete without wrapping.
> The default buffer size is too small  for all kernel configurations.
> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB
> 
> Output after:
>   # ./perf test ftrace
>   79: perf ftrace tests     : Ok
>   #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index a6ee740f0d7e..6161a8bdc251 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -14,6 +14,11 @@ output=$(mktemp /tmp/__perf_test.ftrace.XXXXXX)
>  
>  cleanup() {
>    rm -f "${output}"
> +  if [ "$(uname -m)" = "s390x" ]
> +  then
> +	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
> +  fi
> +
>  
>    trap - EXIT TERM INT
>  }
> @@ -80,6 +85,12 @@ test_ftrace_profile() {
>      echo "perf ftrace profile test  [Success]"
>  }

Could you please use `perf ftrace profile -m 16M ...` instead?

Thanks,
Namhyung

>  
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
> +	echo 16384 > /sys/kernel/tracing/buffer_size_kb
> +fi
> +
>  test_ftrace_list
>  test_ftrace_trace
>  test_ftrace_latency
> -- 
> 2.47.0
> 
