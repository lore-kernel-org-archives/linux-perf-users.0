Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A622258C;
	Tue, 28 Oct 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663698; cv=none; b=Cix7NJReqop9HBL1IL0MByGFyujWC9AuAm4FAbaXZxS5w9ec1/UKPdhPAOnn4+K8S/1dOvztlnwbXtv7JfGjwO64xOp/Qs6nsO3F5PdOLOOH7T8X3/gRSeaYtB7qQDZBFI7UMFVSTZnA2PMvQnSYxVbMWY/WSQQ4539PCMbk3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663698; c=relaxed/simple;
	bh=fDR1UU/jpViWj3orEqNioy0ypYiNSTaz9PN1NfzZJCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYDU7nQBQEDewa3rZl0nNWlq5xMmeoj/kIw7WpcGtLJ5zE6MbP43g/hduxiIw3gy8FEAJT9dqcHCOnxke9oDda60ZiZU+C/qQuFMNuVN7WNijiTtEOY5E5wjPzW65w6ZkdpHYRHYSpdkgTd1DUq1MsVI2dB6qPbozGZP3VuFTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tse/r+jC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tse/r+jC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023AFC4CEE7;
	Tue, 28 Oct 2025 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761663698;
	bh=fDR1UU/jpViWj3orEqNioy0ypYiNSTaz9PN1NfzZJCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tse/r+jCxNHiXhrcdFauGq/IZ+/+nfqLl9vgLk/PGzVm3BGqbSNvrmwABTSvxznrO
	 dvhjRsAGDvgHNwzkcJSXHoDLX7fD1twvALuYJ56Kyq1u3YsktGwDX3jCzOZywYnioO
	 SWtCdT7fJGFEbTnU/BHreO+wQiIc6jvM7Ek8YbyCY2ypHug+o+6nWIgMJERb/UOYLO
	 w6Y+WygjECJXgPm7fRJ/AEulyJTOLi1rNinBP9grUdGXEEBKd7h9h6TWSj3sy+bIfU
	 ++08GhpzcqNhEgFqK/8LUc8E61VBdsvOKaAW/KHCsWbxKCKJMPTxarBtfMSEYNIXew
	 UufCnkfgPf47g==
Date: Tue, 28 Oct 2025 12:01:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Zoe Gates <zoe.blair.gates@icloud.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	zoe@zeocities.dev, yujie.liu@intel.com, sandipan.das@amd.com,
	leo.yan@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf trace: Fix filter expansion length typo
Message-ID: <aQDazno_nD2vMSUx@x1>
References: <6b7c6221032fe9ca888d9905479d0bd502f583f7.camel@icloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b7c6221032fe9ca888d9905479d0bd502f583f7.camel@icloud.com>

On Mon, Oct 27, 2025 at 11:00:33PM -0500, Zoe Gates wrote:
> >From 08185c5be135eb83194a49e593be9258cec78d77 Mon Sep 17 00:00:00 2001
> From: Zoe Gates <zoe@zeocities.dev>
> Date: Mon, 27 Oct 2025 22:14:24 -0500
> Subject: [PATCH 1/3] perf trace: Fix filter expansion length typo
> 
> Keep the filter expansion helper readable by using
> expansion_length everywhere and wrapping the scnprintf call.

You're mixing up changes to the perf-script man page with the perf trace
source code and the patch is garbled:

⬢ [acme@toolbx perf-tools]$        patch -p1 < ./20251027_zoe_blair_gates_perf_trace_fix_filter_expansion_length_typo.mbx
patching file tools/perf/Documentation/perf-script.txt
patch: **** malformed patch at line 42: sample. This is only supported when the

⬢ [acme@toolbx perf-tools]$

also plese try to keep the
existing code structure when changing just typos, i.e. if you have:

	int variable = function();

Don't change it to:

	int variable;

	variable = function();

- Arnaldo
 
> Signed-off-by: Zoe Gates <zoe@zeocities.dev>
> ---
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  tools/perf/builtin-trace.c               | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt
> b/tools/perf/Documentation/perf-script.txt
> index 28bec7e78bc8..e136ca35d380 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -262,7 +262,7 @@ OPTIONS
>  	is printed. This is the full execution path leading to the
> sample. This is only supported when the
>  	sample was recorded with perf record -b or -j any.
>  
> -	Use brstackinsnlen to print the brstackinsn lenght. For
> example, you
> +	Use brstackinsnlen to print the brstackinsn length. For
> example, you
>  	can’t know the next sequential instruction after an
> unconditional branch unless
>  	you calculate that based on its length.
>  
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c607f39b8c8b..ae5fabf91c96 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4291,7 +4291,10 @@ static int trace__expand_filter(struct trace
> *trace, struct evsel *evsel)
>  
>  				if (fmt->strtoul(right, right_size,
> &syscall_arg, &val)) {
>  					char *n, expansion[19];
> -					int expansion_lenght =
> scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
> +					int expansion_length;
> +
> +					expansion_length =
> scnprintf(expansion, sizeof(expansion),
> +								    
> "%#" PRIx64, val);
>  					int expansion_offset = right -
> new_filter;
>  
>  					pr_debug("%s", expansion);
> @@ -4303,7 +4306,7 @@ static int trace__expand_filter(struct trace
> *trace, struct evsel *evsel)
>  					}
>  					if (new_filter != evsel-
> >filter)
>  						free(new_filter);
> -					left = n + expansion_offset +
> expansion_lenght;
> +					left = n + expansion_offset +
> expansion_length;
>  					new_filter = n;
>  				} else {
>  					pr_err("\"%.*s\" not found for
> \"%s\" in \"%s\", can't set filter \"%s\"\n",
> 
> base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
> -- 
> 2.51.1
