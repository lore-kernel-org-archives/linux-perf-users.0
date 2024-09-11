Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8534154C0F;
	Wed, 11 Sep 2024 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041848; cv=none; b=o4Ppu5Qc7VK3tCU3lHb5+82mT9eN1PgUBVfCAwcp8GY0RJSrLivZC/aYdzlxG4uoJdYlwDP74MkEF5b204q7DE7LBXg4BZpswk1aqWacTd2R1L/Eh14wQFECwmcguDpRA5g7R/QGtwIqnpFMIeO23sLSe4kCEuT28zuKV3ji42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041848; c=relaxed/simple;
	bh=yC1LWMwR6h/vkeDq0xNc2uAGBJt0y0JxjvDlY+/Nv2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixKdNXalALQiJFN+wmFhii9Jy8NZG4Su+vg5l43jFa2aWdXuQ95uJwI3NCWjHu8NcO/+h7KrST5ZqL/MDEI1MjdwGg/E8GIZa3acCHk7EAiOLV/jGF+hEWLEGQWJpuHX0yLFcf6pDFhMlq7va2JmZc9XdH8DGNQDvkyjLGFrpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6fM96td; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6fM96td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041847; x=1757577847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yC1LWMwR6h/vkeDq0xNc2uAGBJt0y0JxjvDlY+/Nv2M=;
  b=L6fM96td+GMDCDGwQnztt0fCEZUjSit299ZE8tlwwFXUyu57QHfgFNA3
   p01/d6VrcyebnkK1NdHAVw2QmCfiuvX20jefvdFmGO5Ml4D5EOEp5cIvN
   9QvFG/YQRTZFrz6XdqhseRFMdcqymzcO20bZoC9S0sS1XcHpqE+bPOe6U
   p5Fc3qz+VW3aMWZQZnxbyGHKpMWsv9m2rGN0MLW8a3aeYDOHvciC12SlB
   pUHRaW3RPZh1P6F946VrOyln4iFxEV28TsP2pQaoKSRtqjHmXsi5qlG/U
   0cksYDUk0CzkLf0oial5R1ydidJj19EEDH1kdcau5pR5g9EoBm5LF1QEi
   Q==;
X-CSE-ConnectionGUID: GLBnVavKTkaBTeEvF5p8bA==
X-CSE-MsgGUID: QFr01wDSQMqG8XPU/SiTQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24321122"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24321122"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:06 -0700
X-CSE-ConnectionGUID: mwOrEa4lR4WKSbPBvccY5A==
X-CSE-MsgGUID: Lc5hWikqRiyEAwE4zpeFHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="97989806"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:01 -0700
Message-ID: <17b837bd-d1b5-48f4-9a16-922b71f195e3@intel.com>
Date: Wed, 11 Sep 2024 11:03:55 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] perf: symbol: generalize vmlinux path searching
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
 <20240725021549.880167-5-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-5-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 05:15, Changbin Du wrote:
