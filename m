Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946F320F;
	Sun, 30 Mar 2025 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743312725; cv=none; b=ou/DBOYGLMUHyYmdzHtilI5NRkMkBI3T7r0h+mR2pzKcmpuvqffnIn2FzlohqYMhD1KhMthg/BRDcZuIAnsq5iK/3LrxZezpC3hoD5QNJO+cqFvUF3gVJqKTBT8e551w5238CbOHP224dlOPQMYmGdkqQRHobN4IJRSOi0/ZNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743312725; c=relaxed/simple;
	bh=eqIiHIr1z4MtUcpkYUleYHCPLYsIMyxCYzUccsauYxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIUcBv4CJYW1jBJC4EXfNiOZdRnmV/BB6PvRPjqimyCUiEU36ZX5OKdl22ZePjACqN9VO45BwZZ1oqWGnkt7LexVe/WV8HLs1hK0XBib1IbpZj4HrVrp6k7eL/BAy70B6ImJoVzjsC8R4xNRXNfRdrWiCsIXbRShxHDx7U+ZIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjed1tfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjed1tfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46953C4CEDD;
	Sun, 30 Mar 2025 05:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743312724;
	bh=eqIiHIr1z4MtUcpkYUleYHCPLYsIMyxCYzUccsauYxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vjed1tfjXqSL7BC/HhKBgMPmGgby0uPcmQQBoDRw6+OqAylfo3ut/sJ5PGRtuVZHm
	 bS4fmPEqTmrSdPELDkQ+Emnf9ZYDP14urntZkdT9n3hAJFvXP2rtqrYwSjSSOo318I
	 ZDrOU0JU36EvYXAmALaLyiQN2zdf72VGzIGvFoHYpC4PZL6Srwsk9Aj4brLqLy+i2q
	 KgILK8oCZaFK3z/uSsZ+gXhtFxwOxC44OiXfyaLzUxbmDtdhlJeE5jsXdc7MPn9Ub7
	 w8jqYo27UeW+CHvAbQspF2SDtTtc47QqBLKCDbawjRPWyO3sFaKTpu8v99UVi2e8lX
	 i//z1sJlJcYWg==
Date: Sat, 29 Mar 2025 22:32:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Change __augmented_syscalls__'s value to int
Message-ID: <Z-jXUkUE-Wk1eWCk@z2>
References: <20250326195801.1837855-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326195801.1837855-1-howardchu95@gmail.com>

On Wed, Mar 26, 2025 at 12:58:01PM -0700, Howard Chu wrote:
> This is to match the type of file descriptors, as suggested by Ian
> Rogers in this discussion:
> https://lore.kernel.org/linux-perf-users/CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com/
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index e4352881e3fa..18a3086489ea 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -31,7 +31,7 @@
>  struct __augmented_syscalls__ {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>  	__type(key, int);
> -	__type(value, __u32);
> +	__type(value, int);
>  	__uint(max_entries, MAX_CPUS);
>  } __augmented_syscalls__ SEC(".maps");
>  
> -- 
> 2.45.2
> 
