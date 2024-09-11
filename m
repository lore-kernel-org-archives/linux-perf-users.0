Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295815383E;
	Wed, 11 Sep 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041893; cv=none; b=JEkHV0B5YUKnxBArkCh1UkL9phki7gmPvmcsiKBN0vhsDQZMPOsklP+2DDD5vwk1hvZ4kWwZ7IpAWNYyzAE6lWBl6InEF6dHthbaahzHcDVMKlplm+UxJMCedM8GJl7kepQGms+fuYnNWI7gGNhBhziNuW9DeVlB7u1qBgRJ6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041893; c=relaxed/simple;
	bh=qMKQRYW+ZOVU2E2v6IlxVBcaffQtNMOJ9iP8k8lHyuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFbsFCNMUcP+9GcoPpkm8qhdH+iiSLKQ7p55ZMyERwYp8WQq5EsIeSTGGUWfwdkngL8gIJfOp5la9ZG72B9TNZYnmeVAP66ievW+FY8Hk02p8hZLgUnWKpshnxfNNwwps55tXogc8PU1YDYdVmQrPBUZOY00wf3Ox6iej7PiwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FucUf4gF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FucUf4gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041891; x=1757577891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qMKQRYW+ZOVU2E2v6IlxVBcaffQtNMOJ9iP8k8lHyuc=;
  b=FucUf4gFkRWPLeGAQvrM68rnNPTSIuG14twXJgdIGSxlDHjjyo6/b7rS
   onmyFhWVCB7FESqcmYs4tmVs10tJhIXQpNggUP/8ZSnecNNgXzQ0vM8xU
   Kvvgy5q9c2SvSzYNMdENtM31erFXe9AtMA7FMpXFWbCJWrUn972Kvs5Lz
   1rLKczpQMPzLC5+drgoRV54EDxuwU3hSfcjH8k+dnWQ9voVdnmhnZDmbd
   eGimrJOtJJRp3yI6wlVXDv8oXNSD9FZrRKGOXmRrjDFGWfrdF3KAkWfw0
   ASGlX+7kzOufKcavR7adVJJJhb9WvVse2ieujrxmRPtldHLzswwlqwevY
   g==;
X-CSE-ConnectionGUID: kJktJpS2QIeHYWn6MsphFw==
X-CSE-MsgGUID: SchrljlfSw2VMDN5OAGMXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24321195"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24321195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:51 -0700
X-CSE-ConnectionGUID: 4ecjI4ecQH6p+a1Xal+z7w==
X-CSE-MsgGUID: nw+dKrcdRayiMuAXcOiQEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="97989945"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:04:45 -0700
Message-ID: <04bd63d3-e76b-4a6e-912c-6306062c91a8@intel.com>
Date: Wed, 11 Sep 2024 11:04:39 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] perf: build-id: extend
 build_id_cache__find_debug() to find local debugging vdso
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
 <20240725021549.880167-7-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-7-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 05:15, Changbin Du wrote:
