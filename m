Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410A200CB;
	Tue, 19 Nov 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043245; cv=none; b=hcDHhexOzNfhkv/n9WJ1ZbG4Acsg3zlhb67iqv/u6xsoqEs5EQeSfgO29uL75nz+jaekwVFHSB+eIW4xea0xvr84/6kj75ovqW2xfA+axpKvyQ7JYgUILDp+mZWkzPFD/zbFJuXpd6sttPQBNMz1/k0pMi5ijaWIoJPjpr4aJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043245; c=relaxed/simple;
	bh=ZfqypZC9Pum348YiupEwAgdeG1OQPIFfOAIVK/sKshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpXQXDiVdn58UQJrehVgiWJTKo6JeNF9idKvs0LJka82t0r5eCm5AnOLUONzzekEi3n7Wp/KGKTXatynmu9JTT2fsvjGYMVUk3Ud9Cw26APuuyQ546Mmmb0D0a7OJFPQehSmShGZoY/FYcniRHG+1LNv0vn2EhKBa/2um4jMpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHhUSB5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHhUSB5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B2CC4CECF;
	Tue, 19 Nov 2024 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043245;
	bh=ZfqypZC9Pum348YiupEwAgdeG1OQPIFfOAIVK/sKshs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHhUSB5G/7ThpMlmYBfZ1mbjl6PHzanHKMwwF5zxKIQkRwz/GRbkOXz1HMcKxigVR
	 15xVDNcLTGC8qlLc6niEsRhntwGBU3ijMaiqu/K+ViXLhhxybFQk/3VsYUE1qfqAG6
	 KGYdKsIV49iADaT76IWzd1CAPSAoc1Gqh6ikdKxGeUEVN5ytPrrLio+od0tE7eK2fo
	 pUcR4KJQQsiEU7yjYp6Hsy566GHCUz3hz+ORzVc7HxWkWHQidkwJd95m36HIw9kFau
	 j1Naq0JCJoW+/G8pQeICTzC5lZwzRozZYMnx6zpuRY37d/pM4YHRiMXc0sbzvTKnaT
	 ChIRSe81CseGw==
Date: Tue, 19 Nov 2024 11:07:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3] perf/test: fix perf ftrace test on s390
Message-ID: <Zzzh68RRaVm3BVUJ@google.com>
References: <20241119064856.641446-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119064856.641446-1-tmricht@linux.ibm.com>

On Tue, Nov 19, 2024 at 07:48:56AM +0100, Thomas Richter wrote:
> On s390 the perf test case ftrace sometimes fails as follows:
> 
>   # ./perf test ftrace
>   79: perf ftrace tests    : FAILED!
>   #
> 
> The failure depends on the kernel .config file. Some configurations
> always work fine, some do not.  The ftrace profile test mostly fails,
> because the ring buffer was not large enough, and some lines
> (especially the interesting ones with nanosleep in it) where dropped.
> 
> To achieve success for all tested kernel configurations, enlarge
> the buffer to store the traces completely without wrapping.
> The default buffer size is too small for all kernel configurations.
> Set the buffer size of for the ftrace profile test to 16 MB.
> 
> Output after:
>   # ./perf test ftrace
>   79: perf ftrace tests     : Ok
>   #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/ftrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index a6ee740f0d7e..a785a6274922 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -67,7 +67,7 @@ test_ftrace_latency() {
>  
>  test_ftrace_profile() {
>      echo "perf ftrace profile test"
> -    perf ftrace profile sleep 0.1 > "${output}"
> +    perf ftrace profile -m 16M sleep 0.1 > "${output}"
>      grep ^# "${output}"
>      grep sleep "${output}"
>      grep schedule "${output}"
> -- 
> 2.47.0
> 
