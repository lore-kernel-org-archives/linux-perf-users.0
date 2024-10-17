Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BB1C174C;
	Thu, 17 Oct 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203158; cv=none; b=QA0BLkhEYyZxRruhTnx8EIbWziyXTYyH5MifUcKQXtVHMhkJLZ6YvkFS8LHCSvOtmk4bNS+Rl19Wt33HEBr3TnW/xQm45nl32N0D0XYmpOoqRwHb2Oum9yYL6NhrqOzdLLBoIHmunFoG85QxkCmtDr3ydismspJ40Fnhzd/myC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203158; c=relaxed/simple;
	bh=bTsHE+Y0emmnEbXfSn8H0bEpvMkkGZ2DH2E7Mk4Bjo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e66GPqlA7+8/RmTUHvsuHY5x98+AENks/EVa4SB2LPEH8FJIkbr821JdRKN70gnXQzZncpmhnRE+LUkPqg7ltb3JBF310TldtROGic/pZ6cUqHswMMp1Lg9XtsR/6fzKKmYxYwkJxvayb6TFSleNbZDYkpFn2DnU37bnc893iMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnZsK7Oh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnZsK7Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D7CC4CEC3;
	Thu, 17 Oct 2024 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203157;
	bh=bTsHE+Y0emmnEbXfSn8H0bEpvMkkGZ2DH2E7Mk4Bjo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnZsK7OhzpAE9MqbR/+bBWjLGSNolhvq5jvlxMaXdTSCLT+/ij0oJcyF2Nz2X00Xe
	 KV3MnBY8aJ7WYqIpbOzWxp3+hSc5GpFIiGP6NBy3rCcSjSWKgTO+HZjYhVJC6y/gB3
	 0WW8iYe/cVGC7WH18dO3qBPJPwpX250Rtur5de2c38umIzKqLpCTfRLtGf2YBqAwkg
	 BXWOH7GFzRCLCnGNKnuSTZvJA2UFn8afgH4rPO1QfSyRlYNDuOiL/NEaWOKtnLzd2D
	 ufJkh31UAICP3Qfno+ix5GoQ4gyAOOtv8Q271jEZ3cgAgxVZl9dp4m1q5lQSp6UpwF
	 hRJkYntJcBXeg==
Date: Thu, 17 Oct 2024 15:12:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] perf/tests: fix record+probe_libc_inet_pton test on
 aarch64
Message-ID: <ZxGL1LF9mVzrUGOU@google.com>
References: <1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com>

Hello,

On Tue, Oct 15, 2024 at 03:53:27PM +0800, Jing Zhang wrote:
> Since commit 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix
> call chain match on x86_64") remove function getaddrinfo() on expected
> file, the test failed on aarch64. On aarch64, function getaddrinfo()
> show up in the call chain.
> 
> $perf script -i /tmp/perf.data.1PV
> ping 2588319 [125] 500119.122843: probe_libc:inet_pton: (ffff9a4f7410)
>             ffff9a4f7410 __GI___inet_pton+0x0 (/usr/lib64/libc-2.32.so)
>             ffff9a4c5f7c getaddrinfo+0xec (/usr/lib64/libc-2.32.so)
>             aaaad6d32b38 [unknown] (/usr/bin/ping)

I'm curious how other ARM folks don't see this.  Does it depend on
something other?  Then can we make the line optional like we did on
s390 recently?

> 
> So just remove getaddrinfo() on x86_64.

I'm not sure how it works on other archs.

Thanks,
Namhyung

> 
> Fixes: 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 47a26f2..09d7b0b 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -52,8 +52,12 @@ trace_libc_inet_pton_backtrace() {
>  		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
> +	x86_64)
> +		eventattr='max-stack=3'
> +		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  	*)
>  		eventattr='max-stack=3'
> +		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac
> -- 
> 1.8.3.1
> 
