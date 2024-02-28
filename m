Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D873503
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120550; cv=none; b=FqZwtF3oQcvLWhNYdErZlF3iFqDxCArF91nhak4WmG9qB90elRh/5mpUk0Hwg/eka0c/mdDoA9+EAyfVkznWrrWURIR1HO7uhqwbRBUGrpwM5AW8kKPkh4aBZlSXuGQYKs2aSM11dAysMa42osc6km7rpPQdMxX0hKDuJ6jEaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120550; c=relaxed/simple;
	bh=N3+bF5gDEClIg24u6KSh1V4VCHe6lRAGPBPNX2Epg8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtK7ns74WfSGpH4n+kaDgx8UCE8RFBCnDYBcR4/p6FcTZs9XO3Rfyk6lstlNzmg12SJ176HwuYumcI6PhwW57pfnROeUKwsxC/moMrc0hHo+bLEEEZ9h4lZ8qTl+X7Xq42sA5zzCfV+DLsizB0fW+q75iw9TyDNwYXBkvMCjoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNQOPW4C; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNQOPW4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709120549; x=1740656549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3+bF5gDEClIg24u6KSh1V4VCHe6lRAGPBPNX2Epg8o=;
  b=BNQOPW4CcH+RmAonHr+6abTZ7+bdZ8DRvkhH5lTP54LagnizV7FQgVE1
   5ord1OH4FEjcXgZSpbvSXU86DkZskTcAqPwbmsGRc9BjMITjRCWq5WWvG
   6/vV6c+xlIoolibCMbgn/83Th9tyPqDMiRyzF+IVyO4sbfbvA78DzQLDG
   9ZYIIpmD2mxp/0XYnkwLQIRPVrTrmE9cBHgR1p7Hik6czoDRHzZnNo1Ns
   i/UIH1Q2/XwX24kXeKWo0rGhwXdD90xZEQzlm3ZhhCm7646j54WW44ap9
   8Rwj1kaBSppEbkF+3EZqrUEPZb5hG2NychIIX1ZR0okCmv+ElST7EGzu8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14932338"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14932338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7515843"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:42:27 -0800
Message-ID: <7ca41f7f-28b2-4f3c-8c04-1dba110d3135@intel.com>
Date: Wed, 28 Feb 2024 13:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com
References: <20240227234806.82694-1-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240227234806.82694-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/24 01:48, Andi Kleen wrote:
> Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
> configure capstone to the correct mode. This allows to correctly
> disassemble 32bit code under a 64bit OS.
> 
> % cat > loop.c
> volatile int var;
> int main(void)
> {
> 	int i;
> 	for (i = 0; i < 100000; i++)
> 		var++;
> }
> % gcc -m32 -o loop loop.c
> % perf record -e cycles:u ./loop
> % perf script -F +disasm
>             loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/print_insn.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 459e0e93d7b1..bd7a95e64ce5 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -12,6 +12,8 @@
>  #include "machine.h"
>  #include "thread.h"
>  #include "print_insn.h"
> +#include "map.h"
> +#include "dso.h"
>  
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>  {
> @@ -28,12 +30,12 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  #include <capstone/capstone.h>
>  
> -static int capstone_init(struct machine *machine, csh *cs_handle)
> +static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
>  {
>  	cs_arch arch;
>  	cs_mode mode;
>  
> -	if (machine__is(machine, "x86_64")) {
> +	if (machine__is(machine, "x86_64") && is64) {
>  		arch = CS_ARCH_X86;
>  		mode = CS_MODE_64;
>  	} else if (machine__normalized_is(machine, "x86")) {
> @@ -101,9 +103,21 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
>  	size_t count;
>  	size_t printed = 0;
>  	int ret;
> +	struct addr_location al;
> +	bool is64bit = machine__is(machine, "x86_64");
> +	struct dso *dso;
> +
> +	addr_location__init(&al);
> +	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
> +		(dso = map__dso(al.map)) != NULL &&
> +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> +		map__load(al.map);
> +		is64bit = dso->is_64_bit;
> +	}
> +	addr_location__exit(&al);

Maybe 'al' could be passed down through perf_sample__fprintf_insn()

>  
>  	/* TODO: Try to initiate capstone only once but need a proper place. */
> -	ret = capstone_init(machine, &cs_handle);
> +	ret = capstone_init(machine, &cs_handle, is64bit);
>  	if (ret < 0) {
>  		/* fallback */
>  		return sample__fprintf_insn_raw(sample, fp);

