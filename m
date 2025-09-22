Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A407182B7;
	Mon, 22 Sep 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523672; cv=none; b=OqgwccKOWTmup6kMLqRF65zb+EUT+aSyQosUXRPS8bYNHi8RYGmXEZ5WMN23JCRBRODCTafMHuSmWHwwnWk/sMK0JOxBEn3XTHUFK4YcF75Alq5IYETFvn13/6S3gL2Bl+h851vMZKtrxTO+2/HaerEvOAu8PNfdVps8gOZM6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523672; c=relaxed/simple;
	bh=um8c9LylE867iljcdmP4EdcJQIucfIpVc7FL0tHNLNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceeQ8agyzidGZ72EDGLvaf+vlYdnrspidtf2d/2yoe5EXrg2H1qr3eL9PcL2bxT+3VT91TESJKO3OXBgAwTB8+9E+71ErjOR3a/QFrnMrUatPqq+oHZMNfVwc6eMv0ApBFhWZ0HRsMW8WzDbebTSvIi3zmZIttOS9qkWM6GnG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsTxnXe4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsTxnXe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758523666; x=1790059666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=um8c9LylE867iljcdmP4EdcJQIucfIpVc7FL0tHNLNI=;
  b=ZsTxnXe4KKXJSn4n/cH949sYqqzPs2I17KnSYt35mtMIX0SWflKiAGQB
   4KMzYLAvy1SWtnUjQ2P57jRikjRZx1fvJ+D1rEEovCBkddzBhoL1deuwU
   QGt0N291Fi6Py0vc54kAeKPz/uk+oimmZ81lFFGLUY2dfi1AsYv5wgtqV
   srL4blFZGXMkH4wtL8VxuQSKHk2EQve3sLvEt8bn1y2lv1M8wRR3gxBUi
   i3rypMwfZQyeAmQ6IyRPXEK9IQmmzyErxESCwIjfiJue5qgM+M0JjwBmn
   fa9m4nIcXMRLDB/gLyoXcca4L7FesbuZ2dPIooLmK+4PeoOuLTrYw9Y+d
   w==;