> Just like vmlinux, try to search vdso in predefined paths when collecting
> build-ids. The searched paths usually have debugging info.
> 
> For example, the vdso can be found in
> /lib/modules/<version>/build/arch/x86/entry/vdso/vdso*.so.dbg for local
> build on x86.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> ---
> v3:
>   - continue to try build_id_cache__find_debug_normal() if
>     build_id_cache__find_debug_vdso() failed.
> v2:
>   - Searching the vdso in record stage instead of report. So the debugging
>     vdso will be in build-id cache. This is friendly for cross-machine
>     analysis.
> ---
>  tools/perf/util/build-id.c | 48 ++++++++++++++++++++++++++++++++++----
>  tools/perf/util/symbol.c   | 17 ++++++++++++++
>  tools/perf/util/symbol.h   |  1 +
>  3 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 5bda47de5cf2..67f88b492279 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -593,9 +593,8 @@ static int build_id_cache__add_sdt_cache(const char *sbuild_id,
>  #define build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) (0)
>  #endif
>  
> -static char *build_id_cache__find_debug(const char *sbuild_id,
> -					struct nsinfo *nsi,
> -					const char *root_dir)
> +static char *build_id_cache__find_debug_normal(const char *sbuild_id,

"normal" is a bit vague.  Perhaps just "__build_id_cache__find_debug"

> +				struct nsinfo *nsi, const char *root_dir)
>  {
>  	const char *dirname = "/usr/lib/debug/.build-id/";
>  	char *realname = NULL;
> @@ -646,6 +645,47 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  	return realname;
>  }
>  
> +static char *build_id_cache__find_debug_vdso(const char *sbuild_id)
> +{
> +	char sbuild_id_tmp[SBUILD_ID_SIZE];
> +	struct build_id bid;
> +	int i, ret = 0;
> +
> +	if (!vdso_paths.paths)
> +		return NULL;
> +
> +	pr_debug("Looking at the vdso_path (%d entries long)\n",
> +		 vdso_paths.nr_entries + 1);
> +
> +	for (i = 0; i < vdso_paths.nr_entries; ++i) {
> +		ret = filename__read_build_id(vdso_paths.paths[i], &bid);
> +		if (ret < 0)
> +			continue;
> +
> +		build_id__sprintf(&bid, sbuild_id_tmp);
> +		if (!strcmp(sbuild_id, sbuild_id_tmp)) {
> +			pr_debug("Found debugging vdso %s\n", vdso_paths.paths[i]);
> +			return strdup(vdso_paths.paths[i]);
> +		}
> +	}

Doesn't cover symfs or mount namespace like the other one does.

> +
> +	return NULL;
> +}
> +
> +static char *build_id_cache__find_debug(const char *sbuild_id,
> +					struct nsinfo *nsi,
> +					bool is_vdso,
> +					const char *root_dir)
> +{
> +	char *name = NULL;
> +
> +	if (is_vdso)
> +		name = build_id_cache__find_debug_vdso(sbuild_id);
> +	if (!name)
> +		name = build_id_cache__find_debug_normal(sbuild_id, nsi, root_dir);
> +	return name;
> +}
> +
>  int
>  build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
>  		    struct nsinfo *nsi, bool is_kallsyms, bool is_vdso,
> @@ -702,7 +742,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>  	 * symtab.
>  	 */
>  	if (!is_kallsyms && strncmp(".ko", name + strlen(name) - 3, 3)) {
> -		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
> +		debugfile = build_id_cache__find_debug(sbuild_id, nsi, is_vdso, root_dir);
>  		if (debugfile) {
>  			zfree(&filename);
>  			if (asprintf(&filename, "%s/%s", dir_name,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6bf75c98e1f2..8e982e68b717 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -49,6 +49,7 @@ static int dso__load_vdso_sym(struct dso *dso, struct map *map);
>  static bool symbol__is_idle(const char *name);
>  
>  struct dso_filename_paths vmlinux_paths;
> +struct dso_filename_paths vdso_paths;
>  
>  struct symbol_conf symbol_conf = {
>  	.nanosecs		= false,
> @@ -2303,6 +2304,16 @@ struct dso_filename_pattern vmlinux_patterns[] = {
>  	{"/usr/lib/debug/boot/vmlinux-%s.debug", 1},
>  };
>  
> +struct dso_filename_pattern vdso_patterns[] = {
> +	{"/lib/modules/%s/vdso/vdso.so", 1},
> +	{"/lib/modules/%s/vdso/vdso64.so", 1},
> +	{"/lib/modules/%s/vdso/vdso32.so", 1},
> +	{"/lib/modules/%s/build/arch/%s/vdso/vdso.so.dbg", 2},
> +	{"/lib/modules/%s/build/arch/%s/kernel/vdso/vdso.so.dbg", 2},
> +	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso32.so.dbg", 2},
> +	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso64.so.dbg", 2},
> +};
> +
>  static int dso_filename_path__add(struct dso_filename_paths *paths, const char *new_entry)
>  {
>  	paths->paths[paths->nr_entries] = strdup(new_entry);
> @@ -2565,6 +2576,11 @@ int symbol__init(struct perf_env *env)
>  		return -1;
>  	}
>  
> +	if (dso_filename_path__init(&vdso_paths, vdso_patterns,
> +				    ARRAY_SIZE(vdso_patterns), env) < 0) {
> +		return -1;
> +	}
> +
>  	if (symbol_conf.field_sep && *symbol_conf.field_sep == '.') {
>  		pr_err("'.' is the only non valid --field-separator argument\n");
>  		return -1;
> @@ -2641,6 +2657,7 @@ void symbol__exit(void)
>  	intlist__delete(symbol_conf.pid_list);
>  	intlist__delete(symbol_conf.addr_list);
>  	dso_filename_path__exit(&vmlinux_paths);
> +	dso_filename_path__exit(&vdso_paths);
>  	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
>  	symbol_conf.bt_stop_list = NULL;
>  	symbol_conf.initialized = false;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 30056884945b..08c339594d4e 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -107,6 +107,7 @@ struct dso_filename_paths {
>  };
>  
>  extern struct dso_filename_paths vmlinux_paths;
> +extern struct dso_filename_paths vdso_paths;
>  
>  static inline void *symbol__priv(struct symbol *sym)
>  {

