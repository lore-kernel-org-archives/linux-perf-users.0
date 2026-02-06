Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A6298CAB;
	Fri,  6 Feb 2026 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357095; cv=none; b=Jiwd1FBdULmnKkefGKpfzJTNgU/3pqYKMFFBZzKkwzsJDrcuE+VKOhdh8xUfsRvF2pLCeXqJcpqcj7VtIRZVezc4cWBTD1IvzFgpPgMfC9JeryOwPRXu4NoDRV5YOrgFU4rvhbYQl2Wr1JAPx+NNYbCwcSXIhTGj5t/kwZA9tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357095; c=relaxed/simple;
	bh=VgBkyAlxd6wcBnPAlpKB9OOD0EzRl5PNJikNmuX/nMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsfXFdcjYFre83mvbvj+ED4fl4wi4OVA8cpb6e3CiaVGy6HX5G5JShyjuIsmLn/t0c7C1NpPhczgSQhvokT1AMxpnvBNyPUDLoSj2PNKPYPBMvGy+93ro+ScF/gVSs+d0vJyg+HnUxuudDesV/SIxXH+fSTCnQ4t30bbnxmLOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1NVyBDx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1NVyBDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770357094; x=1801893094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgBkyAlxd6wcBnPAlpKB9OOD0EzRl5PNJikNmuX/nMw=;
  b=n1NVyBDx+GrloOrhpZMU7GAl5Hm5T8aszK5FEPL7cmFdnk/Gq/LZ7iTQ
   blN9UaAYS9ljjrKeNDAGIV4P+qNoRhww3zbfBQQl6lIkUP5EUc6sbVI1j
   RmH3MFWYV5q3RazQxiAdzy3rUd1g+9Dt/MjjrVQsmSyKZrPeM1vZlzkgr
   a1p6/+fR6S7xpAvZdp+G3fNhpM8tmSXlvbhtPXuaim3oB08c4mnNt2tQS
   E/Igj65033GWYiJysM/SOJR+4zB0RK9DClJ5YAwK5PFnApJpFFMNfVokd
   GZmtmcADRxQiswDhNe2PvtDkB7buZKKCoTu0b4pPWE3Yyelq3SujqbrzK
   Q==;
X-CSE-ConnectionGUID: VM94VEc4QSasqzYdF4ipSg==
X-CSE-MsgGUID: v1cZ3gy6TpmW3bDPOH8QDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="70758812"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="70758812"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 21:51:34 -0800
X-CSE-ConnectionGUID: 3jctVAyMRnWXzcLK40XMpA==
X-CSE-MsgGUID: SUG0gtAmSDqB9fjXJ9Hl6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="209871647"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 21:51:31 -0800
Message-ID: <74169f95-0e80-4021-b1b0-cf788cc84b37@linux.intel.com>
Date: Fri, 6 Feb 2026 13:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/13] perf/x86/intel/uncore: Support IIO free-running
 counters on DMR
To: Chun-Tse Shao <ctshao@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-9-zide.chen@intel.com>
 <4f62ecc3-b47c-4c9f-9189-1159e8e9be8a@linux.intel.com>
 <CAJpZYjWBWFx2ac=jYRJf-GEpenBZ14a6JpAhY6CE1kUXyVUVJw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAJpZYjWBWFx2ac=jYRJf-GEpenBZ14a6JpAhY6CE1kUXyVUVJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/6/2026 8:26 AM, Chun-Tse Shao wrote:
