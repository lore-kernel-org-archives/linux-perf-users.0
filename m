Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACB2F32;
	Tue, 26 Nov 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626571; cv=none; b=W4A+6Ma2KA5MnnhWRs+vsmup0Aj1vGZNXV/dL936+BvpD61syj2jkxsmcg2MCO4GxuhxndFhe4diIM7tgeGzWxmwWGrJd3rfeMQ2yvUm+gCA08RHoc3XvS+6GyQyyvof8exbbJSO8PXjxSje8z/TbP+QHE2RYO7zBYm3HNvXE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626571; c=relaxed/simple;
	bh=l/a9+u1Z59XnAVj0KBuyUltnf6pNT7RrDFDLZh6hxOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGJJ73XuMx+3rXDouKZeiKKk4lrcLLtjH/j8MVv7XocyPYNFiFsXashROpyFbb05ifmL0Ro5YS7oRR28TYtIo5g5TCZS9hot4WkjWSh+d3OZE4yN9YHKSlD3sAyC83oFLVJbT06w+8Cic0t86Gt6JeIuUbdewp+n1KZEW4Rad6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSawjxQo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSawjxQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732626569; x=1764162569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l/a9+u1Z59XnAVj0KBuyUltnf6pNT7RrDFDLZh6hxOE=;
  b=aSawjxQoDkP8m1agieVQGxa6tNIzvNwgUUols6n8EQfCkJQdsBKx7O9J
   ys8AVa9N4RAJMRHroq5XOOJ7nYQSkDXIkqb0MefEPtlhkXZq+rPdVJjQ9
   fv0I3Gk70HmKk3ZvYw7GCNUe6iGsQKMBfjPT38EDpNyTJwlNc/SdTPKYG
   CuceRLN5GwTNciex8oik9oYxsOLx/ppd3MkDBa4aec2o94Y8lfFewafpa
   Onw2EQ7/RwDxI4pI3zWVU+Ul0/OBGAy6JOtIGzUqqUtjs66srJX60HbrH
   /PYJmOmm9Z5aGJhem8B+oZFvQtDeEigtPr8kk8q36ck2OkPegDDr34JaL
   w==;
X-CSE-ConnectionGUID: RCnYc27PS8e7HrvHwl3FMA==
X-CSE-MsgGUID: rNqj3ForTUuPOtYuasy6dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50193174"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="50193174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:09:29 -0800
X-CSE-ConnectionGUID: FcSE1Y73Sg6T9hxQi2eCpQ==
X-CSE-MsgGUID: pL/lCiXySQern+h3FXVqYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="96034742"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:09:25 -0800
Message-ID: <63eb3609-33fc-41d0-9ffa-46ae3638ec92@intel.com>
Date: Tue, 26 Nov 2024 15:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf intel-pt: cleanup unneeded return variable in
 intel_pt_text_poke()
To: guanjing <guanjing@cmss.chinamobile.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com, algonell@gmail.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121111414.33760-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241121111414.33760-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/24 13:14, guanjing wrote:
> Removed Unneeded variable: "ret".
> 
> Since the function intel_pt_text_poke() always returns zero,
> drop the return value and change the function to the void type.
> 
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/intel-pt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 30be6dfe09eb..a13add0e0be4 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3391,7 +3391,7 @@ static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
>  }
>  
>  /* Invalidate all instruction cache entries that overlap the text poke */
> -static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
> +static void intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  {
>  	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  	u64 addr = event->text_poke.addr + event->text_poke.new_len - 1;
> @@ -3402,7 +3402,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	struct machine *machine = pt->machine;
>  	struct intel_pt_cache_entry *e;
>  	u64 offset;
> -	int ret = 0;
>  
>  	addr_location__init(&al);
>  	if (!event->text_poke.new_len)
> @@ -3443,7 +3442,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	}
>  out:
>  	addr_location__exit(&al);
> -	return ret;
>  }
>  
>  static int intel_pt_process_event(struct perf_session *session,
> @@ -3522,7 +3520,7 @@ static int intel_pt_process_event(struct perf_session *session,
>  		err = intel_pt_context_switch(pt, event, sample);
>  
>  	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
> -		err = intel_pt_text_poke(pt, event);
> +		intel_pt_text_poke(pt, event);
>  
>  	if (intel_pt_enable_logging && intel_pt_log_events(pt, sample->time)) {
>  		intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",

