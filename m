Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9B3644D4;
	Mon, 22 Jun 2026 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119505; cv=none; b=CrS+U08L5tDttTHmtrq9ooTpITmAntBhD2uNsQp7gsMmJdRNp4ctmN/+UUkibnI0Et0RJw+Uu5qWA6O/71vzosyMdlpKXi/9wmBL9sKn7a7JDJAbLjDCG1iB6vKjBMq7+NWEkYXhZKCqUQ/yVffJ8zxG9Omtrx8evgOmbnLIgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119505; c=relaxed/simple;
	bh=tVeKyPH6vVYIKxiJVVS8S16ZHluc5rI8FNYwabzS9Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nEDX5fx26rJxnRHa3F/qIqr917YI26xNw05mj7T4lCoiq3SS0Ry4yvWT0Y2HVWDgeHIAEVqTbu3tNUN16Afj4fD6Vos46kNn+6en9RQpFCG6oKSgX/9KcJQZfsbi3LhD6z1GlEC4LOS4ioUOpWA57lU5wvmF0KE8ZD7gYW2R4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Eq8SPSSw; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Eq8SPSSw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=degt+rQtMZmtB3zFgacukqIbV8Vn3Ag9Sorzufy1NUM=;
	b=Eq8SPSSwK7kzyH4b9xwAI3yD1SyS7J+HAaoOWuITl49KToX7G5geplQ81SkO6wZtoFHdcB1J5
	LLPHZQuH8ZlUGnYmdxroI5Z+yJjaO7Q90kn0cIcuJC80zpry/6YmhJ3m6J2fi60gg0P6gozHKRN
	B5nw/fd8x2KXEPUmLqwuPd8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gkMfL2Qtnz1cyNs;
	Mon, 22 Jun 2026 17:02:34 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 028A140562;
	Mon, 22 Jun 2026 17:11:37 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 17:11:36 +0800
Message-ID: <26291bce-9be4-4edc-9dc5-4c685d9811c8@huawei.com>
Date: Mon, 22 Jun 2026 17:11:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmu: Recognize default_core as a core PMU in more
 places
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Athira Rajeev
	<atrajeev@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260612012413.3253516-1-irogers@google.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20260612012413.3253516-1-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/6/12 09:24:13, Ian Rogers <irogers@google.com> wrote:
> The python metrics code used in places like ilist.py passes a
> pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
> PMU like "cpu" isn't a literal name match then no PMU matches
> "default_core" and the events fail to parse for the metric. Fix the
> name matching and PMU lookup for "default_core" and check that it
> fixes ilist.py.
> 
> Fixes: 74e2dbe7be50 ("perf tools: Add --pmu-filter option for filtering PMUs")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Note: this bug is in 7.1 but it is a little too late to send for the
>        release. It should get picked up via the fixes tag.
> ---
>   tools/perf/util/pmu.c  | 6 +++++-
>   tools/perf/util/pmus.c | 2 ++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a550f030b85d..836e3b5615cd 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2660,8 +2660,12 @@ bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *wildcard_t
>   		pmu->name,
>   		pmu->alias_name,
>   	};
> -	bool need_fnmatch = strisglob(wildcard_to_match);
> +	bool need_fnmatch;
>   
> +	if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
> +		return true;
> +
> +	need_fnmatch = strisglob(wildcard_to_match);
>   	if (!strncmp(wildcard_to_match, "uncore_", 7))
>   		wildcard_to_match += 7;
>   
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 5e3f571450fe..e0a4cb2428ca 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -150,6 +150,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
>   	bool core_pmu;
>   	unsigned int to_read_pmus = 0;
>   
> +	if (!strcmp(name, "default_core"))
> +		return perf_pmus__find_core_pmu();
>   	/*
>   	 * Once PMU is loaded it stays in the list,
>   	 * so we keep us from multiple reading/parsing

Thank you for the fix, Ian.
In the previous patch, I overlooked the handling of the "default_core"
alias. Also, perhaps we can leave need_fnmatch as-is, since it doesn't
seem to affect anything here.

-- 
Thanks,
Qinxin

