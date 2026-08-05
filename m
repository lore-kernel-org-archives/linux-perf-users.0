Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924433F6C5F
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924433; cv=none; b=Pu8KLzIXSJ/AvMPonRZPvDOHwCp4jBlExz31t2q+lcG8+VHVjkQHJOX37qAka6UujpeSMgfQNIjIELpPCs1amgBqAJHZY25d1ESk340YjM/h45ytPPALwng187AfGUBnb1+1OQNvmGU2RrVjDp632jSyk+yozueIzfT7Emi1+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924433; c=relaxed/simple;
	bh=B5bQv7frE8jt5IaVnB2ovCal6ANrNCQJw7+lBprdOZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnQVPFSjW+/zvyqmuvr3W8aaTxChTtcBesXNoMMNKQkSf9ukTgs1lxzQZgwmmLW2BENRRHRK03+NrD2xk+p7HgfMuU2n8137JYiYhffmfwaIGAlJdlZrxf4wwBl2GlIxrSELemLK48T1za9cMGtKohHdU3sFSPJNjNlI7WZnbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJ84ordA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ84ordA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so3890285e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785924430; x=1786529230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AhK4VD+NMKqhR3cJcndUaz+mOuTJcgBioYBISeP+sk=;
        b=hJ84ordAaRx4NKNzdYiuJnxloS9EG4uTMRG0qvz8xjmfO0J8F70rgAvCMvR6tpicKZ
         4j9I9m2iIYtl5hlNV921rJayidyyn14uVLm/wwNK2Oe00nTfEydXPXIda1AY3f3cKcYF
         jOxIBPYA47q57XPNwbQX8hfwL9s9j/jzPSrhVmKxswRwTjeSKjUCqTwdeXgPtpuzox7h
         AhCwAjiGbbZhOF98wfGaObe1AOfTYXnHsYsOElVH4gwiOnIIOIq9y6vlbVYNApy1x5hV
         +gGhsEgWY6zCXhvUpSySBBcr4m9LrfCuYsNGL6mD2Rf7s20JxsQeoB+zQ1MiYZEVk1D/
         uYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924430; x=1786529230;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AhK4VD+NMKqhR3cJcndUaz+mOuTJcgBioYBISeP+sk=;
        b=Km3HMTBBr7iCjDZWAJZeMvuHvbxY6w0nsPVYqCuDGyOs7UgkbOQevT7Y82mBe5QfjF
         rMlk6HkfCuhYQU5E0h5wFGwKQgDSnFD2mHSwsxvebVLWZvbkLheqgB5wfMEo+hhkzL0a
         2qAra9FZaU70gTFVHu48+kkaAnlryHpK/2717NqPSjWSFRyfSwAyLSJpMwK1QKY+YzT8
         UfCN3jNdC0BAs4rqH1jydvBPwmm0eqY7elrPjSgu3g0ZjjLPglGP+wxNFpZ8TX82Z5Sk
         uce4uoNqM5BwVjLC8ey1ivb2t3CVb5vsxxO+UzuJeuGdyZbe4IR/ipfNtEN9+0phG414
         FW1A==
X-Forwarded-Encrypted: i=1; AHgh+RphMonpzlLHzO58/NoF4dmhJLJtWoxo28LlEtY0ouHh0HZh0kDpyDoApGNjwsGdIQClRG+P2+yvc3H5far0MjUL@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/0Unihcttta5aFUnfBJ/g3gEtaVvqn5v1x2GL+Ky5WV2x1fF
	rqk8lbF4acumhs2Z84MFlue8/Z5BDCongsHEZwqpLecoMzKgTDAjHyVCjb5r9Jb66NY=
