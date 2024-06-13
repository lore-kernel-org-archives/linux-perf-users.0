Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396C14036F;
	Thu, 13 Jun 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273972; cv=none; b=D59hgSqgrC8DXjzGjTu/qWUS5jfBozj7Wbg/mLTmWRObSdWyK6fVI6kP+SY2y6jKe/zJ4de0hNx080FCE8Dadm0MP26SVZySQ7+m76999OxmNBRS4o9cj1NNhrDVnPmWJheAxaWS4slmYmGh2VU+IcGWAQu2wM+brL2Qtsid1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273972; c=relaxed/simple;
	bh=uIMfPsGUZsV3J1yOZyI8w+8ZpQq+WF7reRhIrErMR70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdVbyGjEUOUmKyFBke1RAobZ/R30Qfa9kseMdGLiVzcCH25pymX+SGIoQM9aNjNwmnxUP2ps4wzoKICaWxcRGU1XOkso59XzWobVETUpgN6kmqP4YrcO1Dr2P6XBH5mMzYaLoQEy/srEkIoKcTqS2a46/WbhYL6NopkYXdw1vQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TY5OkMBM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TY5OkMBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718273970; x=1749809970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uIMfPsGUZsV3J1yOZyI8w+8ZpQq+WF7reRhIrErMR70=;
  b=TY5OkMBMtA/toGHWgbso8hF8fsXVJaaJDG88eFMohyaOUciOB6orEG48
   rx7uO/hrZI9w3GekfOqdydBycNE2qdaWZ0Vh+e8muEuM75bub8k23Iseb
   fUxpB36pr1OaY3yjL7tx0iOVyCZS57jmY+qib2Bk/F1PvisydvUnZvIa6
   fc5dKTH1RxzJDQsWWbAsLT5E8BCiTRYnI56zA+bluS/D2n82IAis3X60r
   upp/uDFD4twqNDqeSP6Ed1egUsvDxRX45cm9Vg2eSsBQlf1udvJ5y20PZ
   srmGmuLLZP5Voo2Eh7vX/t/xTh0FjwbJGUfesJN8mcA+O0c46008ApsVZ
   g==;
X-CSE-ConnectionGUID: Ow/Sc0UQRjq7GycSmooOjQ==
X-CSE-MsgGUID: Wj1GvVqLQSOu6V/My179Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26505904"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26505904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:19:29 -0700
X-CSE-ConnectionGUID: r93nnX5uRliATHK9YgCLPQ==
X-CSE-MsgGUID: Yjgz7gYiRTOvLteup72QpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40575727"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:19:24 -0700
Message-ID: <dfc9a604-6857-46af-a778-5c354fe199be@intel.com>
Date: Thu, 13 Jun 2024 13:19:20 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: support specify vdso path in cmdline
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-2-changbin.du@huawei.com>
 <961fe800-7160-4c53-a3a0-f16700c433cd@intel.com>
 <1e17854b16fe46a4b384b6ddec05029a@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1e17854b16fe46a4b384b6ddec05029a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 12:49, duchangbin wrote:
> On Thu, Jun 13, 2024 at 11:23:26AM +0300, Adrian Hunter wrote:
>> On 13/06/24 09:35, Changbin Du wrote:
>>> The vdso dumped from process memory (in buildid-cache) lacks debugging
>>> info. To annotate vdso symbols with source lines we need specify a
>>> debugging version.
>>>
>>> For x86, we can find them from your local build as
>>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
>>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
>>> the buildid has to match.
>>>
>>> $ sudo perf record -a
>>> $ sudo perf report --objdump=llvm-objdump \
>>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
>>>
>>> When doing cross platform analysis, we also need specify the vdso path if
>>> we are interested in its symbols.
>>
>> We already have logic to find debug files, and to deal with a symbol source
>> (syms_ss) and runtime symbol source (runtime_ss).
>>
>> Can't we make that work transparently for vdso so that the user does
>> not have to.
>>
> For Ubuntu, we can find the debug files of vdso in
> /lib/modules/<version>/vdso/vdso{32,64}.so. These two are debug version.
> 
> For local build, seems vdso{32,64}.so.dbg are not installed in /lib/modules/ nor
> other locations.

Isn't there /lib/modules/<version>/build symbolic link to follow?

