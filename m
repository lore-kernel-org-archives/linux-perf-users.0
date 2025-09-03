Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647942D3739;
	Wed,  3 Sep 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881145; cv=none; b=H2xbfmWab3FiBUgMW8YXwWigD/2R0FLal/ZIGatF1M88zqCF7Pb/kTsnq/fUuJjt4U7Rj2+HERq7j0sqQQS2kCUI3uhsr3FA2J+Q5SUD4VaR6zJK3o2Wyzxtlq5jgZ+JhqVJyshXn1c7Fbaq1S9av3TvWzd+Kl2tp0vj9TdDT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881145; c=relaxed/simple;
	bh=iE2AOaV38XaT3YBp6FoCLbXtDdyIZWlACJ84QPR1q9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbWJngZEVUFeET+IfCHcNMQ4rYCbs90tiCx3QNdw3Uoke5S2DEZXTnzV++Tn/5OqpiqU7V2u0SOhZ58jH92xILqX7WI0qzws94n2RpSRSad2/XNeaLEJwVHnYS1JxYlKA08d1e7HdZtlq95lNDt3UwrqQnUBVTEfsveMKevPIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXR1gVNF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXR1gVNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756881144; x=1788417144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iE2AOaV38XaT3YBp6FoCLbXtDdyIZWlACJ84QPR1q9A=;
  b=DXR1gVNFUhinlCwLZHftIM3o7qKu1YxJUxKqxenD/R8dNe+ADu4Cp94d
   qrB8muwTPJoBG+NwliptkXphcnleFR7ff6oZYdlfF/LMZzyIzZVrCSi7d
   Pm9+HPPaymHF1QS1Ol8qRLaVe+Ljd7OBZwZhDkW5FfKpEEFvpzGQXlZ/R
   WiNzZgyB0gH8h1l5ZACQJRDIyOh5+y5zD50zGeGuU9HJKwj1PRTjLwn1i
   mFKRRB4XoU9Mprfx+QqtiD/zngJj75CeLuw/R18o2dY3i6NQ9B6WeM5VX
   Be92hM28GH4RrYTCbjoAS3Hl2OVBxwj0dZNcTukZylCNfT5lkU2UKbSE9
   g==;
X-CSE-ConnectionGUID: WItH1XIDQVenL6BRUwWYfQ==
X-CSE-MsgGUID: V+kP1vY3SOOL+LFIR0u1PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58881624"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58881624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:32:23 -0700
X-CSE-ConnectionGUID: PRjj6JmkRuSZh71mtVnQ1Q==
X-CSE-MsgGUID: 2Mj8wNelTLi/FHctBE05qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="195138127"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:32:20 -0700
Message-ID: <28bf94c1-3b8f-4036-9aa2-b64b9f6edb0c@linux.intel.com>
Date: Wed, 3 Sep 2025 14:32:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
 <aJ-VWevppm9Srjmr@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aJ-VWevppm9Srjmr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/16/2025 4:15 AM, Namhyung Kim wrote:
> On Mon, Aug 11, 2025 at 01:55:40PM +0800, Dapeng Mi wrote:
>> his patch-set fixes perf kvm commands issues, like missed memory
>> allocation check/free, out of range memory access and especially the
>> issue that fails to sample guest with "perf kvm record/top" commands on
>> Intel platforms.
>>
>> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
>>  default event") changes to use PEBS event to do sampling by default
>> including guest sampling. This breaks host to sample guest with commands
>> "perf kvm record/top" on Intel platforms.
>>
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
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Namhyung, thanks for your ack. Do you think is it good to be queued or
still need other acks? 


>
> Thanks,
> Namhyung
>
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
