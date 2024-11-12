Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC992AF06;
	Tue, 12 Nov 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376037; cv=none; b=n3uKOICC39nZd7RM9mwAZpQKGbOSH+N6eDBqt9C9+jtb8NvZNuV5vF+WbbzdanLuvHqHYt1qvR6OaLPfC0FKGH65fx29OHZu5ABcd8ibDWKgKMBcBKdnVl9cjpzAH5qn3e6cMMZXCbTeigwuBQC49KY5a7uvdfbZ1bzsZnRNhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376037; c=relaxed/simple;
	bh=t2riWp8iVz5vagodm+20WB+hhuSzF3Z8aqzuVOor10Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LrrftKLOerzIBLFF2wmnk1qQtoaFz2gKIIn9tzepToXUpV/jyxaDU/6JmCuaWkMmWh4zc5NzCgBSeOD3BNE1I02HuMQoJSDYm5JiTN+kdMzAnnIw3E8ZNuHWnxgdSQSJ4S+ZfpSVOxwRevlzq+MvjdWSfqhVzbwa/fapmjj2WGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XnTk32tJZz10Qsg;
	Tue, 12 Nov 2024 09:44:43 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id ECC7B140157;
	Tue, 12 Nov 2024 09:47:10 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 09:47:10 +0800
Subject: Re: [PATCH 1/2] perf probe: Reset old content before processing the
 next event string
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dima@secretsauce.net>, <aleksander.lobakin@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
 <20241111134705.021f73408c0aff41918ab2a5@kernel.org>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <24c76d15-43d1-3612-be61-44d34fb3ac9e@huawei.com>
Date: Tue, 12 Nov 2024 09:47:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241111134705.021f73408c0aff41918ab2a5@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/11/11 12:47, Masami Hiramatsu (Google) wrote:
> On Sat, 9 Nov 2024 02:19:08 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> I added two probe events:
>>
>>   # perf probe -f -a schedule+8
>>   Added new event:
>>     probe:schedule       (on schedule+8)
>>
>>   You can now use it in all perf tools, such as:
>>
>>           perf record -e probe:schedule -aR sleep 1
>>
>>   # perf probe -f -a schedule+20
>>   Added new event:
>>     probe:schedule_1     (on schedule+20)
>>
>>   You can now use it in all perf tools, such as:
>>
>>           perf record -e probe:schedule_1 -aR sleep 1
>>
>> However, 'perf probe -l' shows the same offset:
>>
>>   # perf probe -l
>>     probe:schedule       (on schedule+8@kernel/sched/core.c)
>>     probe:schedule_1     (on schedule+8@kernel/sched/core.c)
>>
>> __show_perf_probe_events() does not clean up the 'pev' content when
>> parsing the rawlist. If the 'pev->offset' is not set while processing
>> the next probe event string, the offset value of the previous event will
>> be used.  After adding debug information, it was found that indeed there
>> was line number information when processing 'probe:schedule_1', so the
>> offset was not set and used the offset from 'probe:schedule'.
>>
>> To fix this, in the loop that parses the rawlist, reset the contents of
>> 'tev' and 'pev' to ensure it does not affect the next parsing.
>>
>> After the modification,  'perf probe -l' shows the following:
>>
>>   # perf probe -l
>>     probe:schedule       (on schedule+8@kernel/sched/core.c)
>>     probe:schedule_1     (on schedule:-6751@kernel/sched/core.c)
>>
>> Note that 'probe:schedule_1' is displayed with line number, but the line
>> number seem to be incorrect. This issue is independent of the problem
>> fixed by the current patch and will be addressed in the next patch.
>>
> 
> Good catch! But we should do the cleanup in clear_perf_probe_event()
> and clear_probe_trace_event().
> 
>> Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
> 
> What we need is to revert this change for above 2 functions, because
> without that, it "clear"s the structure correctly. Current code
> releases allocated fields, but not clear all fields. This can lead
> another bug.


Right, I will make this change in the next version.

Thanks，
Huafei

> 
> Thank you,
> 
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  tools/perf/util/probe-event.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>> index a17c9b8a7a79..ec0b11f8d881 100644
>> --- a/tools/perf/util/probe-event.c
>> +++ b/tools/perf/util/probe-event.c
>> @@ -2695,6 +2695,8 @@ static int __show_perf_probe_events(int fd, bool is_kprobe,
>>  next:
>>  		clear_perf_probe_event(&pev);
>>  		clear_probe_trace_event(&tev);
>> +		memset(&tev, 0, sizeof(tev));
>> +		memset(&pev, 0, sizeof(pev));
>>  		if (ret < 0)
>>  			break;
>>  	}
>> -- 
>> 2.25.1
>>
>>
> 
> 
