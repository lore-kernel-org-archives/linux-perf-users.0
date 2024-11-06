Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDD202F6C;
	Wed,  6 Nov 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910201; cv=none; b=sprMe56T52Sj+cKOQTsykRb/2mlCerINM8fv/F8qFwRlS7YQen72hyM6FOkGH8WxNf7isB1kNrwwHsd1YJR2dBvZGiQezCrGun6px1by3pseBpkxiM47vxczGekoVtHXmyI00Xlblm6yqvD/V/wTx8sdvFXbTqcI8EiovFrGRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910201; c=relaxed/simple;
	bh=3t18mQxornvSkAQZRcmr+jk6jcmoLH7cx944HKMvwzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=konf+Ux1krnMpGWtkpnOkW21UC9eaGCq+an0Vql3Y+VmqTWzhvqKtWocpxocy7jio6mDyX5HVSX9ZMR2XCp6JLL6BN8Qrg5iRqTV9fq4ZKgLdlGwdC0YvFbDjHQbG1qxDw/nYA8mtvHA0heFcTi+aeAH1f81RcAF7fPJKj1lDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3MA5A7t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3MA5A7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730910199; x=1762446199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3t18mQxornvSkAQZRcmr+jk6jcmoLH7cx944HKMvwzs=;
  b=V3MA5A7tLCUe3seSEwFz/B6KQZR4fIovV4ua0qOFZjtSEgLtChZQnZfJ
   QlQqmBkIoWEjn7FPX9i2EJB8VOAHMB11X2f/6Lr2wneT5qBw8k0D6FKsw
   GqtLeseW9QRWirOnDwRhi9xaCvcPuKW3uhGJfl1CFu3zBC/fO7bmp47xG
   qgCx7RobTdtvYSREwHl6kdavnRYhICZUB46wsyH6fyKyZpzmLIF614jR/
   Ld01ZjvJlxdXjsfUERWapCbYcEstPwo9l+RGurC3RuBKFuOaAIY9XmgP9
   CBG3psncCEcN/7qgaE9tp2Cg7ppsgOvj4gVNUgNH8qkFEx3NQBxHeJOGX
   A==;
X-CSE-ConnectionGUID: VIGZt45ySYWqpFzHggMcuQ==
X-CSE-MsgGUID: /UHVIPbzSh2ldw0Kgd9XRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34498997"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34498997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:23:19 -0800
X-CSE-ConnectionGUID: wZ8EUHJgQQyGZHcGPHLPiA==
X-CSE-MsgGUID: yhawi+coRtyF7joFHFAK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84253798"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:23:18 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CE92F20B5703;
	Wed,  6 Nov 2024 08:23:16 -0800 (PST)
Message-ID: <06c73597-5b23-4759-9101-6594cc13cabc@linux.intel.com>
Date: Wed, 6 Nov 2024 11:23:15 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106004818.2174593-1-irogers@google.com>
 <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
 <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV3RuvU0N_bt7R-ZMs2nX1_wfKh30PA59u3MW0TF4nzBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-06 11:04 a.m., Ian Rogers wrote:
> On Wed, Nov 6, 2024 at 7:27 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-11-05 7:48 p.m., Ian Rogers wrote:
>>> Long metric names combined with units may exceed the metric_bf and
>>> lead to truncation. Double metric_bf in size to avoid this.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/stat-shadow.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>>> index 8c9292aa61d3..6b531d4f58a3 100644
>>> --- a/tools/perf/util/stat-shadow.c
>>> +++ b/tools/perf/util/stat-shadow.c
>>> @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
>>>       if (!metric_events[i]) {
>>>               if (expr__parse(&ratio, pctx, metric_expr) == 0) {
>>>                       char *unit;
>>> -                     char metric_bf[64];
>>> +                     char metric_bf[128];
>>
>> I thin there is already a MAX_EVENT_NAME.
>> Can we similarly define a MAX_METRIC_NAME for it?
> 
> So in this case the buffer needs to be big enough to hold the metric
> name, the unit from the scaleunit (e.g. the "%" from "100%"). I'd
> prefer we used dynamic memory allocation to having hard coded limits,
> just to avoid a "640K ought to be enough for anybody," moment.
> Although this change is implicitly a hard coded limit, sigh. There is
> also the metric only name length:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-stat.c?h=perf-tools-next#n160
> That looked like it was planned to be dynamically computed but then
> the patch adding that never materialized - meaning "standard"
> metric-only output has its own cut-off rules at 20 characters. I'd
> rather wait on doing a larger cleanup and do this quick fix for now,
> mainly as I have enough to do.

OK

> 
> While we're talking metrics, I'm still looking for feedback on the
> python generation of metrics. v1 was sent back in January, if v4 looks
> okay some acknowledgement would be nice:
> https://lore.kernel.org/lkml/CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com/
> Leo sent some feedback to improve some of the ARM metrics, so I can
> resend the whole series. Would be nice to gather some acked-by or
> other tags.
> 

Somehow I missed your last reply. I will take a look.

Thanks,
Kan

