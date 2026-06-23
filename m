Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD083C1419;
	Tue, 23 Jun 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195780; cv=none; b=k6IrfPKOYVLr+e163m2T/O3FG+qDrG5r5FnmdjmUt8KQeWF4iUnVS3tPjokbcNaO9L/2BR9safQwKvcHdDzk1ohdE1j+EobV2zqLt1sSwuXRk2cggMPv3sx97160TQZtyH16hW5nltpD8OdDUeq1jBCAQ6ZaMLASJBP6e7yWtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195780; c=relaxed/simple;
	bh=IVgG6NvJm9Es5+sffdVNfKWEHJiM9hV0GsV+VTlMVT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YlF1Dgx/qwei156I9AZr4daRjP2VNQ6d+U+7ITK+eDHfGJfBmjf75k1dxaIJDyPLDHrNlpIEiPw6J7xX4flpnu5tFPHvJ4cMwYbCVn/YkFrGm2ghyxQMwMLJjFZ3uOKNrYspAwzsdx2KCFPQfAtznVmaA1Jy91CWkLnT6d3B+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y0IYv/MP; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y0IYv/MP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TsOIDQHLeJVoh2Y+lyI8ucBGR3XpXR4/MnAAlsDUFhw=;
	b=y0IYv/MPx3uVD49Yhldz1WO072FSONjmt+s0FuVZgaVd/sDFf5kQbr429aXblcQcebDj/IKo7
	g5Wg0CWrsMJBbLZJd3572bKQJheZ2Cvjw44gCMHtTqi159n34fN1anRGMggcvoBq8pyK2ToyVj7
	olH95dxpdGwYwaouuFHHcd4=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gkvs25T6rz1cyQ9;
	Tue, 23 Jun 2026 14:13:42 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id EC4CF40571;
	Tue, 23 Jun 2026 14:22:45 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jun 2026 14:22:45 +0800
Message-ID: <a9f25a27-5f71-4d64-a42c-ef9c7ed8107b@huawei.com>
Date: Tue, 23 Jun 2026 14:22:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmu: Recognize default_core as a core PMU in more
 places
To: Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, Thomas
 Falcon <thomas.falcon@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260612012413.3253516-1-irogers@google.com>
 <26291bce-9be4-4edc-9dc5-4c685d9811c8@huawei.com>
 <CAP-5=fWY35hNSi8uNjX95TnDMmC3Pek9B7Yaf6Ax0ty_6ZtmCQ@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAP-5=fWY35hNSi8uNjX95TnDMmC3Pek9B7Yaf6Ax0ty_6ZtmCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/6/23 01:53:52, Ian Rogers <irogers@google.com> wrote:
> On Mon, Jun 22, 2026 at 2:11 AM Qinxin Xia<xiaqinxin@huawei.com> wrote:
>>
>>
>> On 2026/6/12 09:24:13, Ian Rogers<irogers@google.com> wrote:
>>> The python metrics code used in places like ilist.py passes a
>>> pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
>>> PMU like "cpu" isn't a literal name match then no PMU matches
>>> "default_core" and the events fail to parse for the metric. Fix the
>>> name matching and PMU lookup for "default_core" and check that it
>>> fixes ilist.py.
>>>
>>> Fixes: 74e2dbe7be50 ("perf tools: Add --pmu-filter option for filtering PMUs")
>>> Signed-off-by: Ian Rogers<irogers@google.com>
>>> ---
>>> Note: this bug is in 7.1 but it is a little too late to send for the
>>>         release. It should get picked up via the fixes tag.
>>> ---
>>>    tools/perf/util/pmu.c  | 6 +++++-
>>>    tools/perf/util/pmus.c | 2 ++
>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index a550f030b85d..836e3b5615cd 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -2660,8 +2660,12 @@ bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *wildcard_t
>>>                pmu->name,
>>>                pmu->alias_name,
>>>        };
>>> -     bool need_fnmatch = strisglob(wildcard_to_match);
>>> +     bool need_fnmatch;
>>>
>>> +     if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
>>> +             return true;
>>> +
>>> +     need_fnmatch = strisglob(wildcard_to_match);
>>>        if (!strncmp(wildcard_to_match, "uncore_", 7))
>>>                wildcard_to_match += 7;
>>>
>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>> index 5e3f571450fe..e0a4cb2428ca 100644
>>> --- a/tools/perf/util/pmus.c
>>> +++ b/tools/perf/util/pmus.c
>>> @@ -150,6 +150,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
>>>        bool core_pmu;
>>>        unsigned int to_read_pmus = 0;
>>>
>>> +     if (!strcmp(name, "default_core"))
>>> +             return perf_pmus__find_core_pmu();
>>>        /*
>>>         * Once PMU is loaded it stays in the list,
>>>         * so we keep us from multiple reading/parsing
>> Thank you for the fix, Ian.
>> In the previous patch, I overlooked the handling of the "default_core"
>> alias. Also, perhaps we can leave need_fnmatch as-is, since it doesn't
>> seem to affect anything here.
> Thanks. I moved need_fnmatch's initialization just to save some work
> in the "default_core" case where the value is unused. While leaving it
> in place would reduce the diff, I think the optimization is worth it
> as we would otherwise call strisglob when say iterating all metrics.
> 
Perhaps we can do it this way：
	if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
              	return true;

	bool need_fnmatch = strisglob(wildcard_to_match);
> Would it be okay to supply a Reviewed-by tag? I notice this fix is
> missing from perf-tools-next.
> 
Sure, add my Reviewed‑by.:-)

> Thanks!
> Ian
> 
>> --
>> Thanks,
>> Qinxin

-- 
Thanks,
Qinxin