X-Gm-Gg: AR+sD11n9PTDHS+PIv2V16I/qwft0Nv0Den5/XXLj0rz5JQjR8L3WT8m+FeGrKk9scL
	Zbl8cV6AlKLDjomTkMopLzRPcbRrfRcs+LSl29eMoT0mwE3QFLpQpBQ4etvwbS2zzZv0JANVPVD
	Uy36QiH2EgPZL/uexYAWsvYXwhzy1DJX9DQ5E92MR5yQNjJ1CGzC5AZB/OxLptGwHqAgv31P7SH
	HD7iLrTCK+xBiRovshaO2fpA50V2sdblnf7mYLAmiBnPw/1kLnOco42+tS+p2mW1G0u4ITdLdWV
	DJGCzv4uXVlnTrto6al4X+wkmNqLtrzmO/T09fa4aDaqmzMYGmYHUA1nRRLa91t7PKZw1esGEuy
	WCDPEqpkAagadIwv1A0w4VqQThByrastQcCuy7PBsqAatoy8wgGfo0KyvyAzQtccc2Gyc10N40z
	IL/9nsvgJxlh4o9HKO01lL7xEj2ieqamCUjib/FW2t8YQp7nUG9CFbGhGQ7XjpzAFOnw==
X-Received: by 2002:a05:600c:4f4c:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4994e7b74afmr77866375e9.11.1785924429725;
        Wed, 05 Aug 2026 03:07:09 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5b1bsm6743054f8f.12.2026.08.05.03.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:07:09 -0700 (PDT)
Message-ID: <6ee32efc-01be-4532-aa59-3948f59156c0@linaro.org>
Date: Wed, 5 Aug 2026 11:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Leo Yan <leo.yan@arm.com>,
 Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260616155716.2631508-1-puranjay@kernel.org>
 <20260616155716.2631508-4-puranjay@kernel.org>
 <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org>
 <CANk7y0inRXCUKtuio3Cb03DvuNPq6yp1o+tsE8PZitrY0LaOPQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CANk7y0inRXCUKtuio3Cb03DvuNPq6yp1o+tsE8PZitrY0LaOPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
