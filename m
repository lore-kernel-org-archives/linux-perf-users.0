Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E06130AC8;
	Thu, 26 Sep 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358431; cv=none; b=IPfSUmL9h/m5orFJeYl4d0jtx7IgOrncWv7PZdzHbZ3oOPfjmXXwk7klSWFAZAS7A+EheRAyaniCQ7vKkV6o105I+5xK0WSHTldYp6p++fLQ4XBB1LfXMGc2jehuzVn//VpIyDRQpURi9IwrjZXi0MJ78dQkPd+MC+dBOZpfAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358431; c=relaxed/simple;
	bh=fALjRuQb0xkZ7zFXpTRrbmjmRrSKWtCjHTE340Dogfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrJUjy3i7S34YgHE3hUhW8Nw2PEUof3IdxtSG+6VT3UJJdklRZhaz71qPZdRBFLkA3KFcO8eng2TvT5GRwRsyWECmM8+iuKorAHw3V2sWvuNW3o6kd1+SQF6MQoYmydol4UlAcRUvCukm89KIx4IwzwrWqkTGAtgxtO4u8TVVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT0bN/AX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT0bN/AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727358429; x=1758894429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fALjRuQb0xkZ7zFXpTRrbmjmRrSKWtCjHTE340Dogfg=;
  b=AT0bN/AX0gLO7873ZHlTpYTJDnaawipTGhMSVQSiloNekOpFGMxHdz1Y
   xOjQ+Ko+L/KtuGFktbZn3KUNNghwJ0QU8RQwFu+zyyI7jmoD1Dfm+WOD/
   1rcyFXVHtR7eP3HlL6/o5WLlOcJptXcHxPbeJhQCOUbuh5q6vXLJCWI7s
   7HQSOC1VaB/ckL2LMzjS7OASAy1FA8WY8m2r2cCjVtIaexmy1JoSvbrGQ
   vtQmMYi2mIPFrLPgpizAg5ZhzNU6ba4GNqLCchLvXgD1SfnmbtTNdGKC2
   QIlqsEJa87kSUfYVV0N0UvXDNMjr5abXOyu/i/gFDF6x0a6FmdEG+198L
   g==;
