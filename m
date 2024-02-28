Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E556B83
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118290; cv=none; b=i49chzs8d9W6Xd4FxpOtF08sxQuINWRBwzj3jcg8hCD1yKzijyW60RTFIvZ5jqsTD3LMA+5n49MjeH9j6ytLFKdE+dcbklqyCJxhgmJRdsYMiX3kK3pB4W6ZznaRqjYismNryrX9u52SaNOO3/gGIv9blHOgz/cWHNJVawx0WgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118290; c=relaxed/simple;
	bh=rpA1jfa1p4CHLfcM9fGJReub9wwbtycTXFcl/XWRDfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qVGaQrv9m9OL4Ex0kBH6AVtRzwE+GfWT+XSAnZ1bLxNKpQi/jfQNy5piVoHrBgOBzUVWZDONWWfNfvFHJFDYQtz5mq0JLuPFZ1ZJdkfZKJeDVC2a2QqIVybUvlMsrmFXwuhwbj6b2xdfndrcI1atbaxglX+Z3lPePynM4nz3vCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4D/0tP6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4D/0tP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709118288; x=1740654288;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=rpA1jfa1p4CHLfcM9fGJReub9wwbtycTXFcl/XWRDfg=;
  b=V4D/0tP6FMEDlEvMVomnFGg3YbJsXpzNGkXfoUZY1OGHTUTAWBsfkl4d
   20H0AANCat5nTR1lfSv/krRdkN0rN4LLo+kRiSQrpwUPD35/cDF2VoGrk
   Ayffl/TYu64qWUiENXgZqkE0yiZSDv/gPJzN/oFVoJwk1LjeGYgVv+Lm8
   6rS1F0KFNVQsEAguWXbVFXSh7T8hs9K/59oFhH2MKX1wjglfr82cib3HY
   DFyLyoQz/Fw7IM1QydcTEMLfxH/2hN8ZQ4ipJ1/N5TibCQGHLsDvhyjKG
   4x7EaN58fmp99FDaQTt6D2RBhGupSzBBbzsCxB8cnIceF5MZkPvAIZACt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3673247"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3673247"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7257958"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:04:45 -0800
Message-ID: <ceb7d039-5088-45e7-b7ea-8f2056f5f7dc@intel.com>
Date: Wed, 28 Feb 2024 13:04:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf, script: Minimize "not reaching sample" for
 brstackinsn
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <20240227183910.55824-1-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240227183910.55824-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/24 20:39, Andi Kleen wrote:
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

How do you know it is not a taken branch that missed the LBR update?

> - The LBR sampling uses a filter ignoring some branches,
> but the perf script check checks for all branches.

Not understanding this case.  Do you mean you expect not to reach
the sample, so there is no point printing the message?

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
> ---
>  tools/perf/builtin-script.c                              | 4 +++-
>  tools/perf/util/dump-insn.c                              | 2 +-
>  tools/perf/util/dump-insn.h                              | 2 +-
>  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 5 +++--
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 37088cc0ff1b..df2555fdb18f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1378,7 +1378,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		printed += fprintf(fp, "\n");
>  		if (ilen == 0)
>  			break;
> -		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
> +		if ((attr->branch_sample_type == 0 || attr->branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> +				&& arch_is_uncond_branch(buffer + off, len - off, x.is64bit)
> +				&& start + off != sample->ip) {

Needs a comment, or update the comment further back.

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

