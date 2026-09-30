Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE034F27B;
	Wed, 30 Sep 2026 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740967; cv=none; b=pMO9pdWBXX7twxHBI9ostNkG2YmQnKcrGOGcOZerwOSUP6wbOrJu2t98nDDOJmI8JNaDEX3Rkp8hMf1haLY6UWLb1HfCcxhYRqtfP3jwfgC2j+0WTKzl4Y3HjJQ/pmmCb72pbBppc6AAcYMW2G3ceijksAxOCMz4kmoXrGGOcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740967; c=relaxed/simple;
	bh=1Q7l9P+mwBxjDPYZS00viz31btmtmTyUZYwSao8wJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3/SQ3Db6ufJIH28mw2JW1Rgk2/JDdPLCheRweEkVHL+ixpe1t5M2XODiediwdPtsYzOWsh68iUVNWnO7e8vYJbwTbVgz/GSciBg4ITPvNlzMZV5CNvzDlniA0fVLNZiob61npjVKCuIc80H6yUR5KaBaIJz3/RJ5TDKSNhhxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD69uOlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD69uOlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8776A1F000FF;
	Wed, 30 Sep 2026 04:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740966;
	bh=fCNNrgHeF3TH0JxabxCWSQevJB+6mov4VDtLXvGgrsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HD69uOlRbB78U5Kr6K/BU0J4R0qXQ38JIOhZBlN3YXsflMCzQn62OGc9PDVofAvYx
	 RlR7ULMKM7kSZ+svXMQntZ++x5bFMeh0bjr+hgIEmVeg7uC2TF7OPOewOfIdlNQcCf
	 HVdHPMLccXZEBhdunmaKK1y0xewF2b2Kwl3feBWKB3/QqdA80mF4M84TVJD95Jr4Ho
	 JwBGbZYr45qEjKqX5O10gt6BNJb4pjyi1UC0L6jL2RUCl6lcQD6ah6baNObDyjfyYm
	 Bs3NP/rKGKHxbi8YFeLHmJbr2qzRxQXCr4KBqTkwQGASDl4+oTir3jqGYCo3QJhZVV
	 ps/Ax5qaxmbHg==
Date: Tue, 29 Sep 2026 21:02:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/26] perf trace: Include the augmented arg header in
 nanosleep's payload length
Message-ID: <aryJ5BrbOnVU9y49@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-3-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:41AM -0700, Ian Rogers wrote:
> Unlike the other augmenters, sys_enter_nanosleep() leaves the struct
> augmented_arg size and err fields out of the record length, so the
> output stops 8 bytes short of the end of the timespec payload. Count
> the header.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

It's a bit confusing to use sizeof(u64) for the two fields, but that's
what others do.. :(

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index f7c9eb49648f..cc70861a23d6 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -419,7 +419,8 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *req_arg = (const void *)args->args[0];
> -	unsigned int len = sizeof(augmented_args->args);
> +	/* the size + err in all 'augmented_arg' structs */
> +	unsigned int len = sizeof(u64) + sizeof(augmented_args->args);
>  	__u32 size = sizeof(struct timespec64);
>  	int err;
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
