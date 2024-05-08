Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9457131BCA
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200377; cv=none; b=kGRU6BXOannbaV0R7LuY1KcyiwNuvX99xeEoYd5sq3wqdaqvPespl5FapT0LyDIfMB2pk6jXk7oGxr+m/N0Phai7QLwGzEyzfpXTxVSbFI18iYot8PYsgJw6Plj4NtcCYac5VNu0MgMfos+FRvsxMVxUKiWx2S+IjPMTtLCP7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200377; c=relaxed/simple;
	bh=oUNlDw7Qs4WGmcJZzL3HrodB/Jl9F1Rom2ISNrpYY5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgH1I06C99poqUKjLmGGsUSfR9DnL2CyyYef6NR1p1Y4LelL0OLJcoyP+xrWmfKCKR3XIpr7TtZaFRjBEtV6l1FprH+tIswG3S5QyDqTfZLP34y4nDJ5B49ELGIrc242cwrhNCHoU9/b7tl1tgot7qN4yL8qUXqVWkMSyFEADAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSfjrQOS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSfjrQOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715200376; x=1746736376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUNlDw7Qs4WGmcJZzL3HrodB/Jl9F1Rom2ISNrpYY5E=;
  b=DSfjrQOSP9c3tymAtCMdeX8h28MFIgij+FcJ7X9ZCRhcYnY1tMx+Z7DC
   aIYDSM/fIKMTeyt9YqkvhJmScPiMMNucWbku0mM4fxKlxPTkvSHax+3na
   AcLmnE57WAWy0kZPHWlNjruYbEdCU/ICeLICGSIcxcNi4i2W0vwFCvoXw
   wMZPv88DUhVsBDk3ddCz5+Byuantmojys3CdcfW1o+KRuS+dIBRu2iuCk
   yEcmQgxa2QI/+L0wEjAYYkUMHp+m+oC4owlJAEL02BYF/1yMQoibSWlq5
   0D8NzjZvfvwybjbQNMVb8ao6kM8fRCFzRnTh9RGEtZthKNt2nY+8WEr3T
   Q==;
X-CSE-ConnectionGUID: T0OfVGLxTHqy9tufGUoPrA==
X-CSE-MsgGUID: ucJxbrjmRaCK/mOeW+f3fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11212005"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11212005"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:32:55 -0700
X-CSE-ConnectionGUID: nJqVueqDS52CDvZO1etc8A==
X-CSE-MsgGUID: mNV8blTFRpux8KN0+UrCjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="66440188"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:32:55 -0700
Date: Wed, 8 May 2024 13:32:01 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com
Subject: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching sample"
 for brstackinsn
Message-ID: <ZjvhQbZhsda_kvy6@tassilo>
References: <20240229161828.386397-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229161828.386397-1-ak@linux.intel.com>

Looks like this bug fix was never applied. Ping!

On Thu, Feb 29, 2024 at 08:18:28AM -0800, Andi Kleen wrote:
> In some situations perf script -F +brstackinsn sees a lot of
> "not reaching sample" messages. This happens when the last LBR block
> before the sample contains a branch that is not in the LBR,
> and the instruction dumping stops.
> 
> $ perf record -b  emacs -Q --batch '()'
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.396 MB perf.data (443 samples) ]
> $ perf script -F +brstackinsn
> ...
>         00007f0ab2d171a4        insn: 41 0f 94 c0
>         00007f0ab2d171a8        insn: 83 fa 01
>         00007f0ab2d171ab        insn: 74 d3                     # PRED 6 cycles [313] 1.00 IPC
>         00007f0ab2d17180        insn: 45 84 c0
>         00007f0ab2d17183        insn: 74 28
>         ... not reaching sample ...
> 
> $ perf script -F +brstackinsn | grep -c reach
> 136
> 
> This is a problem for further analysis that wants to see the full
> code upto the sample.
> 
> There are two common cases where the message is bogus:
> - The LBR only logs taken branches, but the branch might be a
> conditional branch that is not taken (that is the most common
> case actually)
> - The LBR sampling uses a filter ignoring some branches,
> but the perf script check checks for all branches.
> 
> This patch fixes these two conditions, by only checking
> for conditional branches, as well as checking the perf_event_attr's
> branch filter attributes.
> 
> For the test case above it fixes all the messages:
> 
> $ ./perf script -F +brstackinsn | grep -c reach
> 0
> 
> Note that there are still conditions when the message is hit --
> sometimes there can be a unconditional branch that misses the LBR
> update before the sample -- but they are much more rare now.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> --
> 
> v2: Adjust comment (Adrian Hunter)
> ---
>  tools/perf/builtin-script.c                              | 6 ++++--
>  tools/perf/util/dump-insn.c                              | 2 +-
>  tools/perf/util/dump-insn.h                              | 2 +-
>  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 5 +++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 37088cc0ff1b..b97f810ad00e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1343,7 +1343,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  	 * Due to pipeline delays the LBRs might be missing a branch
>  	 * or two, which can result in very large or negative blocks
>  	 * between final branch and sample. When this happens just
> -	 * continue walking after the last TO until we hit a branch.
> +	 * continue walking after the last TO.
>  	 */
>  	start = entries[0].to;
>  	end = sample->ip;
> @@ -1378,7 +1378,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		printed += fprintf(fp, "\n");
>  		if (ilen == 0)
>  			break;
> -		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
> +		if ((attr->branch_sample_type == 0 || attr->branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> +				&& arch_is_uncond_branch(buffer + off, len - off, x.is64bit)
> +				&& start + off != sample->ip) {
>  			/*
>  			 * Hit a missing branch. Just stop.
>  			 */
> diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
> index 2bd8585db93c..c1cc0ade48d0 100644
> --- a/tools/perf/util/dump-insn.c
> +++ b/tools/perf/util/dump-insn.c
> @@ -15,7 +15,7 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
>  }
>  
>  __weak
> -int arch_is_branch(const unsigned char *buf __maybe_unused,
> +int arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
>  		   size_t len __maybe_unused,
>  		   int x86_64 __maybe_unused)
>  {
> diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
> index 650125061530..a5de239679d7 100644
> --- a/tools/perf/util/dump-insn.h
> +++ b/tools/perf/util/dump-insn.h
> @@ -20,6 +20,6 @@ struct perf_insn {
>  
>  const char *dump_insn(struct perf_insn *x, u64 ip,
>  		      u8 *inbuf, int inlen, int *lenp);
> -int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
> +int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64);
>  
>  #endif
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> index c5d57027ec23..292027a984a9 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> @@ -200,12 +200,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
>  	return 0;
>  }
>  
> -int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
> +int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64)
>  {
>  	struct intel_pt_insn in;
>  	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
>  		return -1;
> -	return in.branch != INTEL_PT_BR_NO_BRANCH;
> +	return in.branch == INTEL_PT_BR_UNCONDITIONAL ||
> +	       in.branch == INTEL_PT_BR_INDIRECT;
>  }
>  
>  const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
> -- 
> 2.43.0
> 
