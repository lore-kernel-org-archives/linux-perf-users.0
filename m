Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA33346774;
	Wed, 15 Jul 2026 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099527; cv=none; b=SDpIwbTQzQ7A+0oKJOgZ/eEFWifK0/9PK7NzBppq3EWJtQsE+KXHpllLBFRmSOt6Wzi1JkApyFi5LWiWxtWJQcrInBn/IJ1xEs3sAS+gqcn+dn5AfDpRMzrzlpDaTEh1zUvsz4oR8x1PvdTXLQNKSS+DYFFiSoYmwSyvNd6jIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099527; c=relaxed/simple;
	bh=+YAntzbV6lwJTuYG0LSr+44Db2YVOYDdpm7a79dlP/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ78R5DGOMvQHOCfwq+zFUwxEV1Yzd98p+6BOe+le5xEcRzC2GTM5w/g5MC2Q1rNg5ppCe0i2qJHwL7JxmSpSGt+wdbWADZ+fGau63ZF4QSfHVbfr5Et0zrBl7ZAtKzpHB8vyamDiNoHhZHKC4upKUEdu24J80N1URfxiBFdRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMtIiTRa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMtIiTRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784099525; x=1815635525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+YAntzbV6lwJTuYG0LSr+44Db2YVOYDdpm7a79dlP/A=;
  b=PMtIiTRa0KUHY30j6s+A6YKfepTxET6Ot1pjQ/7D/Rw584FSqh3Nyu6K
   4Rwt4cCO8ONw8uN3upxT5Xl+3cr9wNlRzVK70FkaqMN9icdDClV5qh0Cw
   rE4oNnhnLG6WphvBVWEfEecwkV55FclkkktXlPmaZSRD4PWMun8NVMn4u
   yEEpfzknJsonUAI0DaI52pc1Kl3T+HUOzwsKQa4GnQYEEYccAmBggVcbs
   PVTjITej8onzg6Mnf6Yz6Ey2QjVIQMjaHsF0qRC4i4egYGDhmlTAxc8J8
   29VANwqvTUoLymJhN2lKNCDJS2DtXs4sp/FdTpBsngcZKfe9hCAbEyNu7
   A==;
X-CSE-ConnectionGUID: NGWBx9f/TdukmBT17rmfCA==
X-CSE-MsgGUID: S99+3iCVSBWahBMqKjvV+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84845004"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84845004"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:12:04 -0700
X-CSE-ConnectionGUID: 2NKQvjIUSpGyR4L5VyNpyQ==
X-CSE-MsgGUID: KeiqZPByRxO37zEspmHhpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252696093"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:12:01 -0700
Message-ID: <b11641d2-904b-412d-b4fd-9648799ee23e@linux.intel.com>
Date: Wed, 15 Jul 2026 15:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
To: Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-3-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260714004359.179451-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 7/14/2026 8:43 AM, Thomas Falcon wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  tools/perf/util/bpf-filter.l             | 1 +
>  tools/perf/util/mem-events.c             | 5 +++++
>  tools/perf/util/mem-events.h             | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 178f483140ed..b54032efe41c 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -212,7 +212,7 @@ OPTIONS
>  	The <value> can be one of:
>  	  <number> (for any term)
>  	  na, load, store, pfetch, exec (for mem_op)
> -	  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> +	  l0, l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>  	  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>  	  remote (for mem_remote)
>  	  na, locked (for mem_locked)
> diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
> index 6aa65ade3385..1be9df6550fc 100644
> --- a/tools/perf/util/bpf-filter.l
> +++ b/tools/perf/util/bpf-filter.l
> @@ -131,6 +131,7 @@ store		{ return constant(PERF_MEM_OP_STORE); }
>  pfetch		{ return constant(PERF_MEM_OP_PFETCH); }
>  exec		{ return constant(PERF_MEM_OP_EXEC); }
>  
> +l0		{ return constant(PERF_MEM_LVLNUM_L0); }
>  l1		{ return constant(PERF_MEM_LVLNUM_L1); }
>  l2		{ return constant(PERF_MEM_LVLNUM_L2); }
>  l3		{ return constant(PERF_MEM_LVLNUM_L3); }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4e490f9cd348..4fd48fd20055 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] = {
>  	[PERF_MEM_LVLNUM_L4] = "L4",
>  	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
>  	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
> +	[PERF_MEM_LVLNUM_L0] = "L0",
>  	[PERF_MEM_LVLNUM_UNC] = "Uncached",
>  	[PERF_MEM_LVLNUM_CXL] = "CXL",
>  	[PERF_MEM_LVLNUM_IO] = "I/O",
> @@ -831,6 +832,8 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
>  		}
>  	case PERF_MEM_STAT_CACHE:
>  		switch (src.mem_lvl_num) {
> +		case PERF_MEM_LVLNUM_L0:
> +			return MEM_STAT_CACHE_L0;
>  		case PERF_MEM_LVLNUM_L1:
>  			return MEM_STAT_CACHE_L1;
>  		case PERF_MEM_LVLNUM_L2:
> @@ -915,6 +918,8 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
>  		}
>  	case PERF_MEM_STAT_CACHE:
>  		switch (idx) {
> +		case MEM_STAT_CACHE_L0:
> +			return "L0";
>  		case MEM_STAT_CACHE_L1:
>  			return "L1";
>  		case MEM_STAT_CACHE_L2:
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 5b98076904b0..daa22748f9fe 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -109,6 +109,7 @@ enum mem_stat_op {
>  };
>  
>  enum mem_stat_cache {
> +	MEM_STAT_CACHE_L0,
>  	MEM_STAT_CACHE_L1,
>  	MEM_STAT_CACHE_L2,
>  	MEM_STAT_CACHE_L3,