X-CSE-ConnectionGUID: PGgwTBA6Sh2LbcHaovO/XQ==
X-CSE-MsgGUID: httPp4YsTCyn0AKSG3ysDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26317656"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26317656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:47:08 -0700
X-CSE-ConnectionGUID: pPK5iMDBR1GkpEzXrAST9g==
X-CSE-MsgGUID: bfAy7dsiQbiYD+9cBTE0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72161922"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:47:09 -0700
Received: from [10.212.70.42] (kliang2-mobl1.ccr.corp.intel.com [10.212.70.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E695E20CFEDF;
	Thu, 26 Sep 2024 06:47:05 -0700 (PDT)
Message-ID: <1cf53e52-657b-4b73-bee4-30da208d7321@linux.intel.com>
Date: Thu, 26 Sep 2024 09:47:04 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8muWbnuWkje+8mltQQVRDSF0gcGVyZi94ODYvaW50?=
 =?UTF-8?Q?el/uncore=3A_Enable_uncore_on_vCPUs_when_using_uncore_discovery?=
To: =?UTF-8?B?6ZmI5Z+56bi/KOS5mOm4vyk=?= <chenpeihong.cph@alibaba-inc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?B?6YOR57+UKOato+e/lCk=?= <zx283061@alibaba-inc.com>,
 =?UTF-8?B?6LW155Sf6b6Z?= <shenglong.zsl@alibaba-inc.com>,
 chenpeihong <chenpeihong@linux.alibaba.com>
References: <d420bcf0-5651-41f7-81c9-1c8155bd6bcc.chenpeihong.cph@alibaba-inc.com>
 <73e999cd-93c3-49e0-bac2-0e2c6efe4110@linux.intel.com>
 <b8b078bb-c8d7-428b-8a74-b3977563e6d4.chenpeihong.cph@alibaba-inc.com>
 <a7ce5e22-c9ac-46a0-b870-1438dac3affc@linux.intel.com>
 <bd65cf32-c2f8-42e4-a01d-fcd927000c24.chenpeihong.cph@alibaba-inc.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <bd65cf32-c2f8-42e4-a01d-fcd927000c24.chenpeihong.cph@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-25 10:07 p.m., 陈培鸿(乘鸿) wrote:
>>>>> With uncore discovery, kvm can choose to expose a subset of
>>>>> uncore related MSRs it wants to guest by emulate the uncore
>>>>> discovery device. 
>>>>
>>>> I don't hear that the KVM has started to support uncore vPMU.
>>>> Can you please point me to patches?
>>> There are no such uncore vPMU related patches so far, which may
>>> be supported some day in future. I’m now working on this.
>>
>> I think the patch should be part of the future KVM patch set.
>> Otherwise, It seems like a security hole because of the lack of
>> underlying support.
> I think this patch and the upcomming kvm patch set address two
> different issues. This patch enables uncore vPMU on hypervisors 
> with uncore discovery emulated, not limited just to QEMU/KVM.
> While it's true that the current QEMU/KVM setup lacks uncore vPMU
> support, it does not represent a security vulnerability. Instead,
> it simply allows guests on platforms utilizing uncore discovery,
> e.g., SPR/EMR/GNR, to access uncore capabilities via the emulated
> uncore discovery device. If there is no such device present, the
> uncore module remains inactive.

That's an ideal case. There is no mechanism to prevent a broken emulated
uncore discovery device is created, right?

You ask to expose some capabilities, but there is no real user for now.
I don't see a reason why we want to do it.

Thanks,
Kan
> Thanks,
> Chen
>>
>> Thanks,
>> Kan
>>
>>>> The default of uncore_no_discover is 0. So it bypasses the HYPERVISOR
>>>> check unless the user specially sets the value. It could be a problem
>>>> for the earlier platforms which don't support discovery
>>>> table. How do you plan to emulate the devices on earlier platforms?
>>>>
>>> U R right, I should make a more strict check here.
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index 33776df95aa4..ca510c476895 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -1919,8 +1919,9 @@ static int __init intel_uncore_init(void)
>>> const struct x86_cpu_id *id;
>>> struct intel_uncore_init_fun *uncore_init;
>>> int pret = 0, cret = 0, mret = 0, ret;
>>> + bool in_guest = boot_cpu_has(X86_FEATURE_HYPERVISOR);
>>> - if (uncore_no_discover && boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>> + if (uncore_no_discover && in_guest)
>>> return -ENODEV;
>>> __uncore_max_dies =
>>> @@ -1936,8 +1937,10 @@ static int __init intel_uncore_init(void)
>>> uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>>> if (uncore_no_discover && uncore_init->use_discovery)
>>> return -ENODEV;
>>> - if (uncore_init->use_discovery &&
>>> - !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
>>> + if (!uncore_init->use_discovery) {
>>> + if (in_guest)
>>> + return -ENODEV;
>>> + } else if (!intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
>>> return -ENODEV;
>>> }
>>> For the earlier platforms which don't support discovery table, just
>>> disable uncore for guests. Will there be any issues?
>>>> Thanks,
>>>> Kan
>>>>> So we can enable uncore on virtualized CPUs
>>>>> when uncore discovery is using.
>>>>> Signed-off-by: Cheng Hong <chenpeihong.cph@alibaba-inc.com>
>>>>> —
>>>>> arch/x86/events/intel/uncore.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>>>> index d98fac567684..33776df95aa4 100644
>>>>> --- a/arch/x86/events/intel/uncore.c
>>>>> +++ b/arch/x86/events/intel/uncore.c
>>>>> @@ -1920,7 +1920,7 @@ static int __init intel_uncore_init(void)
>>>>> struct intel_uncore_init_fun *uncore_init;
>>>>> int pret = 0, cret = 0, mret = 0, ret;
>>>>> - if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> + if (uncore_no_discover && boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> return -ENODEV;
>>>>> __uncore_max_dies =
>>> Thanks,
>>> Chen