> 
>>>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>> ---
>>>  tools/perf/builtin-annotate.c |  2 +
>>>  tools/perf/builtin-c2c.c      |  2 +
>>>  tools/perf/builtin-inject.c   |  2 +
>>>  tools/perf/builtin-report.c   |  2 +
>>>  tools/perf/builtin-script.c   |  2 +
>>>  tools/perf/builtin-top.c      |  2 +
>>>  tools/perf/util/symbol.c      | 74 +++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/symbol_conf.h |  5 +++
>>>  8 files changed, 91 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>> index 50d2fb222d48..ff466882065d 100644
>>> --- a/tools/perf/builtin-annotate.c
>>> +++ b/tools/perf/builtin-annotate.c
>>> @@ -742,6 +742,8 @@ int cmd_annotate(int argc, const char **argv)
>>>  		   "file", "vmlinux pathname"),
>>>  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
>>>  		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
>>> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  	OPT_BOOLEAN('l', "print-line", &annotate_opts.print_lines,
>>>  		    "print matching source lines (may be slow)"),
>>>  	OPT_BOOLEAN('P', "full-paths", &annotate_opts.full_path,
>>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>>> index c157bd31f2e5..4764f9139661 100644
>>> --- a/tools/perf/builtin-c2c.c
>>> +++ b/tools/perf/builtin-c2c.c
>>> @@ -3018,6 +3018,8 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	const struct option options[] = {
>>>  	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>>  		   "file", "vmlinux pathname"),
>>> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  	OPT_STRING('i', "input", &input_name, "file",
>>>  		   "the input file to process"),
>>>  	OPT_INCR('N', "node-info", &c2c.node_info,
>>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>>> index a212678d47be..e774e83d0a0f 100644
>>> --- a/tools/perf/builtin-inject.c
>>> +++ b/tools/perf/builtin-inject.c
>>> @@ -2247,6 +2247,8 @@ int cmd_inject(int argc, const char **argv)
>>>  			    "don't load vmlinux even if found"),
>>>  		OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
>>>  			   "kallsyms pathname"),
>>> +		OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
>>>  		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
>>>  				    NULL, "opts", "Instruction Tracing options\n"
>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>> index 69618fb0110b..a64b48460dce 100644
>>> --- a/tools/perf/builtin-report.c
>>> +++ b/tools/perf/builtin-report.c
>>> @@ -1324,6 +1324,8 @@ int cmd_report(int argc, const char **argv)
>>>                      "don't load vmlinux even if found"),
>>>  	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>>>  		   "file", "kallsyms pathname"),
>>> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>>>  	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
>>>  		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index c16224b1fef3..2e358922a8d1 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -3965,6 +3965,8 @@ int cmd_script(int argc, const char **argv)
>>>  		   "file", "vmlinux pathname"),
>>>  	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>>>  		   "file", "kallsyms pathname"),
>>> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  	OPT_BOOLEAN('G', "hide-call-graph", &no_callchain,
>>>  		    "When printing symbols do not display call chain"),
>>>  	OPT_CALLBACK(0, "symfs", NULL, "directory",
>>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>>> index 1d6aef51c122..a3cce4e76eb9 100644
>>> --- a/tools/perf/builtin-top.c
>>> +++ b/tools/perf/builtin-top.c
>>> @@ -1479,6 +1479,8 @@ int cmd_top(int argc, const char **argv)
>>>  		   "file", "kallsyms pathname"),
>>>  	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
>>>  		    "hide kernel symbols"),
>>> +	OPT_CALLBACK(0, "vdso", NULL, "vdso1[,vdso2]", "vdso pathnames",
>>> +		     parse_vdso_pathnames),
>>>  	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
>>>  		     "number of mmap data pages", evlist__parse_mmap_pages),
>>>  	OPT_INTEGER('r', "realtime", &top.realtime_prio,
>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>> index 9e5940b5bc59..8d040039a7ce 100644
>>> --- a/tools/perf/util/symbol.c
>>> +++ b/tools/perf/util/symbol.c
>>> @@ -19,6 +19,7 @@
>>>  #include "build-id.h"
>>>  #include "cap.h"
>>>  #include "dso.h"
>>> +#include "vdso.h"
>>>  #include "util.h" // lsdir()
>>>  #include "debug.h"
>>>  #include "event.h"
>>> @@ -44,6 +45,7 @@
>>>  
>>>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>>>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
>>> +static int dso__load_vdso_sym(struct dso *dso, struct map *map);
>>>  static bool symbol__is_idle(const char *name);
>>>  
>>>  int vmlinux_path__nr_entries;
>>> @@ -1833,6 +1835,12 @@ int dso__load(struct dso *dso, struct map *map)
>>>  		goto out;
>>>  	}
>>>  
>>> +	if (dso__is_vdso(dso)) {
>>> +		ret = dso__load_vdso_sym(dso, map);
>>> +		if (ret > 0)
>>> +			goto out;
>>> +	}
>>> +
>>>  	dso__set_adjust_symbols(dso, false);
>>>  
>>>  	if (perfmap) {
>>> @@ -2349,6 +2357,72 @@ static int vmlinux_path__init(struct perf_env *env)
>>>  	return -1;
>>>  }
>>>  
>>> +int parse_vdso_pathnames(const struct option *opt __maybe_unused,
>>> +			 const char *arg, int unset __maybe_unused)
>>> +{
>>> +	char *tmp, *tok, *str = strdup(arg);
>>> +	unsigned int i = 0;
>>> +
>>> +	for (tok = strtok_r(str, ",", &tmp); tok && i < ARRAY_SIZE(symbol_conf.vdso_name);
>>> +	     tok = strtok_r(NULL, ",", &tmp)) {
>>> +		symbol_conf.vdso_name[i++] = strdup(tok);
>>> +	}
>>> +
>>> +	free(str);
>>> +	return 0;
>>> +}
>>> +
>>> +static int dso__load_vdso(struct dso *dso, struct map *map,
>>> +			  const char *vdso)
>>> +{
>>> +	int err = -1;
>>> +	struct symsrc ss;
>>> +	char symfs_vdso[PATH_MAX];
>>> +
>>> +	if (vdso[0] == '/')
>>> +		snprintf(symfs_vdso, sizeof(symfs_vdso), "%s", vdso);
>>> +	else
>>> +		symbol__join_symfs(symfs_vdso, vdso);
>>> +
>>> +	if (symsrc__init(&ss, dso, symfs_vdso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO))
>>> +		return -1;
>>> +
>>> +	/*
>>> +	 * dso__load_sym() may copy 'dso' which will result in the copies having
>>> +	 * an incorrect long name unless we set it here first.
>>> +	 */
>>> +	dso__set_long_name(dso, vdso, false);
>>> +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
>>> +
>>> +	err = dso__load_sym(dso, map, &ss, &ss, 0);
>>> +	symsrc__destroy(&ss);
>>> +
>>> +	if (err > 0) {
>>> +		dso__set_loaded(dso);
>>> +		pr_debug("Using %s for %s symbols\n", symfs_vdso, dso__short_name(dso));
>>> +	}
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static int dso__load_vdso_sym(struct dso *dso, struct map *map)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (!dso__is_vdso(dso))
>>> +		return -1;
>>> +
>>> +	for (unsigned int i = 0; i < ARRAY_SIZE(symbol_conf.vdso_name); i++) {
>>> +		if (symbol_conf.vdso_name[i] != NULL) {
>>> +			ret = dso__load_vdso(dso, map, symbol_conf.vdso_name[i]);
>>> +			if (ret > 0)
>>> +				return ret;
>>> +		}
>>> +	}
>>> +
>>> +	return -1;
>>> +}
>>> +
>>>  int setup_list(struct strlist **list, const char *list_str,
>>>  		      const char *list_name)
>>>  {
>>> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
>>> index c114bbceef40..108356e3c981 100644
>>> --- a/tools/perf/util/symbol_conf.h
>>> +++ b/tools/perf/util/symbol_conf.h
>>> @@ -3,6 +3,7 @@
>>>  #define __PERF_SYMBOL_CONF 1
>>>  
>>>  #include <stdbool.h>
>>> +#include <subcmd/parse-options.h>
>>>  
>>>  struct strlist;
>>>  struct intlist;
>>> @@ -55,6 +56,7 @@ struct symbol_conf {
>>>  	const char	*default_guest_vmlinux_name,
>>>  			*default_guest_kallsyms,
>>>  			*default_guest_modules;
>>> +	const char	*vdso_name[2];
>>>  	const char	*guestmount;
>>>  	const char	*dso_list_str,
>>>  			*comm_list_str,
>>> @@ -85,4 +87,7 @@ struct symbol_conf {
>>>  
>>>  extern struct symbol_conf symbol_conf;
>>>  
>>> +int parse_vdso_pathnames(const struct option *opt __maybe_unused,
>>> +			 const char *arg, int unset __maybe_unused);
>>> +
>>>  #endif // __PERF_SYMBOL_CONF
>>
>>
> 

