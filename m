Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89512246BCD;
	Fri, 11 Sep 2026 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789087892; cv=none; b=G4T5b/3YjqEedNug5zBwfSJpk+H3p4k5qUNN4Z+Hh2wuVBOydXD6g6gMi2Ej9b7Et8XX7rCyEkwla2Ry3a4BEmue6sCTH+T29tOOQ6q/aEHW2ORxabcWkZO4O9m49+cl5Itw2cW0xF55DLYOTRbm2THVLX1NNvEteQkRJyaZhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789087892; c=relaxed/simple;
	bh=h3n4l978Fvf/6Y9f9VYlYnjs/5zhd96GSmhF0W0LU4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtKR+5r2p1KK0HoH8lYdgmRQKIyRrygsc3q91gvc9j/XjQLFZzb3hEEKTz18YUQLWC5t+Lud2Y/XO+l5/W9VbK3B02snKzzxi17MdVWr4nLmKZa9QMxqnrZgMc0FcH8HS0NtR66mcLFEomFkn8rbmX92Eg16X+MDayQYxgTfvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdnsrAin; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdnsrAin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789087891; x=1820623891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3n4l978Fvf/6Y9f9VYlYnjs/5zhd96GSmhF0W0LU4A=;
  b=OdnsrAinbNk0+WSwUEIHw6/GIGBoZ0LtJXTLlrm3ZKeLGDTe5Q8fXPGw
   eG3bDiVC+zzqPGAmeHrC1XIhKycf517oekMVb3dHfS8yyrwjj4Vfsmj9g
   S8+uzqZG6DFF4Ws//MSyxb+1EAIFg5DhlHcmGhJaTraepET1YkTIRAh7g
   +/CLLgyhbKc/QghJ6e3D0/3f4C//XMGw9ZEkIN+tfnsfHHoI9xnQ3f0Nz
   GOgn7gT1mGA8pwU3xCfDubZ07GIZc1yJGZvJAXktptr8yrQ23oiKL9oai
   wp/+i+Gun9A0IBe7kH8mE9OWFK5q/9athjrn959uh3ydDbciyeOpdcq6v
   A==;
X-CSE-ConnectionGUID: Qw6INAD3QyWAWLP0Q77frQ==
X-CSE-MsgGUID: IzzFzx7AQ3SZO7R4tydVLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89762152"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89762152"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:51:30 -0700
X-CSE-ConnectionGUID: o2mnfWCgReCXqH6LJyallA==
X-CSE-MsgGUID: 9imXuhMlQQW3YJ5n34KZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="147309"
Received: from unknown (HELO [10.238.3.121]) ([10.238.3.121])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:51:27 -0700
Message-ID: <57502b47-49f4-4d23-b0da-5e312431af47@linux.intel.com>
Date: Fri, 11 Sep 2026 08:51:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] perf tools: Show memory region in perf-script
 subcommand
To: Thomas Falcon <thomas.falcon@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-6-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260910194324.98002-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/11/2026 3:43 AM, Thomas Falcon wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Show the memory region in perf-script subcommand. Memory region is found
> in the mem_region field of the memory information data source. This
> field was included with the introduction of support for the Off-module
> Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
> Architectures.
>
> An example of perf-script output with the new memory region field is shown
> below:
>
>       thread 5/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache              ffffffff9f002aba
>       thread 2/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache              ffffffff9dc54c95
>       thread 8/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Other-non-shared-cache          ffffffff9dc54db3
>       thread 0/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  Addr|Region N/A                       ffffffff9dc54db3
>       thread 2/0 ...	|OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region N/A                            ffffffff9f002a8c
>       thread 0/0 ...	|OP LOAD|LVL L3 hit|SNP HitM or Fwd|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-non-shared-cache   ffffffff9f002aba
>       thread 0/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache          ffffffff9dc54ca7
>      thread 30/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region N/A                       ffffffff9dcc1ff2
>      thread 30/0 ...	|OP LOAD|LVL RAM hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Mem-0                          ffffffff9dc54c95
>      thread 19/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A|Region N/A                        ffffffff9f002cbb
>      thread 19/0 ...	|OP LOAD|LVL L3 hit|SNP HitM or Fwd|TLB L1 or L2 hit|LCK No|BLK  N/A|Region Local-non-shared-cache   ffffffff9f002aba
>
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Codeveloped-by: Thomas Falcon <thomas.falcon@intel.com>

Same issue with previous patch. Thanks.


> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v8: Update developer tags and commit message with real example output
> v4: Drop the global show-region flag; pass perf_session to
>     perf_script__meminfo_scnprintf() and gate the Region field
>     on the feature bit, with a pipe-mode fallback
>
> v3: make memory region reporting conditional on feature bit
> ---
>  tools/perf/builtin-script.c                   | 13 +--
>  tools/perf/util/mem-events.c                  | 86 ++++++++++++++++++-
>  tools/perf/util/mem-events.h                  |  4 +-
>  .../scripting-engines/trace-event-python.c    |  5 +-
>  4 files changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index ad8ca08ceb5f..c7454155038d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2078,11 +2078,12 @@ static int evlist__max_name_len(struct evlist *evlist)
>  	return max;
>  }
>  
> -static int data_src__fprintf(u64 data_src, FILE *fp)
> +static int data_src__fprintf(struct perf_session *session,
> +			     u64 data_src, FILE *fp)
>  {
>  	struct mem_info *mi = mem_info__new();
> -	char decode[100];
> -	char out[100];
> +	char decode[200];
> +	char out[200];
>  	static int maxlen;
>  	int len;
>  
> @@ -2090,10 +2091,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
>  		return -ENOMEM;
>  
>  	mem_info__data_src(mi)->val = data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 200, mi, session);
>  	mem_info__put(mi);
>  
> -	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
> +	len = scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);
>  	if (maxlen < len)
>  		maxlen = len;
>  
> @@ -2487,7 +2488,7 @@ static void process_event(struct perf_script *script,
>  		perf_sample__fprintf_addr(sample, thread, evsel, fp);
>  
>  	if (PRINT_FIELD(DATA_SRC))
> -		data_src__fprintf(sample->data_src, fp);
> +		data_src__fprintf(evsel__session(evsel), sample->data_src, fp);
>  
>  	if (PRINT_FIELD(WEIGHT))
>  		fprintf(fp, "%16" PRIu64, sample->weight);
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd20055..8ce4996cad8d 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -604,8 +604,77 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
>  	return l;
>  }
>  
> -int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
>  {
> +	size_t l = 0;
> +	u64 mem = PERF_MEM_REGION_NA;
> +
> +	sz -= 1; /* -1 for null termination */
> +	out[0] = '\0';
> +
> +	if (mem_info)
> +		mem = mem_info__const_data_src(mem_info)->mem_region;
> +
> +	switch (mem) {
> +	case PERF_MEM_REGION_NA:
> +	case PERF_MEM_REGION_RSVD:
> +		l += scnprintf(out + l, sz - l, "N/A");
> +		break;
> +	case PERF_MEM_REGION_L_SHARE:
> +		l += scnprintf(out + l, sz - l, "Local-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_L_NON_SHARE:
> +		l += scnprintf(out + l, sz - l, "Local-non-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_O_IO:
> +		l += scnprintf(out + l, sz - l, "Other-IO");
> +		break;
> +	case PERF_MEM_REGION_O_SHARE:
> +		l += scnprintf(out + l, sz - l, "Other-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_O_NON_SHARE:
> +		l += scnprintf(out + l, sz - l, "Other-non-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_MMIO:
> +		l += scnprintf(out + l, sz - l, "MMIO");
> +		break;
> +	case PERF_MEM_REGION_MEM0:
> +		l += scnprintf(out + l, sz - l, "Mem-0");
> +		break;
> +	case PERF_MEM_REGION_MEM1:
> +		l += scnprintf(out + l, sz - l, "Mem-1");
> +		break;
> +	case PERF_MEM_REGION_MEM2:
> +		l += scnprintf(out + l, sz - l, "Mem-2");
> +		break;
> +	case PERF_MEM_REGION_MEM3:
> +		l += scnprintf(out + l, sz - l, "Mem-3");
> +		break;
> +	case PERF_MEM_REGION_MEM4:
> +		l += scnprintf(out + l, sz - l, "Mem-4");
> +		break;
> +	case PERF_MEM_REGION_MEM5:
> +		l += scnprintf(out + l, sz - l, "Mem-5");
> +		break;
> +	case PERF_MEM_REGION_MEM6:
> +		l += scnprintf(out + l, sz - l, "Mem-6");
> +		break;
> +	case PERF_MEM_REGION_MEM7:
> +		l += scnprintf(out + l, sz - l, "Mem-7");
> +		break;
> +	default:
> +		l += scnprintf(out + l, sz - l, "N/A");
> +		break;
> +	}
> +
> +	return l;
> +}
> +
> +int perf_script__meminfo_scnprintf(char *out, size_t sz,
> +				   const struct mem_info *mem_info,
> +				   struct perf_session *session)
> +{
> +	struct perf_env *env;
>  	int i = 0;
>  
>  	i += scnprintf(out, sz, "|OP ");
> @@ -620,6 +689,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
>  	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|BLK ");
>  	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +	if (session) {
> +		/*
> +		 * In case the feature bits are not available, as in
> +		 * pipe mode, fallback to checking for the existence of
> +		 * memory ranges
> +		 */
> +		env = perf_session__env(session);
> +		if ((env && session->data->is_pipe && env->nr_memory_ranges) ||
> +		    perf_header__has_feat(&session->header,
> +					  HEADER_MEMORY_RANGES)) {
> +			i += scnprintf(out + i, sz - i, "|Region ");
> +			i += perf_mem__region_scnprintf(out + i, sz - i,
> +							mem_info);
> +		}
> +	}
>  
>  	return i;
>  }
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fe..4ebb8109fc3c 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
>  
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"
>  
>  struct perf_mem_event {
>  	bool		supported;
> @@ -47,7 +48,8 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
>  int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
>  int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
>  
> -int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info);
> +int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct mem_info *mem_info,
> +				   struct perf_session *session);
>  
>  struct c2c_stats {
>  	u32	nr_entries;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 8f832ae316ca..e359fe529586 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -694,8 +694,9 @@ static void set_sample_read_in_dict(PyObject *dict_sample, struct perf_sample *s
>  static void set_sample_datasrc_in_dict(PyObject *dict,
>  				      struct perf_sample *sample)
>  {
> +	struct perf_session *session = evsel__session(sample->evsel);
>  	struct mem_info *mi = mem_info__new();
> -	char decode[100];
> +	char decode[200];
>  
>  	if (!mi)
>  		Py_FatalError("couldn't create mem-info");
> @@ -704,7 +705,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
>  			PyLong_FromUnsignedLongLong(sample->data_src));
>  
>  	mem_info__data_src(mi)->val = sample->data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 200, mi, session);
>  	mem_info__put(mi);
>  
>  	pydict_set_item_string_decref(dict, "datasrc_decode",
