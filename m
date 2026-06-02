Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16992DA74C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780377176; cv=none; b=FzTljUoAsA2Ua3GxfQ+O/uGwGsG8HtkjW94un33LggPjcxkYlQrNa0LXtpodZ8XYcTz29iKky9VWhq6HstkrSg70beg+cKYsuqLg0m7USx+QLsiSxJ2btdR0NwJN4GCcv0wmzDl77F4JeL29RVJqP0pp8y/mA8K28sTqPypA5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780377176; c=relaxed/simple;
	bh=gqpQge/JlKKAHXFNohM0NnwXrPrUroOFAz3dUacjbSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHnmT81HqTmGTYwvkV99qmDreS1vL3oYnAzypydJwsxNbrt/RdazfM76dG0+CAFuPyOF40wka5OUO5rfrOSOmfZBFqF/gm0X5Rt1LTVCyyJvFMfpwhtFf0F73au5KC/d+iBdBmeqROghmTYdtzie0EOJevoLcblO0bBY0bHcTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdrFJ45l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdrFJ45l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780377174; x=1811913174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gqpQge/JlKKAHXFNohM0NnwXrPrUroOFAz3dUacjbSU=;
  b=jdrFJ45lYsfzVej9TgRoXNhR1VNNIKSprJc/CYY8n2hfBw6hagzwoM1F
   SKSkNlRHxaQ651nlvVZjCN34ae6FOYWsoCyrkSyFmea2SUvdI0MBSgOLv
   PdPsxqx2e2nK3spPkeh3z0Siip61P7FpEeBK753ma+rMRzmJ+d5bT2rgc
   iCVvrcNN8z4UEEO5ysKez9OKE0qiJSOxKZPVbMLzBlmTQt1m25SXqr8MZ
   mT8ZY2PyiDMDKeWvn7Tc322MWDs8eZpCXvIENwurxmNknJWyOP5Aumids
   FwRXBYnMVp7kB7Jfq7GEhSStI8srbk5tIew/DPjjckk9S620qGfGoY/sR
   Q==;
X-CSE-ConnectionGUID: v1lLeGGMRVqFj0tAEsl2ZQ==
X-CSE-MsgGUID: uRDBF+P3SyeXygcywIBAqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91839469"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91839469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:12:53 -0700
X-CSE-ConnectionGUID: dLN37qnlRPSvqkYfpgKFCQ==
X-CSE-MsgGUID: yTU5Xd8qRxi2uVFi9n2cZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239630114"
Received: from unknown (HELO [10.238.1.64]) ([10.238.1.64])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:12:52 -0700
Message-ID: <bcc73423-2a00-4b2c-afec-83c70e28f023@linux.intel.com>
Date: Tue, 2 Jun 2026 13:12:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 2/5] perf regs: Support x86 eGPRs/SSP sampling
To: Ian Rogers <irogers@google.com>, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529082451.591783-3-dapeng1.mi@linux.intel.com>
 <20260529100610.5E84C1F00898@smtp.kernel.org>
 <CAP-5=fWugapi9c-HWx9acm=MzyE=hb0muYwj3w86774iOBnvWw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWugapi9c-HWx9acm=MzyE=hb0muYwj3w86774iOBnvWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/30/2026 1:29 AM, Ian Rogers wrote:
