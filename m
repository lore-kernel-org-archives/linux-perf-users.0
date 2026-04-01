Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9F30C62D;
	Wed,  1 Apr 2026 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075144; cv=none; b=kQxEBW26Nw/BlsBjUU0S6bPaG/ITSaFVF7XwFPgmW+Xe3Sii+UpqGQ+UZ/Yy0VRUIbElJZ7EDn01bParSrNCS0/OIjhkO3kzLwINcPYvprq5R+IyMeEq6xmLTPYaunrIoWMIkJQlxgUZgw/aEQCf+xNr4w42RJLMUeFjHcSyZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075144; c=relaxed/simple;
	bh=FS4xLikDs2CZ1D57plh+WBOO1XKBqmdCc4ePxwJTdDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki6xhkNFc+Rbu/UVSMuuKFAzCC/IYP46dEQUFY7dNA/KCsZZFeLG1yQmoJqhkFyxDSZnHp+mtF+yv/1xbNcCamrztpyqUX5S30S3QYISrm6/ODxkkX/stMwzspFJ12LW+CzsUygPQE2r7PB8m9mQnz9aeHilhVtgHRmP7lo1068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLidPBIh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLidPBIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775075141; x=1806611141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FS4xLikDs2CZ1D57plh+WBOO1XKBqmdCc4ePxwJTdDM=;
  b=KLidPBIhtTs8eJ11PqRaTJw6ctZntLkzf8pLm5KfyQiMnbCclw2lrDTy
   /uDZiYWVFOYgxbrxlSG6YzfY/p1UioHzaWclAe75CcVxCAconnZRrJi12
   BsdFBAdcZAz5FL3fqjhhm01aEHVlbJ5UXIo6k5HD6uiJBzU/k/hifF7Qo
   5O69OJnwznwxXpWuvSBVZ9MclaA3oa6+m7j8ryHWJXt+C4aIZqw0I5TPe
   VBU9sATBT1bQg9BDoHodhm2EiWRyWzYDK5GwFBbsQzilgZJwGlHCtwJwg
   GWuopt4HYv8DyxUzLJ1bdBNSEgCb87U07yzfw4cxRZAx81+Veq6uMlIht
   A==;