> This generalizes the vmlinux path searching logic. Later we will add
> another instance for vdso.
> 
> The search pattern is described by struct dso_filename_pattern, and the
> formatted paths are hold in struct dso_filename_paths.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/machine.c |   4 +-
>  tools/perf/util/symbol.c  | 112 +++++++++++++++++++++-----------------
>  tools/perf/util/symbol.h  |   8 ++-
>  3 files changed, 70 insertions(+), 54 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8477edefc299..68315520f15b 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -896,9 +896,9 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
>  			printed += fprintf(fp, "[0] %s\n", filename);
>  	}
>  
> -	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
> +	for (i = 0; i < vmlinux_paths.nr_entries; ++i) {
>  		printed += fprintf(fp, "[%d] %s\n", i + dso__has_build_id(kdso),
> -				   vmlinux_path[i]);
> +				   vmlinux_paths.paths[i]);
>  	}
>  	return printed;
>  }
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index ad3b7b929e94..6bf75c98e1f2 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -48,8 +48,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_vdso_sym(struct dso *dso, struct map *map);
>  static bool symbol__is_idle(const char *name);
>  
> -int vmlinux_path__nr_entries;
> -char **vmlinux_path;
> +struct dso_filename_paths vmlinux_paths;
>  
>  struct symbol_conf symbol_conf = {
>  	.nanosecs		= false,
> @@ -2042,10 +2041,10 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
>  	char *filename = NULL;
>  
>  	pr_debug("Looking at the vmlinux_path (%d entries long)\n",
> -		 vmlinux_path__nr_entries + 1);
> +		 vmlinux_paths.nr_entries + 1);
>  
> -	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
> -		err = dso__load_vmlinux(dso, map, vmlinux_path[i], false);
> +	for (i = 0; i < vmlinux_paths.nr_entries; ++i) {
> +		err = dso__load_vmlinux(dso, map, vmlinux_paths.paths[i], false);
>  		if (err > 0)
>  			goto out;
>  	}
> @@ -2209,7 +2208,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
>  			return err;
>  	}
>  
> -	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
> +	if (!symbol_conf.ignore_vmlinux && vmlinux_paths.paths != NULL) {
>  		err = dso__load_vmlinux_path(dso, map);
>  		if (err > 0)
>  			return err;
> @@ -2284,57 +2283,55 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
>  	return err;
>  }
>  
> -static void vmlinux_path__exit(void)
> -{
> -	while (--vmlinux_path__nr_entries >= 0)
> -		zfree(&vmlinux_path[vmlinux_path__nr_entries]);
> -	vmlinux_path__nr_entries = 0;
> -
> -	zfree(&vmlinux_path);
> -}
> -
> -static const char * const vmlinux_paths[] = {
> -	"vmlinux",
> -	"/boot/vmlinux"
> +struct dso_filename_pattern {
> +	const char *pattern;
> +	/*
> +	 * 0 for matching directly,
> +	 * 1 for matching by kernel_version,
> +	 * 2 for matching by kernel_version + arch.
> +	 */
> +	int match_type;
>  };
>  
> -static const char * const vmlinux_paths_upd[] = {
> -	"/boot/vmlinux-%s",
> -	"/usr/lib/debug/boot/vmlinux-%s",
> -	"/lib/modules/%s/build/vmlinux",
> -	"/usr/lib/debug/lib/modules/%s/vmlinux",
> -	"/usr/lib/debug/boot/vmlinux-%s.debug"
> +struct dso_filename_pattern vmlinux_patterns[] = {
> +	{"vmlinux", 0},
> +	{"/boot/vmlinux", 0},
> +	{"/boot/vmlinux-%s", 1},
> +	{"/usr/lib/debug/boot/vmlinux-%s", 1},
> +	{"/lib/modules/%s/build/vmlinux", 1},
> +	{"/usr/lib/debug/lib/modules/%s/vmlinux", 1},
> +	{"/usr/lib/debug/boot/vmlinux-%s.debug", 1},
>  };
>  
> -static int vmlinux_path__add(const char *new_entry)
> +static int dso_filename_path__add(struct dso_filename_paths *paths, const char *new_entry)
>  {
> -	vmlinux_path[vmlinux_path__nr_entries] = strdup(new_entry);
> -	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
> +	paths->paths[paths->nr_entries] = strdup(new_entry);
> +	if (paths->paths[paths->nr_entries] == NULL)
>  		return -1;
> -	++vmlinux_path__nr_entries;
> +	++paths->nr_entries;
>  
>  	return 0;
>  }
>  
> -static int vmlinux_path__init(struct perf_env *env)
> +static void dso_filename_path__exit(struct dso_filename_paths *paths)
>  {
> -	struct utsname uts;
> -	char bf[PATH_MAX];
> -	char *kernel_version;
> -	unsigned int i;
> +	while (--paths->nr_entries >= 0)
> +		zfree(&paths->paths[paths->nr_entries]);
> +	paths->nr_entries = 0;
>  
> -	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
> -			      ARRAY_SIZE(vmlinux_paths_upd)));
> -	if (vmlinux_path == NULL)
> -		return -1;
> -
> -	for (i = 0; i < ARRAY_SIZE(vmlinux_paths); i++)
> -		if (vmlinux_path__add(vmlinux_paths[i]) < 0)
> -			goto out_fail;
> +	zfree(&paths->paths);
> +}
>  
> -	/* only try kernel version if no symfs was given */
> -	if (symbol_conf.symfs[0] != 0)
> -		return 0;
> +static int dso_filename_path__init(struct dso_filename_paths *paths,
> +				   struct dso_filename_pattern *patterns,
> +				   int nr_patterns,
> +				   struct perf_env *env)
> +{
> +	struct utsname uts;
> +	char bf[PATH_MAX];
> +	const char *kernel_version;
> +	const char *arch = perf_env__arch(env);
> +	int i;
>  
>  	if (env) {
>  		kernel_version = env->os_release;
> @@ -2345,16 +2342,28 @@ static int vmlinux_path__init(struct perf_env *env)
>  		kernel_version = uts.release;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(vmlinux_paths_upd); i++) {
> -		snprintf(bf, sizeof(bf), vmlinux_paths_upd[i], kernel_version);
> -		if (vmlinux_path__add(bf) < 0)
> +	paths->paths = malloc(sizeof(char *) * nr_patterns);
> +	if (paths->paths == NULL)
> +		return -1;
> +
> +	for (i = 0; i < nr_patterns; i++) {
> +		if (patterns[i].match_type == 0)
> +			strlcpy(bf, patterns[i].pattern, sizeof(bf));
> +		else if (symbol_conf.symfs[0] == 0) {
> +			/* only try kernel version if no symfs was given */
> +			if (patterns[i].match_type == 1)
> +				snprintf(bf, sizeof(bf), patterns[i].pattern, kernel_version);
> +			else if (patterns[i].match_type == 2)
> +				snprintf(bf, sizeof(bf), patterns[i].pattern, kernel_version, arch);
> +		}
> +		if (dso_filename_path__add(paths, bf) < 0)
>  			goto out_fail;
>  	}
>  
>  	return 0;
>  
>  out_fail:
> -	vmlinux_path__exit();
> +	dso_filename_path__exit(paths);
>  	return -1;
>  }
>  
> @@ -2550,8 +2559,11 @@ int symbol__init(struct perf_env *env)
>  
>  	symbol__elf_init();
>  
> -	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
> +	if (symbol_conf.try_vmlinux_path &&
> +	    dso_filename_path__init(&vmlinux_paths, vmlinux_patterns,
> +				    ARRAY_SIZE(vmlinux_patterns), env) < 0) {
>  		return -1;
> +	}
>  
>  	if (symbol_conf.field_sep && *symbol_conf.field_sep == '.') {
>  		pr_err("'.' is the only non valid --field-separator argument\n");
> @@ -2628,7 +2640,7 @@ void symbol__exit(void)
>  	intlist__delete(symbol_conf.tid_list);
>  	intlist__delete(symbol_conf.pid_list);
>  	intlist__delete(symbol_conf.addr_list);
> -	vmlinux_path__exit();
> +	dso_filename_path__exit(&vmlinux_paths);
>  	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
>  	symbol_conf.bt_stop_list = NULL;
>  	symbol_conf.initialized = false;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..30056884945b 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -101,8 +101,12 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
>  
>  #define symbol__join_symfs(bf, path) __symbol__join_symfs(bf, sizeof(bf), path)
>  
> -extern int vmlinux_path__nr_entries;
> -extern char **vmlinux_path;
> +struct dso_filename_paths {
> +	int nr_entries;
> +	char **paths;
> +};

Feels a bit over engineered.  We only need the nth path so
a simpler, more encapsulated API could be just:

const char *vdso_path(size_t i);

Also wonder why the paths cannot just be created by asprint().
e.g. notwithstanding that perf_env__os_release() does not exist:


#define MAX_VDSO_PATHS 8
static char *vdso_paths[MAX_VDSO_PATHS];
static size_t vdso_path__nr_entries;

static int vdso_path__init(struct perf_env *env)
{
	const char *k = perf_env__os_release(env);
	const char *a = perf_env__arch(env);
	int i = 0;

#define PATH_INIT(fmt, ...)						\
	(i < MAX_VDSO_PATHS ? ({					\
		int ret = asprintf(&vdso_paths[i], fmt, ##__VA_ARGS__);	\
		if (ret >= 0) {						\
			i += 1;						\
			ret = 0;					\
		}							\
		ret;							\
	}) : -1)

	if (PATH_INIT("/lib/modules/%s/vdso/vdso.so", k) ||
	    PATH_INIT("/lib/modules/%s/vdso/vdso64.so", k) ||
	    PATH_INIT("/lib/modules/%s/vdso/vdso32.so", k) ||
	    PATH_INIT("/lib/modules/%s/build/arch/%s/vdso/vdso.so.dbg", k, a) ||
	    PATH_INIT("/lib/modules/%s/build/arch/%s/kernel/vdso/vdso.so.dbg", k, a) ||
	    PATH_INIT("/lib/modules/%s/build/arch/%s/entry/vdso/vdso32.so.dbg", k, a) ||
	    PATH_INIT("/lib/modules/%s/build/arch/%s/entry/vdso/vdso64.so.dbg", k, a))
		goto out_err;

#undef PATH_INIT

	vdso_path__nr_entries = i;
	return 0;

out_err:
	while (i)
		zfree(&vdso_paths[--i]);
	return -ENOMEM;
}

static void vdso_path__exit(void)
{
	while (vdso_path__nr_entries)
		zfree(&vdso_paths[--vdso_path__nr_entries]);
}

const char *vdso_path(size_t i)
{
	if (i >= vdso_path__nr_entries)
		return NULL;

	return vdso_paths[i];
}

