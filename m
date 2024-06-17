Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A002AE6A;
	Mon, 17 Jun 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602026; cv=none; b=i1VJk/FjzpZv1qZLsNImxMjJEu6mH1BR7U2/bUxDBVfIpghdqqw0P5PJQPqnfHxlAMiH8J1LBXQodUfY8dsxF1Pjt1IGKelsRQxJpijSzGJGIeQUrcfljeIEPyutApUrH6hu7bBoOIf8UW7wAyM293DbC2KKJIDGthLVAuqk1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602026; c=relaxed/simple;
	bh=9PUMDrkYWNIljtNYV2Hf0l2hllwKm1PbdkTuhidxuz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFhyKobD+QzuTWUaNqP9DrmA+CWLOPvl+oKOkdjyi+dGHVLUUrxasgyf9mtVgr4R4qdDpiYGohZrjX7lPOhgWnXdfquLOw+DvpviVHDEu505BGUBiAtJkjxxMQcHcNFBi5A8HbnBZD83O53sBBh65lzQ/MU2w6hk9fkH8W04918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+C3ejOO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+C3ejOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718602024; x=1750138024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9PUMDrkYWNIljtNYV2Hf0l2hllwKm1PbdkTuhidxuz8=;
  b=Y+C3ejOO8J66Nf8BWvdu0tVXhLzXp9zGY05fjzuT97utK1uTNYtSEK/6
   U1WsYzNknmNSTzedhsi+ZB4x1UMoT1s2qAfmEDxsKryYcrJo9suMCw3KP
   iKo2nXytDtIMfsaBe68Vj1OgExnIykYnX+IMX/RAfoGk9GjFJGkRhY3Ez
   pthhr9+ZbD+B9ELyhePgU1PsOn6QRnCNn6zndn2UQZVGXmH/bU5jp6nET
   5gj5zubTyf/NybcTL5CDUR9+L5i1GLZRV69XI5ZAOCygYhASh+P0gr2K8
   JNaaQ6rVk0E31+26cRcBVMdn95K1rQRBu98/EodZAs2yrKYhDIqoI+7qC
   A==;
X-CSE-ConnectionGUID: VoUIS7F9TOyCi5EIgD2VoQ==
X-CSE-MsgGUID: DW7PdVqwTAy4mENLt9/ZTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19200270"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19200270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 22:27:04 -0700
X-CSE-ConnectionGUID: YWFH4EBgQJe1K2tab+ffxg==
X-CSE-MsgGUID: Z0RMN4meTAWIxXZ1dXv6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41185777"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 22:26:59 -0700
Message-ID: <020779ae-f3f1-4ab0-b45c-4622b199131f@intel.com>
Date: Mon, 17 Jun 2024 08:26:55 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] perf: support specify vdso path in cmdline
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
 llvm@lists.linux.dev
References: <20240615092015.1820362-1-changbin.du@huawei.com>
 <20240615092015.1820362-2-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240615092015.1820362-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/06/24 12:20, Changbin Du wrote:
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

If perf can now find the vdso debug info, then why is the parameter needed?

> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-annotate.c |  2 +
>  tools/perf/builtin-c2c.c      |  2 +
>  tools/perf/builtin-inject.c   |  2 +
>  tools/perf/builtin-report.c   |  2 +
>  tools/perf/builtin-script.c   |  2 +
>  tools/perf/builtin-top.c      |  2 +
>  tools/perf/util/disasm.c      |  5 ++-
>  tools/perf/util/symbol.c      | 82 ++++++++++++++++++++++++++++++++++-
>  tools/perf/util/symbol_conf.h |  5 +++
>  9 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 50d2fb222d48..ff466882065d 100644
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
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c157bd31f2e5..4764f9139661 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3018,6 +3018,8 @@ static int perf_c2c__report(int argc, const char **argv)
>  	const struct option options[] = {
>  	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>  		   "file", "vmlinux pathname"),
> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  	OPT_STRING('i', "input", &input_name, "file",
>  		   "the input file to process"),
>  	OPT_INCR('N', "node-info", &c2c.node_info,
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a212678d47be..e774e83d0a0f 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2247,6 +2247,8 @@ int cmd_inject(int argc, const char **argv)
>  			    "don't load vmlinux even if found"),
>  		OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
>  			   "kallsyms pathname"),
> +		OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
>  		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
>  				    NULL, "opts", "Instruction Tracing options\n"
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 69618fb0110b..a64b48460dce 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1324,6 +1324,8 @@ int cmd_report(int argc, const char **argv)
>                      "don't load vmlinux even if found"),
>  	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>  		   "file", "kallsyms pathname"),
> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
>  		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..2e358922a8d1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3965,6 +3965,8 @@ int cmd_script(int argc, const char **argv)
>  		   "file", "vmlinux pathname"),
>  	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>  		   "file", "kallsyms pathname"),
> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  	OPT_BOOLEAN('G', "hide-call-graph", &no_callchain,
>  		    "When printing symbols do not display call chain"),
>  	OPT_CALLBACK(0, "symfs", NULL, "directory",
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1d6aef51c122..a3cce4e76eb9 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1479,6 +1479,8 @@ int cmd_top(int argc, const char **argv)
>  		   "file", "kallsyms pathname"),
>  	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
>  		    "hide kernel symbols"),
> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
> +		     parse_vdso_pathnames),
>  	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
>  		     "number of mmap data pages", evlist__parse_mmap_pages),
>  	OPT_INTEGER('r', "realtime", &top.realtime_prio,
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 72aec8f61b94..442e9802a772 100644
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
> @@ -1134,7 +1135,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  		goto fallback;
>  
>  	linkname[len] = '\0';
> -	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> +	if (strstr(linkname, DSO__NAME_KALLSYMS) || strstr(linkname, DSO__NAME_VDSO) ||
>  		access(filename, R_OK)) {
>  fallback:
>  		/*
> @@ -1142,7 +1143,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  		 * cache, or is just a kallsyms file, well, lets hope that this
>  		 * DSO is the same as when 'perf record' ran.
>  		 */
> -		if (dso__kernel(dso) && dso__long_name(dso)[0] == '/')
> +		if ((dso__kernel(dso) || dso__is_vdso(dso)) && dso__long_name(dso)[0] == '/')
>  			snprintf(filename, filename_size, "%s", dso__long_name(dso));
>  		else
>  			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..a90c647d37e1 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -19,6 +19,7 @@
>  #include "build-id.h"
>  #include "cap.h"
>  #include "dso.h"
> +#include "vdso.h"
>  #include "util.h" // lsdir()
>  #include "debug.h"
>  #include "event.h"
> @@ -44,6 +45,7 @@
>  
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
> +static int dso__load_vdso_sym(struct dso *dso, struct map *map);
>  static bool symbol__is_idle(const char *name);
>  
>  int vmlinux_path__nr_entries;
> @@ -1833,6 +1835,12 @@ int dso__load(struct dso *dso, struct map *map)
>  		goto out;
>  	}
>  
> +	if (dso__is_vdso(dso)) {
> +		ret = dso__load_vdso_sym(dso, map);
> +		if (ret > 0)
> +			goto out;
> +	}
> +
>  	dso__set_adjust_symbols(dso, false);
>  
>  	if (perfmap) {
> @@ -2017,12 +2025,14 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
>  		dso__set_binary_type(dso, DSO_BINARY_TYPE__VMLINUX);
>  
>  	err = dso__load_sym(dso, map, &ss, &ss, 0);
> -	symsrc__destroy(&ss);
> -
>  	if (err > 0) {
>  		dso__set_loaded(dso);
>  		pr_debug("Using %s for symbols\n", symfs_vmlinux);
> +
> +		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
> +			dso__set_symsrc_filename(dso, strdup(symfs_vmlinux));
>  	}
> +	symsrc__destroy(&ss);
>  
>  	return err;
>  }
> @@ -2349,6 +2359,74 @@ static int vmlinux_path__init(struct perf_env *env)
>  	return -1;
>  }
>  
> +int parse_vdso_pathnames(const struct option *opt __maybe_unused,
> +			 const char *arg, int unset __maybe_unused)
> +{
> +	char *tmp, *tok, *str = strdup(arg);
> +	unsigned int i = 0;
> +
> +	for (tok = strtok_r(str, ",", &tmp); tok && i < ARRAY_SIZE(symbol_conf.vdso_name);
> +	     tok = strtok_r(NULL, ",", &tmp)) {
> +		symbol_conf.vdso_name[i++] = strdup(tok);
> +	}
> +
> +	free(str);
> +	return 0;
> +}
> +
> +static int dso__load_vdso(struct dso *dso, struct map *map,
> +			  const char *vdso)
> +{
> +	int err = -1;
> +	struct symsrc ss;
> +	char symfs_vdso[PATH_MAX];
> +
> +	if (vdso[0] == '/')
> +		snprintf(symfs_vdso, sizeof(symfs_vdso), "%s", vdso);
> +	else
> +		symbol__join_symfs(symfs_vdso, vdso);
> +
> +	if (symsrc__init(&ss, dso, symfs_vdso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO))
> +		return -1;
> +
> +	/*
> +	 * dso__load_sym() may copy 'dso' which will result in the copies having
> +	 * an incorrect long name unless we set it here first.
> +	 */
> +	dso__set_long_name(dso, vdso, false);
> +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +
> +	err = dso__load_sym(dso, map, &ss, &ss, 0);
> +	if (err > 0) {
> +		dso__set_loaded(dso);
> +		pr_debug("Using %s for %s symbols\n", symfs_vdso, dso__short_name(dso));
> +
> +		if (symsrc__has_symtab(&ss) && !dso__symsrc_filename(dso))
> +			dso__set_symsrc_filename(dso, strdup(symfs_vdso));
> +	}
> +	symsrc__destroy(&ss);
> +
> +	return err;
> +}
> +
> +static int dso__load_vdso_sym(struct dso *dso, struct map *map)
> +{
> +	int ret;
> +
> +	if (!dso__is_vdso(dso))
> +		return -1;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(symbol_conf.vdso_name); i++) {
> +		if (symbol_conf.vdso_name[i] != NULL) {
> +			ret = dso__load_vdso(dso, map, symbol_conf.vdso_name[i]);
> +			if (ret > 0)
> +				return ret;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>  int setup_list(struct strlist **list, const char *list_str,
>  		      const char *list_name)
>  {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index c114bbceef40..108356e3c981 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -3,6 +3,7 @@
>  #define __PERF_SYMBOL_CONF 1
>  
>  #include <stdbool.h>
> +#include <subcmd/parse-options.h>
>  
>  struct strlist;
>  struct intlist;
> @@ -55,6 +56,7 @@ struct symbol_conf {
>  	const char	*default_guest_vmlinux_name,
>  			*default_guest_kallsyms,
>  			*default_guest_modules;
> +	const char	*vdso_name[2];
>  	const char	*guestmount;
>  	const char	*dso_list_str,
>  			*comm_list_str,
> @@ -85,4 +87,7 @@ struct symbol_conf {
>  
>  extern struct symbol_conf symbol_conf;
>  
> +int parse_vdso_pathnames(const struct option *opt __maybe_unused,
> +			 const char *arg, int unset __maybe_unused);
> +
>  #endif // __PERF_SYMBOL_CONF

