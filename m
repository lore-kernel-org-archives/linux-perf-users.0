Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45011B810
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Apr 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211742; cv=none; b=mxLx2sTy3n+e3Dcu9KTcdY5cAkwezWTJXgmESPAWTmUJNAPHOyw3ju8HsrFmAESKHG8+Ro7KTr9KIzVdEodsjzyjn1UFSDK54Zc/FqIUqEfoEx1hYTEiSCZxdImQwsUK3KOLvSElAkTMAPitY1Z8H+p6EP25TACbbZ4L/vjqguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211742; c=relaxed/simple;
	bh=N9mU7wUXvWAraObkg91KrYjzYyWfJokGqgSinkPGR/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AAc64vdsNiyz9sRtxowEHo2wLV2xaBJFX7HOnVRXgQLVDvRBza3CVQPwY+Hu/tiu+8A7qT4PUyxTU+6CCqF1tm0xX8YrBgUiFtuEPHH+sIX7r+e+C6fVm2f7LxBIG0kV9uWuDV87atRFXznNYBzjy+tEKRcIEw0dXfrcuBsTnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXiSyIBx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXiSyIBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712211740; x=1743747740;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=N9mU7wUXvWAraObkg91KrYjzYyWfJokGqgSinkPGR/U=;
  b=JXiSyIBxI6b52tx1U5GoWxir37rmmObqKJE8DpEhM+zVLYircBXJxwr4
   +f9AQ33V3qev4uBkGnp7MA1ivrh1o8zDT4h6O6AEKAJ3Ihb5RQwsDdpca
   DOoAeQPE/M7TIJR90/Dl55mWoigPDpAL7cjM9+bMH0+iiEhBBg3mL2Ldo
   3TYE9ph/mDFIGakOqe0YvBPVIWlASaYTBsJO8CpRifrtRCp0KxbRrk74z
   xQ86JI2thylBZUhmZGr2ynzHQ20aKHPzDyDbShU0GtCLJIzlZsqsD6Fby
   OCvN6STyNqGjQTP3U8PSpPG6NUj1TfI4BT4/eKEu0HXVIEDSAZLOOydqy
   g==;
X-CSE-ConnectionGUID: zep44R3GQKS82ox3R0cUGQ==
X-CSE-MsgGUID: YnCp80ItSgC6YxgpQJWHHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11293494"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11293494"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:22:19 -0700
X-CSE-ConnectionGUID: XWktPK5vSVaGlbVtl0kLRA==
X-CSE-MsgGUID: 5gtXhHTwSzaAE61TJ7o0uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23330836"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.213.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:22:16 -0700
Message-ID: <3b60c8dd-32fe-4dfb-a78f-8596b3ef4410@intel.com>
Date: Thu, 4 Apr 2024 09:22:11 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] perf, capstone: Support 32bit code under 64bit OS
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <20240401210925.209671-1-ak@linux.intel.com>
 <20240401210925.209671-2-ak@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240401210925.209671-2-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/04/24 00:08, Andi Kleen wrote:
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

As with V4, comma in subject is slightly odd, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Also note V4 Ack from Thomas Richter:

	https://lore.kernel.org/all/5399c3b2-a1f0-41c6-ba91-a6a6692629dd@linux.ibm.com/

> 
> ---
> 
> v2: Factor out DSO lookup into separate function
> v3: Pass down al
> v4: Simplify is64bitip
> v5: Fix fallback
> ---
>  tools/perf/builtin-script.c  |  9 +++++----
>  tools/perf/util/print_insn.c | 27 ++++++++++++++++++++++-----
>  tools/perf/util/print_insn.h |  2 +-
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 2e7148d667bd..94946396bb6e 100644
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
> index 459e0e93d7b1..32dc9dad9cf2 100644
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
> @@ -93,17 +95,31 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  	return printed;
>  }
>  
> +static bool is64bitip(struct machine *machine, struct addr_location *al)
> +{
> +	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
> +
> +	if (dso)
> +		return dso->is_64_bit;
> +
> +	return machine__is(machine, "x86_64") ||
> +		machine__normalized_is(machine, "arm64") ||
> +		machine__normalized_is(machine, "s390");
> +}
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
> +	bool is64bit = is64bitip(machine, al);
>  
>  	/* TODO: Try to initiate capstone only once but need a proper place. */
> -	ret = capstone_init(machine, &cs_handle);
> +	ret = capstone_init(machine, &cs_handle, is64bit);
>  	if (ret < 0) {
>  		/* fallback */
>  		return sample__fprintf_insn_raw(sample, fp);
> @@ -128,7 +144,8 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
>  				struct thread *thread __maybe_unused,
>  				struct machine *machine __maybe_unused,
> -				FILE *fp __maybe_unused)
> +				FILE *fp __maybe_unused,
> +				struct addr_location *al __maybe_unused)
>  {
>  	return 0;
>  }
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

