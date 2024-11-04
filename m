Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAA18BC0E;
	Mon,  4 Nov 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715127; cv=none; b=EEXG0xV7CGthEnV7Y9ttaBdxxlL4pXfSZs6UImrOGplhHuNoJmWcQDTF8NtQCDXQVBO87ZYuTq1CmgCvEf6NV4lsEVZmCxTkKo55J3jDHOiIswoSnNdKDvmoYPHABuR8lcughb3zXPvf++bf/76rjAPe7eqlvMe71Ihf97CAWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715127; c=relaxed/simple;
	bh=fMBrJ+ivi3ALTf8YCQpNicGCOTy9OFqS86iASws5tcM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NGkq9m0oxGDUjmu5aLv1sOLrdEDGkVGDsfagMOR26wo/N0ntlWWV8vXRrpW4JrtQvKH/2oVdH22QgTgJCroqwgGmxZuBO2ItyAKp+BPFw1TcKNAYVFAo9BKHwMqviZGaxjyarkoyvKhFQ3VXVOHdIEnpQbCY7r6aLP0p7eJzgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi8LMHyF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi8LMHyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730715125; x=1762251125;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fMBrJ+ivi3ALTf8YCQpNicGCOTy9OFqS86iASws5tcM=;
  b=Wi8LMHyFLb7+hW6/YlrqVzkhop6NT2Rwvg52Ul3H/IiIEEKpODSMIwym
   Mxa4r3hnAoRgFiPpS13Z6r2splRJBOGZDvbc7salyKRc3HNzWF02GuMX+
   2mxp/cbUw+yqhi5c8NcQzzfDLYmg6MNn61H4CYACScfiaPHC7TpW1qABq
   ud2jCCkwZJmV7UsO0bCQCPdNkH4dhWvIjkDMMyKjo1Wnt+uz41jFZLu+O
   p+mM/+H2lfZC0QNuluj4PPV7bgbR0DeVLA3OgHv7qFT9hVwp6yMQZRQeM
   QrtDDEptavN9iIrNdPyYkumkQ9BT4QlIZu1h8DNcjUWo6hd0urS3x8RyS
   Q==;
X-CSE-ConnectionGUID: dfAsZ8KVQjCEuwMXN48+BQ==
X-CSE-MsgGUID: SXLxa4SJQFqx5aCEugnXLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29832191"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29832191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:12:04 -0800
X-CSE-ConnectionGUID: cgqXwjL9QR+kmFyCZNdqIQ==
X-CSE-MsgGUID: Qjmd+TnCRs25GjKf0TAP8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88124969"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:11:56 -0800
Message-ID: <0b073156-dbf4-420e-b6e2-98d404ba38f1@intel.com>
Date: Mon, 4 Nov 2024 12:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 00/11] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 H Peter Anvin <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20241022155920.17511-1-adrian.hunter@intel.com>
 <7bacbe72-c283-453b-bf1f-6ba05b68cac8@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7bacbe72-c283-453b-bf1f-6ba05b68cac8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/10/24 15:16, Adrian Hunter wrote:
> On 22/10/24 18:59, Adrian Hunter wrote:
>> Hi
>>
>> Note for V14:
>> 	KVM patches dropped.
> 
> ping

ping

