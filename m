Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115557C8A;
	Thu, 13 Jun 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266540; cv=none; b=ptYLTWhr72GqpZTDrO9l25DKbeanPcKtBPqVSXD+c+kN/Gf6hGeG+XPk79AIW4Gnn66f4E/p5izKr6Exb4NeXXrLlV/lEd4os4KUm6jsIoi394/S713NYHjtZOBJxFT7+0zyR7DB30NEk1JJO2JyEWqc3uCo1A069VlxpMrtlMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266540; c=relaxed/simple;
	bh=UMjVs06sJwT6Ygcoh+wejcNTxXAeh2E2nNUlc3p70fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivFwOvEVeFZZjzX8P7IFjhajBk9Me6qagbGswUIjgHXQv4io19JigVyRmVzQbQTJhZ84dtSWsY41CVNbmdWEf+tKbqRoPca4IyhPREN3mhU0fxILTGdJstI5OUfHCTvB1X2HrBRuokhUxczhoFt+kuGAq/mY/zs/wlL3x/E+xlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQbszUB3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQbszUB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718266538; x=1749802538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMjVs06sJwT6Ygcoh+wejcNTxXAeh2E2nNUlc3p70fA=;
  b=kQbszUB3rCi6WBIUQP0FjGhvX8665wPALlPVEdXGFT/16gdFXIPCC5wW
   PoYPl3Ch4K9RNXg01MnlK7JdR7sQ0Y+c7l+2ZHubGK87hw/feaSqjEYvH
   tre8q38b6jQpyWsyOrML0oKY46VhBa1Ac20qe5XAeeVlpDhKMts5XUIVt
   7HOprIXmtPjmXLQtkNeCYVgGY3DbyXJXjwSQ3HWUw11/UvOfUdcW7Jfe8
   lZqMBXRG2hf7b+k69Eldp99Vw+XZtCRdfsZ3squHVEtaGofINOiV2VhW5
   vzrP/+ZWcsZNrMPC9av4FignfU7u5jPoztgWHykHLKnXmGed3D2mb2cxs
   w==;
X-CSE-ConnectionGUID: llk/+rGkQ9qzVvdNBXCC+g==
X-CSE-MsgGUID: wnT0j980Q+mPjB111Pk3wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32611569"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32611569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:15:37 -0700
X-CSE-ConnectionGUID: 1AfnX+tyQFiO0NT59KF07g==
X-CSE-MsgGUID: MV6X4M17TJyK3VRtJ1pu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44974488"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:15:32 -0700
Message-ID: <395cfff7-9692-4123-96b6-353752007f46@intel.com>
Date: Thu, 13 Jun 2024 11:15:28 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: disasm: prefer symsrc_filename for filename
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-3-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240613063510.348692-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 09:35, Changbin Du wrote:
> If we already found a debugging version when loading symbols for that dso,
> then use the same file for disasm instead of looking up in buildid-cache.

In the past, there have been cases where the debugging version has not
worked for reading object code.  I don't remember the details, but the
symbols and debugging information was OK while the object code was not.

In general, using anything other than the file that was actually executed
for reading object code seems like a bad idea.

> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/disasm.c |  5 +++++
>  tools/perf/util/symbol.c | 12 ++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 72aec8f61b94..75cfc6fbd11d 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1103,6 +1103,11 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	    !dso__is_kcore(dso))
>  		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
>  
> +	if (dso__symsrc_filename(dso)) {
> +		strlcpy(filename, dso__symsrc_filename(dso), filename_size);
> +		return 0;
> +	}
> +
>  	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>  	if (build_id_filename) {
>  		__symbol__join_symfs(filename, filename_size, build_id_filename);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8d040039a7ce..a90c647d37e1 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2025,12 +2025,14 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
>  		dso__set_binary_type(dso, DSO_BINARY_TYPE__VMLINUX);
>  
>  	err = dso__load_sym(dso, map, &ss, &ss, 0);
> -	symsrc__destroy(&ss);
> -
>  	if (err > 0) {
>  		dso__set_loaded(dso);
>  		pr_debug("Using %s for symbols\n", symfs_vmlinux);
> +
> +		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
> +			dso__set_symsrc_filename(dso, strdup(symfs_vmlinux));
>  	}
> +	symsrc__destroy(&ss);
>  
>  	return err;
>  }
> @@ -2395,12 +2397,14 @@ static int dso__load_vdso(struct dso *dso, struct map *map,
>  	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
>  
>  	err = dso__load_sym(dso, map, &ss, &ss, 0);
> -	symsrc__destroy(&ss);
> -
>  	if (err > 0) {
>  		dso__set_loaded(dso);
>  		pr_debug("Using %s for %s symbols\n", symfs_vdso, dso__short_name(dso));
> +
> +		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
> +			dso__set_symsrc_filename(dso, strdup(symfs_vdso));
>  	}
> +	symsrc__destroy(&ss);
>  
>  	return err;
>  }

