Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45E1DFE22
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748552303; cv=none; b=YJw3yTsgDBkrjUCNX7d/Q95BF3u/6YgmRRUp2wFXwsJF7yssVzbm+XZXEYEufKsGRRxHpw8abCUgYTiHx6qZKUFbphjGO6h356Zwr8WiG/eD/yvovX5N6pNwtmRjWzAKvcblSn7seajczOsY1CQ8CF7CnXNwRE+BBJ9RocoLw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748552303; c=relaxed/simple;
	bh=+8hmouDlAlvBZw4X5c1SQKI7ETOIA05IZTa/UMIGwpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3yoewoWdlcd2n2WSzLcyI0qKNX0GpdGJ16EMZqZRP1sRD7t+kH6CnwGmhgn0O+aMeWEPrEGICz3+ZYVJ1CWX3+Vuh+5E6z655+Qec9Yjtb9CkNF096a3xZppT1PMdSfikBWT8I4d0VkeHvekOB36IvdZ/JcTcUwgXJyHoOhw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGXVDEwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGXVDEwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34450C4CEE7;
	Thu, 29 May 2025 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748552302;
	bh=+8hmouDlAlvBZw4X5c1SQKI7ETOIA05IZTa/UMIGwpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGXVDEwYTT/J15U6KBN4DLaMVtMuuBSj/hczHHAjCPkcF/g40eE7anHBN7cXVfEz+
	 anxngw7dAjO/46te3BorybsGqPljvool74ZL/SxxtRj3p4u6tfBjVVeUQXAYoH1Z8i
	 Gk0jPPBrwr6O3dfRRLOj3nDIO6ltFvJMdyFKN6w/vftbueSv/kfaXHhrFwtP4cpv0c
	 kuj8X0NNAvjdHg2fbVaUjwqelm3bpNA16dUHkJXz6EkiuqSYTFz1ig2wWhlpO9QEyP
	 T1qNi/T3AzoN6/3/oMBCohwQWHTRsbr56SoGQbqFYYMUTa0KkupzoFkqHvaSSCWLoQ
	 4cMxaNdOZBHEQ==
Date: Thu, 29 May 2025 13:58:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: set errpid to false for rseq and
 set_robust_list
Message-ID: <aDjKbDqdlnrC50ul@google.com>
References: <20250529143334.1469669-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529143334.1469669-2-ashelat@redhat.com>

Hello,

On Thu, May 29, 2025 at 10:33:35AM -0400, Anubhav Shelat wrote:
> rseq and set_robust_list don't return a pid, so set errpid for both to
> false.
> 
> Fixes 0c1019e3463b2 and 1de5b5dcb8353.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 07eddd5c0baa..0e086b7c1495 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1348,7 +1348,7 @@ static const struct syscall_fmt syscall_fmts[] = {
>  	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
>  		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
>  		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
> -	{ .name	    = "rseq",	    .errpid = true,
> +	{ .name	    = "rseq",	    .errpid = false,

Probably better to just remove the errpid part.


>  	  .arg = { [0] = { .from_user = true /* rseq */, }, }, },
>  	{ .name	    = "rt_sigaction",
>  	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
> @@ -1372,7 +1372,7 @@ static const struct syscall_fmt syscall_fmts[] = {
>  	{ .name	    = "sendto",
>  	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
>  		   [4] = SCA_SOCKADDR_FROM_USER(addr), }, },
> -	{ .name	    = "set_robust_list",	    .errpid = true,
> +	{ .name	    = "set_robust_list",	    .errpid = false,

Ditto.

Thanks,
Namhyung


>  	  .arg = { [0] = { .from_user = true /* head */, }, }, },
>  	{ .name	    = "set_tid_address", .errpid = true, },
>  	{ .name	    = "setitimer",
> -- 
> 2.49.0
> 
