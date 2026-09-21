Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F73D76;
	Mon, 21 Sep 2026 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949000; cv=none; b=goR2ub1mQpMYJS4q4NJfwEvEpXxIEZK9NO7Jyl25VHKWzsineGmZJzCG1xQmDBTbQ3v0GJoeWPvKXU7PKDSfoWw32ql476uUoFeaChcCT+AzzY2sDuzTD7ed5T5r5m/qZbjP6PPMbm21BXLfa8xi8sXBgpifpeQOZs9Mq04vke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949000; c=relaxed/simple;
	bh=6a9TAUJLX9j5QQcuWKin1yKPjW7rL3kfM595xz3xJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQYV3myhv3Q13w7iZKDCFTh2Slx8O1B2/cwWvuWUVlUjEGOICrytWdUw3bHyIs4GHAKAL5SuJYzvCATJZL3APSJ7W9aCiqGIPVjcxN2/ftQjgcSVg3ZP2i2v+gYUF3lqtdRDKlr7CNIpbBgBQgdKMYcjJwN6OPMzQfLp3GCtF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci5NmWvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci5NmWvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022191F000FF;
	Mon, 21 Sep 2026 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948998;
	bh=S/3h4uG1WsJcJUJEmT1KLuivMFU3+V8UfbgpCp24+A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ci5NmWvn52JjWvQtKdSgQSq3QuMrxMlKXb9JliSm+ozvZe9Jcuvl7ezSRwxnoyKPN
	 p49gUVhCPbysq8eNk0Nvhl3bSXvCDkaBtWqaJN/jkCgVB6WiE5ctrVySTtfMCV7ZEY
	 dVKNdSViZ9b9QAW/zBki8VvRxOvmSlLU7tFgX56lKPCtc0srdLCEDN/KhNpDa4ztn6
	 QD7TpEUgnKCH2VYzAv26nGKHLNnvO4p+7U9tBGIYv7H4omde86vPNf76Xb+726uGhK
	 7Yc8akImBsfagGGVPreTA+AD2Iu7XxgQku/TvTQg7/n095C1W3wbF2uo3l0DK84dSY
	 q27c6vFB5ho2A==
Date: Sun, 20 Sep 2026 17:03:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
Message-ID: <arB0RCpi9szb5d_R@z2>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-2-495b8f00ad7c@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-perf-symbol-memory-send-v2-2-495b8f00ad7c@uber.com>

On Sat, Sep 19, 2026 at 07:33:57PM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> perf script eagerly materializes every ELF symbol into an rb-tree kept
> until process exit. Large profiles can therefore consume substantial
> anonymous memory, causing perf script to be OOM-killed or forcing the
> kernel to reclaim memory from co-located workloads.
> 
> This patch adds --max-symbol-bytes to bound struct symbol allocations.
> Once the budget is reached, the ELF loader stops loading symbols, warns
> once, and lets unresolved addresses appear as [unknown]. This allows
> users to bound the memory footprint upfront and explicitly choose between
> complete symbolization and avoiding unbounded host memory pressure. perf
> record already provides a similar --max-size option to bound disk usage.
> 
> The counter includes every symbol__new() allocation, but this patch
> enforces the limit only in the ELF loader, which is the source of the
> unbounded memory growth addressed here. In this path, reaching the limit
> can safely produce [unknown] symbols. Other loaders currently treat a
> failed symbol allocation as an error. Capping those paths would therefore
> require separate changes whose complexity may outweigh the potential
> memory savings.
> 
> The cap applies to userspace DSOs, vmlinux-as-ELF, and kernel modules.
> Sizes require a B/K/M/G suffix, except that a bare 0 and the default mean
> unlimited. Reservations are atomic so concurrent loaders cannot exceed the
> limit; accounting retains complete name lengths and partial zero-sized
> symbol ranges do not cover omitted addresses.
> 
> Document the option with the code that introduces it and add focused
> accounting and concurrent-reservation tests.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
[SNIP] 
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 46b1649c64fc..f7331edf0b71 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -90,7 +90,7 @@ struct symbol {
>  	u64		start;
>  	u64		end;
>  	/** Length of the string name. */
> -	u16		namelen;
> +	u32		namelen;

Why is this needed?  Do you have symbols with a really long name?
Anyway, it should be a separate change then.

Thanks,
Namhyung


>  	_Atomic uint16_t flags;
>  	/** Architecture specific. Unused except on PPC where it holds st_other. */
>  	u8		arch_sym;
> @@ -227,6 +227,12 @@ void symbol__elf_init(void);
>  int symbol__annotation_init(void);
>  
>  struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name);
> +struct symbol *symbol__new_bounded(u64 start, u64 len, u8 binding, u8 type,
> +				  const char *name, bool *budget_exceeded);
> +size_t symbol__bytes_used(void);
> +void symbol__account_bytes(size_t bytes);
> +bool symbol__try_account_bytes(size_t bytes);
> +void symbol__unaccount_bytes(size_t bytes);
>  size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
>  				      const struct addr_location *al,
>  				      bool unknown_as_addr,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 71f60081a85b..6a16c5badd5e 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -120,6 +120,7 @@ struct symbol_conf {
>  	int		pad_output_len_dso;
>  	int		group_sort_idx;
>  	int		addr_range;
> +	unsigned long	max_symbol_bytes;
>  	DECLARE_BITMAP(parallelism_filter, MAX_NR_CPUS + 1);
>  };
>  
> 
> -- 
> Git-157)
> 
> 
