Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749515C13F;
	Wed, 11 Sep 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069318; cv=none; b=OoG2RGgtTzbDHuD1o+rRKk+Nr8Lo83R4KUBwIp7i9lYbwvT03wjzn2D/uCfPAq5w/5zmoGNoFd0dk1JL5g1I+L0j66r4jfJOQxiI2bzkUM7MTeLE3OnE1MBJ3o6Q4omAWHz6qv8eAB6VHdqd0zZqrUQf9iEPV8OmJwxbM1YFXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069318; c=relaxed/simple;
	bh=l8agknXOHhuK8j6L1LR3NxdQOL2ZslLS4qY5lnPt0mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lv94ue0tolwehU3JkRz8NAMJlgsg34xCGEXXXna2DdTUnYdKqS3qK9FcMxYlJuSX62TpMt8kwnewH62ArvSUhAIiJhByTAtvd6539b2WElh19XW2XyRU61m7j1UQUWkCMypxdWSKFZc45uqdc45ca0cB8fpgJzSqUsfWJ04VScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biyLkvWw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biyLkvWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726069317; x=1757605317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l8agknXOHhuK8j6L1LR3NxdQOL2ZslLS4qY5lnPt0mA=;
  b=biyLkvWwBNzuhth85k8P+8IWpetRN9U9+iPJan3QWbIRGdD2l/0e+GU2
   vgU1IuTp9RB3tvp/6NUmx8WDuKJ5PsNSZCMh0/B6enOUQqPx5neGf2cv0
   nGQnCqEeuiOG7uebeX/avru/jK/7GP5izEl7pn3ht+/R01WyQ8fYnuIy4
   b/lLPg4d0WhKIHNcF46mBWZ2fZLjR7S+oJHeKmHQHtZUi4kAqrSaHJ47S
   DWgCZQGEGNh8CV1eq8K31QpCI/LC2WRBpJnThRe7/xD+ihN8tSVqpkfBX
   ceNc7uEZ8i6nCccFZCZqSzYE+uly1k9NDayqx305U1UcqkWY1CfY0oXJy
   g==;
X-CSE-ConnectionGUID: QC6DNq0SRDiYYkXjC9SOFA==
X-CSE-MsgGUID: ecY7zWm0Sui84lVrKTdbDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36015427"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="36015427"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:41:57 -0700
X-CSE-ConnectionGUID: NA3R0DhuSFCI/FM+p7Hh9g==
X-CSE-MsgGUID: CumHc+JeTxGqD70JdEQ5Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="104864090"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:41:56 -0700
Received: from [10.212.119.193] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4B7CA20CFEDC;
	Wed, 11 Sep 2024 08:41:55 -0700 (PDT)
Message-ID: <17676366-31b8-4c7c-b2e5-a91b054a5e7c@linux.intel.com>
Date: Wed, 11 Sep 2024 11:41:54 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf env: Find correct branch counter info on hybrid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240909184201.553519-1-kan.liang@linux.intel.com>
 <ZuGnCqBa4HZUzrmX@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZuGnCqBa4HZUzrmX@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-11 10:19 a.m., Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 09, 2024 at 11:42:00AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> No event is printed in the "Branch Counter" column on hybrid machines.
>>
>> For example,
>>  $perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S"
>>  -j any,counter
>>  $perf report --total-cycles
> 
> So I tried this on an Intel Hybrid system, I start the TUI, then try 'B'
> and, after applying your patch:
> 
>   0.66%  67.8K  0.00%   75                    ┌─Branch counter abbr list────────────┐ibc_write+18]          libc.so.6
>   0.63%  65.4K  0.00%  106                  [p│                                     │r_active+159]          [kernel.kallsyms]
>   0.61%  63.2K  0.01%  175  [native_queued_spi│ The branch counter is not available.│in_lock_slowpath+528]  [kernel.kallsyms]
>   0.57%  58.4K  0.00%   39         [syscall_ex│Press any key...                     │ser_mode+109]          [kernel.kallsyms]
>   0.54%  55.6K  0.00%    1  [_IO_file_xsputn@@└─────────────────────────────────────┘BC_2.2.5+316]          libc.so.6
> 
> The perf.data was obtained from:
> 
> root@number:~# perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S" -j any,counter find /
> 
> And:
> 
> root@number:~# perf evlist --group 
> {cpu_core/branch-instructions/pp,cpu_core/branches/}
> dummy:u
> root@number:~# 
> 
> Only mishap above we discussed already, the missing :S, and then:
> 
> root@number:~# perf evlist -v
> cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config: 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY

For a hybrid client, the "Branch Counter" feature is only supported
starting from the just released Lunar Lake. Perf falls back to only
"ANY" on your Raptor Lake.

The "The branch counter is not available" message is expected.

Here is the perf evlist result from my Lunar Lake machine,

#perf evlist -v
cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config:
0xc4 (branch-instructions), { sample_period, sample_freq }: 4000,
sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER,
read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1,
precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type:
ANY|COUNTERS


