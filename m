Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0939FCB9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785584; cv=none; b=PqrbNbNHPl5RWbZoH75ri4RVeYhx0r+64ZePWEdkTLaOsD33thR69jHNbhFfA6viun7ZpyX/Dn7mmITd4r3zsoO1dSikySy1TXryjwOtgqROsiJFBzQa9p8aot8fCIWvHgDhHkUGmgyNPNkz2UGPSywHGkJWu0zffHxZ3BA7Q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785584; c=relaxed/simple;
	bh=qBcJ8vKNSneL/rpZZLxYZd6ePo2FHj+D372yqVvkKuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZkUSRlcP1VFqYZ/gsxqxoaQy2RiLHajO3/ypZbn3tQ6oXHCCO9NpksPVl8yUCu785jvZR+QTqbjoEjVIlhHvP2QJhiULqx6y0NZr3OyGkPe8lEDBdFA7pcVKarr0NFzPQW1MLR8F8h0VNYaMtFU37dM3o0d/QXA3Lph4zutbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QE4AgIKN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QE4AgIKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778785583; x=1810321583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qBcJ8vKNSneL/rpZZLxYZd6ePo2FHj+D372yqVvkKuI=;
  b=QE4AgIKNHgSvuBmG7keih0ixnRrlJt4gcu6neuqLMYDqB1FGFJXUg0q3
   +wa2Ey/RPj1REQrbwCTxViBy+WyXtihWNlA/JS1D7DmvCt1EwrhnmINy5
   uHhfG0rkN1NUoIlyI8SaA5o3dXgi3GB2Ue8eWX6eq+px6phyYv9k/bQsJ
   HomjztiYl4q08F5OWsWjLRtQA0mxNMJr+MyduDAa3mqpx0c6av4XKEx1c
   XY3S9Dk7fhXgbf1dEbr84PqQbwKHnkdRvMEZ1hgprFos9Pruym2lYGM3Y
   a/1BYqHZTRBE5gTgwOuHgPZ1FZ1PJkNR+A+NyjOb2mYepWGA7UGAIYqdS
   Q==;
X-CSE-ConnectionGUID: GDnt/fiSQjaaldRvaI9c3w==
X-CSE-MsgGUID: xRvfjycpRqGJOV8FLRz5FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91201572"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="91201572"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:06:23 -0700
X-CSE-ConnectionGUID: N+VcM6DhSj+J/h8jcaskAg==
X-CSE-MsgGUID: 69pllpBYRoqbYrYxRDatHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="232075741"
Received: from jaimerod-mobl.amr.corp.intel.com (HELO [10.125.32.83]) ([10.125.32.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:06:21 -0700
Message-ID: <54179bc4-b895-4613-9d08-155fee7371da@intel.com>
Date: Thu, 14 May 2026 12:06:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf/x86/intel/uncore: Rename refcount fields and
 other cleanups
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260512233048.9577-2-zide.chen@intel.com>
 <20260514005809.D4D0CC19425@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260514005809.D4D0CC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 5:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] NULL Pointer Dereference in `uncore_pci_pmu_unregister()` when device registration fails.
> - [High] NULL Pointer Dereference (previously reported as UAF) during perf event operations if a PCI device is removed while events are active.
> --
> 
> commit 247a617f910d49e9f19af35d0216a5b938d9d034
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Rename refcount fields and other cleanups
> 
> This commit renames several fields and parameters in the intel uncore PMU
> driver to clarify their purpose, such as activeboxes to die_refcnt and
> box->refcnt to box->cpu_refcnt. It also fixes a typo and removes an
> incorrect refcount increment.
> 
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index e9cc1ba921c5e..e200f4744eb9b 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
> 
> [ ... ]
> 
>> @@ -1230,7 +1229,7 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
>>  	struct intel_uncore_box *box = pmu->boxes[die];
>>  
>>  	pmu->boxes[die] = NULL;
>> -	if (atomic_dec_return(&pmu->activeboxes) == 0)
>> +	if (atomic_dec_return(&pmu->die_refcnt) == 0)
>>  		uncore_pmu_unregister(pmu);
>>  	uncore_box_exit(box);
> 
> While reviewing these unregistration changes, I noticed a pre-existing issue
> here.
> 
> If PMU registration fails during PCI device probe, uncore_pci_pmu_register()
> frees the box and sets pmu->boxes[die] = NULL.
> 
> Later, when the device is removed, the bus notifier calls
> uncore_pci_pmu_unregister() which fetches the NULL box:
> 
>     struct intel_uncore_box *box = pmu->boxes[die];
> 
> and passes it to uncore_box_exit(box).
> 
> Since uncore_box_exit() does not check for NULL before testing box->flags:

Yes, you are right, uncore_pci_pmu_unregister() should validate the box:

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 208901ea280c..edf608ba8e9a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1285,8 +1285,11 @@ static void uncore_pci_pmu_unregister(struct
intel_uncore_pmu *pmu, int die)
        pmu->boxes[die] = NULL;
        if (atomic_dec_return(&pmu->die_refcnt) == 0)
                uncore_pmu_unregister(pmu);
-       uncore_box_exit(box);
-       kfree(box);
+
+       if (box) {
+               uncore_box_exit(box);
+               kfree(box);
+       }
 }

> 
> static inline void uncore_box_exit(struct intel_uncore_box *box)
> {
>         if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
> 
> Does this sequence result in a NULL pointer dereference?
> 
> Additionally, if a PCI device is removed while perf events are still active
> on its CPU, this function sets pmu->boxes[die] = NULL and frees the box.
> > If other dies still have boxes present, die_refcnt will be greater
than zero
> and uncore_pmu_unregister(pmu) is bypassed.

Yes, this series is mostly focusing on the MSR/MMIO uncore paths, not
PCI hot plug/unplug handling yet.  I plan to address them in follow-up
patches.


> Could this leave active events scheduled in the perf subsystem?
> 
> If the perf subsystem later attempts to read or stop the event,
> uncore_event_to_box() would return NULL. Would subsequent calls like
> uncore_perf_event_update() or accesses to box->n_active then trigger a NULL
> pointer dereference when operating on the missing box?
> 
>>  	kfree(box);
>>  }
> 

