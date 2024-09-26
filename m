Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A417799F
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353618; cv=none; b=Op0TYcWSCv6roWs/DOXoOpWUNvnJqwKCfnEZyE89Qd7C7DLdVFwD+iNHZgcb8/kJcPfSp43CX9Yd1wCI5RcH1HMNjTKcTDw3M6vEssWhS4Gvh+tufrHSWGkHE+/xqrjNEsQ6HAwpse0vZpW9vYyj4hvrLznD/s5ivxQEt5I1Wgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353618; c=relaxed/simple;
	bh=W1K4LUZoM1dpkDf1rPVbHtgMVLSGFsIkoB4l+0nrXWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJZgIqjzDU5efqAg1/KFkFR0WRPQ5LOPfnHHIro+tibkN/xpm8+iO/pNUUCIOJ7UCHE/034zvG6oWSyqUAFpJ62QjV9GnnudnKsYsHxJl8dI8gClSY/5OdXXOhJ3iyJ4trpKsnIlo/BKvrHQqOGLyksTim3S0JWbNBPW5kYfi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfIc4cc6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfIc4cc6"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so128554966b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727353615; x=1727958415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eB/LC0WCkLRHYHqq55Ehj0gnBL7BMz7IH9VuKZNge8=;
        b=gfIc4cc6DjZ34/raLrCgVzIfwqxM6Garlcqf8iQWdmRP7ff8PZ/r+SRoHy6Q7odqtq
         AiiC6cYY33Ij3nKmeaPloudMJPBYkPBHsySoA6Md8zbAut8ycZNhkof6nJBKVf8NuwOk
         MZNTOlwYkdhE9dWwNwd2gVRjdC15qipBM0PE5Yj3C7kNsWHQ7TWW/aLUdItd4JRu5IoX
         1L77maFsgUTWBSKEfHVThIpRcb57eMGRoXEUOfOwT2V0w1FrMZkM8N1oqydaaUQQQg8q
         31AUzIxY6f3ML1ohnzh5Zlneb8Q5IUWvOWrz7Cns/SXtYmsjZ9n6Y5KFbDwZNnIWPlWE
         oiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353615; x=1727958415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eB/LC0WCkLRHYHqq55Ehj0gnBL7BMz7IH9VuKZNge8=;
        b=E0zrDwyV1n70ierkg5q2JGSvYojX9ahoFvwh0l/TNfLJZfOrvIsJEfZ/84kbkf2HuP
         fq+wZmD93y6lKXFSBB9VgEaOWtZRLhnt/74Vn/wnBBrcZmGeUWCdYNgn9ODjxmm4JS5q
         bvAfFPyeFqNXFxuTptw2HZ3Q2mT3G4GDv3Rm/OOZn1fKDplJ9XMxg7mQSYNGPJEatjn5
         GYwf9oU/izOgiDy3Vy4iuQJ+9gDzdgrHubbj0ZTBKZES1jbHYHx5mEY6c6sepeqI3MDC
         W9P2nuIG6w0kB6D4MelXdjk30Wz1noD++PtZZ0zyNGn4s0NRjkygyAk3Jy5BbU+gpJJe
         JjIg==
X-Gm-Message-State: AOJu0YzLhpIRqVWNpAEHS+hv3kT71FgorYGi0eluSE53mje6RcjVweiI
	zoCFYBqk4qBFzTuY2pqgBAhNVJ6EliPjqQSkbq8X2dhC4Hfe+Fcp273PFKCbWRE=
X-Google-Smtp-Source: AGHT+IEby6swK1qKmKOhNp9ApnteMBewDC39/Ox0Bk0vbizMEUBN8yjxVubq07e6qVNDHlKPjcMkOw==
X-Received: by 2002:a17:907:3f99:b0:a86:7fc3:8620 with SMTP id a640c23a62f3a-a93a03fefdfmr593049066b.31.1727353615307;
        Thu, 26 Sep 2024 05:26:55 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f541e4sm345619666b.66.2024.09.26.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 05:26:54 -0700 (PDT)
Message-ID: <55f95839-5403-44e3-968c-ba0cc93bfb73@linaro.org>
Date: Thu, 26 Sep 2024 13:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Event parsing fixes
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, kan.liang@linux.intel.com,
 ak@linux.intel.com, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Colin Ian King <colin.i.king@gmail.com>, Yang Li
 <yang.lee@linux.alibaba.com>, Yang Jihong <yangjihong@bytedance.com>,
 Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>,
 Yanteng Si <siyanteng@loongson.cn>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240925141357.1033087-1-james.clark@linaro.org>
 <ZvTlUXJs2jVDDL0B@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZvTlUXJs2jVDDL0B@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/09/2024 5:38 am, Namhyung Kim wrote:
> On Wed, Sep 25, 2024 at 03:13:38PM +0100, James Clark wrote:
>> I rebased this one and made some other fixes so that I could test it,
>> so I thought I'd repost it here in case it's helpful. I also added a
>> new test.
>>
>> But for the testing it all looks ok.
>>
>> There is one small difference where it now hides _all_ default
>> <not supported> events, when previously it would only hide some
>> selected subset of events like "stalled-cycles-frontend". I think
>> this is now more consistent across platforms because, for example,
>> Apple M only has cycles and instructions, and the rest of the
>> default events would always show as <not supported> there.
>>
>> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
>> cycles PMU) and I also faked an Apple M on Juno.
> 
> Hmm.. I got a segfault with 'perf stat true' on my Zen2 box.
> 
>    $ gdb -q -args ./perf stat true
>    Reading symbols from ./perf...
>    (gdb) r
>    Starting program: /home/namhyung/tmp/perf stat true
>    [Thread debugging using libthread_db enabled]
>    Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
>    
>    Program received signal SIGSEGV, Segmentation fault.
>    0x00005555557e04b5 in perf_pmu__is_fake (pmu=0x0) at util/pmu.c:1173
>    1173		return pmu->type == PERF_PMU_TYPE_FAKE;
>    (gdb) bt
>    #0  0x00005555557e04b5 in perf_pmu__is_fake (pmu=0x0) at util/pmu.c:1173
>    #1  0x00005555558c1b8b in evsel__sys_has_perf_metrics (evsel=0x5555560cc4b0) at arch/x86/util/evsel.c:50
>    #2  0x00005555558c1c33 in arch_evsel__must_be_in_group (evsel=0x5555560cc4b0) at arch/x86/util/evsel.c:64
>    #3  0x00005555557773a4 in parse_events__sort_events_and_fix_groups (list=0x7fffffff9ad0) at util/parse-events.c:2098
>    #4  0x0000555555777793 in __parse_events (evlist=0x5555560aa880,
>        str=0x5555558d6498 "context-switches,cpu-migrations,page-faults,instructions,cycles,stalled-cycles-frontend,stalled-cycles-backend,branches,branch-misses", pmu_filter=0x0, err=0x7fffffff9bd0, fake_pmu=false, warn_if_reordered=true, fake_tp=false) at util/parse-events.c:2186
>    #5  0x00005555555c787f in parse_events (evlist=0x5555560aa880,
>        str=0x5555558d6498 "context-switches,cpu-migrations,page-faults,instructions,cycles,stalled-cycles-frontend,stalled-cycles-backend,branches,branch-misses", err=0x7fffffff9bd0) at util/parse-events.h:41
>    #6  0x00005555555cce39 in add_default_events () at builtin-stat.c:1977
>    #7  0x00005555555cf928 in cmd_stat (argc=1, argv=0x7fffffffd840) at builtin-stat.c:2724
>    #8  0x000055555564cb81 in run_builtin (p=0x555556024548 <commands+360>, argc=2, argv=0x7fffffffd840) at perf.c:351
>    #9  0x000055555564ce28 in handle_internal_command (argc=2, argv=0x7fffffffd840) at perf.c:404
>    #10 0x000055555564cf81 in run_argv (argcp=0x7fffffffd63c, argv=0x7fffffffd630) at perf.c:448
>    #11 0x000055555564d2cf in main (argc=2, argv=0x7fffffffd840) at perf.c:562
> 
> Thanks,
> Namhyung
> 

Oh yeah that's from the rebase. Looks like pmu is never NULL here on Arm 
and hybrid x86 so I didn't see it, but I do see it on non-hybrid x86. It 
just needs a NULL check:

   bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
   {
   ...
   	pmu = evsel->pmu;
	if (pmu && perf_pmu__is_fake(pmu))
		pmu = NULL;

I also noticed a new issue though, the change to make all default stat 
events skippable=true hides permission errors, so now instead of the 
hint to look at perf_event_paranoid you just get nothing, so I need to 
fix that:

   $ cat /proc/sys/kernel/perf_event_paranoid
   4

   $ perf stat true

     Performance counter stats for 'true':


        0.000431617 seconds time elapsed

        0.000445000 seconds user
        0.000000000 seconds sys

I'm thinking it either needs to never skip EPERM or some other errors, 
or maybe make cycles always non skippable. Probably the first option is 
better.

James

