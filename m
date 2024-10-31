Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C193427;
	Thu, 31 Oct 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366073; cv=none; b=sPnu9XSB3Rf7yiok0KBuKkMjjZDkntYri4R6remk8KtmRu4ymvhBhKl8t0fMvblR3MyJNuvUx5kXgQVGEf8wn1V1TbCNycE3txeEsGzp8pGTmXXlCp2Y9mO03bnPg09u9Wd8LaIOQ+mT1aNpD0PV3hylOCA/zRHqAd2sME4vcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366073; c=relaxed/simple;
	bh=tli3DYo2LvI+/T7xA8UfS2QU8a1u1b4z9XXM+Z0zBlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=twCvmYjOEco/fMn/hqrU0NIpqyMhV0mMaLtIaVM4BO6TipqS6MrcUdetwZu+sKqOGej3NbDsDocsgauHhlqfY/aVMZchw8hWRg5pzWNuxZuQYxGnWRacPYcVyKY064Ar2Cws4wO5I6MbYznME6ylSHVdyA+8Bn6KRi1qpMmFvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjUbAVJh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjUbAVJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730366071; x=1761902071;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=tli3DYo2LvI+/T7xA8UfS2QU8a1u1b4z9XXM+Z0zBlY=;
  b=YjUbAVJhlruG5V2o4O5w66Qxs6Z8souR9Fv2ocsmKhMoBS4Dgw3PygfY
   AYjQaP8AP2sJAkj4I2grH5GHFkGNcYVfA9fVbmA7N/hO8KA4j5BYLb0Ct
   q4bYyt5Krhkupmuinwc0jHx0dxbhxn+YWrNZA3+8M3IfzdGA9zk8aF3wV
   Qhi+aMzrAvd+XiBDQWbB7DLSHhWmJ+TXeiDFonG396xr2a/nI1QbgEKYQ
   paWXt57Qk0lWle///QVLao34F9NfOoFwr6RctZZyECuQG7NSpBa20Q8xK
   /XvFMGbgMa+50pmzSEOQV2yqI/mFc58fuh4mqAtQtCxsHzP9jXLxV1zyO
   w==;
X-CSE-ConnectionGUID: DvfuRDWPSnCGKZt8TQF2PA==
X-CSE-MsgGUID: 3auvNBAoTEmyBFAcYE9oqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30310936"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30310936"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:14:27 -0700
X-CSE-ConnectionGUID: x0ylb6c0TsOFfaAWP+/nkQ==
X-CSE-MsgGUID: UTWKQdeNS+ewCl9ntXG/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82485919"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:14:20 -0700
Message-ID: <6e6bd96f-912a-40e4-b43e-53f6a99f4338@intel.com>
Date: Thu, 31 Oct 2024 11:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] perf x86: Define arch_fetch_insn in NO_AUXTRACE
 builds
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-12-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241031014252.753588-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/24 03:42, Ian Rogers wrote:
> archinsn.c containing arch_fetch_insn was only enabled with
> CONFIG_AUXTRACE, but this meant that a NO_AUXTRACE build on x86 would
> use the empty weak version of arch_fetch_insn - weak symbols are a
> frequent source of errors like this and are outside of the C
> specification. Change it so that archinsn.c is always built on x86 and
> make the weak symbol empty version of arch_fetch_insn a strong one
> guarded by ifdefs.
> 
> arch_fetch_insn on x86 depends on insn_decode which is a function
> included then built into
> intel-pt-insn-decoder.c. intel-pt-insn-decoder.c isn't built in a
> NO_AUXTRACE=1 build. Separate the insn_decode function from
> intel-pt-insn-decoder.c by just directly compiling the relevant
> file. Guard this compilation to be for either always on x86 (because
> of the use in arch_fetch_insn) or when auxtrace is enabled. Apply the
> CFLAGS overrides as necessary, reducing the amount of code where
> warnings are disabled.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

For Intel PT

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/Build                 |  2 +-
>  tools/perf/util/Build                          |  2 +-
>  tools/perf/util/intel-pt-decoder/Build         | 18 ++++++++++++++----
>  .../intel-pt-decoder/intel-pt-insn-decoder.c   |  3 ---
>  tools/perf/util/trace-event-scripting.c        |  4 +++-
>  5 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index bc56a8e70f34..c5df4a2cf180 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -18,6 +18,6 @@ perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
>  perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
> -perf-util-$(CONFIG_AUXTRACE) += archinsn.o
> +perf-util-y += archinsn.o
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
>  perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 650974413849..340544a6f5ec 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -122,7 +122,7 @@ perf-util-y += iostat.o
>  perf-util-y += stream.o
>  perf-util-y += kvm-stat.o
>  perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
> -perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
> +perf-util-y += intel-pt-decoder/
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
>  perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
>  perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
> diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
> index 30793d08c6d4..f99d150059b9 100644
> --- a/tools/perf/util/intel-pt-decoder/Build
> +++ b/tools/perf/util/intel-pt-decoder/Build
> @@ -9,14 +9,24 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
>  
>  # Busybox's diff doesn't have -I, avoid warning in the case
>  
> -$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
> +ifeq ($(SRCARCH),x86)
> +  perf-util-y += inat.o insn.o
> +else
> +  perf-util-$(CONFIG_AUXTRACE) += inat.o insn.o
> +endif
> +
> +$(OUTPUT)util/intel-pt-decoder/inat.o: $(srctree)/tools/arch/x86/lib/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)
>  
> -CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
> +CFLAGS_inat.o += -I$(OUTPUT)util/intel-pt-decoder
> +
> +$(OUTPUT)util/intel-pt-decoder/insn.o: $(srctree)/tools/arch/x86/lib/insn.c
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
>  
>  ifeq ($(CC_NO_CLANG), 1)
> -  CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
> +  CFLAGS_insn.o += -Wno-override-init
>  endif
>  
> -CFLAGS_intel-pt-insn-decoder.o += -Wno-packed
> +CFLAGS_insn.o += -Wno-packed
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> index 47cf35799a4d..8fabddc1c0da 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> @@ -11,9 +11,6 @@
>  #include <byteswap.h>
>  #include "../../../arch/x86/include/asm/insn.h"
>  
> -#include "../../../arch/x86/lib/inat.c"
> -#include "../../../arch/x86/lib/insn.c"
> -
>  #include "event.h"
>  
>  #include "intel-pt-insn-decoder.h"
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 2e9da0b089ef..8d71998a9ecd 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -272,11 +272,13 @@ void setup_perl_scripting(void)
>  #endif
>  #endif
>  
> -__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
> +#if !defined(__i386__) && !defined(__x86_64__)
> +void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
>  		     struct thread *thread __maybe_unused,
>  		     struct machine *machine __maybe_unused)
>  {
>  }
> +#endif
>  
>  void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
>  		       struct machine *machine, bool native_arch)

