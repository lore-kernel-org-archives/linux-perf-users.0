Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60712364AB
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885951; cv=none; b=TMFoFOKDwQhGBXETPkfNlK3nxHpcKa758IEQ4UuaJqDlH0Vd+QjAVlqCrdMa/w4ke43oavd8s0B2k9TWYAAI5zmn/PCha2PdmC1TlprBFk64eTpTQfW5xmr8Vf9R2HyxG/R5tqc2yrPD0EOr2QUupAyVW0CiK/QOPj2C4PGr36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885951; c=relaxed/simple;
	bh=fhkNfnsjGWd+VZGRllYXpp7QDQJLpLgJjnteHFosbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY7lCS1Mhxd12kyKF61T3/Dd6ZOcWpm8sknboyqfLz6N3t+daBTmobmVrs/mtaQDzgyoiimO1ZIJGQvC09g+Q2+m3hi4r/oVukzk6LUApKQBtdxnGn+jSxSP68zE4+KDM5FiHP36v8fWJYNiqUMIdaeBoHWCzJ3dSWnB7pAKU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyAKHbAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyAKHbAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D272BC32782;
	Mon,  5 Aug 2024 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885951;
	bh=fhkNfnsjGWd+VZGRllYXpp7QDQJLpLgJjnteHFosbNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyAKHbAzJYsc54FbCjmvjrGx7Hj7QK4/itW0S7FvDE0YOfTduEdQbynUiuCqVAVfF
	 z1dhxUvW5e4+jyackbVUx2e2O0Kpl9sDCgpfIMfyq1KZ5zBDVwxRpdH0FYqdXOKGCQ
	 XBt9yU9WcyryyPGqsbaL1g/n5xuOueSIxWAbWKPit59SQCmXFR2q8beFaw11lXKLez
	 JX8GJrIaZ7Tbee6L3t75TIrGvqmQHpT/X+J/VgzxUpTDVwxXcu12XP1WjKt9XBUWzL
	 sRIIbWTYpbsH8CJOMPAXwX5p5GKesAG510Dyr1G6sl/98cCJYjW7zzljEsJo8N5t7O
	 xvqSaUOkriiXQ==
Date: Mon, 5 Aug 2024 12:25:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 4/4] Add a test case for perf script -F +metric
Message-ID: <ZrEnPYNK-59eGjoy@google.com>
References: <20240801212844.677895-1-ak@linux.intel.com>
 <20240801212844.677895-4-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801212844.677895-4-ak@linux.intel.com>

On Thu, Aug 01, 2024 at 02:28:44PM -0700, Andi Kleen wrote:
> Just a simple test

Can you please briefly describe what the test does?  Ideally with an
example output with 'perf test -vv'.

Thanks,
Namhyung

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ----
> 
> v2: Avoid bashisms. Use noploop
> v3: Avoid false positive in shellcheck
> v4: Use :S in the test (Ian, Namhyung)
> ---
>  tools/perf/tests/shell/script.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index c1a603653662..e69c3548583a 100755
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
> +	perf record -e '{cycles,instructions}:S' -o "${perfdatafile}" perf test -w noploop
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
