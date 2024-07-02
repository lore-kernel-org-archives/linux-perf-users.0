Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE097282E1
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961222; cv=none; b=B5Dce5qPDmfKxhjPje6LXDoZX0R4t5xvSZuXX6pIcjUrTLiHbt2TJKksecSjt8MpXj1PbZk5NL1OZ9X8yhTelWGwnVd9+FF8mB4PrSKXJUxt1qpqb77DBgPpKXTw7aEwvKL9I2NFx+ACXFPvhbh86agsJ8ht8eDoQyFzLHI6m98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961222; c=relaxed/simple;
	bh=mkZNNAfKheu8FP0FJXI5XquEfjEwKDLT1LEVusaVZ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3kh0qlxzJn5kz2oUyXYY4aYf7co+TYiVnmyPZTm/yS4HahyGRhcbEhjNFjgW+4yWbf48kSC+WNolf0KGT8s361hlXJRaKqJ7MLYwVebggn7CND+UrptzHeEe3xt0bTGdqsncUdd15H1C6y8Symn3X8TkBoUshMfDNOr7Stg0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opMJtTbb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opMJtTbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A0EC116B1;
	Tue,  2 Jul 2024 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719961222;
	bh=mkZNNAfKheu8FP0FJXI5XquEfjEwKDLT1LEVusaVZ2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opMJtTbbBCQiy340eXTXiWkdIUlTfbS/2G/mrK66DqgLRF41kMX68hDMWPlzBnoWH
	 91HTta8s2X9wVbosZwMEYQYAu7Lc9PAt76eB9FdLHwBmTSfE3k1JnTcpGD/xCY1QHH
	 xwpstwystLr1na1gi402HceywRaX+VWax3msYqiK60Bdmsg1UmmK2+MYlnP+fAlUjg
	 pPY7UC5U4da10fdx0yn46lD5BV8cmmT9WIiycr5iaNUrC1sVPK5j+9oCSivrjmF76W
	 K3rAYGOF75TSNUG86lmTj8gJ/RMcmIYTQBXKv0WfAXuufC2006HH4UarhiW8ttRA8x
	 NVaKWln6HNBwA==
Date: Tue, 2 Jul 2024 16:00:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Add a test case for perf script -F +metric
Message-ID: <ZoSGhJRvWEqlTKl7@google.com>
References: <20240628000455.1890269-1-ak@linux.intel.com>
 <20240628000455.1890269-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628000455.1890269-2-ak@linux.intel.com>

On Thu, Jun 27, 2024 at 05:04:55PM -0700, Andi Kleen wrote:
> Just a simple test
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> --
> 
> v2: Avoid bashisms. Use noploop
> ---
>  tools/perf/tests/shell/script.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index c1a603653662..de4b1dce55ad 100755
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
> +	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
> +	test `grep -c metric $scriptoutput` -gt 5

The shellcheck (now part of build process) doesn't like this.

  In tests/shell/script.sh line 99:
  	test `grep -c metric $scriptoutput` -gt 5
               ^----------------------------^ SC2046 (warning): Quote this to prevent word splitting.
  
  For more information:
    https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
  make[4]: *** [tests/Build:91: tests/shell/script.sh.shellcheck_log] Error 1
  make[3]: *** [linux/tools/build/Makefile.build:158: tests] Error 2
  make[2]: *** [Makefile.perf:750: perf-test-in.o] Error 2
  make[2]: *** Waiting for unfinished jobs....

Thanks,
Namhyung


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