X-CSE-ConnectionGUID: 42vV/94OSKKj+dmfuCKS0g==
X-CSE-MsgGUID: siohYbgPQt6OZ0GvmlnPeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75301530"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75301530"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:25:41 -0700
X-CSE-ConnectionGUID: 8Kd4HXjcSKKRtPO9lFROAw==
X-CSE-MsgGUID: XEceVQPCS9qCqshvsfgYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="228390846"
Received: from unknown (HELO [10.241.241.7]) ([10.241.241.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:25:40 -0700
Message-ID: <d0e4d464-0f9e-4e76-952f-daac7d585f5b@intel.com>
Date: Wed, 1 Apr 2026 13:25:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] perf/x86/intel/uncore: Fix PMON enumeration with
 NUMA disabled
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260330212444.117325-1-zide.chen@intel.com>
 <20260330212444.117325-5-zide.chen@intel.com>
 <e899636d-371a-44dc-b8e7-578f499847fa@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <e899636d-371a-44dc-b8e7-578f499847fa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/30/2026 6:26 PM, Mi, Dapeng wrote:
> 
> On 3/31/2026 5:24 AM, Zide Chen wrote:
>> When NUMA is disabled on a NUMA-capable platform, UPI and M3UPI PMON
>> units are not enumerated.
>>
>> In this case, pcibus_to_node() always returns NUMA_NO_NODE, causing
>> uncore_device_to_die() to return -1 for all PCI devices. As a result,
>> the corresponding PMON units are not added to the RB tree.
>>
>> These PMON units are per-die resources, and their utility when NUMA is
>> disabled is limited.  The driver does not prohibit their use, and the
>> enumeration should still work correctly.
>>
>> Fix this by using uncore_pcibus_to_dieid(), which works regardless of
>> whether NUMA is enabled.  This requires calling
>> snbep_pci2phy_map_init() in spr_uncore_pci_init().
>>
>> Since pci_init() is called before mmio_init(), remove the redundant
>> snbep_pci2phy_map_init() call from spr_uncore_mmio_init().  If
>> snbep_pci2phy_map_init() fails, uncore driver should be bailed out,
>> so the fallback path in spr_uncore_mmio_init() can be removed.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V6:
>> - Split from patch v5 3/4.
>> - Remove the redundant call in spr_uncore_mmio_init().
>> - Update commit messages.
>> ---
>>  arch/x86/events/intel/uncore.c       |  1 +
>>  arch/x86/events/intel/uncore_snbep.c | 26 +++++++++++---------------
>>  2 files changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 786bd51a0d89..e9cc1ba921c5 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
>>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>>  }
>>  
>> +/* Note: This API can only be used when NUMA information is available. */
>>  int uncore_device_to_die(struct pci_dev *dev)
>>  {
>>  	int node = pcibus_to_node(dev->bus);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 8ee06d4659bb..73da1e88e286 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -6415,7 +6415,7 @@ static void spr_update_device_location(int type_id)
>>  
>>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>>  
>> -		die = uncore_device_to_die(dev);
>> +		die = uncore_pcibus_to_dieid(dev->bus);
>>  		if (die < 0)
>>  			continue;
>>  
>> @@ -6439,6 +6439,10 @@ static void spr_update_device_location(int type_id)
>>  
>>  int spr_uncore_pci_init(void)
>>  {
>> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/*
>>  	 * The discovery table of UPI on some SPR variant is broken,
>>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.
>> @@ -6460,21 +6464,13 @@ int spr_uncore_pci_init(void)
>>  
>>  void spr_uncore_mmio_init(void)
>>  {
>> -	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
>> +	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
>> +						 UNCORE_SPR_MMIO_EXTRA_UNCORES,
>> +						 spr_mmio_uncores,
>> +						 UNCORE_SPR_NUM_UNCORE_TYPES,
>> +						 spr_uncores);
>>  
>> -	if (ret) {
>> -		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
>> -							 UNCORE_SPR_NUM_UNCORE_TYPES,
>> -							 spr_uncores);
>> -	} else {
>> -		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
>> -							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
>> -							 spr_mmio_uncores,
>> -							 UNCORE_SPR_NUM_UNCORE_TYPES,
>> -							 spr_uncores);
>> -
>> -		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
>> -	}
>> +	spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
> 
> I'm not sure if we can directly remove the snbep_pci2phy_map_init() call
> here. In theory, the snbep_pci2phy_map_init() call in spr_uncore_pci_init()
> could fail and then spr_uncore_mmio_init() doesn't know it and directly
> initializes MMIO PMU, then it could lead to the MMIO initialization fails.


Yes, this is true. But I would argue that the fix in this patch is
correct, and the issue you pointed out is not new: the uncore driver
registers a PMU device without guaranteeing it's functioning.

This is because the Intel uncore driver employs a lazy init approach.
And when init_box() fails, it doesn't unregister the inaccessible PMU
devices. For example, intel_generic_uncore_mmio_init_box() could fail
for a number of reasons, making all associated PMU devices non-functional.

Originally the uncore driver tried to enumerate PCI/MSR/MMIO uncore
independently, but evolving hardware complexity makes this more
challenging.  This patch is just one example, IMC Freerunning is
MMIO-accessed but relies on PCI devices to read the die-specific MMIO
base address. Explicitly gating sysfs node creation with PCI init code
in mmio_init() is neither clean nor reliable.

To fix it, it seems reasonable to have init_box() return int and
unregister the PMU device if deemed inaccessible — similar to what
perf_event_ibs_init() does.

--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -129,7 +129,7 @@ struct intel_uncore_type {
 #define events_group attr_groups[2]

 struct intel_uncore_ops {
-       void (*init_box)(struct intel_uncore_box *);
+       int (*init_box)(struct intel_uncore_box *);

--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1155,7 +1155,8 @@ static int uncore_pci_pmu_register(struct pci_dev
*pdev,
        box->dieid = die;
        box->pci_dev = pdev;
        box->pmu = pmu;
-       uncore_box_init(box);
+       ret = uncore_box_init(box);
+	if (ret)
+               return ret;

@@ -1598,8 +1599,10 @@ static int uncore_box_ref(struct
intel_uncore_type **types,
                pmu = type->pmus;
                for (i = 0; i < type->num_boxes; i++, pmu++) {
                        box = pmu->boxes[id];
-                       if (box && box->cpu >= 0 &&
atomic_inc_return(&box->refcnt) == 1)
-                               uncore_box_init(box);
+                       if (box && box->cpu >= 0 &&
atomic_inc_return(&box->refcnt) == 1)
+                               if (uncore_box_init(box))
+                                       uncore_pmu_unregister(pmu);


> Currently the PCI, CPU and MMIO initialization are totally independent,
> only when the 3 types initialization all fail, then uncore PMU can abort.
> 
> ``` 
> 
>    if (uncore_init->pci_init) {
>         pret = uncore_init->pci_init();
>         if (!pret)
>             pret = uncore_pci_init();
>     }
> 
>     if (uncore_init->cpu_init) {
>         uncore_init->cpu_init();
>         cret = uncore_cpu_init();
>     }
> 
>     if (uncore_init->mmio_init) {
>         uncore_init->mmio_init();
>         mret = uncore_mmio_init();
>     }
> 
>     if (cret && pret && mret) {
>         ret = -ENODEV;
>         goto free_discovery;
>     }
> ```
> 
> 
>>  }
>>  
>>  /* end of SPR uncore support */

