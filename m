Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590319E7CF
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528886; cv=none; b=okTTIt4w+2aJNAduA1Tuu4xwVFWh2eNjcM1IL7zLdLLzeuEt0MFDG54D29MjfBuG/UgyeHQ7mRCcHVwZe7w54+zm7efqa7D5/R8huFnB4Xm9ByC1LnVWlqKaaHxrxMg7BZU7dllUzqjxw8cpQIVTYdw6nl9YGX3wCN5AdCO3rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528886; c=relaxed/simple;
	bh=r3sVzubnrRoYdeVlsM0Fl6qgJJNDJWGciVIonCrzca8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugIFo09wkqBxox1WQDPcNV80g5SeLfEgmtDu8ihe4XeLkBEU6d1DJfhDe57TRlTT0TYPd5TV1sVPRIO/e9xIcRSoNlttcw72HLvvpRAQRVwGyEq9IRcOtbYI3aJkyPGkJ/cCyFLvmBWuObYeJqzsbj82+WPzwFadZdVqaHhrQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsRy52Lw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsRy52Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBB2C2BBFC;
	Thu, 27 Jun 2024 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719528885;
	bh=r3sVzubnrRoYdeVlsM0Fl6qgJJNDJWGciVIonCrzca8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsRy52LwRBxZJoVVpSIWk6C/n5a/Jf3oehsSBbtAQf7B41sdbsKNI13pFC5ByW6Fq
	 WWZKzuGRFDCHzUl4z4MWAFGEn/a7Kpggb9pSczqDc2Me0Tbt7ZzMmu74k28TiCqYFr
	 XiArp1ohxQMUIzyWqKlwbPfhHE5Vj4QoHUmAfoIPZ7dIvltgLQm70j9zCZB7SAlsVa
	 lweI0e1fDjqElqLOVIKEUl1PsAIfhUzj5z9THz9SnsOCuzDF1oHZX9nIatUTUXT3Ml
	 9OWKZEKN6KpI754kVPxWOPVT6R8ANLbwDyGaxrXkZaJPfLufxiDLAnnzKTwZ4nEm+G
	 qhY57+WrB46Nw==
Date: Thu, 27 Jun 2024 15:54:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] Add a test case for perf script -F +metric
Message-ID: <Zn3ts87B4KEebXUB@google.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
 <20240625004232.1852705-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625004232.1852705-2-ak@linux.intel.com>

On Mon, Jun 24, 2024 at 05:42:32PM -0700, Andi Kleen wrote:
> Just a simple test
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/tests/shell/script.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index c1a603653662..cd9d41734021 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash

Do we really need this?


>  # perf script tests
>  # SPDX-License-Identifier: GPL-2.0
>  
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
> +	perf record -e '{cycles,instructions}' -o "${perfdatafile}" bash -c 'for i in `seq 1000` ; do true ; done'

You can use built-in workloads like noploop or so instead of running
an external command.

  $ perf record -- perf test -w noploop

Thanks,
Namhyung


> +	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
> +	test $(grep -c metric $scriptoutput) -gt 5
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
