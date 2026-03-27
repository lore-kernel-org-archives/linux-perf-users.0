Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC83BED56;
	Fri, 27 Mar 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593683; cv=none; b=mwmm5cQ5uKELc4LyA4En3hHU0dotZZ8fZydIUcPWvHVZ/BorNJOpjj4aOv1Wf/i/g69fMos9HbrWMA81S+oEhFpej9kXrc4ztVbsVvjbgFNMXu997M7Qsz9z942TrsII5QK15epHduuItVndG8LoI1b17pviGcoR9MjhDaRDA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593683; c=relaxed/simple;
	bh=y7W7yldxxgAEG/ek95kbzee/RUGjhGUQnIgP4O5/KZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJb7P9F9tgEU1ap6mm4Sqe3K1hXq3D/ugCs1EmE6d1XztghSHnQI9pXY7wqTf3mPzLnSWsWWfT7I+zgAAP8V31KBZj9AQn7eni6xdI+okgJAMUTFincf2J5z7goHicQbAfyuh0ctoA8xXw+RK3TXbgv+jsqKlz5ErwF3XfHO0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WdwC9dez; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WdwC9dez; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WdwC9dez";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WdwC9dez"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IuwJNxlbX8QYmeZpv4R6FhgivDm3napVgMAby7ZcWtQ=;
	b=WdwC9dezo5/EZ8Y3myjfjLBY0u1t3BmHxEOqVLd53Gs+WCj2PfT8kVN4lF3qcGMFePPuToi/B
	FYnxNCCGyCsrvhipl7e2CBa/pN3tEtcmdE+EQ6MWGpQRz/kMdswxN110a+DJ5NkTO9rOnZpRs9q
	UQemANmaz7h7x1a3UOM7blQ=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fhrd70zKPz1BFpC;
	Fri, 27 Mar 2026 14:40:59 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IuwJNxlbX8QYmeZpv4R6FhgivDm3napVgMAby7ZcWtQ=;
	b=WdwC9dezo5/EZ8Y3myjfjLBY0u1t3BmHxEOqVLd53Gs+WCj2PfT8kVN4lF3qcGMFePPuToi/B
	FYnxNCCGyCsrvhipl7e2CBa/pN3tEtcmdE+EQ6MWGpQRz/kMdswxN110a+DJ5NkTO9rOnZpRs9q
	UQemANmaz7h7x1a3UOM7blQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fhrV53z1vzLlTV;
	Fri, 27 Mar 2026 14:34:53 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 75CB34055B;
	Fri, 27 Mar 2026 14:40:59 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Mar 2026 14:40:58 +0800
Message-ID: <3ff48829-1168-4efd-84e1-dfffa99dcf98@huawei.com>
Date: Fri, 27 Mar 2026 14:40:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] perf: Add --pmu-filter option for filtering PMUs
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <jonathan.cameron@huawei.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<linuxarm@huawei.com>
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
 <20260310040607.1780971-2-xiaqinxin@huawei.com> <abMA1UTdr7k16_IK@google.com>
 <7f333498-4bed-4784-999f-7ee96dc63fd8@huawei.com>
 <CAP-5=fWxRR86FuvKM7y1trmEy3sNrt-zbxkCmVN8RekXB2rcog@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAP-5=fWxRR86FuvKM7y1trmEy3sNrt-zbxkCmVN8RekXB2rcog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/21 06:56:07, Ian Rogers <irogers@google.com> wrote:
> On Thu, Mar 19, 2026 at 3:23 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>>
>> On 2026/3/13 02:07:17, Namhyung Kim <namhyung@kernel.org> wrote:
>>> On Tue, Mar 10, 2026 at 12:06:07PM +0800, Qinxin Xia wrote:
>>>> This patch adds a new --pmu-filter option to perf-stat command to allow
>>>> filtering events on specific PMUs. This is useful when there are
>>>> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).
>>>>
>>>> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>       19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>>>                    0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
>>>>                    0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
>>>>                    0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
>>>>       19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
>>>>                    0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
>>>>                    0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
>>>>                    0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
>>>>       19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
>>>>           75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
>>>>           18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
>>>>                    0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
>>>>       19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>>>                    0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
>>>>                    0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
>>>>                    0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
>>>>
>>>>         19.417734480 seconds time elapsed
>>>>
>>>> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>        6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
>>>>           50,548,465      cpa_p0_wr_dat
>>>>            7,552,182      cpa_p0_rd_dat_64b
>>>>                    0      cpa_p0_rd_dat_32b
>>>>
>>>>          6.234139320 seconds time elapsed
>>>
>>> Ian, can you please take a look at this?
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>>
>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> 
> Sorry for the delay.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Hi Namhyung!

Ian has already provided Reviewed-by. Could you please apply this
patch if everything looks good to you? :-)

-- 
Thanks,
Qinxin