Thanks,
Kan
> cpu_core/branches/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000004, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> root@number:~#
> 
>         Version: Intel(R) Core(TM) i7-14700K
>         Voltage: 1.0 V
>         External Clock: 100 MHz
>         Max Speed: 8500 MHz
>         Current Speed: 3400 MHz
>         Status: Populated, Enabled
>         Upgrade: Socket LGA1700
> 
> What am I doing wrong not to get to see that "branch counter abbr list"
> info to then check before/after your patch?
> 
> - Arnaldo
>  
>>  # Branch counter abbr list:
>>  # cpu_core/branch-instructions/pp = A
>>  # cpu_core/branches/ = B
>>  # '-' No event occurs
>>  # '+' Event occurrences may be lost due to branch counter saturated
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles  Branch Counter
>>  # ...............  ..............  ...........  ..........  ..............
>>            44.54%          727.1K        0.00%           1   |+   |+   |
>>            36.31%          592.7K        0.00%           2   |+   |+   |
>>            17.83%          291.1K        0.00%           1   |+   |+   |
>>
>> The branch counter information (br_cntr_width and br_cntr_nr) in the
>> perf_env is retrieved from the CPU_PMU_CAPS. However, the CPU_PMU_CAPS
>> is not available on hybrid machines. Without the width information, the
>> number of occurrences of an event cannot be calculated.
>>
>> For a hybrid machine, the caps information should be retrieved from the
>> PMU_CAPS, and stored in the perf_env->pmu_caps.
>>
>> Add a perf_env__find_br_cntr_info() to return the correct branch counter
>> information from the corresponding fields.
>>
>> Fixes: 6f9d8d1de2c6 ("perf script: Add branch counters")
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/builtin-script.c |  5 +++--
>>  tools/perf/util/annotate.c  |  5 +++--
>>  tools/perf/util/env.c       | 15 +++++++++++++++
>>  tools/perf/util/env.h       |  3 +++
>>  tools/perf/util/session.c   |  6 ++++--
>>  5 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index dbe792b52c5c..a644787fa9e1 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -1241,10 +1241,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>>  	}
>>  
>>  	if (PRINT_FIELD(BRCNTR)) {
>> -		unsigned int width = evsel__env(evsel)->br_cntr_width;
>> -		unsigned int i = 0, j, num, mask = (1L << width) - 1;
>>  		struct evsel *pos = evsel__leader(evsel);
>> +		unsigned int i = 0, j, num, mask, width;
>>  
>> +		perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
>> +		mask = (1L << width) - 1;
>>  		printed += fprintf(fp, "br_cntr: ");
>>  		evlist__for_each_entry_from(evsel->evlist, pos) {
>>  			if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 4990c70b1794..c6ebde9d40a8 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -333,14 +333,15 @@ static int symbol__account_br_cntr(struct annotated_branch *branch,
>>  {
>>  	unsigned int br_cntr_nr = evsel__leader(evsel)->br_cntr_nr;
>>  	unsigned int base = evsel__leader(evsel)->br_cntr_idx;
>> -	unsigned int width = evsel__env(evsel)->br_cntr_width;
>>  	unsigned int off = offset * evsel->evlist->nr_br_cntr;
>> -	unsigned int i, mask = (1L << width) - 1;
>>  	u64 *branch_br_cntr = branch->br_cntr;
>> +	unsigned int i, mask, width;
>>  
>>  	if (!br_cntr || !branch_br_cntr)
>>  		return 0;
>>  
>> +	perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
>> +	mask = (1L << width) - 1;
>>  	for (i = 0; i < br_cntr_nr; i++) {
>>  		u64 cntr = (br_cntr >> i * width) & mask;
>>  
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index a459374d0a1a..1edbccfc3281 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -624,3 +624,18 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>>  	free(cap_eq);
>>  	return NULL;
>>  }
>> +
>> +void perf_env__find_br_cntr_info(struct perf_env *env,
>> +				 unsigned int *nr,
>> +				 unsigned int *width)
>> +{
>> +	if (nr) {
>> +		*nr = env->cpu_pmu_caps ? env->br_cntr_nr :
>> +					  env->pmu_caps->br_cntr_nr;
>> +	}
>> +
>> +	if (width) {
>> +		*width = env->cpu_pmu_caps ? env->br_cntr_width :
>> +					     env->pmu_caps->br_cntr_width;
>> +	}
>> +}
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index 2a2c37cc40b7..51b36c36019b 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -192,4 +192,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>>  			     const char *cap);
>>  
>>  bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
>> +void perf_env__find_br_cntr_info(struct perf_env *env,
>> +				 unsigned int *nr,
>> +				 unsigned int *width);
>>  #endif /* __PERF_ENV_H */
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index b492300ec959..dbaf07bf6c5f 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -856,7 +856,6 @@ static void branch_stack__printf(struct perf_sample *sample,
>>  	struct branch_entry *entries = perf_sample__branch_entries(sample);
>>  	bool callstack = evsel__has_branch_callstack(evsel);
>>  	u64 *branch_stack_cntr = sample->branch_stack_cntr;
>> -	struct perf_env *env = evsel__env(evsel);
>>  	uint64_t i;
>>  
>>  	if (!callstack) {
>> @@ -900,8 +899,11 @@ static void branch_stack__printf(struct perf_sample *sample,
>>  	}
>>  
>>  	if (branch_stack_cntr) {
>> +		unsigned int br_cntr_width, br_cntr_nr;
>> +
>> +		perf_env__find_br_cntr_info(evsel__env(evsel), &br_cntr_nr, &br_cntr_width);
>>  		printf("... branch stack counters: nr:%" PRIu64 " (counter width: %u max counter nr:%u)\n",
>> -			sample->branch_stack->nr, env->br_cntr_width, env->br_cntr_nr);
>> +			sample->branch_stack->nr, br_cntr_width, br_cntr_nr);
>>  		for (i = 0; i < sample->branch_stack->nr; i++)
>>  			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_cntr[i]);
>>  	}
>> -- 
>> 2.38.1
> 
