Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462D13CFA5;
	Wed, 25 Sep 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272161; cv=none; b=umEWJY/4A7lYZzMPiRz2AVfZq/AQloqdiB/xfP6fcMs9LkJW3yGbTKq7iplo8umXqjNQmhsIpbjMNs6k0bZ2SOwVHADbRgsMrIld/XET1coX5L2+7gMscl8cSTG8xPVLT2z16RCJfsY0JE/SJKyONN8dzQd+jvUHy4uxVvzOXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272161; c=relaxed/simple;
	bh=O07KZkOlI0Wqw6PkWgiIyyO0yc63ne6ZIR3FFo1ePh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV7G5VGUceLytVnIP2B7Ea9QFTN1DdXUeNOZpZlL7pbgv+ZPQPc57iq0ya+YbGLNmu6N0ln/7pOe9zBO7HqwWq7qdiapE4NMHlZ4BIZPd4KGHpd1duihYWJ3FEWnk0r+a0RbF7VLdLzFivv9w0BOtpfPic3/fFKb8P9wLQGJrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBMhEgUs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBMhEgUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727272160; x=1758808160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O07KZkOlI0Wqw6PkWgiIyyO0yc63ne6ZIR3FFo1ePh4=;
  b=DBMhEgUsXEGVJkC9+8XTc9E5yjYuBidiMrCW4b81L6uWL6gB99TbvN8/
   2fS2CgYIZKQoIjbtWHwBxPzhZOkN6RFEL02KoDkYz7bgyldqgjiWj8psI
   uIz1zrSN0gC8k7aYGc8tgv1ofHSI7JJTvTyEfsDnz0V+V6Q1xw2aanS0w
   vAACdbItkTFBLPKHYH+PMz8yOSdw4GRq4N6StVVjWUPATCwh1plWlw/EF
   MM6TrKW/ffcqABVAnvzqmMKSWZIEgz2hJXZdAq0J9Ci16zb/1HquWij1U
   6A6YRf3zM2/51jZ4ap/oFe45WX+2FS1TdKHjl8WB+MgVtVB4WctpsSEhx
   A==;
X-CSE-ConnectionGUID: xHFE5jkLSs+SUrgWEd8InQ==
X-CSE-MsgGUID: 52vZ2EciTSaiE0dNiZP8PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="25831037"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="25831037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:49:18 -0700
X-CSE-ConnectionGUID: OKHgzjvwQ++bBpSeN1Zu8Q==
X-CSE-MsgGUID: tYyWWl2SRNuitOyqao83zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71923618"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:49:18 -0700
Received: from [10.212.122.167] (kliang2-mobl1.ccr.corp.intel.com [10.212.122.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8EDDD20CFEEA;
	Wed, 25 Sep 2024 06:49:15 -0700 (PDT)
Message-ID: <01c8dcaa-d557-407e-9ef3-babf90eb37d3@linux.intel.com>
Date: Wed, 25 Sep 2024 09:49:14 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
To: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
 <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
 <ZvMfVe1VXwhCIOB9@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZvMfVe1VXwhCIOB9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-24 4:21 p.m., Namhyung Kim wrote:
> On Mon, Sep 23, 2024 at 09:47:17AM +0100, James Clark wrote:
>>
>> On 06/09/2024 3:33 pm, Liang, Kan wrote:
>>>
>>> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
>>>> This option is to support the old behavior of setting exclude_guest by
>>>> default.  Now it doesn't set the bit so users want the old behavior can
>>>> use this option.
>>>>
>>>>    $ perf stat true
>>>>
>>>>     Performance counter stats for 'true':
>>>>
>>>>                  0.86 msec task-clock:u                     #    0.443 CPUs utilized
>>>>                     0      context-switches:u               #    0.000 /sec
>>>>                     0      cpu-migrations:u                 #    0.000 /sec
>>>>                    49      page-faults:u                    #   56.889 K/sec
>>>>                   ...
>>>>
>>>>    $ perf stat --exclude-guest true
>>>>
>>>>     Performance counter stats for 'true':
>>>>
>>>>                  0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
>>>>                     0      context-switches:Hu              #    0.000 /sec
>>>>                     0      cpu-migrations:Hu                #    0.000 /sec
>>>>                    49      page-faults:Hu                   #   62.078 K/sec
>>>>                   ...
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>   tools/perf/Documentation/perf-stat.txt | 7 +++++++
>>>>   tools/perf/builtin-stat.c              | 2 ++
>>>>   2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>>> index 2bc06367248691dd..d28d8370a856598f 100644
>>>> --- a/tools/perf/Documentation/perf-stat.txt
>>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>>> @@ -382,6 +382,13 @@ color the metric's computed value.
>>>>   Don't print output, warnings or messages. This is useful with perf stat
>>>>   record below to only write data to the perf.data file.
>>>> +--exclude-guest::
>>>> +Don't count event in the guest mode.  It was the old behavior but the
>>>> +default is changed to count guest events also.  Use this option if you
>>>> +want the old behavior (host only).  Note that this option needs to be
>>>> +before other events in case you added -e/--event option in the command
>>>> +line.
>>> I'm not sure if we really need this option. I think it may bring more
>>> trouble than what we get.
>>>
>>> The name of the "--exclude-guest" sounds like a replacement of the event
>>> modifier "H". But in fact, it's not. It should only affect the default.
>>> It doesn't set the "H" for any events.
> Well I think it's tricky but it'd set "H" modifier events after the
> option.  But I have to agree that it can bring more troubles.

I may have miss-read something before. After some simple tests, yes, the
"H" is applied with the option.

Since there is a limit for the "--exclude-guest" option, can we print a
warning if the option becomes invalid because of the order?

> 
>>> Except for the perf kvm user, I don't think there are many users which
>>> care the exclude_guest. The behavior of the perf kvm is not changed. So
>>> the option seems not that important. If we really want an option to
>>> restore the old behavior, it's better to choose a better name and update
>>> the description.
> Personally I don't want to this option but just worried if there's a
> case where exclude_guest is preferred.

The only case I can imagine is that, with the new vPMU passthrough
introduced, some users may want to explicitly set the exclude_guest to
avoid the fallback. But I'm not sure how useful it is for them.

Thanks,
Kan
