Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3131413A3EF;
	Tue, 18 Jun 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707909; cv=none; b=oUBltlPAyZqSEFDwKl1ELbAHPn22b0YhwooZ8AYp1x1WhOtqaDjGs2on/NzraCHaiYslGqdCqFZkq4o5yNr13RYKrVN9H008ScJxzXaS7kHYM9mFGTeAskjDKgSb9s2c1hTA5UoeHzwMZJvccH4NPewRpM1NDYy/s9glQ88m3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707909; c=relaxed/simple;
	bh=dqqDQrONi6GgiJG2rZvb/DnknGfgShyAUAlLINpXwtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJhXaYijokrp9yfef8h/qOjBjfvoZ3o2veu52MdM13eqrtj1YHM1SGflpml860jAv6BEW//mvybeXRBSqxi4m5w09SffX1F3TiPttAjxrelatMJ4aTAEik9rbrU7AndmBtEmwt8oL4C8M8/p6vz0NjipJ6IlMcpCUCd6c4phf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F8EDA7;
	Tue, 18 Jun 2024 03:52:11 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83D73F6A8;
	Tue, 18 Jun 2024 03:51:44 -0700 (PDT)
Message-ID: <4e2422e8-f082-4ce1-8b2b-63721fda2c74@arm.com>
Date: Tue, 18 Jun 2024 11:51:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf pmu: Don't de-duplicate core PMUs
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240617134348.208241-1-james.clark@arm.com>
 <20240617134348.208241-3-james.clark@arm.com>
 <CAP-5=fWzmz+_9-Rz1xPwN0sniGvhyiRtrR-OCqAJgiWybpoCXg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWzmz+_9-Rz1xPwN0sniGvhyiRtrR-OCqAJgiWybpoCXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/06/2024 22:30, Ian Rogers wrote:
> On Mon, Jun 17, 2024, 6:44 AM James Clark <james.clark@arm.com> wrote:
> 
>> Arm PMUs have a suffix, either a single decimal (armv8_pmuv3_0) or 3 hex
>> digits which (armv8_cortex_a53) which Perf assumes are both strippable
>> suffixes for the purposes of deduplication. S390 "cpum_cf" is a
>> similarly suffixed core PMU but is only two characters so is not treated
>> as strippable because the rules are a minimum of 3 hex characters or 1
>> decimal character.
>>
>> There are two paths involved in listing PMU events:
>>
>>  * HW/cache event printing assumes core PMUs don't have suffixes so
>>    doesn't try to strip.
>>  * Sysfs PMU events share the printing function with uncore PMUs which
>>    strips.
>>
>> This results in slightly inconsistent Perf list behavior if a core PMU
>> has a suffix:
>>
>>   # perf list
>>   ...
>>   armv8_pmuv3_0/branch-load-misses/
>>   armv8_pmuv3/l3d_cache_wb/          [Kernel PMU event]
>>   ...
>>
>> Fix it by partially reverting back to the old list behavior where
>> stripping was only done for uncore PMUs. For example commit 8d9f5146f5da
>> ("perf pmus: Sort pmus by name then suffix") mentions that only PMUs
>> starting 'uncore_' are considered to have a potential suffix. This
>> change doesn't go back that far, but does only strip PMUs that are
>> !is_core. This keeps the desirable behavior where the many possibly
>> duplicated uncore PMUs aren't repeated, but it doesn't break listing for
>> core PMUs.
>>
>> Searching for a PMU continues to use the new stripped comparison
>> functions, meaning that it's still possible to request an event by
>> specifying the common part of a PMU name, or even open events on
>> multiple similarly named PMUs. For example:
>>
>>   # perf stat -e armv8_cortex/inst_retired/
>>
>>   5777173628      armv8_cortex_a53/inst_retired/          (99.93%)
>>   7469626951      armv8_cortex_a57/inst_retired/          (49.88%)
>>
>> Fixes: 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like
>> mrvl_ddr_pmu")
>> Signed-off-by: James Clark <james.clark@arm.com>
>>
> 
> Should this have my suggested by tag?
> 
> Thanks,
> Ian

Yep, you're right I can add it

> 
> ---
>>  tools/perf/util/pmu.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 97d74fe6d816..b73946ba9d05 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -847,6 +847,22 @@ __weak const struct pmu_metrics_table
>> *pmu_metrics_table__find(void)
>>         return perf_pmu__find_metrics_table(NULL);
>>  }
>>
>> +/**
>> + * Return the length of the PMU name not including the suffix for uncore
>> PMUs.
>> + *
>> + * We want to deduplicate many similar uncore PMUs by stripping their
>> suffixes,
>> + * but there are never going to be too many core PMUs and the suffixes
>> might be
>> + * interesting. "arm_cortex_a53" vs "arm_cortex_a57" or "cpum_cf" for
>> example.
>> + *
>> + * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are
>> visible
>> + */
>> +static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, bool
>> skip_duplicate_pmus)
>> +{
>> +       return skip_duplicate_pmus && !pmu->is_core
>> +               ? pmu_name_len_no_suffix(pmu->name)
>> +               : strlen(pmu->name);
>> +}
>> +
>>  /**
>>   * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring
>> any
>>   *                                   trailing suffix? The Suffix must be
>> in form
>> @@ -1796,9 +1812,7 @@ static char *format_alias(char *buf, int len, const
>> struct perf_pmu *pmu,
>>                           const struct perf_pmu_alias *alias, bool
>> skip_duplicate_pmus)
>>  {
>>         struct parse_events_term *term;
>> -       size_t pmu_name_len = skip_duplicate_pmus
>> -               ? pmu_name_len_no_suffix(pmu->name)
>> -               : strlen(pmu->name);
>> +       size_t pmu_name_len = pmu_deduped_name_len(pmu,
>> skip_duplicate_pmus);
>>         int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len,
>> pmu->name, alias->name);
>>
>>         list_for_each_entry(term, &alias->terms.terms, list) {
>> @@ -1839,9 +1853,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu,
>> bool skip_duplicate_pmus,
>>                 size_t buf_used, pmu_name_len;
>>
>>                 info.pmu_name = event->pmu_name ?: pmu->name;
>> -               pmu_name_len = skip_duplicate_pmus
>> -                       ? pmu_name_len_no_suffix(info.pmu_name)
>> -                       : strlen(info.pmu_name);
>> +               pmu_name_len = pmu_deduped_name_len(pmu,
>> skip_duplicate_pmus);
>>                 info.alias = NULL;
>>                 if (event->desc) {
>>                         info.name = event->name;
>> --
>> 2.34.1
>>
>>
> 
