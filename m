Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A151DB94C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455135; cv=none; b=Vq1wSRCbjgrfGHf5RxBH8fparZlQEBz/f1k0RgWOWbs7LYggPpRKZHlvykLYV3eJT7Pu4B9mnPaf6lFPU1pIivu/hi2EonZFtFvB544IGPzaExQgKDD93e4cALpiUEmjNxLFF90nBcZjh7tktwrDCHjCRWuRLscZ/LEAffZ6l74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455135; c=relaxed/simple;
	bh=uVVf9cmWr0r2rRDL4SQs0SWxxAzcXe+nZwH80jVfdRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMrbVaz3ogjJ7TFzoGJixl61qBQzEvUkFyKZIl0N1Kt+G9cju6dtdScfNl3kvXdYqm6w3VZnoNPXow8mF3Xr3QX8qCrEjWtuPF3rgpjeyf4XK7LnOMFFiqRl6lyalAsaYp5Zkceo4KRGRZc1juHVw4iqx4q0khZOJw/gkeRzHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR0AUq0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR0AUq0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89642C4CEC8;
	Wed,  4 Sep 2024 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455135;
	bh=uVVf9cmWr0r2rRDL4SQs0SWxxAzcXe+nZwH80jVfdRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR0AUq0dYwBROhkoj66jwhvyviBmftWMKvt+DLNG2d5i/tKuf7yRdShQEqhtK2Ons
	 3hjGu2ypCytkyTJzfW1/YqKRLjMUAZ/R7WS8SwiPAqynfI2PxZ3nz8agvQg51JpHsH
	 bbr0l6tUxJynYxENEcXwcP1zxBu4iabX4zp0ASiFdXXpaviwPVQXquC6QBQrbhkkTv
	 MNZGz8x04y/epjXBUNqpmmbepPnYxjY/iwHP7Rqfi/y7yd4N+8KYyFsPaC4c1zznCz
	 7mUoBMZzsSUEqvhLVMRCSgLZz2EWcfjda1kDIbVLOMnoX6VAnAhjScvG6e/6g2qctP
	 xvPo/54S8qThg==
Date: Wed, 4 Sep 2024 10:05:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v14 3/7] perf version: Update --build-options to use
 'supported_features' array
Message-ID: <ZthbFDYPX3Opb8Ij@x1>
References: <20240904061836.55873-1-adityag@linux.ibm.com>
 <20240904061836.55873-4-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904061836.55873-4-adityag@linux.ibm.com>

On Wed, Sep 04, 2024 at 11:48:32AM +0530, Aditya Gupta wrote:
> Now that the feature list has been duplicated in a global
> 'supported_features' array, use that array instead of manually checking
> status of built-in features.
> 
> This helps in being consistent with commands such as 'perf check feature',
> so commands can use the same array, and any new feature can be added at
> one place, in the 'supported_features' array

So I tested and applied the first two patches, but it is failing for
this 3rd, please rebase from what is in the tmp.perf-tools-next branch
at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

- Arnaldo
 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/builtin-version.c | 43 +++++++-----------------------------
>  1 file changed, 8 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 398aa53e9e2e..e149d96c6dc5 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -46,45 +46,18 @@ static void status_print(const char *name, const char *macro,
>  	printf("  # %s\n", macro);
>  }
>  
> -#define STATUS(__d, __m)				\
> -do {							\
> -	if (IS_BUILTIN(__d))				\
> -		status_print(#__m, #__d, "on");		\
> -	else						\
> -		status_print(#__m, #__d, "OFF");	\
> +#define STATUS(feature)                                   \
> +do {                                                      \
> +	if (feature.is_builtin)                               \
> +		status_print(feature.name, feature.macro, "on");  \
> +	else                                                  \
> +		status_print(feature.name, feature.macro, "OFF"); \
>  } while (0)
>  
>  static void library_status(void)
>  {
> -	STATUS(HAVE_DWARF_SUPPORT, dwarf);
> -	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
> -#ifndef HAVE_SYSCALL_TABLE_SUPPORT
> -	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
> -#endif
> -	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
> -	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
> -	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
> -	STATUS(HAVE_LIBELF_SUPPORT, libelf);
> -	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
> -	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
> -	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> -	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
> -	STATUS(HAVE_SLANG_SUPPORT, libslang);
> -	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
> -	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
> -	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
> -	STATUS(HAVE_LIBCAPSTONE_SUPPORT, libcapstone);
> -	STATUS(HAVE_ZLIB_SUPPORT, zlib);
> -	STATUS(HAVE_LZMA_SUPPORT, lzma);
> -	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
> -	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
> -	STATUS(HAVE_AIO_SUPPORT, aio);
> -	STATUS(HAVE_ZSTD_SUPPORT, zstd);
> -	STATUS(HAVE_LIBPFM, libpfm4);
> -	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
> -	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
> -	STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
> -	STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
> +	for (int i = 0; supported_features[i].name; ++i)
> +		STATUS(supported_features[i]);
>  }
>  
>  int cmd_version(int argc, const char **argv)
> -- 
> 2.46.0
