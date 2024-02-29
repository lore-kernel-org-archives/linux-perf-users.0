Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9138DF1
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194787; cv=none; b=kccvJR7HwrIYvzbKnmdMLcSOOUoHmlUzLfONmseJ60a5hVnqYD3ehD5SmMlq+EKOZKk2zY6QXXj1FOs2RaWGqY+qoalYsYPLwrb/H7FLNEaEPc0RfxIIgIhmWiiEg2q78BT73p6MmjmlKEFuIXA2/B19c2X/To/8RW6Lb3AjPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194787; c=relaxed/simple;
	bh=UXPdo0L5jh40rbtnEFwFGYbqFj/MrllmogwAPQC1dFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj/kXzZ8zUp3eG960xvJU7dC5qZcHGGZx0CamRIRyuj7nNzxNib1YUjUZx3k6SVSuOX70Nyo4KRft/dxoiuRTIWrM8hkJl6ujO0wHlqVOub2nXzvnWwo9uYtEhIWoSsP6xa1i8H/gW6+JhzRXumRRtylnfifDHTAln9/pTx5bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7Kfzzgb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7Kfzzgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709194786; x=1740730786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UXPdo0L5jh40rbtnEFwFGYbqFj/MrllmogwAPQC1dFc=;
  b=W7Kfzzgb+Iaolf5mfnYZyDclJANyqE6cVSv8oEPiLu0XryTKbE30giLL
   J4UC+IfwDnzv4Skgx14mRWn3x2QR8udbgAX5ozJLj/FFlEnf356QrpQ7f
   qR7bUoQwvZ+WleZ+NAohtl4xoNN/zgetHZ2OzhdAiqzVR5ONRPX69cZhl
   6OfqIWmX53hzKAgLb5N+bgUQd8Xcp91Gd5x/UT//GHA0OlBth7tsnwjNa
   Dacpk1gmHzQksOt7ApkkVc5xI7uPnIDKNx8/Io4rbd+Ejo362bPhUES2N
   2hC/31xhRL+FWpB+Igjh6Dszb/3tBp0WVRPxEkXpCGb+pzDCo9NO1FDaQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14355318"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14355318"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8101434"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.103])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:19:44 -0800
Message-ID: <2e054691-05a0-4d3d-bcc8-704e8b112305@intel.com>
Date: Thu, 29 Feb 2024 10:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf, capstone: Support 32bit code under 64bit OS
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com
References: <20240229013826.329549-1-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240229013826.329549-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/24 03:38, Andi Kleen wrote:
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
> 
> ---
> 
> v2: Factor out DSO lookup into separate function
> ---
>  tools/perf/util/print_insn.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 459e0e93d7b1..eca20dded45f 100644
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
> @@ -93,6 +95,24 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  	return printed;
>  }
>  
> +static bool is64bitip(struct perf_sample *sample, struct thread *thread,
> +		      struct machine *machine,uint64_t ip)
> +{
> +	bool is64bit = machine__is(machine, "x86_64");
> +	struct dso *dso;
> +	struct addr_location al;
> +
> +	addr_location__init(&al);
> +	if (thread__find_map(thread, sample->cpumode, ip, &al) &&
> +		(dso = map__dso(al.map)) != NULL &&
> +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> +		map__load(al.map);
> +		is64bit = dso->is_64_bit;
> +	}
> +	addr_location__exit(&al);
> +	return is64bit;
> +}
> +
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>  				struct machine *machine, FILE *fp)
>  {
> @@ -101,9 +121,10 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
>  	size_t count;
>  	size_t printed = 0;
>  	int ret;
> +	bool is64bit = is64bitip(sample, thread, machine, sample->ip);

Still seems better to pass down al 

>  
>  	/* TODO: Try to initiate capstone only once but need a proper place. */
> -	ret = capstone_init(machine, &cs_handle);
> +	ret = capstone_init(machine, &cs_handle, is64bit);
>  	if (ret < 0) {
>  		/* fallback */
>  		return sample__fprintf_insn_raw(sample, fp);