> On Mon, Aug 3, 2026 at 12:07 PM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 16/06/2026 16:57, Puranjay Mohan wrote:
>>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
>>> perf_snapshot_branch_stack static call for BRBE.
>>>
>>> BRBE is paused before masking exceptions to avoid branch buffer
>>> pollution from trace_hardirqs_off(). Exceptions are then masked with
>>> local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
>>> If an overflow between pause and DAIF save re-enables BRBE, the snapshot
>>> detects this via BRBFCR_EL1.PAUSED and bails out.
>>>
>>> Branch records are read using perf_entry_from_brbe_regset() with a NULL
>>> event pointer to bypass event-specific filtering. The buffer is
>>> invalidated after reading.
>>>
>>> Introduce a for_each_brbe_entry() iterator to deduplicate bank
>>> iteration between brbe_read_filtered_entries() and the snapshot.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>> ---
>>>    drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++-------
>>>    drivers/perf/arm_brbe.h  |   9 +++
>>>    drivers/perf/arm_pmuv3.c |   5 +-
>>>    3 files changed, 120 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
>>> index effbdeacfcbb..a141ad7abcf2 100644
>>> --- a/drivers/perf/arm_brbe.c
>>> +++ b/drivers/perf/arm_brbe.c
>>> @@ -9,6 +9,7 @@
>>>    #include <linux/types.h>
>>>    #include <linux/bitmap.h>
>>>    #include <linux/perf/arm_pmu.h>
>>> +#include <asm/daifflags.h>
>>>    #include "arm_brbe.h"
>>>
>>>    #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
>>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
>>>               brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
>>>    }
>>>
>>> +static __always_inline bool cpu_has_brbe(void)
>>
>> This should be more like cpu_valid_brbe_version(). has_brbe() only
>> implies that the CPU has BRBE, not that it's a version that the driver
>> supports. And it's actually just a wrapper around valid_brbe_version()
>> that accesses the ID reg on that CPU, not a functionally different check.
>>
>> But it also looks like valid_brbe_version() isn't called from anywhere
>> else, so why not delete that function and use its name for the new one?
> 
> I will do that in next version
> 
>>
>>> +{
>>> +     u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>> +     int brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
>>> +
>>> +     return valid_brbe_version(brbe);
>>> +}
>>> +
>>>    static void select_brbe_bank(int bank)
>>>    {
>>>        u64 brbfcr;
>>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
>>>        isb();
>>>    }
>>>
>>> +static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
>>> +{
>>> +     if (++(*idx) >= BRBE_BANK_MAX_ENTRIES &&
>>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
>>> +             *idx = 0;
>>> +             select_brbe_bank(++(*bank));
>>> +     }
>>> +}
>>> +
>>> +#define for_each_brbe_entry(idx, nr_hw)                                      \
>>> +     for (int __bank = (select_brbe_bank(0), 0), idx = 0;            \
>>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);            \
>>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
>>> +
>>>    static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
>>>    {
>>>        entry->brbinf = get_brbinf_reg(idx);
>>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
>>>
>>>    void brbe_probe(struct arm_pmu *armpmu)
>>>    {
>>> -     u64 brbidr, aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>> -     u32 brbe;
>>> +     u64 brbidr;
>>>
>>> -     brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
>>> -     if (!valid_brbe_version(brbe))
>>> +     if (!cpu_has_brbe())
>>>                return;
>>>
>>>        brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
>>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
>>>
>>>        brbe_set_perf_entry_type(entry, brbinf);
>>>
>>> -     if (!branch_sample_no_cycles(event))
>>> +     if (!event || !branch_sample_no_cycles(event))
>>>                entry->cycles = brbinf_get_cycles(brbinf);
>>>
>>> -     if (!branch_sample_no_flags(event)) {
>>> +     if (!event || !branch_sample_no_flags(event)) {
>>>                /* Mispredict info is available for source only and complete branch records. */
>>>                if (!brbe_record_is_target_only(brbinf)) {
>>>                        entry->mispred = brbinf_get_mispredict(brbinf);
>>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>>>    {
>>>        struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>>        int nr_hw = brbe_num_branch_records(cpu_pmu);
>>> -     int nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
>>>        int nr_filtered = 0;
>>>        u64 branch_sample_type = event->attr.branch_sample_type;
>>>        DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
>>>
>>>        prepare_event_branch_type_mask(branch_sample_type, event_type_mask);
>>>
>>> -     for (int bank = 0; bank < nr_banks; bank++) {
>>> -             int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
>>> -             int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
>>> +     for_each_brbe_entry(i, nr_hw) {
>>> +             struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
>>>
>>> -             select_brbe_bank(bank);
>>> +             if (!perf_entry_from_brbe_regset(i, pbe, event))
>>> +                     break;
>>>
>>> -             for (int i = 0; i < nr_this_bank; i++) {
>>> -                     struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
>>> +             if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
>>> +                     continue;
>>>
>>> -                     if (!perf_entry_from_brbe_regset(i, pbe, event))
>>> -                             goto done;
>>> +             nr_filtered++;
>>> +     }
>>>
>>> -                     if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
>>> -                             continue;
>>> +     branch_stack->nr = nr_filtered;
>>> +}
>>>
>>> -                     nr_filtered++;
>>> -             }
>>> +/*
>>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
>>> + * self-recording and return 0 if the snapshot state appears disturbed.
>>> + */
>>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>>> +{
>>> +     unsigned long flags;
>>> +     int nr_hw, nr_copied = 0;
>>> +     u64 brbfcr, brbcr;
>>> +
>>> +     if (!cnt)
>>> +             return 0;
>>
>> If you're trying to avoid branches before pausing BRBE, can't you check
>> this after the pause?
> 
> will drop this in the next version and this is just an optimization.
> 
>>
>>> +
>>> +     /* Guard against running on a CPU without BRBE (e.g. big.LITTLE). */
>>> +     if (!cpu_has_brbe())
>>> +             return 0;
>>> +
>>> +     /*
>>> +      * Pause BRBE first to avoid recording our own branches. The
>>> +      * sysreg read/write and ISB are branchless, so pausing before
>>> +      * checking BRBCR avoids polluting the buffer with our own
>>> +      * conditional branches.
>>> +      */
>>> +     brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>> +     brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>
>> Can this work without first disabling interrupts? Sashiko pointed it
>> out, but I think it's correct. If you read an active state into brbfcr,
>> then the PMU event fires and disables BRBE, then you disable interrupts,
>> then you would restore an active state when it should be inactive.
>> Surely the only way to do it properly is to disable interrupts before
>> touching anything at all, if the PMU handler is also touching the same
>> registers?
>>
>> If you want to avoid trace_hardirqs_off() can you make a new
>> raw_local_daif_save() that disables interrupts and then call
>> trace_hardirqs_off() yourself after pausing BRBE? Or not call
>> trace_hardirqs_off() at all? There is a comment mentioning something
>> like that in arch/arm64/kernel/suspend.c.
> 
> Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and mask before
> touching any BRBE register, which fixes the stale restore. trace_hardirqs_off()
> then moves below the pause so lockdep still sees a balanced off/on pair while
> its branches land in an already paused buffer.
> 
>>
>> Also, disabling interrupts doesn't stop the PMU event from overflowing
>> and changing the state of PAUSED either. I think this is another path
>> that leads to you restoring the wrong state, so don't you also need to
>> disable the PMU?
> 
> Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a freeze needs
> BRBE to not already be paused (RNXCWF). So once we have paused, nothing changes
> underneath us and the PMU does not need disabling. It would not help anyway:
> armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and discards the
> records we came to read.

That does mean you throw away real freeze events while paused though, in 
addition to the brbe_invalidate() you need to avoid non contiguous 
buffers. So it takes branches away from PMU events.

> 
> You are right that a freeze can still land in the window between reading BRBFCR
> and setting PAUSED, and restoring the value we read would then clear a PAUSED
> bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE paused if a
> counter has overflowed. Reads of PMOVSCLR are non-destructive and it stays set
> until the overflow handler clears it, so it is still visible after we have set
> PAUSED ourselves:
> 
>          if (!valid_brbe_version())
>                  return 0;
> 
>          flags = raw_local_daif_save();
> 
>          brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>          brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> 
>          write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>          isb();
> 
>          trace_hardirqs_off();
> 
>          /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
>          if (!brbcr)
>                  goto restore;
> 
>          ... read the records ...
> 

Up to the point where you read the records you technically don't need 
any branches (if you don't do trace_hardirqs_off()) so you could do the 
whole thing without pausing. Just disable interrupts, read every branch 
entry unconditionally, re-enable interrupts and then find the last valid 
entry and do the branchy stuff after reading.

I'm thinking out loud, but doesn't that make it a lot easier? And it 
avoids the brbe_invalidate() which takes the branches away from the PMU 
event. It also avoids having to think too hard about racing with PMU 
events causing a freeze even after interrupts are disabled and after 
reading the freeze value:

   raw_local_daif_save();
   brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
   brbcr = read_sysreg_s(SYS_BRBCR_EL1);
   select_bank(0);
   read_record(0);
   read_record(1);
   ...
   select_bank(0);
   read_record(0);
   read_record(1);
   ...
   write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
   isb();
   local_daif_restore();

   /* Now do post processing, find last valid record, check if it was 
enabled by looking at brbcr etc. */

>          if ((brbfcr & BRBFCR_EL1_PAUSED) || read_pmovsclr())
>                  brbfcr |= BRBFCR_EL1_PAUSED;
>          else
>                  brbe_invalidate();
> restore:
>          write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>          isb();
>          local_daif_restore(flags);
> 
> If BRBE stays paused the records are left alone, they belong to the pending
> overflow handler. Otherwise recording resumes and the records either side of
> the pause are not contiguous (RPKZCF), so they are discarded.
> 
> What do you think about this?
> 
> Thanks,
> Puranjay

