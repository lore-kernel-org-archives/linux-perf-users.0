Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22C17FD;
	Thu,  8 Aug 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115569; cv=none; b=hsxUepD6ssvdzzmgYeNUcjfBLz3gEwepkLtkfQYL2EWs+Lt0UIFdy84eEBlwMXNPHfzmlOtaCX5ztiaALLDCSQAcSwvVAmv5xYKopmAL6Z2dRC4Hg+aBa28frDDsicgipqWNRQoHBgq5k6dKWBFWSUQEKZmRbowKmNy65tEf7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115569; c=relaxed/simple;
	bh=hve/sLIedZ/7OwEbxUW7nOAwAuDnbF9YZxcJcFWT4Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWx1WfR36y6QHepWaWl0LWGhvXwHHTsEes/F9GrkmXW2ka1T4oilOa8CAyHBh5a3eSMmKSLuEGjidZ5SlTuE/JxLUtkuwimLmay9PgYZ7IznkslS42WLZVUioP2XtgXmV8tORQsTHAKhGelibCCzK8hql5njSd5qEfhujJYEDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAvjiZe3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAvjiZe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723115568; x=1754651568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hve/sLIedZ/7OwEbxUW7nOAwAuDnbF9YZxcJcFWT4Gs=;
  b=RAvjiZe3ZKZfodXUilFqsr0n+dKoG/XZT0luFZtL8k4Eo65nP+YgT7j4
   rOFbxSwbLfHzhVU3ZIDcva+JrKNV3euS2X7x4aQ/Z2SMNUf8d8JTT/Gf3
   OM0JEtOtEB7ovcms4IGIty+NlYg4sNwi1KS/Ifr6kC/o7Lvbp2bqpZD3X
   jv+6dDjFHWDG9LEDBLO1E8x9bWXvZseWSvAdIrpNzoLP4tBxXPbpDK6BD
   2DrGWMFYO1qJ2LNlf3qvJu+RMREm4sm2695F4KmlKCsLg2ewvkbjqu/ak
   wZqYhBiZfb6VBLQDmBvmoMwM5RZSe9q+rNoUyBWf8puLCA0HAo68x0iIU
   A==;
X-CSE-ConnectionGUID: sEir1PfcT+elR5vfuLDPCg==
X-CSE-MsgGUID: 2FH5wNWRT/SOXIXzDTpEyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21091977"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21091977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:12:47 -0700
X-CSE-ConnectionGUID: eRQQvbl2QU2UaOfjSf/lFw==
X-CSE-MsgGUID: bCj3M3+SSKGCr9oXhgM0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57054756"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:12:43 -0700
Message-ID: <95455271-83dc-4765-b5b8-0851a75b9164@intel.com>
Date: Thu, 8 Aug 2024 14:12:35 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script python: Add the ins_lat field to event
 handler
To: Zixian Cai <fzczx123@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240808080027.3559776-1-fzczx123@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240808080027.3559776-1-fzczx123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/08/24 11:00, Zixian Cai wrote:
> For example, when using the Alder Lake PMU memory load event, the
> instruction latency is stored in ins_lat, while the cache latency is
> stored in weight.
> 
> This patch reports the ins_lat field for Python scripting.

Patch does not apply.

Needs to be based on upstream kernel.  Latest perf tools kernel
tree and branch is:

	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git	perf-tools-next

> 
> Signed-off-by: Zixian Cai <fzczx123@gmail.com>
> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 41d4f9e6a..68eb0586c 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -861,6 +861,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	set_sample_read_in_dict(dict_sample, sample, evsel);
>  	pydict_set_item_string_decref(dict_sample, "weight",
>  			PyLong_FromUnsignedLongLong(sample->weight));
> +	pydict_set_item_string_decref(dict_sample, "ins_lat",
> +			PyLong_FromUnsignedLongLong(sample->ins_lat));
>  	pydict_set_item_string_decref(dict_sample, "transaction",
>  			PyLong_FromUnsignedLongLong(sample->transaction));
>  	set_sample_datasrc_in_dict(dict_sample, sample);
> @@ -1286,7 +1288,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	struct tables *tables = container_of(dbe, struct tables, dbe);
>  	PyObject *t;
> 
> -	t = tuple_new(25);
> +	t = tuple_new(26);
> 
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> @@ -1313,6 +1315,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	tuple_set_d64(t, 22, es->sample->insn_cnt);
>  	tuple_set_d64(t, 23, es->sample->cyc_cnt);
>  	tuple_set_s32(t, 24, es->sample->flags);
> +	tuple_set_s32(t, 25, es->sample->ins_lat);
> 
>  	call_object(tables->sample_handler, t, "sample_table");
> 
> --
> 2.25.1
> 

