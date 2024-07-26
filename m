Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7260628
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953976; cv=none; b=ZeAzOY8Lh0ovu4uKeBdkCiFtTT1z8JcNpjOFQK7Og//gSOBIzlvG7I8ZkTQS49Ps78uvpT9SAbDDcYFmP5heAp1qSpZLGdEl/8LWIbXcB6GVN8w1pr76+bKGcVSUQt+fLbWUXy7FE3QdCXn4yYaWWTHmkbWdiAktOURz5R+Fu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953976; c=relaxed/simple;
	bh=PjfFfum1D40DrDuceagUPcvJjpmY6OrkIqubK02K+Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKt5Pg7WYO/100j6A05mO8idOcBXia8MMRZ7dQ7FysEYvEAHMRFDsZGytWQ/8yrj+anDAG+v/RVrLnXdxx6AJ1p1Fyb9xmaqEibAynqhYfapM/k40X+m/6EkruhpRNO83ohh/nfGsToEBJUNOgC/TAd1kxTlDjJZY/TpY9YY4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfwZ5mZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfwZ5mZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E165C116B1;
	Fri, 26 Jul 2024 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721953976;
	bh=PjfFfum1D40DrDuceagUPcvJjpmY6OrkIqubK02K+Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfwZ5mZ95Tc7MEHD0Es8cz2rX0CwaEKQN+uJMc7r71/vYhGF8sloEoyHXwshG0T6r
	 zohQndlAQ1gOmMfn0Ibshg6QLPTGZ987hwAsuenxp3vq92/n/L4scJqmyVjX4y+nzG
	 LJvSfdy42S1iuqcZU1bwKNVG658jqwlz13YDPCATHK6t6x5i+flKKVJ935Uw+MwcaM
	 T1C/YXysAfeaC5Mb2HcJ5+mVsvB0nuMlCmRXyUz4SDZ3UZqyxtwjj7tRNrJ3tP7iA6
	 vR0KYMiRB9XsOKxd6rgxZIDuggpQuQOomt8YWZtnaUF9Gg7P3I32JjD1A3QgSEyv92
	 ebqTVIvq80/ag==
Date: Thu, 25 Jul 2024 17:32:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Add a test case for perf script -F +metric
Message-ID: <ZqLutumsVq2_bSga@google.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-4-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240724190137.3810429-4-ak@linux.intel.com>

On Wed, Jul 24, 2024 at 12:01:37PM -0700, Andi Kleen wrote:
> Just a simple test
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ----
> 
> v2: Avoid bashisms. Use noploop
> v3: Avoid false positive in shellcheck
> ---
>  tools/perf/tests/shell/script.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index c1a603653662..5e080e40b390 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -7,6 +7,7 @@ set -e
>  temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
>  
>  perfdatafile="${temp_dir}/perf.data"
> +scriptoutput="${temp_dir}/script"
>  db_test="${temp_dir}/db_test.py"
>  
>  err=0
> @@ -88,8 +89,21 @@ test_parallel_perf()
>  	echo "parallel-perf test [Success]"
>  }
>  
> +test_metric()
> +{
> +	echo "script metric test"
> +	if ! perf list | grep -q cycles ; then return ; fi
> +	if ! perf list | grep -q instructions ; then return ; fi
> +	perf record -e '{cycles,instructions}' -o "${perfdatafile}" perf test -w noploop

Let's use the leader sampling here.

Thanks,
Namhyung


> +	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
> +	test "`grep -c metric $scriptoutput`" -gt 5
> +	grep metric $scriptoutput | head
> +	echo "script metric test [Success]"
> +}
> +
>  test_db
>  test_parallel_perf
> +test_metric
>  
>  cleanup
>  
> -- 
> 2.45.2
> 