> 
>>
>> Note for V12:
>> 	There was a small conflict between the Intel PT changes in
>> 	"KVM: x86: Fix Intel PT Host/Guest mode when host tracing" and the
>> 	changes in this patch set, so I have put the patch sets together,
>> 	along with outstanding fix "perf/x86/intel/pt: Fix buffer full but
>> 	size is 0 case"
>>
>> 	Cover letter for KVM changes (patches 2 to 4):
>>
>> 	There is a long-standing problem whereby running Intel PT on host and guest
>> 	in Host/Guest mode, causes VM-Entry failure.
>>
>> 	The motivation for this patch set is to provide a fix for stable kernels
>> 	prior to the advent of the "Mediated Passthrough vPMU" patch set:
>>
>> 		https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/
>>
>> 	which would render a large part of the fix unnecessary but likely not be
>> 	suitable for backport to stable due to its size and complexity.
>>
>> 	Ideally, this patch set would be applied before "Mediated Passthrough vPMU"
>>
>> 	Note that the fix does not conflict with "Mediated Passthrough vPMU", it
>> 	is just that "Mediated Passthrough vPMU" will make the code to stop and
>> 	restart Intel PT unnecessary.
>>
>> Note for V11:
>> 	Moving aux_paused into a union within struct hw_perf_event caused
>> 	a regression because aux_paused was being written unconditionally
>> 	even though it is valid only for AUX (e.g. Intel PT) PMUs.
>> 	That is fixed in V11.
>>
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> These patches add such a facilty and show how it would work for Intel
>> Processor Trace.
>>
>> Maintainers of other AUX area tracing implementations are requested to
>> consider if this is something they might employ and then whether or not
>> the ABI would work for them.  Note, thank you to James Clark (ARM) for
>> evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
>> positively to the RFC.
>>
>> Changes to perf tools are now (since V4) fleshed out.
>>
>> Please note, Intel® Architecture Instruction Set Extensions and Future
>> Features Programming Reference March 2024 319433-052, currently:
>>
>> 	https://cdrdv2.intel.com/v1/dl/getContent/671368
>>
>> introduces hardware pause / resume for Intel PT in a feature named
>> Intel PT Trigger Tracing.
>>
>> For that more fields in perf_event_attr will be necessary.  The main
>> differences are:
>> 	- it can be applied not just to overflows, but optionally to
>> 	every event
>> 	- a packet is emitted into the trace, optionally with IP
>> 	information
>> 	- no PMI
>> 	- works with PMC and DR (breakpoint) events only
>>
>> Here are the proposed additions to perf_event_attr, please comment:
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 0c557f0a17b3..05dcc43f11bb 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -369,6 +369,22 @@ enum perf_event_read_format {
>>  	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
>>  };
>>  
>> +enum {
>> +	PERF_AUX_ACTION_START_PAUSED		=   1U << 0,
>> +	PERF_AUX_ACTION_PAUSE			=   1U << 1,
>> +	PERF_AUX_ACTION_RESUME			=   1U << 2,
>> +	PERF_AUX_ACTION_EMIT			=   1U << 3,
>> +	PERF_AUX_ACTION_NR			= 0x1f << 4,
>> +	PERF_AUX_ACTION_NO_IP			=   1U << 9,
>> +	PERF_AUX_ACTION_PAUSE_ON_EVT		=   1U << 10,
>> +	PERF_AUX_ACTION_RESUME_ON_EVT		=   1U << 11,
>> +	PERF_AUX_ACTION_EMIT_ON_EVT		=   1U << 12,
>> +	PERF_AUX_ACTION_NR_ON_EVT		= 0x1f << 13,
>> +	PERF_AUX_ACTION_NO_IP_ON_EVT		=   1U << 18,
>> +	PERF_AUX_ACTION_MASK			= ~PERF_AUX_ACTION_START_PAUSED,
>> +	PERF_AUX_PAUSE_RESUME_MASK		= PERF_AUX_ACTION_PAUSE | PERF_AUX_ACTION_RESUME,
>> +};
>> +
>>  #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
>>  #define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
>>  #define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
>> @@ -515,10 +531,19 @@ struct perf_event_attr {
>>  	union {
>>  		__u32	aux_action;
>>  		struct {
>> -			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
>> -				aux_pause        :  1, /* on overflow, pause AUX area tracing */
>> -				aux_resume       :  1, /* on overflow, resume AUX area tracing */
>> -				__reserved_3     : 29;
>> +			__u32	aux_start_paused  :  1, /* start AUX area tracing paused */
>> +				aux_pause         :  1, /* on overflow, pause AUX area tracing */
>> +				aux_resume        :  1, /* on overflow, resume AUX area tracing */
>> +				aux_emit          :  1, /* generate AUX records instead of events */
>> +				aux_nr            :  5, /* AUX area tracing reference number */
>> +				aux_no_ip         :  1, /* suppress IP in AUX records */
>> +				/* Following apply to event occurrence not overflows */
>> +				aux_pause_on_evt  :  1, /* on event, pause AUX area tracing */
>> +				aux_resume_on_evt :  1, /* on event, resume AUX area tracing */
>> +				aux_emit_on_evt   :  1, /* generate AUX records instead of events */
>> +				aux_nr_on_evt     :  5, /* AUX area tracing reference number */
>> +				aux_no_ip_on_evt  :  1, /* suppress IP in AUX records */
>> +				__reserved_3      : 13;
>>  		};
>>  	};
>>
>>
>> Changes in V14:
>>       Dropped KVM patches
>>
>>       perf/x86/intel/pt: Add support for pause / resume
>> 	Set pt->handle_nmi after configuration is completed instead of during
>>
>> Changes in V13:
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Do aux_resume at the end of __perf_event_overflow() so as to trace
>> 	less of perf itself
>>
>>       perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
>> 	Add error message also in EOPNOTSUPP case (Leo)
>>
>> Changes in V12:
>> 	Add previously sent patch "perf/x86/intel/pt: Fix buffer full
>> 	but size is 0 case"
>>
>> 	Add previously sent patch set "KVM: x86: Fix Intel PT Host/Guest
>> 	mode when host tracing"
>>
>> 	Rebase on current tip plus patch set "KVM: x86: Fix Intel PT Host/Guest
>> 	mode when host tracing"
>>
>> Changes in V11:
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Make assignment to event->hw.aux_paused conditional on
>> 	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).
>>
>>       perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
>> 	Remove definition of has_aux_action() because it has
>> 	already been added as an inline function.
>>
>>       perf/x86/intel/pt: Fix sampling synchronization
>>       perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
>>       perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
>> 	Dropped because they have already been applied
>>
>> Changes in V10:
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Move aux_paused into a union within struct hw_perf_event.
>> 	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
>> 	Factor out has_aux_action() as an inline function.
>> 	Use scoped_guard for irqsave.
>> 	Move calls of perf_event_aux_pause() from __perf_event_output()
>> 	to __perf_event_overflow().
>>
>> Changes in V9:
>>       perf/x86/intel/pt: Fix sampling synchronization
>> 	New patch
>>
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Move aux_paused to struct hw_perf_event
>>
>>       perf/x86/intel/pt: Add support for pause / resume
>> 	Add more comments and barriers for resume_allowed and
>> 	pause_allowed
>> 	Always use WRITE_ONCE with resume_allowed
>>
>>
>> Changes in V8:
>>
>>       perf tools: Parse aux-action
>> 	Fix clang warning:
>> 	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
>> 	     821 |         {NULL},
>> 	         |              ^
>>
>> Changes in V7:
>>
>> 	Add Andi's Reviewed-by for patches 2-12
>> 	Re-base
>>
>> Changes in V6:
>>
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
>> 	Expanded comment about guarding against NMI
>>
>> Changes in V5:
>>
>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Added James' Ack
>>
>>     perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
>> 	New patch
>>
>>     perf tools
>> 	Added Ian's Ack
>>
>> Changes in V4:
>>
>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Rename aux_output_cfg -> aux_action
>> 	Reorder aux_action bits from:
>> 		aux_pause, aux_resume, aux_start_paused
>> 	to:
>> 		aux_start_paused, aux_pause, aux_resume
>> 	Fix aux_action bits __u64 -> __u32
>>
>>     coresight: Have a stab at support for pause / resume
>> 	Dropped
>>
>>     perf tools
>> 	All new patches
>>
>> Changes in RFC V3:
>>
>>     coresight: Have a stab at support for pause / resume
>> 	'mode' -> 'flags' so it at least compiles
>>
>> Changes in RFC V2:
>>
>> 	Use ->stop() / ->start() instead of ->pause_resume()
>> 	Move aux_start_paused bit into aux_output_cfg
>> 	Tighten up when Intel PT pause / resume is allowed
>> 	Add an example of how it might work for CoreSight
>>
>>
>> Adrian Hunter (11):
>>       perf/x86/intel/pt: Fix buffer full but size is 0 case
>>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>>       perf/x86/intel/pt: Add support for pause / resume
>>       perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
>>       perf tools: Add aux_start_paused, aux_pause and aux_resume
>>       perf tools: Add aux-action config term
>>       perf tools: Parse aux-action
>>       perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
>>       perf intel-pt: Improve man page format
>>       perf intel-pt: Add documentation for pause / resume
>>       perf intel-pt: Add a test for pause / resume
>>
>>  arch/x86/events/intel/core.c               |   4 +-
>>  arch/x86/events/intel/pt.c                 |  84 +++-
>>  arch/x86/events/intel/pt.h                 |   6 +
>>  include/linux/perf_event.h                 |  28 ++
>>  include/uapi/linux/perf_event.h            |  11 +-
>>  kernel/events/core.c                       |  75 +++-
>>  kernel/events/internal.h                   |   1 +
>>  tools/include/uapi/linux/perf_event.h      |  11 +-
>>  tools/perf/Documentation/perf-intel-pt.txt | 596 ++++++++++++++++++-----------
>>  tools/perf/Documentation/perf-record.txt   |   4 +
>>  tools/perf/builtin-record.c                |   4 +-
>>  tools/perf/tests/shell/test_intel_pt.sh    |  28 ++
>>  tools/perf/util/auxtrace.c                 |  67 +++-
>>  tools/perf/util/auxtrace.h                 |   6 +-
>>  tools/perf/util/evsel.c                    |  15 +
>>  tools/perf/util/evsel.h                    |   1 +
>>  tools/perf/util/evsel_config.h             |   1 +
>>  tools/perf/util/parse-events.c             |  10 +
>>  tools/perf/util/parse-events.h             |   1 +
>>  tools/perf/util/parse-events.l             |   1 +
>>  tools/perf/util/perf_event_attr_fprintf.c  |   3 +
>>  tools/perf/util/pmu.c                      |   1 +
>>  22 files changed, 716 insertions(+), 242 deletions(-)
>>
>>
>> Regards
>> Adrian
> 

