Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC090280324;
	Wed, 18 Jun 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244580; cv=none; b=sSeX8jRrTofc7u/omA2Y9NK4R0/y+PpUearfF/tKe1m0a0RfLPgADzFtVHkdw8+ZutzPYObjsa8IXNXldUL+uidE2CN8ReGo7tk5Cd698oXnLK1f6NFjajso5SDrx5era1Xs+zLvjnnFBbJ+7/4NjY4qw8pIjQ5olq5ynJhg3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244580; c=relaxed/simple;
	bh=Kribkm4xXxuHVsBQRwIKcTNDRPOlLAuyBWENouVSeuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1hC/5z891o5stBahzu19JoVHO1AHrxVndfUis/J4flXs1VHYxi23Z8av6VoNi2eIHN8sVjq/5XwqlZy2+QzaGcLkcdfVSKvOPpmMqz/+Z1U9jVKZeMec4vSChcAZq4Kbx2TAOqa4lWyIDh4Twly0I49LmCso+CDyuNkwhk2VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcRtWwS7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcRtWwS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750244579; x=1781780579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kribkm4xXxuHVsBQRwIKcTNDRPOlLAuyBWENouVSeuo=;
  b=KcRtWwS7GopsMSiptksjRr6GMPmR/MIS3Dha+cSprkurvcoRKv4RA440
   HxhWwVlNLofek+3AlnH2KOIlqMAu0+dKGrdEXFpq0CXArAVkHbhWrrgTO
   doXo4v27qZMPYdtd4JRIvENif3y6WxUYMhX9MHHIPKULryeabMHxvzblp
   kq8j3uX6+3kcl7/bsnC9dzs/yHrsYn3xiSkUHL64xg6My977gYNJxttUq
   HN/coOdUY2c0KrRjFuZLtfCV9W++r6+nDcvzlz7/X8qPpu4HYMH0Kf4lo
   TXDhvRfAovk95psEItBerUZvmqAtUHzrM5WLQQD/RIRW8NkyHORVwP+1X
   Q==;
X-CSE-ConnectionGUID: X0meMBdiQdqsgjBXyhkn0A==
X-CSE-MsgGUID: znvBSeWVRIOFBm0e3euZVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51680323"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="51680323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 04:02:58 -0700
X-CSE-ConnectionGUID: 0yAdYnM1Q+OYu2ssEpXRKw==
X-CSE-MsgGUID: Jp2434kkQ6ilL0Oi6rDu+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149437910"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 04:02:58 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9939520B5736;
	Wed, 18 Jun 2025 04:02:56 -0700 (PDT)
Message-ID: <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
Date: Wed, 18 Jun 2025 07:02:55 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
 <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
 <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-17 11:49 p.m., Vince Weaver wrote:
> On Tue, 17 Jun 2025, Liang, Kan wrote:
> 
>> The commit 2dc0572f2cef was triggered by the fake event VLBR_EVENT.
>> But this error should be triggered by the Topdown perf metrics event,
>> INTEL_TD_METRIC_RETIRING, which uses the idx 48 internally.
>>
>> We never support perf metrics events in sampling mode. The PEBS cannot
>> be enabled in counting mode. So it's weird the cpuc->pebs_enabled has
>> the idx 48 set.
>>
>> The recent change I did for the PEBS is commit e02e9b0374c3
>> "perf/x86/intel: Support PEBS counters snapshotting". But it should not
>> impact the above.
>>
>> Could you please help on the below questions?
>> - It only happens on the p-core, right?
> 
> how would I tell?  I don't think the error message says what CPU it 
> happens on?

No, the error message doesn't say it. Just want to check if you have
extra information. Because the Topdown perf metrics is only supported on
p-core. I want to understand whether the code messes up with e-core.

> 
>> - Which kernel base do you use? Is it 6.16-rc2?
> 
> I was running just before -rc1.  I've updated to current git but didn't 
> realize the throttle fix hadn't made it upstream yet so managed to lock up 
> the machine and not sure when I'll be able to get over to reboot it.
>

They are not in rc2 as well. I guess it should be included in rc3.


>> - Can this be easily reproduced?
> 
> probably.  It's another thing that's a pain to check because it's a 
> WARN_ONCE I think so I have to reboot in order to see.  Even if it's not 
> reproducible the fuzzer usually hits it within a few hours.

OK. I will try to reproduce it locally.

> 
>>   Is it possible to bisect the error commit? (Maybe start from the
>> commit e02e9b0374c3?)
> 
> Maybe but I'd only like to do that as a last resort as it's a pain to 
> build and reboot kernels on this machine (for secureboot and other 
> reasons).  


Sure.

Thanks,
Kan

> Also I suppose I'd have to manually apply the throttle patch 
> while bisecting.

> 
> Vince Weaver
> vincent.weaver@maine.edu
> 

