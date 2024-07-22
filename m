Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F29288B1;
	Mon, 22 Jul 2024 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682700; cv=none; b=sRVIk75i1shH4dQsHREBEt5mgooqEo0u8i3MItHkWSAaLuyey7VNwG3LETDe8fJXjf/iX/52pCubqaGXYvTA+YXHFuKY9FwW0befG9LWZfgz/J6EkdVByWkGjay3TbEmmdwzH2Ox686NrekG8IqjRj0mR58r6KapkEwqgfRh85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682700; c=relaxed/simple;
	bh=UvzwkYHbRWbHo1c0eZoByK8ZAK2m1fVjXSpij9ogaOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMEQLnRsa8BlghWU1Gqo8J+pDixyvHWWaBbYEt+ICHA6LW62Qwh8y1s4dHAKqVdS//j7PfLY2yRajerrv7Jjevyy3jDtv1GyiUamsmmT350MUNrM8aJjaroVHKDbLrcr0YKNhd/EiTLYXV/1KWewQwM0y4DHEe3WPsA7YHMbm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD81E139F;
	Mon, 22 Jul 2024 14:12:03 -0700 (PDT)
Received: from [10.57.12.31] (unknown [10.57.12.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BFC3F5A1;
	Mon, 22 Jul 2024 14:11:35 -0700 (PDT)
Message-ID: <e6973788-625c-4be3-8bbe-3d8fcb1256c9@arm.com>
Date: Mon, 22 Jul 2024 22:11:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-2-leo.yan@arm.com>
 <CAP-5=fXr62AWU_g=Lymf=8wO-9FF-eEEsoBEYHdqxxdD0qgbnQ@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fXr62AWU_g=Lymf=8wO-9FF-eEEsoBEYHdqxxdD0qgbnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/2024 5:16 PM, Ian Rogers wrote:
> On Sun, Jul 21, 2024 at 1:21 PM Leo Yan <leo.yan@arm.com> wrote:
>>
>> Rather than iterating the whole PMU list for finding the associated PMU
>> device for an evsel, this commit optimizes to directly use evsel's 'pmu'
>> pointer for accessing PMU device.
> 
> The code doesn't do that:
> ```
> struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
> {
>        struct perf_pmu *pmu = evsel->pmu;
> 
>        if (!pmu) {
>                pmu = perf_pmus__find_by_type(evsel->core.attr.type);
>                ((struct evsel *)evsel)->pmu = pmu;
>        }
>        return pmu;
> }
> ```
> That is, if the evsel->pmu is not NULL then just return it, otherwise
> find the pmu using the type from the attribute. Any linear such should
> happen at most once unless the pmu is NULL from event parsing or
> perf_pmus__find_by_type.

So evsel__find_pmu() is good enough.

> The PMU may be NULL for legacy events and if
> sysfs isn't mounted. If you are encountering that then maybe we need a
> flag to say don't find the PMU for this evsel as it is known NULL.

I don't see a case of the PMU pointer is NULL. So don't need this flag.

My bad for misreading the code :\  Thanks a lot for pointing out.

Leo
