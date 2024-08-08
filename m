Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50CB674;
	Thu,  8 Aug 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132234; cv=none; b=SIibD3vIENGgwW7EDVNlEx55Jc15etju1zsSJwyoMoo6S9aN3tWhuvxdMT4XZrlEb5E67XKx2TI8aDq5DzfW5ZFS+qU1wCiGdT4rStvWNLvts5Z90KlswqSNMW5faNQW3g4pEiq4oqR9LPie5JBw167mhfhd4L+jXGjNkOBK1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132234; c=relaxed/simple;
	bh=cF8lG+FljttAPs/y7T3E1OAF1orNiDt90PQJ2Ifk7jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH6Y1oZmgZwqRGIR8T1B5ZZAcnFgrH3yt9b9pqwHq+l44wqImHtBw/2tkrOC3hStrCWL6ek/+z78gu7dmiweptB+Ca0uTR+6xQsyIz03npzBzLzbuFaPkb49/P0//UF3F61krSlAS86uH/KdHn0iokR37w8gG9ohZr2OesXXuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPy6f5qM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPy6f5qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723132232; x=1754668232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cF8lG+FljttAPs/y7T3E1OAF1orNiDt90PQJ2Ifk7jw=;
  b=BPy6f5qMF3ww5cB2tD3M6iIAkMskD6pvp2uSn6UAvn3irbqFdzpOLqTn
   PLeTU4K1bi30MnNxt1AEyirOm2W3DTxLijQvl0UHfV0HplVu+GLY7JgXI
   2zqINjskm/PFuCg1FIRD6xMI1YRuj9gqO8hBtJU3+c4oSPWhYv7GSYYtf
   /UUM7SzDZkmazZKypXvyrXRKygvEUv0pVPM843nHwIHjh99HsSww5x8q4
   FLrcCmI4Z4OrUvj8Cre1Whm5mouhiv0/9Hk65krNHfEX4AwOa8X38dqgY
   tH3XdfWek2ZeOp24rK80zwWUx7WiPDcW43sh0ZZQ0NZCIFzF5GSkddkj5
   A==;
X-CSE-ConnectionGUID: bPLUh+/ASfGPgZcx25lOaw==
X-CSE-MsgGUID: 84Rm1WN4QNGvhuTPrYInVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31896400"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="31896400"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:50:30 -0700
X-CSE-ConnectionGUID: nHltjxwwT4qi6FZJTYhgVA==
X-CSE-MsgGUID: Kkdea4OwQsayntjDZLlq6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57168146"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:50:24 -0700
Message-ID: <8be2eeaf-9c85-4a77-b66d-53dd1b35bf91@intel.com>
Date: Thu, 8 Aug 2024 18:50:16 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script python: Add the ins_lat field to event
 handler
To: Zixian Cai <fzczx123@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Paran Lee <p4ranlee@gmail.com>,
 Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240808133208.3577910-1-fzczx123@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240808133208.3577910-1-fzczx123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/08/24 16:32, Zixian Cai wrote:
> For example, when using the Alder Lake PMU memory load event, the instruction latency is stored in ins_lat, while the cache latency is stored in weight.
> 
> This patch reports the ins_lat field for Python scripting.
> 
> Signed-off-by: Zixian Cai <fzczx123@gmail.com>

Minor comments, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2) rebase on top of perf-tools-next
> 
>  tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index fb00f3ad6815..c9e8dbd6feb5 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -888,6 +888,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	set_sample_read_in_dict(dict_sample, sample, evsel);
>  	pydict_set_item_string_decref(dict_sample, "weight",
>  			PyLong_FromUnsignedLongLong(sample->weight));
> +	pydict_set_item_string_decref(dict_sample, "ins_lat",
> +			PyLong_FromUnsignedLongLong(sample->ins_lat));

ins_lat is u16 so it could be PyLong_FromUnsignedLong()

>  	pydict_set_item_string_decref(dict_sample, "transaction",
>  			PyLong_FromUnsignedLongLong(sample->transaction));
>  	set_sample_datasrc_in_dict(dict_sample, sample);
> @@ -1317,7 +1319,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	struct tables *tables = container_of(dbe, struct tables, dbe);
>  	PyObject *t;
> 
> -	t = tuple_new(27);
> +	t = tuple_new(28);
> 
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> @@ -1346,6 +1348,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	tuple_set_s32(t, 24, es->sample->flags);
>  	tuple_set_d64(t, 25, es->sample->id);
>  	tuple_set_d64(t, 26, es->sample->stream_id);
> +	tuple_set_s32(t, 27, es->sample->ins_lat);

ins_lat is u16 so it could be tuple_set_u32()

> 
>  	call_object(tables->sample_handler, t, "sample_table");
> 
> --
> 2.25.1
> 