> On Sat, Jan 3, 2026 at 6:31 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/1/2026 6:42 AM, Zide Chen wrote:
>>> The free-running counters for IIO uncore blocks on Diamond Rapids are
>>> similar to Sapphire Rapids IMC freecounters, with the following
>>> differences:
>>>
>>> - The counters are MMIO based.
>>> - Only a subset of IP blocks implement free-running counters:
>>>   HIOP0 (IP Base Addr: 2E7000h)
>>>   HIOP1 (IP Base Addr: 2EF000h)
>>>   HIOP3 (IP Base Addr: 2FF000h)
>>>   HIOP4 (IP Base Addr: 307000h)
>>> - IMH2 (Secondary IMH) does not provide free-running counters.
>>>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> V2:
>>> - Remove pr_warn() from dmr_uncore_freerunning_init_box().
>>>
>>>  arch/x86/events/intel/uncore_snbep.c | 118 +++++++++++++++++++++++++--
>>>  1 file changed, 113 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>> index 09a3bdbd188a..28bcccf5cdfe 100644
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -472,10 +472,14 @@
>>>  #define SPR_C0_MSR_PMON_BOX_FILTER0          0x200e
>>>
>>>  /* DMR */
>>> +#define DMR_IMH1_HIOP_MMIO_BASE                      0x1ffff6ae7000
>>> +#define DMR_HIOP_MMIO_SIZE                   0x8000
>>>  #define DMR_CXLCM_EVENT_MASK_EXT             0xf
>>>  #define DMR_HAMVF_EVENT_MASK_EXT             0xffffffff
>>>  #define DMR_PCIE4_EVENT_MASK_EXT             0xffffff
>>>
>>> +#define UNCORE_DMR_ITC                               0x30
>>> +
>>>  #define DMR_IMC_PMON_FIXED_CTR                       0x18
>>>  #define DMR_IMC_PMON_FIXED_CTL                       0x10
>>>
>>> @@ -6442,7 +6446,11 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
>>>       for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>>>               unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>>>
>>> -             if (unit->id > max)
>>> +             /*
>>> +              * on DMR IMH2, the unit id starts from 0x8000,
>>> +              * and we don't need to count it.
>>> +              */
>>> +             if ((unit->id > max) && (unit->id < 0x8000))
>>>                       max = unit->id;
>>>       }
>>>       return max + 1;
>>> @@ -6930,6 +6938,101 @@ int dmr_uncore_cbb_units_ignore[] = {
>>>       UNCORE_IGNORE_END
>>>  };
>>>
>>> +static unsigned int dmr_iio_freerunning_box_offsets[] = {
>>> +     0x0, 0x8000, 0x18000, 0x20000
>>> +};
>>> +
>>> +static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
>>> +{
>>> +     struct intel_uncore_type *type = box->pmu->type;
>>> +     u64 mmio_base;
>>> +
>>> +     if (box->pmu->pmu_idx >= type->num_boxes)
>>> +             return;
>>> +
>>> +     mmio_base = DMR_IMH1_HIOP_MMIO_BASE;
>>> +     mmio_base += dmr_iio_freerunning_box_offsets[box->pmu->pmu_idx];
>>> +
>>> +     box->io_addr = ioremap(mmio_base, type->mmio_map_size);
>>> +     if (!box->io_addr)
>>> +             pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
>>> +}
>>> +
>>> +static struct intel_uncore_ops dmr_uncore_freerunning_ops = {
>>> +     .init_box       = dmr_uncore_freerunning_init_box,
>>> +     .exit_box       = uncore_mmio_exit_box,
>>> +     .read_counter   = uncore_mmio_read_counter,
>>> +     .hw_config      = uncore_freerunning_hw_config,
>>> +};
>>> +
>>> +enum perf_uncore_dmr_iio_freerunning_type_id {
>>> +     DMR_ITC_INB_DATA_BW,
>>> +     DMR_ITC_BW_IN,
>>> +     DMR_OTC_BW_OUT,
>>> +     DMR_OTC_CLOCK_TICKS,
>>> +
>>> +     DMR_IIO_FREERUNNING_TYPE_MAX,
>>> +};
>>> +
>>> +static struct freerunning_counters dmr_iio_freerunning[] = {
>>> +     [DMR_ITC_INB_DATA_BW]   = { 0x4d40, 0x8, 0, 8, 48},
>>> +     [DMR_ITC_BW_IN]         = { 0x6b00, 0x8, 0, 8, 48},
>>> +     [DMR_OTC_BW_OUT]        = { 0x6b60, 0x8, 0, 8, 48},
>>> +     [DMR_OTC_CLOCK_TICKS]   = { 0x6bb0, 0x8, 0, 1, 48},
>>> +};
>>> +
>>> +static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] = {
>>> +     /*  ITC Free Running Data BW counter for inbound traffic */
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"),
> Hi, it is probably a bit late but I think the third argument should be
> a string. Because the macro already applies __stringify, the resulting
> expansion is ""3.814697266e-6"", which eventually shows in sysfs
> knobs. It would cause problems while Perf tries to parse the file.

Good catch. This needs a fix. Thanks.


>
> Thanks,
> CT
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"),
>>> +
>>> +     /*  ITC Free Running BW IN counters */
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
>>> +
>>> +     /*  ITC Free Running BW OUT counters */
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
>>> +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
>>> +
>>> +     /* Free Running Clock Counter */
>>> +     INTEL_UNCORE_EVENT_DESC(clockticks, "event=0xff,umask=0x40"),
>>> +     { /* end: all zeroes */ },
>>> +};
>>> +
>>> +static struct intel_uncore_type dmr_uncore_iio_free_running = {
>>> +     .name                   = "iio_free_running",
>>> +     .num_counters           = 25,
>>> +     .mmio_map_size          = DMR_HIOP_MMIO_SIZE,
>>> +     .num_freerunning_types  = DMR_IIO_FREERUNNING_TYPE_MAX,
>>> +     .freerunning            = dmr_iio_freerunning,
>>> +     .ops                    = &dmr_uncore_freerunning_ops,
>>> +     .event_descs            = dmr_uncore_iio_freerunning_events,
>>> +     .format_group           = &skx_uncore_iio_freerunning_format_group,
>>> +};
>>> +
>>> +#define UNCORE_DMR_MMIO_EXTRA_UNCORES                1
>>> +static struct intel_uncore_type *dmr_mmio_uncores[UNCORE_DMR_MMIO_EXTRA_UNCORES] = {
>>> +     &dmr_uncore_iio_free_running,
>>> +};
>>> +
>>>  int dmr_uncore_pci_init(void)
>>>  {
>>>       uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
>>> @@ -6937,11 +7040,16 @@ int dmr_uncore_pci_init(void)
>>>                                               dmr_uncores);
>>>       return 0;
>>>  }
>>> +
>>>  void dmr_uncore_mmio_init(void)
>>>  {
>>> -     uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
>>> -                                              UNCORE_DMR_NUM_UNCORE_TYPES,
>>> -                                              dmr_uncores);
>>> -}
>>> +     uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
>>> +                                             UNCORE_DMR_MMIO_EXTRA_UNCORES,
>>> +                                             dmr_mmio_uncores,
>>> +                                             UNCORE_DMR_NUM_UNCORE_TYPES,
>>> +                                             dmr_uncores);
>>>
>>> +     dmr_uncore_iio_free_running.num_boxes =
>>> +             uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_DMR_ITC);
>>> +}
>>>  /* end of DMR uncore support */
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>>
>>
