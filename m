Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161951C31
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwulOFOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFEC433C8;
	Tue, 21 Nov 2023 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700569961;
	bh=zGnoedvglamEbp32UJfoHImXoP4xUfJaqjgMd05AtNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwulOFOw54sw8cq8gtxbQvDcUCh068vF14yB5jDdYBcQp1hb1PqQWzqYBFNRD32eY
	 RqWYoFAprQ8Lrb3ZnkVhBFbFGzXceKyyAbiCVn6ip+xpaqfEmg+wYQqUiVspW3Ts7s
	 sdP7xyh6jFZDfBj2TnyhpM+qkY3+ZKm3M6j+yz/e+rN7/6O/7oEN35JSleWCt5flN+
	 X3gpDII1rTjMuYHidqggpjkik4y+sjp8+Cxe7PMLOIuAfeGr5ZB1mDLbN8Tb1Oukso
	 wEs2jHS+G9XtydMJlZmY6FIsweNXCpNCLCtenO5JLZkVmlQv65hi+0XjquesLBTf6E
	 yPv6i6/yRi8qA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id E2AD340094; Tue, 21 Nov 2023 09:32:38 -0300 (-03)
Date: Tue, 21 Nov 2023 09:32:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test record.sh: Raise limit of open file descriptors
Message-ID: <ZVyjZjPCXVmGGVFk@kernel.org>
References: <20231115140522.28200-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115140522.28200-1-vmolnaro@redhat.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 15, 2023 at 03:05:22PM +0100, vmolnaro@redhat.com escreveu:
> From: Veronika Molnarova <vmolnaro@redhat.com>
 
> Subtest for system-wide record with '--threads' option fails due to a
> limit of open file descriptors(usually set to 1024) on systems with
> 128 and more CPUs.
> 
> If the default limit is set lower than 2048 file descriptors,
> temporarily raise it to this value for the test.

Can we instead raise it to a multiple of the number of CPUs? Using:

[acme@five ~]$ getconf _NPROCESSORS_ONLN
32
[acme@five ~]$

If you tested 2048 is ok for a 128 CPU system, then maybe this is more
future proof:

[acme@five ~]$ echo $(($(getconf _NPROCESSORS_ONLN) * 16))
512
[acme@five ~]$ echo $((128 * 16))
2048
[acme@five ~]$

- Arnaldo
 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/record.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 4fbc74805d52..c6c43263809a 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,6 +11,8 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog="perf test -w thloop"
>  testsym="test_loop"
> +min_fd_limit=2048
> +default_fd_limit=$(ulimit -n)
>  
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -154,10 +156,16 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>  
> +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> +	ulimit -n $min_fd_limit
> +fi
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
>  
> +ulimit -n $default_fd_limit
> +
>  cleanup
>  exit $err
> -- 
> 2.41.0
