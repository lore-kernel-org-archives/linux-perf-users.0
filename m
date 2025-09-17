Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899031F462D;
	Wed, 17 Sep 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153171; cv=none; b=ik36DIoqxsUssQmAq5npFS3TAaYAYEhfrfFr71yP9G29nAxoq2o22Qk7dP5vb5XdqCPmIxeIX37+vrChLpQc/RFJ5wHQE+og1Uyn/66jxlwojhv8KLO0dqANjs3gJ/gJck5Pn1Fcf8wv3OnZ0PjlvDErXH5baNEuGFWOpuhw46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153171; c=relaxed/simple;
	bh=nUw9UV3qqAqfedKxW/GHa+5T1537ToqgVNkqjyyf6I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yda4ZIqEJrSwfzFKozfHfY2JYPydwRF+gmMHKwr8qEWzyOOlinfi6kG8+NKdd5wlM0Nn5K34MVRKauohmuWLWQNRo5nGjQSnaMEJbfi/ruDHK/OQW/F7pyYqhp1FUEKzcQS3fsn89f2LpXXO56zbqI8oYXozCpJxISphi+jt2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtHmqwVt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtHmqwVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758153169; x=1789689169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nUw9UV3qqAqfedKxW/GHa+5T1537ToqgVNkqjyyf6I4=;
  b=jtHmqwVtOg1jvUJ4yleFoSxxPEBHJPI1qe9UDWANfFFBqOeLLdZdC39w
   Epwuwze4nRNiVyVWLNXb2bBl36vYZS5dVonMh1UJ6mozeIpsPoWy6yv0Y
   jB8aci7O0d4/Ev0DAcLN7K2fgDIumpAF/LlOU88UyQT2n+hTxYNSd+E8M
   SoIDGQPvn51bNpeL5GuhmznzkGT9cBa/qjFw8X38a4KIxyr3eXLA7Assy
   zhPktunLjPGtVVEzCURHPYfIH48lF9O2Vje2Uj9fpyKPwFBKL8nWeNdi1
   D+2NsbyNoNYSJqa5K5MVUY/VpsvX9qUkrc+EAyTHhGbS9Vgh0pOdnj1ce
   g==;
X-CSE-ConnectionGUID: IN8PgtfJTDOSSUywIrh8uQ==
X-CSE-MsgGUID: gIrW07KRTEm/+1LUhVXsvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60623386"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="60623386"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 16:52:48 -0700
X-CSE-ConnectionGUID: ue/ZtmWzSq6WQmExoQw84A==
X-CSE-MsgGUID: YZob5zk7SoeTxvtGECKUyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="212535712"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 16:52:46 -0700
Message-ID: <189e060b-207b-469f-9b6e-314380d12a42@linux.intel.com>
Date: Thu, 18 Sep 2025 07:52:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWcf7F1QvWXzAD_KMpOnnKGw9PFM7mNtgzp_jh4Vi6V-w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWcf7F1QvWXzAD_KMpOnnKGw9PFM7mNtgzp_jh4Vi6V-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/18/2025 5:12 AM, Ian Rogers wrote:
> On Sun, Aug 10, 2025 at 10:56 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> his patch-set fixes perf kvm commands issues, like missed memory
>> allocation check/free, out of range memory access and especially the
>> issue that fails to sample guest with "perf kvm record/top" commands on
>> Intel platforms.
>>
>> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
>>  default event") changes to use PEBS event to do sampling by default
>> including guest sampling. This breaks host to sample guest with commands
>> "perf kvm record/top" on Intel platforms.
> Huh? That change is:
> ```
> $ git show 634d36f82517
> commit 634d36f82517eb5c6a9b9ec7fe3ba19dbbcb7809
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Tue Oct 15 23:23:58 2024 -0700
>
>     perf record: Just use "cycles:P" as the default event
>
>     The fallback logic can add ":u" modifier if needed.
> ...
> -               bool can_profile_kernel = perf_event_paranoid_check(1);
> -
> -               err = parse_event(rec->evlist, can_profile_kernel ?
> "cycles:P" : "cycles:Pu");
> +               err = parse_event(rec->evlist, "cycles:P");
> ...
> ```
> isn't the precision the same before and after? I think you've blamed
> the wrong patch.
>
> The change to use cycles:P looks to come from commit 7b100989b4f6
> ("perf evlist: Remove __evlist__add_default") but the old code was
> doing things like "evsel->precise_max = true;" so I think I was just
> carrying forward behavior. The use of precise_max comes from commit
> 4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip
> detection") from over 6 years ago, and the behavior before that also
> appears to have been to use the maximum supported precision.
>
> Apart from the blame and commit message being off I think the change
> is okay, delta my usual complaint that weak symbols are the devil's
> work.

Hmm, yeah, you're right. Thanks for correcting this. 


>
> Thanks,
> Ian
>
>> Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
>>  via DS"[1] starts, host loses the capability to sample guest with PEBS
>> since all PEBS related MSRs are switched to guest value after vm-entry,
>> like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
>> to PEBS events can't be used to sample guest by host, otherwise no guest
>> PEBS records can be really sampled. The patches 5-6/6 fix this issue by
>> using "cycles" event instead of PEBS event "cycles:P" to sample guest on
>> Intel platforms.
>>
>> Changes:
>>   v1 -> v2:
>>   * Free memory allocated by strdup().
>>   * Check "--pfm-events" in kvm_add_default_arch_event() as well.
>>   * Opportunistically fix the missed memory allocation and free issue in
>>     builtin-kwork.
>>   * Comments refine.
>>
>>
>> Tests:
>>   * Run command "perf kvm record -a && perf kvm report" and "perf kvm
>>     top" on Intel Sapphire Rapids platform, guest records can be
>>     captured successfully.
>>   * Since no powerpc platforms on hand, doesn't check the patches on
>>     powerpc. Any test on powerpc is appreciated.
>>
>> Ref:
>>   [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/
>>
>>
>> Dapeng Mi (6):
>>   perf tools kvm: Add missed memory allocation check and free
>>   perf tools kwork: Add missed memory allocation check and free
>>   perf tools kvm: Fix the potential out of range memory access issue
>>   perf tools: Add helper x86__is_intel_cpu()
>>   perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
>>   perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
>>
>>  tools/perf/arch/x86/util/kvm-stat.c |  51 +++++++++++
>>  tools/perf/builtin-kvm.c            | 130 ++++++++++++++++++++--------
>>  tools/perf/builtin-kwork.c          |  27 ++++--
>>  tools/perf/util/env.c               |  22 +++++
>>  tools/perf/util/env.h               |   2 +
>>  tools/perf/util/kvm-stat.h          |  10 +++
>>  6 files changed, 203 insertions(+), 39 deletions(-)
>>
>>
>> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
>> --
>> 2.34.1
>>
