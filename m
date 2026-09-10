Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995433557D;
	Thu, 10 Sep 2026 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006980; cv=none; b=IJJPLDuPmhSqqTJsU9NfU06bhWzgMSNLrYZ2dBuykCEbx+Yl1CLNpYr+QdUQgKIa2cDnDZ+vrtu/31g/FmvphKvlN9aol8ZTN0a/TPl/qecQ8lKHMZCMCx88x+TWqK4XZKEGn5+kTKg6o0gQ8MTDBt/8pSzebBqiq+ogBUSxZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006980; c=relaxed/simple;
	bh=8ERJE0jevKkO2RVEhRtlrtgxqA80hCw0UIp+ZVJwqyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi+xbcve6EmxN8vr9n5of393yTRyTUco8kvxvZ4w+ag1L72258Ecy1D83C+fyrHvktr9V/f1cRn/uJOpq7icIwCH9s30yWTzLTGbrI9rlDJh/GU2ElkWh3FlXIym4r4gFqIXWJ2Udou8YndbsudDdkxzJ4aTvO+psNUDJ35cpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzSzWMoj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzSzWMoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789006979; x=1820542979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ERJE0jevKkO2RVEhRtlrtgxqA80hCw0UIp+ZVJwqyE=;
  b=RzSzWMojpEMp2/Y0rT5bpidVsKNWq6UkMJijYGzp4VDfvD6uFO5MLo1m
   sDuCmjL44wNPcFn3CTVCopO///FIg8spx+XOpq74soeXmT4u2tMRYPLBN
   Aow6Js+Cp7/UC/fbYinNfO1TzNrRrIzUBT8Dl/reGWwK1b9oPlltlgRvL
   4ZjTI9Z2n6oomQzJNs26qnOKvFxYNycm9Rj20xijBjVrDAXkKzabYUrmZ
   JXVSU9RHsCZf9Hh8KOoktjL9RJp7swx+xXsMBOF4FqoZoVqdEARYeoYEU
   NceRDWvLJDp0bSTgxfOKj9ln+FrhHanqK1TPlGBRDkAI8+X0eRukcdo5m
   A==;
X-CSE-ConnectionGUID: YWdiiD+oTKW8Je+ouYhTNQ==
X-CSE-MsgGUID: 4Y0VHlblQY6K6yoPmZtkCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89292511"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89292511"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:22:58 -0700
X-CSE-ConnectionGUID: FobBjntTR3WYogbgGVyLqw==
X-CSE-MsgGUID: z0VEw9YpShOwf1cIcb7b/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275256919"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:22:55 -0700
Message-ID: <c867ffcd-d2de-49a5-977c-5579b1029ca9@linux.intel.com>
Date: Thu, 10 Sep 2026 10:22:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] perf tools: Show memory region in perf-script
 subcommand
To: Thomas Falcon <thomas.falcon@intel.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-6-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260909160218.174928-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/10/2026 12:02 AM, Thomas Falcon wrote:
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
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add your "Co-developed-by" tag here. Thanks.


> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
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
