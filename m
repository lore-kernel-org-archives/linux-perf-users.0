Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C23B788
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Mar 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102894; cv=none; b=AzVPxu9eUQW4uuq6XzRVzNtTqZv4vd1a+3UO7wVt4u5O4+ypi3uUTCj2Gaz/2PgHL3RljOTJHmkkHW1YvoVCgDQ6sSaKzs4ACg1GTBSF47RGCoF8Vze5cQRgQJrEfMpTULtrWOD8PntuF2jlIvOkPuTJxtwQnem8JlGuT7a/PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102894; c=relaxed/simple;
	bh=Mvowesc4yeCDLY31rV9dnuQUymiurq40h0RFYOlw/1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mT7X7Th4LJMEu/zHXzLrBGz90jBNzlFKYpXS+w3TR2HjkO0rrON7JrKuo+DgRmFcH0l/3/pl/+FmpKbslFyhwUrDIir3N20ntg02w9fa4kVacSvPFlHVzsRXwM+limmn5mgiq/Jundb91FEuXo4nKElQlDy5+QGHuAeag6CwOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRD9Yn/m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRD9Yn/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711102893; x=1742638893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mvowesc4yeCDLY31rV9dnuQUymiurq40h0RFYOlw/1M=;
  b=TRD9Yn/mPSaJNjenVmhBifqG903hXI4Bws47zn2boonn9oWhESpF8fX4
   9yAn8+Pk3J08TiJz1kSJntysa2KAdurYG0ZZnIZ8m7y093WGIInxwbSkl
   IedjAeKysmk7LtAiPICCPVWjVv/KcDde9FszCgQOnpNPSLQTkP7EANjZj
   1XGqgRINLtfw/ZbfwcI09jXrDLzoJALLLelsO83+cdlSN0ByIGJ8hWy6L
   Ms09Kub7z06WAn7WEBwbIzXhIhEe2kPAo5oLkW4/0e4QhnaDr98pDoeTK
   E7TUYEoK0osaitOPBdEtFjahVe83aMV+Kgsd+POhYDNhjbeB3p6h7/ORP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16690266"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16690266"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14773492"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.137])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:21:28 -0700
Message-ID: <b56cd2db-3bd8-480e-b5ad-5e413c8ccbe3@intel.com>
Date: Fri, 22 Mar 2024 12:21:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf, capstone: Support 32bit code under 64bit OS
To: Andi Kleen <ak@linux.intel.com>
Cc: changbin.du@huawei.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240308170611.719794-1-ak@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240308170611.719794-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/03/24 19:06, Andi Kleen wrote:
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

Comma in subject is slightly odd, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> v2: Factor out DSO lookup into separate function
> v3: Pass down al
> v4: Simplify is64bitip
> ---
>  tools/perf/builtin-script.c  |  9 +++++----
>  tools/perf/util/print_insn.c | 24 ++++++++++++++++++++----
>  tools/perf/util/print_insn.h |  2 +-
>  3 files changed, 26 insertions(+), 9 deletions(-)
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
> index 459e0e93d7b1..8e4e3cffd677 100644
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

