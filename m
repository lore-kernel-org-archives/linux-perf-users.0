Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110E20C461;
	Fri,  6 Feb 2026 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342251; cv=none; b=ClghiTvEKF+5yt7bOAsPNTuTUd9is0K8ibGVo8XC5UHx+PqFWLDRVHGKtMtYlBr6a3Il8C7EN8G6ZitMAWt/m/B8VmcKGylzLSlcG8qQKVCuysroJUze5+ce2SA+NohwNdd3RfDx9mNO9NxRxuAfjITcpTZ4z99MgmJNKzJ6EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342251; c=relaxed/simple;
	bh=9KFbjLzWhBf/FU3xamFxcMIaayPRvTlmSJa4tUDWUFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OMF2gmT3/BvByXMTBwwFGvVtxzLbxWOPMb9miBy3Hd0qi9WprYgjE75DQJuPwDkqFu9LaEudydYEh/Ta/FGu4dTbl5ePKzcFTSTZveZzhTVQVa4iBfkJOl1brnvt0EqGOV3uX4lmRmYDgggF+9MXKxKrsnEbHguHQBkAEvGIDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWdCq/pm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWdCq/pm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770342252; x=1801878252;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9KFbjLzWhBf/FU3xamFxcMIaayPRvTlmSJa4tUDWUFg=;
  b=CWdCq/pmNdktuvwMKpQnbyCNq7/wBtuB2msbZDdVnfoGaDsSwtflzIme
   1IIn/GPPyzCS5E+Wj2AJoHr6qKzsOaj45O7dI5MaxB9bwskUB/uIi7NBT
   sVxgNCrKRuANmvxJJFJcN2E4fRmLxKfwQev3UqTjpgq7hAXYK9kyIJSy/
   uDfvjso7zaWtV6RdP+fX9+GPsv5RaJcbqmnnHHIY808FKtH5U34+M81J9
   fyaJZgKYA0qJei1zdSrVS0QH0H3u+0Gk7ba0GI1bBO8/Ru6j3a+1XnUov
   6uACbIRfKLKaUmf8FAF7WlVeKp+rSAo0P6c1bzgeTKpeHuIvZuE44pQe9
   Q==;
X-CSE-ConnectionGUID: RTCG89TGTHOqCwmsQgeoYQ==
X-CSE-MsgGUID: iOBtoVl/S8qXm+Yb9lfEYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71731710"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71731710"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:44:11 -0800
X-CSE-ConnectionGUID: Jir3g5jhSum9IDTqgcYpoQ==
X-CSE-MsgGUID: a6oZ62bSQ6OvjdIzLyJ3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210018480"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:44:07 -0800
Message-ID: <764406ae-c604-410c-9205-7f3343a4bd8f@linux.intel.com>
Date: Fri, 6 Feb 2026 09:44:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf callchain lbr: Make the leaf IP that of the
 sample
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Weilin Wang <weilin.wang@intel.com>
References: <20260205205622.530825-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260205205622.530825-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/6/2026 4:56 AM, Ian Rogers wrote:
> The current IP of a leaf function when reported from a perf record
> with "--call-graph lbr" is the "to" field of the LBR branch stack
> record. The sample for the event being recorded may be further into
> the function and there may be inlining information associated with
> it. Rather than use the branch stack "to" field in this case switch to
> the callchain appending the sample->ip and thereby allowing the inline
> information to show.
>
> Before this change:
> ```
> $ perf record --call-graph lbr perf test -w inlineloop
> ...
> $ perf script --fields +srcline
> ...
> perf-inlineloop  467586  4649.344493:     950905 cpu_core/cycles/P:
>            55dfda2829c0 parent+0x0 (perf)
>  inlineloop.c:31
>            55dfda282a96 inlineloop+0x86 (perf)
>  inlineloop.c:47
>            55dfda236420 run_workload+0x59 (perf)
>  builtin-test.c:715
>            55dfda236b03 cmd_test+0x413 (perf)
>  builtin-test.c:825
> ...
> ```
>
> After this change:
> ```
> $ perf record --call-graph lbr perf test -w inlineloop
> ...
> $ perf script --fields +srcline
> ...
> perf-inlineloop  529703 11878.680815:     950905 cpu_core/cycles/P:
>             555ce86be9e6 leaf+0x26
>   inlineloop.c:20 (inlined)
>             555ce86be9e6 middle+0x26
>   inlineloop.c:27 (inlined)
>             555ce86be9e6 parent+0x26 (perf)
>   inlineloop.c:32
>             555ce86bea96 inlineloop+0x86 (perf)
>   inlineloop.c:47
>             555ce8672420 run_workload+0x59 (perf)
>   builtin-test.c:715
>             555ce8672b03 cmd_test+0x413 (perf)
>   builtin-test.c:825
> ...
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/machine.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5b0f5a48ffd4..e76f8c86e62a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2423,8 +2423,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
>  	}
>  
>  	if (callee) {
> -		/* Add LBR ip from first entries.to */
> -		ip = entries[0].to;
> +		/*
> +		 * Set the (first) leaf function's IP to sample->ip (the
> +		 * location of the sample) but if not recorded use entries.to
> +		 */
> +		if (sample->ip)
> +			ip = sample->ip;
> +		else
> +			ip = entries[0].to;
>  		flags = &entries[0].flags;
>  		*branch_from = entries[0].from;
>  		err = add_callchain_ip(thread, cursor, parent,
> @@ -2477,8 +2483,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
>  	}
>  
>  	if (lbr_nr > 0) {
> -		/* Add LBR ip from first entries.to */
> -		ip = entries[0].to;
> +		/*
> +		 * Set the (first) leaf function's IP to sample->ip (the
> +		 * location of the sample) but if not recorded use entries.to
> +		 */
> +		if (sample->ip)
> +			ip = sample->ip;
> +		else
> +			ip = entries[0].to;
>  		flags = &entries[0].flags;
>  		*branch_from = entries[0].from;
>  		err = add_callchain_ip(thread, cursor, parent,

LGTM. Thanks.


