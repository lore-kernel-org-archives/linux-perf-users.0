Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9632D435;
	Wed, 21 Jan 2026 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965321; cv=none; b=TrWjWfAjNU4l8uLJdr9eVgAT38HBtrMYh6e9V5ZIB7ScxtPqWnoYI+2OTOWXLeyzg/Hs8WrydgB7X5N0vZY8mZIwI4nmdhClZwqT4xpXHquAHfsA+k5p+JPcgRRMZ/hVugAGu2SMucH1x0EeCtl9OayK9BjhVjYxisSMgs9pOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965321; c=relaxed/simple;
	bh=EJUwIubY877WbQk63UGlOlimf0ntp9+6wcYRP+7KH3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XdfOOARW/dp0Q6TG6G3/HeZ+7/ArX17GmJG8OT0Z6ZZv+ljZfEFIH4RwMS5wmRtRkgLLTUp3qXnYQXzb3SzjuKHPGb+RddR60tUTaWSOquW/MxW53zdCOYnGO5k7xPJqwdFqfpDrfsyS0s3VUq5cjFHEx50FB8TIvoDTXeUU5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=m26pb32E; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="m26pb32E"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7NZklfFTFGOOxN0TruesuQXdxFIRQiht8I7RfAV8A8A=;
	b=m26pb32E3SEv6FJt2g8kIqaBZx9V7lSTtqkGz4KaY3cn9QyUVtQ6YGV+quLqO4ksOX4PjfIQt
	7cXt+ayFIPNwA5MQS2W+2YltCVtM0Wp0M0uNdlJYiW1gvS2kDKh+vzQ1LGPSc2Y8MoGhIlx27rH
	Zu30LbT2aWqc9nAujP0pWeE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dwq3g2K5nz1prM8;
	Wed, 21 Jan 2026 11:11:43 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id E151340539;
	Wed, 21 Jan 2026 11:15:08 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Jan 2026 11:15:08 +0800
Message-ID: <b53c62a5-a752-436a-b039-cdc82b055fdd@huawei.com>
Date: Wed, 21 Jan 2026 11:15:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] perf: Add --uncorepmu option for filtering uncore
 PMUs
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <wangyushan12@huawei.com>, <hejunhao3@h-partners.com>,
	<jonathan.cameron@huawei.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <james.clark@linaro.org>, <linuxarm@huawei.com>
References: <20260120095058.2778834-1-xiaqinxin@huawei.com>
 <CAP-5=fVHMeWP3Ct_uOwYw4XKNdK7-eR=tbbUOFHwTdCVwBCZVg@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAP-5=fVHMeWP3Ct_uOwYw4XKNdK7-eR=tbbUOFHwTdCVwBCZVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/1/21 04:55:30, Ian Rogers <irogers@google.com> wrote:
> On Tue, Jan 20, 2026 at 1:51 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> This patch adds a new --uncorepmu option to perf-stat command to allow
>> filtering events on specific uncore PMUs. This is useful when there are
>> multiple uncore PMUs with the same type (e.g. hisi_sicl2_cpa0 and
>> hisi_sicl0_cpa0).
>>
>> eg:
>> [root@localhost tmp]# ./perf stat -M cpa_p0_avg_bw
>>   Performance counter stats for 'system wide':
>>
>>      19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
>>          75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
>>          18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
>>      19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>>                   0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
>>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
>>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
>>
>>        19.417734480 seconds time elapsed
>>
>> [root@localhost tmp]# ./perf stat --uncorepmu hisi_sicl2_cpa0 -M cpa_p0_avg_bw
>>   Performance counter stats for 'system wide':
>>
>>       6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
>>          50,548,465      cpa_p0_wr_dat
>>           7,552,182      cpa_p0_rd_dat_64b
>>                   0      cpa_p0_rd_dat_32b
>>
>>         6.234139320 seconds time elapsed
> 
> So normally for this case the -A/--no-merge will give you a per-PMU
> breakdown. It isn't restricted to a single PMU like the output here,
> but we similarly don't have options to restrict per-socket, per-dir,
> per-cluster and per-core. There is an option with --per-cache but that
> looks like a way to avoid having many --per-cache options rather than
> taking a value for a particular cache to only dump.
> 
> I did deliberate make the --cputype code generic so it could be used
> in ways like this, but it'd be nice to glob match the names for
> consistency with event parsing:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c#n2647
> I needed to have --cputype as Intel's early hybrid patches had added
> it before I cleaned things up to be more PMU oriented.
> 
Hello, Ian!

For core-related events and metric, we usually care about which core it
happens on, so we can filter it with -C.

Such as:

[root@localhost ~]# perf stat -C 0 -e L1-dcache-loads sleep 3

  Performance counter stats for 'CPU(s) 0':

            136,578      L1-dcache-loads 


        3.099147550 seconds time elapsed

[root@localhost tool]# ./perf stat -C 0 -M l1d_miss_rate sleep 3

  Performance counter stats for 'CPU(s) 0':

             18,708      L1-dcache-load-misses            #      3.6 % 
l1d_miss_rate
            513,038      L1-dcache-loads 


        3.004649800 seconds time elapsed

