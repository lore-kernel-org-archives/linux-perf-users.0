Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666C191;
	Mon, 12 Aug 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484011; cv=none; b=plxwjFJjckEn0XWN8ZM5gQwja1t6zlEy1fhVbeR6O1NTVaVrVtNkGiB7ywnYaFJfmFKwedsmK/LjPEtTVAkBUCrcjlEl9R8UO8ypgyjEcMqm/KEYKJRDHFSzjYvj2KvDc320AwHMo5G4MRW7+8J/b6TrQwoGc9IL8xdBzux5lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484011; c=relaxed/simple;
	bh=+hevNowKUmPgWOv+xcjbhVWNsC7IU/ZZjoQNOBBsqis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2dYgbhgtkJDaEYDTIpMtOgEOJ4fIO3SX6iszuYxZLFHSfSu0guq0/+g/thNtNFGtZJBof7XnjP3xLSYzN+kpK9jAN5qLzJfK0owRYVNR4uJTiiEuQvKFPprZX1/RC4Mday3YgmU16QSEpd8i6Nvz/TBAhk8NJeCppoDSdH9LG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL5kmQKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL5kmQKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF71C32782;
	Mon, 12 Aug 2024 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723484011;
	bh=+hevNowKUmPgWOv+xcjbhVWNsC7IU/ZZjoQNOBBsqis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aL5kmQKP4nAB4Za0B1shM3JqHHRqygf39jTY+L+T21mY69/Sub8ohLMNvX8m4wSiH
	 822qNc+jhdCyrOveWwVsJdMXaeci8dPemM1XarkF2eeRGTNCRFFiJ3DNw/QQvgL4N2
	 nczsdsJK+Vn/p1whTrHK9PRlUlpxqIfiom27cTl+E6MWXrRWiUPN+F7w+/qxsB4umO
	 HljApv6FSb2TYfieMnxPCVAgnjt8p1/T6UvC0tRYV4YCggINmJr1IsjliVUWiZNjlu
	 yU9+SACFu4/oHZXl+H82RTK7fWcLX/0HYj2wzgM/2CoKA5zK2vw/xTiKfZoYIx95Ih
	 JQMo2wd6F8Wcw==
Date: Mon, 12 Aug 2024 14:33:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] perf lock contention: Change stack_id type to s32
Message-ID: <ZrpHZ01AE3kwsh2x@x1>
References: <20240812172533.2015291-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812172533.2015291-1-namhyung@kernel.org>

On Mon, Aug 12, 2024 at 10:25:33AM -0700, Namhyung Kim wrote:
> The bpf_get_stackid() helper returns a signed type to check whether it
> failed to get a stacktrace or not.  But it saved the result in u32 and
> checked if the value is negative.
> 
>       376         if (needs_callstack) {
>       377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>       378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
>   --> 379                 if (pelem->stack_id < 0)
> 
>   ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
>   warn: unsigned 'pelem->stack_id' is never less than zero.
> 
> Let's change the type to s32 instead.
> 
> Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for BPF")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2) fix build error for s32

Thanks, applied to perf-tools-next,

- Arnaldo
 
>  tools/perf/util/bpf_skel/lock_data.h       | 4 ++--
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index 36af11faad03..de12892f992f 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -7,11 +7,11 @@ struct tstamp_data {
>  	u64 timestamp;
>  	u64 lock;
>  	u32 flags;
> -	u32 stack_id;
> +	s32 stack_id;
>  };
>  
>  struct contention_key {
> -	u32 stack_id;
> +	s32 stack_id;
>  	u32 pid;
>  	u64 lock_addr_or_cgroup;
>  };
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> index e9028235d771..d818e30c5457 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -15,6 +15,7 @@
>  
>  typedef __u8 u8;
>  typedef __u32 u32;
> +typedef __s32 s32;
>  typedef __u64 u64;
>  typedef __s64 s64;
>  
> -- 
> 2.46.0.76.ge559c4bf1a-goog
