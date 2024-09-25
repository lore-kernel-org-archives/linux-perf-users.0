Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54A43AA4;
	Wed, 25 Sep 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269523; cv=none; b=qdsbfeg1xZ1I9xQq0S5VwcU86cnEx7eF6Ezzq0cQ3whtNbtRfcubY5dZVYJJJLMUwXST7/M3kpxAdA7JU261/i3v8Gqs0Uq+PQgz/2Ul/XiguO0/89ePGBkK6QK7nJVSILeyFfChfAHD7ZyOBFaiAN+VWJIa62vaRqFYFBba3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269523; c=relaxed/simple;
	bh=21895p5Bk4h39QK/4IHkulfA1X+A4iSTVMvI73M5VMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3GFHNwh2TS6paBDt75R+iXTUYzejp8dTAkv03yCun+YoNJvMiJbMmaHooXSjg18hV/Dg9WoeYNlFjMu+Jm7MVE6nfx3NanZoanQfnT3UYhQQnCzrXILpY3xYj1TIvo4cjiJQn9VuDt4F7KrSrF5pvFS/ki8xqE/FKPkWILsR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsFHVRgy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsFHVRgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727269521; x=1758805521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21895p5Bk4h39QK/4IHkulfA1X+A4iSTVMvI73M5VMs=;
  b=dsFHVRgyTgLAkx/DMkrNshcRmzS9rjaTyl5AAJcaAoK6pyqJyaTbT9JT
   RAkRhJLmkCerEIZ+DLSUk4Hx5Ikf9PMcmC6Cf/+feyUqBft3ZjIxJeLK4
   JZUziym+NO7eoUueoF6U/k8u7tLigZ1+UFHheopRknMUAbpvPQ0hVvw+B
   FV+sYI/g6l8PUQAyRHwqIlUhpo8H7EhBbXRw86uq2bEStM3K5nqMNFI3q
   67A1GERqp+87r3M6VQ6mRVf9yVEpGm1CC3PwHlD0xb9sj7CQp1d3iCeEr
   g6sNi0cv5fnVFONqwJsUkWTknIW6EKOH0wd1QmUzD+YjNDknnsCoUuS4i
   Q==;
X-CSE-ConnectionGUID: HVRzfGYxTK+Ms46bpDqXsg==
X-CSE-MsgGUID: MlR3h0evQpyJ3JOuVX9XsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37691620"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37691620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:05:20 -0700
X-CSE-ConnectionGUID: jZ8g5h3wSDO5yVhLD16O0Q==
X-CSE-MsgGUID: mFiFVbBkQquHRUcbi+HMFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71847427"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:05:20 -0700
Received: from [10.212.122.167] (kliang2-mobl1.ccr.corp.intel.com [10.212.122.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F321D20CFEE9;
	Wed, 25 Sep 2024 06:05:17 -0700 (PDT)
Message-ID: <a7ce5e22-c9ac-46a0-b870-1438dac3affc@linux.intel.com>
Date: Wed, 25 Sep 2024 09:05:16 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSF0gcGVyZi94ODYvaW50ZWwvdW5jb3Jl?=
 =?UTF-8?Q?=3A_Enable_uncore_on_vCPUs_when_using_uncore_discovery?=
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 chenpeihong <chenpeihong@linux.alibaba.com>
Cc: =?UTF-8?B?6YOR57+UKOato+e/lCk=?= <zx283061@alibaba-inc.com>,
 =?UTF-8?B?6LW155Sf6b6Z?= <shenglong.zsl@alibaba-inc.com>
References: <d420bcf0-5651-41f7-81c9-1c8155bd6bcc.chenpeihong.cph@alibaba-inc.com>
 <73e999cd-93c3-49e0-bac2-0e2c6efe4110@linux.intel.com>
 <b8b078bb-c8d7-428b-8a74-b3977563e6d4.chenpeihong.cph@alibaba-inc.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <b8b078bb-c8d7-428b-8a74-b3977563e6d4.chenpeihong.cph@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-25 4:22 a.m., 陈培鸿(乘鸿) wrote:
>>> With uncore discovery, kvm can choose to expose a subset of
>>> uncore related MSRs it wants to guest by emulate the uncore
>>> discovery device. 
>>
>> I don't hear that the KVM has started to support uncore vPMU.
>> Can you please point me to patches?
> There are no such uncore vPMU related patches so far, which may
> be supported some day in future. I’m now working on this.

I think the patch should be part of the future KVM patch set.
Otherwise, It seems like a security hole because of the lack of
underlying support.

Thanks,
Kan

>> The default of uncore_no_discover is 0. So it bypasses the HYPERVISOR
>> check unless the user specially sets the value. It could be a problem
>> for the earlier platforms which don't support discovery
>> table. How do you plan to emulate the devices on earlier platforms?
>>
> U R right, I should make a more strict check here.
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 33776df95aa4..ca510c476895 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1919,8 +1919,9 @@ static int __init intel_uncore_init(void)
>  const struct x86_cpu_id *id;
>  struct intel_uncore_init_fun *uncore_init;
>  int pret = 0, cret = 0, mret = 0, ret;
> + bool in_guest = boot_cpu_has(X86_FEATURE_HYPERVISOR);
> - if (uncore_no_discover && boot_cpu_has(X86_FEATURE_HYPERVISOR))
> + if (uncore_no_discover && in_guest)
>  return -ENODEV;
>  __uncore_max_dies =
> @@ -1936,8 +1937,10 @@ static int __init intel_uncore_init(void)
>  uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>  if (uncore_no_discover && uncore_init->use_discovery)
>  return -ENODEV;
> - if (uncore_init->use_discovery &&
> - !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
> + if (!uncore_init->use_discovery) {
> + if (in_guest)
> + return -ENODEV;
> + } else if (!intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
>  return -ENODEV;
>  }
> For the earlier platforms which don't support discovery table, just
> disable uncore for guests. Will there be any issues?
>> Thanks,
>> Kan
>>> So we can enable uncore on virtualized CPUs
>>> when uncore discovery is using.
>>> Signed-off-by: Cheng Hong <chenpeihong.cph@alibaba-inc.com>
>>> —
>>> arch/x86/events/intel/uncore.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index d98fac567684..33776df95aa4 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -1920,7 +1920,7 @@ static int __init intel_uncore_init(void)
>>> struct intel_uncore_init_fun *uncore_init;
>>> int pret = 0, cret = 0, mret = 0, ret;
>>> - if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>> + if (uncore_no_discover && boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>> return -ENODEV;
>>> __uncore_max_dies =
> Thanks,
> Chen