For core-independent events and metrics such as ddrc, smmu, and cpa, we
care about which hardware module they occur. (The example provided in
commit info is sicl.) so we want to filter it by pmu, for events I can
filter it with'cputype' (This is a little strange because sicl does not
belong to any cputype.). However, metric does not support this mode.

[root@localhost ~]# perf stat --cputype hisi_sicl0_cpa0 -e cpa_cycles
sleep 3

  Performance counter stats for 'system wide':

      3,003,492,731      cpa_cycles 


        3.003484270 seconds time elapsed


[root@localhost ~]# perf stat --cputype hisi_sicl0_cpa0 -M
cpa_p0_wr_dat sleep 3

Cannot find metric or group `cpa_p0_wr_dat'

This patch supports the metric scenario through '--uncorepmu'.

> So I can see the purpose of this patch in being low overhead compared
> to -A, I'm just not sure whether this is a PMU or an aggregation
> option. I also think the term "uncore" is kind of confusing and so
> have tried to keep it away from command line options. Why isn't is it
> just a pmu filter?
> 
> Thanks,
> Ian
> 
Perhaps we could make cputype a little more generic so that it could
also include pmu-filter functionality.

>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   tools/perf/Documentation/perf-stat.txt |  4 ++++
>>   tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
>>   tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>>   3 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index 1a766d4a2233..9c0952b43a57 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -573,6 +573,10 @@ $ perf config stat.no-csv-summary=true
>>   Only enable events on applying cpu with this type for hybrid platform
>>   (e.g. core or atom)"
>>
>> +--uncorepmu::
>> +Only enable events on applying uncore pmu with specified for multiple
>> +uncore pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
>> +
>>   EXAMPLES
>>   --------
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index ab40d85fb125..3f34bfc79179 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1235,6 +1235,28 @@ static int parse_cputype(const struct option *opt,
>>          return 0;
>>   }
>>
>> +static int parse_uncorepmu(const struct option *opt,
>> +                          const char *str,
>> +                          int unset __maybe_unused)
>> +{
>> +       const struct perf_pmu *pmu;
>> +       struct evlist *evlist = *(struct evlist **)opt->value;
>> +
>> +       if (!list_empty(&evlist->core.entries)) {
>> +               fprintf(stderr, "Must define uncorepmu before events/metrics\n");
>> +               return -1;
>> +       }
>> +
>> +       pmu = perf_pmus__pmu_for_pmu_filter(str);
>> +       if (!pmu || pmu->is_core) {
>> +               fprintf(stderr, "--uncorepmu %s is not supported!\n", str);
>> +               return -1;
>> +       }
>> +       parse_events_option_args.pmu_filter = pmu->name;
>> +
>> +       return 0;
>> +}
>> +
>>   static int parse_cache_level(const struct option *opt,
>>                               const char *str,
>>                               int unset __maybe_unused)
>> @@ -2579,6 +2601,10 @@ int cmd_stat(int argc, const char **argv)
>>                          "Only enable events on applying cpu with this type "
>>                          "for hybrid platform (e.g. core or atom)",
>>                          parse_cputype),
>> +               OPT_CALLBACK(0, "uncorepmu", &evsel_list, "uncore pmu",
>> +                       "Only enable events on applying uncore pmu with specified "
>> +                       "for multiple uncore pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
>> +                       parse_uncorepmu),
>>   #ifdef HAVE_LIBPFM
>>                  OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>>                          "libpfm4 event selector. use 'perf list' to list available events",
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 25c75fdbfc52..59ef71df20bd 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
>>                                        const char *metric_or_groups)
>>   {
>>          const char *pm_pmu = pm->pmu ?: "cpu";
>> +       struct perf_pmu *perf_pmu = NULL;
>>
>> -       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
>> +       if (pm->pmu)
>> +               perf_pmu = perf_pmus__find(pm->pmu);
>> +
>> +       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
>> +          (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>>                  return false;
>>
>>          return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
>> @@ -1260,7 +1265,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>>   static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>                       struct expr_parse_ctx *ids, const char *modifier,
>>                       bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
>> -                    struct evlist **out_evlist)
>> +                    struct evlist **out_evlist,
>> +                    const char *filter_pmu)
>>   {
>>          struct parse_events_error parse_error;
>>          struct evlist *parsed_evlist;
>> @@ -1314,7 +1320,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>>          }
>>          pr_debug("Parsing metric events '%s'\n", events.buf);
>>          parse_events_error__init(&parse_error);
>> -       ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
>> +       ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
>>                               &parse_error, fake_pmu, /*warn_if_reordered=*/false,
>>                               /*fake_tp=*/false);
>>          if (ret) {
>> @@ -1417,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>                                          /*modifier=*/NULL,
>>                                          /*group_events=*/false,
>>                                          tool_events,
>> -                                       &combined_evlist);
>> +                                       &combined_evlist,
>> +                                       (pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>                  }
>>                  if (combined)
>>                          expr__ctx_free(combined);
>> @@ -1472,7 +1479,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>                  }
>>                  if (!metric_evlist) {
>>                          ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>> -                                       m->group_events, tool_events, &m->evlist);
>> +                                       m->group_events, tool_events, &m->evlist,
>> +                                       (pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>>                          if (ret)
>>                                  goto out;
>>
>> --
>> 2.33.0
>>

-- 
Thanks,
Qinxin

