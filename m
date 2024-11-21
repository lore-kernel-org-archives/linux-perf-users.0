Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F1CD1E2;
	Thu, 21 Nov 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184312; cv=none; b=TZ836h9qSRJIH+wnz9iOo1Lx7hFS1D8OHAVxe4/5k69AO7lCYMM+NNyI35EI0iK6vC6JF0/9dyOCIt8mxNqStOkSTnicVtZtIOoNfeq9smEu9o+nlnn6zwYd5NKiI6Nod8rLltSZ/VeKqz/B1TBWhM5SZHU/8QyAYL0DzUaLTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184312; c=relaxed/simple;
	bh=wlCC9KYBfvH6f8bzXyZMsbzrX7ITXIMK+pupeDh0eI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVg/uNC8HqpCDUPHTfJUGrw+eTFwH3Q4yXYTws9DU7gDU/98JH8nZf2s2YiGuFrTk880B/mttf2DeAutDYx742bmfqYrF11Kx6aXLbH51HPtqaB+QwxonfIj7jLMgsdem6ptNR1VcU+8BJbqMgJlLW2U4/rGMNteKug06qMnaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLNV5SWX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLNV5SWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732184311; x=1763720311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wlCC9KYBfvH6f8bzXyZMsbzrX7ITXIMK+pupeDh0eI4=;
  b=JLNV5SWXJ8oCnCR4naK03x+oq5p1LKqywJIASGSmSdblf3E9aFMi/HIb
   4ah8y/P7N7TMGB+L4cxWAYamxuqOA5d6V0fL0xwVryQtfPTzkURcpi5r8
   xJw31+dzXFC/lQb+/Mpw/IA3cHTJUWipkYby54+V/H0C31nIo970xXBim
   tdZvFXnTt193juF9TAWFfhMJkI8Z4nfPwhakkggydYQOiD5m1Z7Z9A/jA
   zwZB11pv/y51E7yxbwExX03yA0SJeyUKQLa3ippS1AWS5lTJJF+Wi+wZI
   G2Tlp1m9Qi8Q0broy0QdmUkwJaDCrgZ0kDBLbdw/mz0SpKYN4oiBqvXga
   Q==;
X-CSE-ConnectionGUID: Gtyww8w+Q2OqLECQQ7gKPQ==
X-CSE-MsgGUID: TnyBuehxR6etIpUH33Yjbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42906117"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="42906117"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 02:18:30 -0800
X-CSE-ConnectionGUID: t+ofQvoHSCaTxbTYyifiUg==
X-CSE-MsgGUID: wYW50nb5R6aJW8g5XoOi8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="90615268"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 02:18:25 -0800
Message-ID: <820e9b6b-16eb-446a-b524-adc8129726ec@intel.com>
Date: Thu, 21 Nov 2024 12:18:18 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf intel-pt: cleanup unneeded return variable in
 intel_pt_text_poke()
To: guanjing <guanjing@cmss.chinamobile.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, algonell@gmail.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121100047.25318-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241121100047.25318-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/24 12:00, guanjing wrote:
> Removed Unneeded variable: "ret"
> 
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")

A Fixes tag is not for patches that don't fix some functionality.

> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> ---
>  tools/perf/util/intel-pt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 30be6dfe09eb..6c0234acc669 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3402,7 +3402,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	struct machine *machine = pt->machine;
>  	struct intel_pt_cache_entry *e;
>  	u64 offset;
> -	int ret = 0;
>  
>  	addr_location__init(&al);
>  	if (!event->text_poke.new_len)
> @@ -3443,7 +3442,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	}
>  out:
>  	addr_location__exit(&al);
> -	return ret;
> +	return 0;

Should just drop the return value entirely, since it is
always zero.

>  }
>  
>  static int intel_pt_process_event(struct perf_session *session,