>>>> ---
>>>>    tools/perf/Documentation/perf-stat.txt |  4 ++++
>>>>    tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
>>>>    tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>>>>    tools/perf/util/parse-events.c         |  2 +-
>>>>    4 files changed, 37 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>>> index 7cccc3a847d1..b72a29c9223c 100644
>>>> --- a/tools/perf/Documentation/perf-stat.txt
>>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>>> @@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=true
>>>>    Only enable events on applying cpu with this type for hybrid platform
>>>>    (e.g. core or atom)"
>>>>
>>>> +--pmu-filter::
>>>> +Only enable events on applying pmu with specified for multiple
>>>> +pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
>>>> +
>>>>    EXAMPLES
>>>>    --------
>>>>
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index 73c2ba7e3076..69c83a5beb71 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -1214,6 +1214,21 @@ static int parse_cputype(const struct option *opt,
>>>>       return 0;
>>>>    }
>>>>
>>>> +static int parse_pmu_filter(const struct option *opt,
>>>> +                       const char *str,
>>>> +                       int unset __maybe_unused)
>>>> +{
>>>> +    struct evlist *evlist = *(struct evlist **)opt->value;
>>>> +
>>>> +    if (!list_empty(&evlist->core.entries)) {
>>>> +            fprintf(stderr, "Must define pmu-filter before events/metrics\n");
>>>> +            return -1;
>>>> +    }
>>>> +
>>>> +    parse_events_option_args.pmu_filter = str;
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static int parse_cache_level(const struct option *opt,
>>>>                            const char *str,
>>>>                            int unset __maybe_unused)
>>>> @@ -2561,6 +2576,10 @@ int cmd_stat(int argc, const char **argv)
>>>>                       "Only enable events on applying cpu with this type "
>>>>                       "for hybrid platform (e.g. core or atom)",
>>>>                       parse_cputype),
>>>> +            OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
>>>> +                    "Only enable events on applying pmu with specified "
>>>> +                    "for multiple pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
>>>> +                    parse_pmu_filter),
>>>>    #ifdef HAVE_LIBPFM
>>>>               OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>>>>                       "libpfm4 event selector. use 'perf list' to list available events",
>>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>>> index 46bf4dfeebc8..89b83ca38483 100644
>>>> --- a/tools/perf/util/metricgroup.c
>>>> +++ b/tools/perf/util/metricgroup.c
>>>> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
>>>>                                     const char *metric_or_groups)
>>>>    {
>>>>       const char *pm_pmu = pm->pmu ?: "cpu";
>>>> +    struct perf_pmu *perf_pmu = NULL;
>>>>
>>>> -    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
>>>> +    if (pm->pmu)
>>>> +            perf_pmu = perf_pmus__find(pm->pmu);
>>>> +
>>>> +    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
>>>> +       (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>>>>               return false;
>>>>
>>>>       return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
>>>> @@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>>>>    static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>>>                    struct expr_parse_ctx *ids, const char *modifier,
>>>>                    bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
>>>> -                 struct evlist **out_evlist)
>>>> +                 struct evlist **out_evlist,
>>>> +                 const char *filter_pmu)
>>>>    {
>>>>       struct parse_events_error parse_error;
>>>>       struct evlist *parsed_evlist;
>>>> @@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>>>       }
>>>>       pr_debug("Parsing metric events '%s'\n", events.buf);
>>>>       parse_events_error__init(&parse_error);
>>>> -    ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
>>>> +    ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
>>>>                            &parse_error, fake_pmu, /*warn_if_reordered=*/false,
>>>>                            /*fake_tp=*/false);
>>>>       if (ret) {
>>>> @@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>>>                                       /*modifier=*/NULL,
>>>>                                       /*group_events=*/false,
>>>>                                       tool_events,
>>>> -                                    &combined_evlist);
>>>> +                                    &combined_evlist,
>>>> +                                    (pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>>>               }
>>>>               if (combined)
>>>>                       expr__ctx_free(combined);
>>>> @@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>>>               }
>>>>               if (!metric_evlist) {
>>>>                       ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>>>> -                                    m->group_events, tool_events, &m->evlist);
>>>> +                                    m->group_events, tool_events, &m->evlist,
>>>> +                                    (pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>>>                       if (ret)
>>>>                               goto out;
>>>>
>>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>>> index b9efb296bba5..789ff4d15e47 100644
>>>> --- a/tools/perf/util/parse-events.c
>>>> +++ b/tools/perf/util/parse-events.c
>>>> @@ -429,7 +429,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
>>>>       if (parse_state->pmu_filter == NULL)
>>>>               return false;
>>>>
>>>> -    return strcmp(parse_state->pmu_filter, pmu->name) != 0;
>>>> +    return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
>>>>    }
>>>>
>>>>    static int parse_events_add_pmu(struct parse_events_state *parse_state,
>>>> --
>>>> 2.33.0
>>>>
>>>
>>
>> Gentle ping.
>> --
>> Thanks,
>> Qinxin
>>
