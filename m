Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBB55766
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893947; cv=none; b=VKDk1dPvrBOPRngJKBwARZfDBhJgMdc2V3l7sooigzAymvoDKOvH84o00pgQG0maqsRNXLpOJYbeeFLJjvJgQIQnDfuvFCgQ9WS9mZL77bekN6oI7kacDpBAjji6BJCKuT2CcqCPlx7lO3zLdSUgdowXLzjCTbfaCtSvlngWlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893947; c=relaxed/simple;
	bh=Ig9b32InA7BMDoWvlGxiLRjbV4GCmXymSpxRv0i/KiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jo7GaIaP5jDoAh1lw1xaNkFSYfkEad7id/bRqM3u2/iFgC3sh02tlOclqzeiWevIINwEUTVe1Ci29QY0giu6zEArLjIAve1VdmO6ymW8Vg7bHd9cZecaRXh7h20OsFmqUMgYoO7UIhDri5DHWbz0whv3io3cUguPfv/fZ6b8iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlIXtfY/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlIXtfY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709893945; x=1741429945;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Ig9b32InA7BMDoWvlGxiLRjbV4GCmXymSpxRv0i/KiE=;
  b=BlIXtfY/mZWRqckZe1eIBELvlAl2TMSXpeRmkl+cl1aSHEIuOkAJwN7h
   xd7u0ubppW8x9i8L0oUiwCCTn//R9lyxCYFTASr6PlJlqzjTYHRiOPelx
   HExsKsloH6D5soin3O9LMiMWC/BOT+58fJwzc3ZLvA7KlJakWX6+/4rLn
   9q09x0UGsE1jJxSbDpHy+YEtPA4wKvVabAJwzrdbByJyZTyhrZ9FECG6V
   2+mp0QTniWBPohwY3gM8fTBCMt9hDFMnTjbqCvpLJoSZ03UHztxQgtjVh
   W5oMG1ca8hP7JNanzhVzPc9FPkW4tc5C3lLDKkF5stO6ZLccL4Majdhw9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15255874"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15255874"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10522563"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.63])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:32:22 -0800
Message-ID: <063ab5b9-a030-4601-a2b4-805d11b60543@intel.com>
Date: Fri, 8 Mar 2024 12:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf, script: Minimize "not reaching sample" for
 brstackinsn
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <20240229161828.386397-1-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240229161828.386397-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/24 18:18, Andi Kleen wrote:
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

I still think this condition could use some more explanation,
say:
		/*
		 * Warn if it should be possible to walk to the sample but an
		 * unconditional branch is encountered. Conditional branches are
		 * assumed to be non-taken, since non-taken branches would not
		 * be in the branch stack.
		 */

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

