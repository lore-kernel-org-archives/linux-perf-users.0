Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2F3A5431;
	Tue, 28 Jul 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259122; cv=none; b=TEcz5XdYKwIVhZRNxhGCRUZZ/5x6n7VE7f+9boogi1KKRLzHI1fUHQ+lV9R220OhQA92uZAIGpy6ubXY74edQnxGJgt74Hs0khoLqqhj54y2QkrfYVWU32IJrYiDKvmUnYTxCblzv8H9j1yRGVZE5lnl6eZ1ai8CukwSWDv1b/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259122; c=relaxed/simple;
	bh=/1Dw/cJW7seUIiifVyXrYEc+5cti/kysMYzgCr3B/bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtG8CJPPaO/9XUJcux/wR9NOJ/HxtQ3En9z61iMnJ/r6ad0lbNxBVLEnST7fF/nWhpaUigTHTbhtLXjn3zhdA4fFr9Wuopt8f0GfYFLD2mOWvZpkZiA45rT0cSkhSHLIQQlpLyIZiiXXWFnJEScJ0ERdNbsP8rqtEaXhuFh/+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGM9SxE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGM9SxE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFBD1F000E9;
	Tue, 28 Jul 2026 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259121;
	bh=yAm9jRupU6rYpMiEpul6f0uTZFNuxgamB6+BBspHo5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGM9SxE7OA8OSflN6635JPwWnuKaJpxsyo8vT/8lvUotg5O2SqpuDd1hpvkyFNg6i
	 mqKFRAXEI8CVp4KHfVnMS6uR78GIbpALVURiMzPCd5xgNr8Ko+XP+Rq525fMht3Y66
	 EnBkuOtET4NFRS1fVeQHNlvQApi93JX6Vuc2p3W7ag0HpHKWC2r/XqY7+XSevCRDjZ
	 XqVApFUCZapfxXv/2VHd022p5nSxqetIsSSkxc6XpWypGxLRVT5pKpuUYFtbrgqqng
	 1B/REJ2/lz2ILaeT0gstLovW+C6MXUYTIlx0UO+wqQLjpl7PgXcM9wHczxO8HBL4bp
	 sZdE+5P0t7p4w==
Date: Tue, 28 Jul 2026 10:18:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 4/6] perf tools: Show memory region in perf-script
 subcommand
Message-ID: <amjkb_AGLUTB7GAx@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-5-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714004359.179451-5-thomas.falcon@intel.com>

On Mon, Jul 13, 2026 at 07:43:57PM -0500, Thomas Falcon wrote:
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
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> Changes in v2:
> -- increased buffers passed to perf_script__meminfo_scnprintf() from 150
>    to 200 bytes to avoid silent truncation
> ---
>  tools/perf/builtin-script.c                   |  8 +--
>  tools/perf/util/mem-events.c                  | 68 +++++++++++++++++++
>  .../scripting-engines/trace-event-python.c    |  4 +-
>  3 files changed, 74 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index f91d8b1fbd01..ba8ec0093f4f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2081,8 +2081,8 @@ static int evlist__max_name_len(struct evlist *evlist)
>  static int data_src__fprintf(u64 data_src, FILE *fp)
>  {
>  	struct mem_info *mi = mem_info__new();
> -	char decode[100];
> -	char out[100];
> +	char decode[200];
> +	char out[200];
>  	static int maxlen;
>  	int len;
>  
> @@ -2090,10 +2090,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
>  		return -ENOMEM;
>  
>  	mem_info__data_src(mi)->val = data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 200, mi);
>  	mem_info__put(mi);
>  
> -	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
> +	len = scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);
>  	if (maxlen < len)
>  		maxlen = len;
>  
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd20055..ff08f1fee0e3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -604,6 +604,72 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
>  	return l;
>  }
>  
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
> +{
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
> +		l += scnprintf(out + l, sz - l, " N/A");
> +		break;
> +	case PERF_MEM_REGION_L_SHARE:
> +		l += scnprintf(out + l, sz - l, " Local-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_L_NON_SHARE:
> +		l += scnprintf(out + l, sz - l, " Local-non-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_O_IO:
> +		l += scnprintf(out + l, sz - l, " Other-IO");
> +		break;
> +	case PERF_MEM_REGION_O_SHARE:
> +		l += scnprintf(out + l, sz - l, " Other-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_O_NON_SHARE:
> +		l += scnprintf(out + l, sz - l, " Other-non-shared-cache");
> +		break;
> +	case PERF_MEM_REGION_MMIO:
> +		l += scnprintf(out + l, sz - l, " MMIO");
> +		break;
> +	case PERF_MEM_REGION_MEM0:
> +		l += scnprintf(out + l, sz - l, " Mem-0");
> +		break;
> +	case PERF_MEM_REGION_MEM1:
> +		l += scnprintf(out + l, sz - l, " Mem-1");
> +		break;
> +	case PERF_MEM_REGION_MEM2:
> +		l += scnprintf(out + l, sz - l, " Mem-2");
> +		break;
> +	case PERF_MEM_REGION_MEM3:
> +		l += scnprintf(out + l, sz - l, " Mem-3");
> +		break;
> +	case PERF_MEM_REGION_MEM4:
> +		l += scnprintf(out + l, sz - l, " Mem-4");
> +		break;
> +	case PERF_MEM_REGION_MEM5:
> +		l += scnprintf(out + l, sz - l, " Mem-5");
> +		break;
> +	case PERF_MEM_REGION_MEM6:
> +		l += scnprintf(out + l, sz - l, " Mem-6");
> +		break;
> +	case PERF_MEM_REGION_MEM7:
> +		l += scnprintf(out + l, sz - l, " Mem-7");
> +		break;
> +	default:
> +		l += scnprintf(out + l, sz - l, " N/A");
> +		break;
> +	}
> +
> +	return l;
> +}
> +
>  int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
>  {
>  	int i = 0;
> @@ -620,6 +686,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
>  	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|BLK ");
>  	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +	i += scnprintf(out + i, sz - i, "|Region ");
> +	i += perf_mem__region_scnprintf(out + i, sz - i, mem_info);

Same thing.  Would be nice if it can be conditional.

Thanks,
Namhyung

>  
>  	return i;
>  }
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 8f832ae316ca..57ec259897e4 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -695,7 +695,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
>  				      struct perf_sample *sample)
>  {
>  	struct mem_info *mi = mem_info__new();
> -	char decode[100];
> +	char decode[200];
>  
>  	if (!mi)
>  		Py_FatalError("couldn't create mem-info");
> @@ -704,7 +704,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
>  			PyLong_FromUnsignedLongLong(sample->data_src));
>  
>  	mem_info__data_src(mi)->val = sample->data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 200, mi);
>  	mem_info__put(mi);
>  
>  	pydict_set_item_string_decref(dict, "datasrc_decode",
> -- 
> 2.43.0
> 