X-CSE-ConnectionGUID: ZPNH56mPQwSex3ayvRlqoA==
X-CSE-MsgGUID: ibXxIQbXT3aYxXISI0BxCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="71402749"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="71402749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 23:47:44 -0700
X-CSE-ConnectionGUID: ujVU+tgVTV6dYFeb2yPUvg==
X-CSE-MsgGUID: KJP3wthhR/SutvPer6xkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="207365735"
Received: from unknown (HELO [10.238.2.49]) ([10.238.2.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 23:47:42 -0700
Message-ID: <59d61506-9f20-4ac7-8e96-3fef1857c27f@linux.intel.com>
Date: Mon, 22 Sep 2025 14:47:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 5/6] perf tools kvm: Use "cycles" to sample guest for
 "kvm record" on Intel
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
 <20250919021659.1263351-6-dapeng1.mi@linux.intel.com> <aM2tSh6RGo2hB-XM@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aM2tSh6RGo2hB-XM@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/20/2025 3:21 AM, Arnaldo Carvalho de Melo wrote:
> On Fri, Sep 19, 2025 at 10:16:58AM +0800, Dapeng Mi wrote:
>> After KVM supports PEBS for guest on Intel platforms
>> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
> So this isn't something selectable, i.e. with the patch above there is
> no way to disable precise samples on the guest and instead allow the
> host to use perf kvm with cycles:P to have a more precise view of guest
> samples?
>
> I.e. wouldn't it be better to make cycles:P be accepted and since it
> fails, it drops precise_ip to zero as its the "most precise" it can use
> on the host when the guest is "hoarding"/using PEBS?
>
>> host loses the capability to sample guest with PEBS since all PEBS related
>> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
>> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
>> fails to sample guest on Intel platforms since "cycles:P" event is used to
>> sample guest by default as below case shows.
> Or it is even worse than I thought, the host _can_ ask for cycles:P, get
> it but then _when the guest_ vm-entries and while it is running, the
> host doesn't have access to it?

Unfortunately it's the latter one. That's why see the 0 guest records when
running "perf kvm record/top" commands, it would always success that host
creates cycles:P event, but once VM enters guest, guest owns the PEBS HW
resource (All PEBS MSRs are switched to guest values) and host has no way
to touch the PEBS HW resource in guest mode.


>
> Isn't there any programmatic way for the host to know if the guest is
> with PEBS and thus make cycles:P turn into plain "cycles"?

Currently we don't have such kind of code in Kernel. Of course, it can be
added in theory but it could be meaningless since when users try to run
"perf kvm" commands it's probably there are running VMs and the x86 guest
PEBS support in KVM is always enabled. 


>
> - Arnaldo
>
>> sudo perf kvm record -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
>>
>> So to ensure guest record can be sampled successfully, use "cycles"
>> instead of "cycles:P" to sample guest record by default on Intel
>> platforms. With this patch, the guest record can be sampled
>> successfully.
> but unconditionally not having access to PEBS :-\
>
> - Arnaldo
>  
>> sudo perf kvm record -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]
>>
>> Reported-by: Kevin Tian <kevin.tian@intel.com>
>> Fixes: cf8e55fe50df ("KVM: x86/pmu: Expose CPUIDs feature bits PDCM, DS, DTES64")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/perf/arch/x86/util/kvm-stat.c | 51 +++++++++++++++++++++++++++++
>>  tools/perf/builtin-kvm.c            | 10 ------
>>  tools/perf/util/kvm-stat.h          | 10 ++++++
>>  3 files changed, 61 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
>> index 424716518b75..bff36f9345ea 100644
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
>> @@ -211,3 +213,52 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
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
>> +	int ret = 0, i, j = *argc;
>> +
>> +	const struct option event_options[] = {
>> +		OPT_BOOLEAN('e', "event", &event, NULL),
>> +		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
>> +		OPT_END()
>> +	};
>> +
>> +	if (!x86__is_intel_cpu())
>> +		return 0;
>> +
>> +	tmp = calloc(j + 1, sizeof(char *));
>> +	if (!tmp)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < j; i++)
>> +		tmp[i] = argv[i];
>> +
>> +	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
>> +	if (!event) {
>> +		argv[j++] = STRDUP_FAIL_EXIT("-e");
>> +		argv[j++] = STRDUP_FAIL_EXIT("cycles");
>> +		*argc += 2;
>> +	}
>> +
>> +	free(tmp);
>> +	return 0;
>> +
>> +EXIT:
>> +	free(tmp);
>> +	return ret;
>> +}
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index d297a7b2c088..c0d62add4996 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -1636,16 +1636,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
>>  	return ret;
>>  }
>>  
>> -#define STRDUP_FAIL_EXIT(s)		\
>> -	({	char *_p;		\
>> -		_p = strdup(s);		\
>> -		if (!_p) {		\
>> -			ret = -ENOMEM;	\
>> -			goto EXIT;	\
>> -		}			\
>> -		_p;			\
>> -	})
>> -
>>  int __weak setup_kvm_events_tp(struct perf_kvm_stat *kvm __maybe_unused)
>>  {
>>  	return 0;
>> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
>> index 4249542544bb..53db3d56108b 100644
>> --- a/tools/perf/util/kvm-stat.h
>> +++ b/tools/perf/util/kvm-stat.h
>> @@ -190,5 +190,15 @@ static inline struct kvm_info *kvm_info__new(void)
>>  #define kvm_info__zput(ki) do { } while (0)
>>  #endif /* HAVE_KVM_STAT_SUPPORT */
>>  
>> +#define STRDUP_FAIL_EXIT(s)		\
>> +	({	char *_p;		\
>> +		_p = strdup(s);		\
>> +		if (!_p) {		\
>> +			ret = -ENOMEM;	\
>> +			goto EXIT;	\
>> +		}			\
>> +		_p;			\
>> +	})
>> +
>>  extern int kvm_add_default_arch_event(int *argc, const char **argv);
>>  #endif /* __PERF_KVM_STAT_H */
>> -- 
>> 2.34.1
