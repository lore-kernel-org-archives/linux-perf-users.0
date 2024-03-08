Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5B54BF1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895482; cv=none; b=mFGXc05vm0FtBw83wiQXuTYAFPA45Z4at0H2SwRd3wN+E8SFHhRY2DX6UBJL4Q5yoWSsj4U7wW/saLMRHrKEHyANiLCTQPggClyEIEkJlu08M/hBhDi8V7qtrLrt9klN7x7SZEu3Mk/29+EZQFnBumKjrp8wIwDIU7DT8ueHxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895482; c=relaxed/simple;
	bh=J17sr1hDSj7UgzcV3dczW8z6J2MLPDXd9ppxC9YZQJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt6TNoJE+76agM6FkvpC2Vmtk2yRfXtFkbD3ilDUKB5dM+ywR7Es+ZTxcvEOU6364xtyr0w5yOtIKwjg1DKghz8FN5GOA2+Rt+71s9Zc7nOLox/KN39H0TVRLWOyDr6oa2d0M3NvPJNjMDvfTwKSeHaTocUbsiVT6igOwb6zyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrMzKmZy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrMzKmZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709895481; x=1741431481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J17sr1hDSj7UgzcV3dczW8z6J2MLPDXd9ppxC9YZQJA=;
  b=jrMzKmZyj1WdPMNimH1Wug71GXllmnZ8PyB57o/l7P+vjVYpO+xdwkTH
   vX52pu0J383C17uVAZZjrb527XRl8P2mM4JdnrsPuKIXhlG6Fx3ceZxQH
   GUant4gQcjocrKSOpxxxqTs43yJY/akBLR4CTiHrTbqwiXPsY466mrvcl
   3RofFYWI135eNLbGNgjLXe7fjDC3NM3EU33tyDWVFfmpySK7C5yer6oVd
   cVTVTbKoltX1HguvNFzOkgIbp9Vp5GYRAFnaV0PyKtjom2II0vGY1xdBQ
   jttIx9TpLi88//qwtAUwrFKgSmvA1q+sIYG8UWjb3aKj+HZC73GRCUHvn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4479811"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4479811"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15129344"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:58:00 -0800
Message-ID: <a182e556-a47e-4cf8-9ddb-de0b7946a6ec@intel.com>
Date: Fri, 8 Mar 2024 12:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf, capstone: Support 32bit code under 64bit OS
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com
References: <20240305215517.695988-1-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240305215517.695988-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/03/24 23:55, Andi Kleen wrote:
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
> v3: Pass down al
> ---
>  tools/perf/builtin-script.c  |  9 +++++----
>  tools/perf/util/print_insn.c | 28 ++++++++++++++++++++++++----
>  tools/perf/util/print_insn.h |  2 +-
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 37088cc0ff1b..0299b1ed8744 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1517,7 +1517,8 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
>  static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  				     struct perf_event_attr *attr,
>  				     struct thread *thread,
> -				     struct machine *machine, FILE *fp)
> +				     struct machine *machine, FILE *fp,
> +				     struct addr_location *al)
>  {
>  	int printed = 0;
>  
> @@ -1531,7 +1532,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  	}
>  	if (PRINT_FIELD(DISASM) && sample->insn_len) {
>  		printed += fprintf(fp, "\t\t");
> -		printed += sample__fprintf_insn_asm(sample, thread, machine, fp);
> +		printed += sample__fprintf_insn_asm(sample, thread, machine, fp, al);
>  	}
>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
> @@ -1606,7 +1607,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  	if (print_srcline_last)
>  		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
>  
> -	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
> +	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
>  	printed += fprintf(fp, "\n");
>  	if (PRINT_FIELD(SRCCODE)) {
>  		int ret = map__fprintf_srccode(al->map, al->addr, stdout,
> @@ -2259,7 +2260,7 @@ static void process_event(struct perf_script *script,
>  
>  	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
>  		perf_sample__fprintf_bpf_output(sample, fp);
> -	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
> +	perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
>  
>  	if (PRINT_FIELD(PHYS_ADDR))
>  		fprintf(fp, "%16" PRIx64, sample->phys_addr);
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 459e0e93d7b1..8e3e2bc23811 100644
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
> @@ -93,17 +95,35 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  	return printed;
>  }
>  
> +static bool is64bitip(struct perf_sample *sample, struct thread *thread,
> +		      struct machine *machine,uint64_t ip,
> +		      struct addr_location *al)
> +{
> +	bool is64bit = machine__is(machine, "x86_64");
> +	struct dso *dso;
> +
> +	if (thread__find_map(thread, sample->cpumode, ip, al) &&
> +		(dso = map__dso(al->map)) != NULL &&
> +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> +		map__load(al->map);
> +		is64bit = dso->is_64_bit;
> +	}
> +	return is64bit;
> +}

'al' has already been resolved, so this can be:

static bool is64bit(struct machine *machine, struct addr_location *al)
{
	const struct dso *dso = al->map ? map__dso(al->map) : NULL;

	if (dso)
		return dso->is_64_bit;

	return machine__is(machine, "x86_64") ||
	       machine__normalized_is(machine, "arm64") ||
	       machine__normalized_is(machine, "s390");
}

> +
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> -				struct machine *machine, FILE *fp)
> +				struct machine *machine, FILE *fp,
> +				struct addr_location *al)
>  {
>  	csh cs_handle;
>  	cs_insn *insn;
>  	size_t count;
>  	size_t printed = 0;
>  	int ret;
> +	bool is64bit = is64bitip(sample, thread, machine, sample->ip, al);
>  
>  	/* TODO: Try to initiate capstone only once but need a proper place. */
> -	ret = capstone_init(machine, &cs_handle);
> +	ret = capstone_init(machine, &cs_handle, is64bit);
>  	if (ret < 0) {
>  		/* fallback */
>  		return sample__fprintf_insn_raw(sample, fp);
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index 465bdcfcc2fd..6447dd41b543 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -10,7 +10,7 @@ struct thread;
>  struct machine;
>  
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
> -				struct machine *machine, FILE *fp);
> +				struct machine *machine, FILE *fp, struct addr_location *al);
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
>  
>  #endif /* PERF_PRINT_INSN_H */

