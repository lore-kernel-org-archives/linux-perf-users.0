Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAACC1531E1;
	Tue, 18 Mar 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324663; cv=none; b=kavPx6uzWfs1VZtsdlSfJ9/ykSThLnOP9JumzpNgIUj0Yi0HclCk/hieAd/ejMosrfQ7QIYsivhCTzAOpjZlbPTXsdh0Suf0SCamRRzmllXU4cDWkhNPdGBtwiUj/TDZ8GPLuypVh7s/4mBy7CqfpWPhtUFknkMJdhItlZ72P+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324663; c=relaxed/simple;
	bh=q8oOp41cHl33YfGvOaDk6/xbHYWsX2yx6+8wUa0yDHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuaQHkQ0j9iushXNRNmrgNhrfp87LXdOZixhcvb8svELO4kUP2jxLM+FUZ9L3fLPv01hHDLmQxKkSF+qpvFLFCfspsqNJP1jHGW79hjywVCz1lhOiwL2qYkBYyaOJSnMMywlIBmIq19ESrTcbhscAoWpYXfTPoFP3qbr3lby+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEJkeNyn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEJkeNyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9514CC4CEDD;
	Tue, 18 Mar 2025 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742324663;
	bh=q8oOp41cHl33YfGvOaDk6/xbHYWsX2yx6+8wUa0yDHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEJkeNyn8a4ZrsAPb8DRhFNwI2U050JwzDRxBsfpmEsMpvv9kTob/NUbhpWIIugn5
	 4cpDRdE+pN1pJ0QvBuA3rlcH/Qzak7OZmUVOQ5BJcb1p1n5t8NKwnY8YseJ93ATUyY
	 YyUqD3Np3LvcrBf+IlDFQB90KXtymd4mnuXx1vS56gFlTS+M2KoOS09izWC03RpDVq
	 x6MNaW+CiHXW5tYTHhFn+hC0XYyo//h7PKFixoeb0hJOK2BGF0WNebgpWo5u1gN2VQ
	 LABMVs/ujFoE9y9A57vJnVsPaa+W/SSmd4GIumkSbtXvoLjYoZOZvE736hJPm49vd7
	 vs3CB19du7HEw==
Date: Tue, 18 Mar 2025 16:04:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 13/13] perf trace: Fix BTF memory leak
Message-ID: <Z9nDtMyoARGiHAGg@x1>
References: <20250318033150.119174-1-irogers@google.com>
 <20250318033150.119174-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318033150.119174-14-irogers@google.com>

On Mon, Mar 17, 2025 at 08:31:50PM -0700, Ian Rogers wrote:
> Add missing btf__free in trace__exit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a5f31472980b..d4bbb6a1e817 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -5339,6 +5339,12 @@ static void trace__exit(struct trace *trace)
>  		zfree(&trace->syscalls.table);
>  	}
>  	zfree(&trace->perfconfig_events);
> +#ifdef HAVE_LIBBPF_SUPPORT
> +	if (trace->btf != NULL) {

No need for the check, btf__free() does:

void btf__free(struct btf *btf)
{
        if (IS_ERR_OR_NULL(btf))
                return;

Up to Namhyung to turn this into the simpler:

	btf__free(trace->btf);
	trace->btf = NULL;

> +		btf__free(trace->btf);
> +		trace->btf = NULL;
> +	}
> +#endif
>  }
>  
>  #ifdef HAVE_BPF_SKEL
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