> On Fri, May 29, 2026 at 3:08 AM <sashiko-bot@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [Medium] Intel PT PEBS register synthesis is silently disabled on SIMD-capable machines.
>> - [Medium] Requesting legacy XMM registers (e.g., `-I XMM0`) fails with an 'Unknown register' error on modern CPUs, breaking backwards compatibility.
>> --
>>
>> commit a0d7b85bb399d047c94284c24c34805466f84209
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Subject: perf regs: Support x86 eGPRs/SSP sampling
>>
>> This commit adds support for sampling x86 extended GP registers (R16-R31) and
>> the shadow stack pointer (SSP) register. It reclaims the original XMM registers
>> space in sample_regs_user/sample_regs_intr to represent the eGPRs and SSP when
>> SIMD sampling is supported, using a new abi argument to distinguish layouts.
> Thanks Dapeng! I think stylistically this is exactly what I was hoping for!
>
> When I try to apply the patch on perf-tools-next it is failing, on
> this patch with a conflict on:
> ```
> --- tools/perf/builtin-inject.c
> +++ tools/perf/builtin-inject.c
> @@ -457,6 +457,8 @@ static int
> perf_event__convert_sample_callchain(const struct perf_tool *tool,
>   /* adjust sample size for stack and regs */
>   sample_size -= sample->user_stack.size;
>   sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) *
> sizeof(u64);
> + if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> + sample_size -= 4 * sizeof(u64); /* Reduce SIMD regs header size */
>   sample_size += (sample->callchain->nr + 1) * sizeof(u64);
>   event_copy->header.size = sample_size;
> ```
> This is happening because commit daac18e7c42c ("perf inject: Fix
> itrace branch stack synthesis") switched the size logic to use
> perf_event__sample_event_size, which I believe accurately accounts for
> the new layout and so it is safe to drop this part of the change.

Sure. I would drop it in next version. This pachset is based on top of
Peter's perf/core tree and I forgot to rebase it on the perf-tools-next
tree. :(



>
>>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>>> index fc9eec8b54b82..2729ad8c6d263 100644
>>> --- a/tools/perf/util/intel-pt.c
>>> +++ b/tools/perf/util/intel-pt.c
>>> @@ -2470,6 +2470,7 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
>>>       }
>>>
>>>       if (sample_type & PERF_SAMPLE_REGS_INTR &&
>>> +         !evsel->core.attr.sample_simd_regs_enabled &&
>>>           (items->mask[INTEL_PT_GP_REGS_POS] ||
>>>            items->mask[INTEL_PT_XMM_POS])) {
>>>               u64 regs_mask = evsel->core.attr.sample_regs_intr;
>> [Severity: Medium]
>> Does this completely disable PEBS register synthesis on SIMD-capable machines?
>>
>> Since PERF_SAMPLE_REGS_ABI_SIMD is set by default on supported platforms in
>> __perf_reg_mask_x86(), opts->sample_simd_regs_enabled will be set to 1 for
>> any register request (like -I ax).
>>
>> Could this cause basic GPR synthesis to be silently skipped here, resulting in
>> a functional regression for userspace tooling?
> I don't think functionality is lost and presumably the driver is
> ensuring PEBS sampled registers are preferred over say pt_regs from
> the interrupt.

Strictly speaking, PEBS_VIA_PT feature is only enabled for legacy PEBS now,
so sample_simd_regs_enabled won't be enabled on such kind of supporting
legacy PEBS platforms and then there is no any functionality lost.

Thanks.


>
>> [ ... ]
>>
>>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>>> index b6d20522b4e8f..ae26d991cdc9f 100644
>>> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>>> @@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
>> [ ... ]
>>> +uint64_t __perf_reg_mask_x86(bool intr, int *abi)
>>> +{
>> [ ... ]
>>> +     if (mask != PERF_REGS_MASK) {
>>> +             *abi |= PERF_SAMPLE_REGS_ABI_SIMD;
>>> +     } else {
>>> +             mask |= __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
>>> +                                      false);
>>>       }
>>>
>>> -     return PERF_REGS_MASK;
>>> +     return mask;
>>>  }
>> [ ... ]
>>> +const char *__perf_reg_name_x86(int id, int abi)
>>> +{
>>> +     const char *name;
>>> +
>>> +     name = __arch_reg_gpr_name(id);
>>> +     if (name)
>>> +             return name;
>>> +
>>> +     if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>> +             name = __arch_reg_egpr_name(id);
>>> +     else
>>> +             name = __arch_reg_xmm_name(id);
>>> +
>>> +     return name;
>>> +}
>> [Severity: Medium]
>> Does this break backwards compatibility for legacy XMM register requests?
>>
>> When the CPU supports eGPRs/SSP, PERF_SAMPLE_REGS_ABI_SIMD is set and the
>> legacy XMM registers (PERF_REG_EXTENDED_MASK) are excluded from the returned
>> mask because they share the same bit space.
>>
>> If __perf_reg_name_x86() maps these overlapping IDs exclusively to eGPR names
>> (for instance, mapping ID 32 to R16), will name_to_perf_reg_mask() fail to
>> resolve legacy requests like -I XMM0 and throw an unknown register error?
> So with PERF_SAMPLE_REGS_ABI_SIMD XMM0 is no longer part of the
> register mask and thus name_to_perf_reg_mask shouldn't set a bit for
> it. The next patch adjusts __parse_regs to encode vector registers in
> the new space within perf_event_attr.
>
> Thanks,
> Ian
>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260529082451.591783-1-dapeng1.mi@linux.intel.com?part=2
>>
