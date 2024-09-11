Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844513AD18;
	Wed, 11 Sep 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041815; cv=none; b=cIwSnZtinUkpgeuUPUfyygL98cO35vcAbYCwh4bBr6W5IXzDjTh/eN0l27CqTYzatsvFUhCCfEJ4PTgxppa0UoZrh1EYknLF8ePxeK8UblILtsKMhBNcaCySAruX11U7VEFlOmeyxY5KlPzf0u+DMLocHC+2/f6BH/fLv7ou0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041815; c=relaxed/simple;
	bh=x2N6ahkVP2f1wV4kYKI9LoSxAZjIok/l/sgL/e6mnwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ExwRJGKA5vvFZAemAxpNKTqwQMlUOON9hVfgU9UsMdlAVqwwxZz1O/rA2A1ybzqx7rtH1ScJhglMDZBpImPZlbJAsFPTMbJH1wrvYa9kiYgDjKuez+K/ygvw4Jf8uN0x9bpM44cMxiOQVFJVEfJKILZ01M6Rzmw673wlM/6oaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEhHuqsJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEhHuqsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041813; x=1757577813;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=x2N6ahkVP2f1wV4kYKI9LoSxAZjIok/l/sgL/e6mnwU=;
  b=oEhHuqsJeH07354aDOO1wjK9ibDd5/fq8Po8Wu2vZk23s8ULoQRMu49f
   4624nBr1Wi8c1eXxPeE0yXidY8O562BKN4bqHsYSMJjhw1A/oBu9lqAOb
   IPkw/7sRelPESZEIJmxY7bN5HquURH2oeSYIhmwjqCb07e6nmZn8cOmOj
   QC0mGGoUI4lgw3TTXaw/LNJ/32d4FD2HGkoTgL47G+NuSd1pdZ4TAciWd
   PCK3uyxCX+cbq2IfAwW+ONXxZVuplhaWANp6SSAMvJHh2tPFu9vcvDC1h
   fvMSFE96n6DL3Rt7VGlI02IEeBmWSf5qSFDFV/Wd2idaUt6GZ1xAOObVY
   Q==;
X-CSE-ConnectionGUID: LTNkMtTnS46VZ2+WtB8/ww==
X-CSE-MsgGUID: r9rXifMeQceAC53wKXYDQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24321004"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24321004"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:03:32 -0700
X-CSE-ConnectionGUID: rTrbspWIRIKFiyPoDmfQNg==
X-CSE-MsgGUID: LPJ0WJG/RKGAcLZcWsc0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="97989653"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:03:27 -0700
Message-ID: <b13bcf7c-4d03-4b7d-8509-cebb64297a86@intel.com>
Date: Wed, 11 Sep 2024 11:03:21 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 1/8] perf: support specify vdso path in cmdline
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
 llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
 <20240725021549.880167-2-changbin.du@huawei.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/07/24 05:15, Changbin Du wrote:
> The vdso dumped from process memory (in buildid-cache) lacks debugging
> info. To annotate vdso symbols with source lines we need specify a
> debugging version.
> 
> For x86, we can find them from your local build as
> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
> the buildid has to match.
> 
> $ sudo perf record -a
> $ sudo perf report --objdump=llvm-objdump \
>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
> 
> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
> Percent│       movq    -48(%rbp),%rsi
>        │       testq   %rax,%rax
>        │     ;               return vread_hvclock();
>        │       movq    %rax,%rdx
>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>        │     ↑ js      eb
>        │     ↑ jmp     74
>        │     ;               ts->tv_sec = vdso_ts->sec;
>   0.02 │147:   leaq    2(%rbx),%rax
>        │       shlq    $4, %rax
>        │       addq    %r10,%rax
>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>   9.38 │152:   movl    (%r10),%ecx
> 
> When doing cross platform analysis, we also need specify the vdso path if
> we are interested in its symbols.
> 
> v2: update documentation.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  3 +
>  tools/perf/Documentation/perf-c2c.txt      |  3 +
>  tools/perf/Documentation/perf-inject.txt   |  3 +
>  tools/perf/Documentation/perf-report.txt   |  3 +
>  tools/perf/Documentation/perf-script.txt   |  3 +
>  tools/perf/Documentation/perf-top.txt      |  3 +
>  tools/perf/builtin-annotate.c              |  2 +
>  tools/perf/builtin-c2c.c                   |  2 +
>  tools/perf/builtin-inject.c                |  2 +
>  tools/perf/builtin-report.c                |  2 +
>  tools/perf/builtin-script.c                |  2 +
>  tools/perf/builtin-top.c                   |  2 +
>  tools/perf/util/disasm.c                   |  7 +-
>  tools/perf/util/symbol.c                   | 82 +++++++++++++++++++++-
>  tools/perf/util/symbol_conf.h              |  5 ++
>  15 files changed, 119 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index b95524bea021..4b6692f9a793 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -58,6 +58,9 @@ OPTIONS
>  --ignore-vmlinux::
>  	Ignore vmlinux files.
>  
> +--vdso=<vdso1[,vdso2]>::
> +	Specify vdso pathnames. You can specify up to two for multiarch-support.
> +
>  --itrace::
>  	Options for decoding instruction tracing data. The options are:
>  

<SNIP>

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index b10b7f005658..e0aa657e6ca0 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -742,6 +742,8 @@ int cmd_annotate(int argc, const char **argv)
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
>  		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  	OPT_BOOLEAN('l', "print-line", &annotate_opts.print_lines,
>  		    "print matching source lines (may be slow)"),
>  	OPT_BOOLEAN('P', "full-paths", &annotate_opts.full_path,

<SNIP>

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index e10558b79504..7e26d5215640 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -16,6 +16,7 @@
>  #include "debug.h"
>  #include "disasm.h"
>  #include "dso.h"
> +#include "vdso.h"
>  #include "env.h"
>  #include "evsel.h"
>  #include "map.h"
> @@ -1126,7 +1127,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
>  		dirname(build_id_path);
>  
> -	if (dso__is_kcore(dso))
> +	if (dso__is_kcore(dso) || dso__is_vdso(dso))

Sorry for very long delay.

This patch (probably this bit here) breaks annotation of vdso.
To allow for bisection, you need to arrange changes so that each
patch leaves things in a working state.

However, I disagree with adding --vdso option since with just
patch 8 alone, it would be possible to do:

  perf buildid-cache --remove /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
  perf buildid-cache --add /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

and same of vdso32.

That would leave the buildid-cache containing only the debug versions,
which would mean you will only get the debug versions, and it would only
need to be done once per kernel instead of having to add --vdso to
every perf command.

