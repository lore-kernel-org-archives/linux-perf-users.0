Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD23C133;
	Thu,  7 Aug 2025 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536099; cv=none; b=SN6epNCz2VHePEa4+RSHjpTBTOquOcoJYrBvyYsubBeXlEcww57OmZVTcwZalkK+VeeLyharxN5i6PYtHvqYpZeVuJZ0pbkbW9WOVFS2EBDO11t7i0rKXRH7SU5L7Xg5FNfsH28zUCRU18gGP1/RQTD0yJ/eHH+0pfNz8vf2MU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536099; c=relaxed/simple;
	bh=GRk527uBL2x5DQixo/UdMSzo0YC2frEsKN6fDg6Cff0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akX1GRmkjdd+6kpuGdgvJHDqt/0qkEmf9ljEepoG3KK96vF99eYLCa9RGOMwi+X3ozXCEDQVRLWy9W7BsQTqsVXumNq5djs8WTzJsejmKBDdxjtKzcbtQHX1CL5zPJaPzxHLYrIliqqZlTwLbsDEYQ/u3M0STLWsMGD4kZpBvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiwO/d4l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiwO/d4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754536098; x=1786072098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GRk527uBL2x5DQixo/UdMSzo0YC2frEsKN6fDg6Cff0=;
  b=FiwO/d4l0/tv0xzTVNr4Z2rRmJDFVzbY7ynmfn9kGtlAlPmfZN1rh9TG
   knoeNBB95ZQLJiutBYMbu0lncIBYky8QuhMAgLhSNCejGarXRQpQ9QW/y
   zsbBIHqV+/2CW25VXhf12TyWIPSE9qI2ZttlpZXfjaNcFvh39IPMcZfaF
   i8Hoc6qQ8nQtF6BJASKa8Tql+ncOJvAF9LeBIQXampeD65aVczP1HD9Cz
   tod/MsGu96HabmRStNGGMk985gGGhkL+1d/iEPyNlQMscmoL196WTdAAe
   u84vHXQnyrF5oJ+Pirp8JCIoYCRHo2hrzQx1mEHk5/uingwNn3NXwvx5j
   A==;
X-CSE-ConnectionGUID: 5N/EwZa9S3KNWAeqdDU2yg==
X-CSE-MsgGUID: GB85AskfQm+aCUde3ZGJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67562132"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67562132"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 20:08:18 -0700
X-CSE-ConnectionGUID: NEkFjQjTQPm+tJwfZnYgsA==
X-CSE-MsgGUID: 0uspJoupTai29Vx6JfNEJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164588660"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 20:08:15 -0700
Message-ID: <154b59ee-0858-4caf-9972-3679db0a0c49@linux.intel.com>
Date: Thu, 7 Aug 2025 11:08:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf tools kvm: Use "cycles" to sample guest for "kvm
 record" on Intel
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-5-dapeng1.mi@linux.intel.com>
 <aJPuhpFK_ZjLk-ct@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aJPuhpFK_ZjLk-ct@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/7/2025 8:08 AM, Namhyung Kim wrote:
> On Tue, Aug 05, 2025 at 08:46:32AM +0800, Dapeng Mi wrote:
>> After KVM supports PEBS for guest on Intel platforms
>> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
>> host loses the capability to sample guest with PEBS since all PEBS related
>> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
>> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
>> fails to sample guest on Intel platforms since "cycles:P" event is used to
>> sample guest by default as below case shows.
> Do you mean we cannot use "cycles:PG" for perf kvm record?

Yes. Here is the output on Intel Sapphire rapids.

sudo ./perf record -e cycles:PG -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.801 MB perf.data ]

No guest records are captured with PEBS, and guest PEBS records can be
sampled only without PEBS.

sudo ./perf record -e cycles:G -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.798 MB perf.data (60 samples) ]


>
>> sudo perf kvm record -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
>>
>> So to ensure guest record can be sampled successfully, use "cycles"
>> instead of "cycles:P" to sample guest record by default on Intel
>> platforms. With this patch, the guest record can be sampled
>> successfully.
>>
>> sudo perf kvm record -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]
> What if user already gave some events in the command line?  I think you
> need to check if "-e" or "--event" (and "--pfm-events" too) is in the
> argv[] before adding these.

kvm_add_default_arch_event() would detect if user already sets events explicitly. If so, it won't add "cycles" event any more. Thanks.

>
> Thanks,
> Namhyung
>
>> Reported-by: Kevin Tian <kevin.tian@intel.com>
>> Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/kvm-stat.c | 46 +++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
>> index 424716518b75..cdb5f3e1b5be 100644
>> --- a/tools/perf/arch/x86/util/kvm-stat.c
>> +++ b/tools/perf/arch/x86/util/kvm-stat.c
>> @@ -3,9 +3,11 @@
>>  #include <string.h>
>>  #include "../../../util/kvm-stat.h"
>>  #include "../../../util/evsel.h"
>> +#include "../../../util/env.h"
>>  #include <asm/svm.h>
>>  #include <asm/vmx.h>
>>  #include <asm/kvm.h>
>> +#include <subcmd/parse-options.h>
>>  
>>  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
>>  define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
>> @@ -211,3 +213,47 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>>  
>>  	return 0;
>>  }
>> +
>> +/*
>> + * After KVM supports PEBS for guest on Intel platforms
>> + * (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
>> + * host loses the capability to sample guest with PEBS since all PEBS related
>> + * MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
>> + * switched to guest GVA at vm-entry. This would lead to "perf kvm record"
>> + * fails to sample guest on Intel platforms since "cycles:P" event is used to
>> + * sample guest by default.
>> + *
>> + * So, to avoid this issue explicitly use "cycles" instead of "cycles:P" event
>> + * by default to sample guest on Intel platforms.
>> + */
>> +int kvm_add_default_arch_event(int *argc, const char **argv)
>> +{
>> +	const char **tmp;
>> +	bool event = false;
>> +	int i, j = *argc;
>> +
>> +	const struct option event_options[] = {
>> +		OPT_BOOLEAN('e', "event", &event, NULL),
>> +		OPT_END()
>> +	};
>> +
>> +	if (!x86__is_intel_cpu())
>> +		return 0;
>> +
>> +	tmp = calloc(j + 1, sizeof(char *));
>> +	if (!tmp)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < j; i++)
>> +		tmp[i] = argv[i];
>> +
>> +	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
>> +	if (!event) {
>> +		argv[j++] = strdup("-e");
>> +		argv[j++] = strdup("cycles");
>> +		*argc += 2;
>> +	}
>> +
>> +	free(tmp);
>> +	return 0;
>> +}
>> -- 
>> 2.34.1
>>
