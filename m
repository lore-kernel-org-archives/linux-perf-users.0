Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFF481FAA
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947220; cv=none; b=ub3koMz4Tn6SbCn+q7TBUCFWjKXamH0AkYilcxVhhe7YFfPu2QHSQUVaNNo8n5qjxRwaSpQpKPNotJukX28zBsX3zbEkYMxIA+4ELh/ZDfUqwNs2RteeuqvHSoCHsdf9NduNlUO81k4LCORj4gGDeus5cKnEsky/e26qKv5B9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947220; c=relaxed/simple;
	bh=96tM4uicNBR3/oFwIy3nemVrNKeWVML0qr5by1CoRCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUE6fesH8kj/o+yy1dtMiEkgyNQMyfWGHptr6jgeeo3X5/6irrlJFcIsAAL0MclOHzdU2z626vy7WN+939KXC2dYOEk1S2eel2cVgS7/pTgNaRAuCO2oe4OD6VAa8N+HcUsEv/MlHKc3t1XAMFPb+DxzqwU6xhY4jW5tJw6WSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ICa5Czrt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICa5Czrt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fdb6f7d72so733471f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785947216; x=1786552016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daeifs2uc9oo7Dw8xYA7KxbaF/u580/TXeKl51imcRI=;
        b=ICa5Czrt9XC63Cw/eDjix8fGg0R/LE9RiX952JksLflNRWiriifGTVTS1nSq7hysdj
         Dad4zx4Bq35lkZzhJBkbYCPdVSuQsMTi66u6p4vH2u0Ij8Yg8ROgJY1AMsMrRP9KTe1e
         YHujKjoXPVvdfZU+d2tploUhEk6XBYCjsg/5sooJ7bnBGdiTxH0MicqmwIvRc8WIZbCE
         fkZAK50/ohDVcqYvEIi5N0j+X4/t013ioI1eQICAHe5HS2K4e5ZcSS/8XSKkK/3bHGus
         N2ZlhMlD1+7TqE6pBvYyFWnhuYz+YKBDPcIma+uvxJbR157QXV23qM3R5EomeIWu6dG1
         JBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947216; x=1786552016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daeifs2uc9oo7Dw8xYA7KxbaF/u580/TXeKl51imcRI=;
        b=SLvXNC/mUAUy3GWmABmY4HfwJIoEBqt8v9IqZ5hNNqWeHYe3H1Od5nL7bJSRSN5ok6
         Gkksl6nc9VHNfxWGHNcXoneWM6OOVDEARYDC9oIZWjzBm98yRZPuRQEyExc9MIpwZjL4
         tCzAKl/AU+XIWaJgGrdpbswVW1jn899swaSOR6vTwLPmK/SUxSBkhkdnu7cihMlMO+Ab
         ty9/Skbq0eaDfPkk85C3C7cK1m2jf/uby9MpJiWS8DE9YoJkB0WXBowfIo9lctq+m/CN
         zIQuZjOOrlN/pqn8ZRlKCxdEcP4YDL1NW/Ct6jisoc+HoFPOcwfHw7pV5sOt9ENP17rK
         WeSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnmmtYo3tC8G7LJ0GOz2HBR1SL23zC2NxHgr3pVFwIsaGkuwm4HW9ZCWsOuSy4f0TvoNH6d3n3kpbEkiqHcb1r@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOEAqvgGeS0/dhGO3yb1T64UqvrEg1GXtRzgwdI65k5DKBUQY
	B5YD3GaeML+yv3kNqComyi1+8yxQNVR/1J1ofc9RwSHItQUq4WvHZ1eozJ2OsU183+w=
X-Gm-Gg: AR+sD13QKMQWmWwH5vp9GfMsVEv/nlqUXV3Ihbi2kdoGfWo+iDAO7Gyu53uAglHZpb1
	5d6vOcbcTzMEv87jalSwdO8JCcupkv051IHSG6rswLqJ4KqI44p1801N86zx2+7Bz/ije3wQgPF
	jzasWCbOQD/YWahGjC8ri/i0cyL/3HRZVsSy0V5JV9O5WW2ks5j0S1RzaIPZVIRkuGj/B8bnwyN
	yi858/Z9F78Wnx+f9i+o47Y6QP8QAe/k6Lsy6cI/e2vgPAt8TofKegYsQkuDxaOgoQLZqwkLQn7
	cz3rGF5SaFv7tExbinF2oCxYbbOFh4AuhNKuGe9j5/kE9FIeSvPLAylxZBB4ZdaJtSMlGkc0se5
	hJFZC8xqdup8IkixekOg03DNWabVWYGAannxzzPEg1AQdpNPCZ/t6GhfOzGhyl/PHH95aRS255T
	+bya4Ev+bI7vL/6vxfTQ2upQ9wKhwqaGvHyUK1/C3gQGhvaQ8XJ20BxtQikoBP/bAteQ==
X-Received: by 2002:a05:6000:2c0d:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-47fec4f11cbmr14253267f8f.9.1785947215811;
        Wed, 05 Aug 2026 09:26:55 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfdd383sm9334155f8f.8.2026.08.05.09.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:26:55 -0700 (PDT)
Message-ID: <2b402e4b-b916-4dba-bcb3-634ad58f1710@linaro.org>
Date: Wed, 5 Aug 2026 17:26:53 +0100
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
 <6ee32efc-01be-4532-aa59-3948f59156c0@linaro.org>
 <CANk7y0hU_m6gJ9FpGfGUJg-Ok8PoXhKruny_0OkeOgLbCo6ZLA@mail.gmail.com>
 <9fa68534-2b12-420a-93b7-a6ada21c180e@linaro.org>
 <CANk7y0is-SB+hPhriwQ24v-UUTUfk9p01y1CQm=q_Y-=GXO04A@mail.gmail.com>
 <ffeea852-b55b-45b5-afcd-47dc4e6f6824@linaro.org>
 <CANk7y0gcj-kRCt-EgL6UK+Tc4xvJQkGz9F=HNpE86kB3fKxymA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CANk7y0gcj-kRCt-EgL6UK+Tc4xvJQkGz9F=HNpE86kB3fKxymA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/08/2026 16:44, Puranjay Mohan wrote:
> On Wed, Aug 5, 2026 at 4:14 PM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 05/08/2026 15:43, Puranjay Mohan wrote:
>>> On Wed, Aug 5, 2026 at 2:58 PM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 05/08/2026 12:47, Puranjay Mohan wrote:
>>>>> On Wed, Aug 5, 2026 at 11:07 AM James Clark <james.clark@linaro.org> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
>>>>>>> On Mon, Aug 3, 2026 at 12:07 PM James Clark <james.clark@linaro.org> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 16/06/2026 16:57, Puranjay Mohan wrote:
>>>>>>>>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
>>>>>>>>> perf_snapshot_branch_stack static call for BRBE.
>>>>>>>>>
>>>>>>>>> BRBE is paused before masking exceptions to avoid branch buffer
>>>>>>>>> pollution from trace_hardirqs_off(). Exceptions are then masked with
>>>>>>>>> local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
>>>>>>>>> If an overflow between pause and DAIF save re-enables BRBE, the snapshot
>>>>>>>>> detects this via BRBFCR_EL1.PAUSED and bails out.
>>>>>>>>>
>>>>>>>>> Branch records are read using perf_entry_from_brbe_regset() with a NULL
>>>>>>>>> event pointer to bypass event-specific filtering. The buffer is
>>>>>>>>> invalidated after reading.
>>>>>>>>>
>>>>>>>>> Introduce a for_each_brbe_entry() iterator to deduplicate bank
>>>>>>>>> iteration between brbe_read_filtered_entries() and the snapshot.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>>>>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>>>>>>> ---
>>>>>>>>>       drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++-------
>>>>>>>>>       drivers/perf/arm_brbe.h  |   9 +++
>>>>>>>>>       drivers/perf/arm_pmuv3.c |   5 +-
>>>>>>>>>       3 files changed, 120 insertions(+), 22 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
>>>>>>>>> index effbdeacfcbb..a141ad7abcf2 100644
>>>>>>>>> --- a/drivers/perf/arm_brbe.c
>>>>>>>>> +++ b/drivers/perf/arm_brbe.c
>>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>>       #include <linux/types.h>
>>>>>>>>>       #include <linux/bitmap.h>
>>>>>>>>>       #include <linux/perf/arm_pmu.h>
>>>>>>>>> +#include <asm/daifflags.h>
>>>>>>>>>       #include "arm_brbe.h"
>>>>>>>>>
>>>>>>>>>       #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
>>>>>>>>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
>>>>>>>>>                  brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> +static __always_inline bool cpu_has_brbe(void)
>>>>>>>>
>>>>>>>> This should be more like cpu_valid_brbe_version(). has_brbe() only
>>>>>>>> implies that the CPU has BRBE, not that it's a version that the driver
>>>>>>>> supports. And it's actually just a wrapper around valid_brbe_version()
>>>>>>>> that accesses the ID reg on that CPU, not a functionally different check.
>>>>>>>>
>>>>>>>> But it also looks like valid_brbe_version() isn't called from anywhere
>>>>>>>> else, so why not delete that function and use its name for the new one?
>>>>>>>
>>>>>>> I will do that in next version
>>>>>>>
>>>>>>>>
>>>>>>>>> +{
>>>>>>>>> +     u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>>>>>>>> +     int brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
>>>>>>>>> +
>>>>>>>>> +     return valid_brbe_version(brbe);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>       static void select_brbe_bank(int bank)
>>>>>>>>>       {
>>>>>>>>>           u64 brbfcr;
>>>>>>>>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
>>>>>>>>>           isb();
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> +static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
>>>>>>>>> +{
>>>>>>>>> +     if (++(*idx) >= BRBE_BANK_MAX_ENTRIES &&
>>>>>>>>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
>>>>>>>>> +             *idx = 0;
>>>>>>>>> +             select_brbe_bank(++(*bank));
>>>>>>>>> +     }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +#define for_each_brbe_entry(idx, nr_hw)                                      \
>>>>>>>>> +     for (int __bank = (select_brbe_bank(0), 0), idx = 0;            \
>>>>>>>>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);            \
>>>>>>>>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
>>>>>>>>> +
>>>>>>>>>       static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
>>>>>>>>>       {
>>>>>>>>>           entry->brbinf = get_brbinf_reg(idx);
>>>>>>>>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
>>>>>>>>>
>>>>>>>>>       void brbe_probe(struct arm_pmu *armpmu)
>>>>>>>>>       {
>>>>>>>>> -     u64 brbidr, aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>>>>>>>> -     u32 brbe;
>>>>>>>>> +     u64 brbidr;
>>>>>>>>>
>>>>>>>>> -     brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
>>>>>>>>> -     if (!valid_brbe_version(brbe))
>>>>>>>>> +     if (!cpu_has_brbe())
>>>>>>>>>                   return;
>>>>>>>>>
>>>>>>>>>           brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
>>>>>>>>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
>>>>>>>>>
>>>>>>>>>           brbe_set_perf_entry_type(entry, brbinf);
>>>>>>>>>
>>>>>>>>> -     if (!branch_sample_no_cycles(event))
>>>>>>>>> +     if (!event || !branch_sample_no_cycles(event))
>>>>>>>>>                   entry->cycles = brbinf_get_cycles(brbinf);
>>>>>>>>>
>>>>>>>>> -     if (!branch_sample_no_flags(event)) {
>>>>>>>>> +     if (!event || !branch_sample_no_flags(event)) {
>>>>>>>>>                   /* Mispredict info is available for source only and complete branch records. */
>>>>>>>>>                   if (!brbe_record_is_target_only(brbinf)) {
>>>>>>>>>                           entry->mispred = brbinf_get_mispredict(brbinf);
>>>>>>>>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>>>>>>>>>       {
>>>>>>>>>           struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>>>>>>>>           int nr_hw = brbe_num_branch_records(cpu_pmu);
>>>>>>>>> -     int nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
>>>>>>>>>           int nr_filtered = 0;
>>>>>>>>>           u64 branch_sample_type = event->attr.branch_sample_type;
>>>>>>>>>           DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
>>>>>>>>>
>>>>>>>>>           prepare_event_branch_type_mask(branch_sample_type, event_type_mask);
>>>>>>>>>
>>>>>>>>> -     for (int bank = 0; bank < nr_banks; bank++) {
>>>>>>>>> -             int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
>>>>>>>>> -             int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
>>>>>>>>> +     for_each_brbe_entry(i, nr_hw) {
>>>>>>>>> +             struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
>>>>>>>>>
>>>>>>>>> -             select_brbe_bank(bank);
>>>>>>>>> +             if (!perf_entry_from_brbe_regset(i, pbe, event))
>>>>>>>>> +                     break;
>>>>>>>>>
>>>>>>>>> -             for (int i = 0; i < nr_this_bank; i++) {
>>>>>>>>> -                     struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
>>>>>>>>> +             if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
>>>>>>>>> +                     continue;
>>>>>>>>>
>>>>>>>>> -                     if (!perf_entry_from_brbe_regset(i, pbe, event))
>>>>>>>>> -                             goto done;
>>>>>>>>> +             nr_filtered++;
>>>>>>>>> +     }
>>>>>>>>>
>>>>>>>>> -                     if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
>>>>>>>>> -                             continue;
>>>>>>>>> +     branch_stack->nr = nr_filtered;
>>>>>>>>> +}
>>>>>>>>>
>>>>>>>>> -                     nr_filtered++;
>>>>>>>>> -             }
>>>>>>>>> +/*
>>>>>>>>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
>>>>>>>>> + * self-recording and return 0 if the snapshot state appears disturbed.
>>>>>>>>> + */
>>>>>>>>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>>>>>>>>> +{
>>>>>>>>> +     unsigned long flags;
>>>>>>>>> +     int nr_hw, nr_copied = 0;
>>>>>>>>> +     u64 brbfcr, brbcr;
>>>>>>>>> +
>>>>>>>>> +     if (!cnt)
>>>>>>>>> +             return 0;
>>>>>>>>
>>>>>>>> If you're trying to avoid branches before pausing BRBE, can't you check
>>>>>>>> this after the pause?
>>>>>>>
>>>>>>> will drop this in the next version and this is just an optimization.
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +     /* Guard against running on a CPU without BRBE (e.g. big.LITTLE). */
>>>>>>>>> +     if (!cpu_has_brbe())
>>>>>>>>> +             return 0;
>>>>>>>>> +
>>>>>>>>> +     /*
>>>>>>>>> +      * Pause BRBE first to avoid recording our own branches. The
>>>>>>>>> +      * sysreg read/write and ISB are branchless, so pausing before
>>>>>>>>> +      * checking BRBCR avoids polluting the buffer with our own
>>>>>>>>> +      * conditional branches.
>>>>>>>>> +      */
>>>>>>>>> +     brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>>>>>>> +     brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>>>>>>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>>>>>>>
>>>>>>>> Can this work without first disabling interrupts? Sashiko pointed it
>>>>>>>> out, but I think it's correct. If you read an active state into brbfcr,
>>>>>>>> then the PMU event fires and disables BRBE, then you disable interrupts,
>>>>>>>> then you would restore an active state when it should be inactive.
>>>>>>>> Surely the only way to do it properly is to disable interrupts before
>>>>>>>> touching anything at all, if the PMU handler is also touching the same
>>>>>>>> registers?
>>>>>>>>
>>>>>>>> If you want to avoid trace_hardirqs_off() can you make a new
>>>>>>>> raw_local_daif_save() that disables interrupts and then call
>>>>>>>> trace_hardirqs_off() yourself after pausing BRBE? Or not call
>>>>>>>> trace_hardirqs_off() at all? There is a comment mentioning something
>>>>>>>> like that in arch/arm64/kernel/suspend.c.
>>>>>>>
>>>>>>> Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and mask before
>>>>>>> touching any BRBE register, which fixes the stale restore. trace_hardirqs_off()
>>>>>>> then moves below the pause so lockdep still sees a balanced off/on pair while
>>>>>>> its branches land in an already paused buffer.
>>>>>>>
>>>>>>>>
>>>>>>>> Also, disabling interrupts doesn't stop the PMU event from overflowing
>>>>>>>> and changing the state of PAUSED either. I think this is another path
>>>>>>>> that leads to you restoring the wrong state, so don't you also need to
>>>>>>>> disable the PMU?
>>>>>>>
>>>>>>> Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a freeze needs
>>>>>>> BRBE to not already be paused (RNXCWF). So once we have paused, nothing changes
>>>>>>> underneath us and the PMU does not need disabling. It would not help anyway:
>>>>>>> armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and discards the
>>>>>>> records we came to read.
>>>>>>
>>>>>> That does mean you throw away real freeze events while paused though, in
>>>>>> addition to the brbe_invalidate() you need to avoid non contiguous
>>>>>> buffers. So it takes branches away from PMU events.
>>>>>
>>>>> RBHYTD gives a freeze two effects: PAUSED is set, and BRBTS_EL1 captures a
>>>>> timestamp. Recording has already stopped because we paused, and the driver never
>>>>> reads BRBTS_EL1. On the way out we check PMOVSCLR_EL0 and leave PAUSED set if a
>>>>> counter overflowed, so a pending overflow handler still finds a frozen buffer.
>>>>>
>>>>>> So it takes branches away from PMU events.
>>>>>
>>>>> Yes, but that is brbe_invalidate(), not the pause. Interrupts are masked and
>>>>> nothing else runs on the CPU, so the only branches the pause suppresses are the
>>>>> snapshot's own.
>>>>>
>>>>>>>
>>>>>>> You are right that a freeze can still land in the window between reading BRBFCR
>>>>>>> and setting PAUSED, and restoring the value we read would then clear a PAUSED
>>>>>>> bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE paused if a
>>>>>>> counter has overflowed. Reads of PMOVSCLR are non-destructive and it stays set
>>>>>>> until the overflow handler clears it, so it is still visible after we have set
>>>>>>> PAUSED ourselves:
>>>>>>>
>>>>>>>             if (!valid_brbe_version())
>>>>>>>                     return 0;
>>>>>>>
>>>>>>>             flags = raw_local_daif_save();
>>>>>>>
>>>>>>>             brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>>>>>             brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>>>>>
>>>>>>>             write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>>>>>>             isb();
>>>>>>>
>>>>>>>             trace_hardirqs_off();
>>>>>>>
>>>>>>>             /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
>>>>>>>             if (!brbcr)
>>>>>>>                     goto restore;
>>>>>>>
>>>>>>>             ... read the records ...
>>>>>>>
>>>>>>
>>>>>> Up to the point where you read the records you technically don't need
>>>>>> any branches (if you don't do trace_hardirqs_off()) so you could do the
>>>>>> whole thing without pausing. Just disable interrupts, read every branch
>>>>>> entry unconditionally, re-enable interrupts and then find the last valid
>>>>>> entry and do the branchy stuff after reading.
>>>>>>
>>>>>> I'm thinking out loud, but doesn't that make it a lot easier? And it
>>>>>> avoids the brbe_invalidate() which takes the branches away from the PMU
>>>>>> event. It also avoids having to think too hard about racing with PMU
>>>>>> events causing a freeze even after interrupts are disabled and after
>>>>>> reading the freeze value:
>>>>>>
>>>>>>       raw_local_daif_save();
>>>>>>       brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>>>>       brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>>>>       select_bank(0);
>>>>>>       read_record(0);
>>>>>>       read_record(1);
>>>>>>       ...
>>>>>>       select_bank(0);
>>>>>>       read_record(0);
>>>>>>       read_record(1);
>>>>>>       ...
>>>>>>       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>>>>>>       isb();
>>>>>>       local_daif_restore();
>>>>>>
>>>>>>       /* Now do post processing, find last valid record, check if it was
>>>>>> enabled by looking at brbcr etc. */
>>>>>
>>>>> MRS is not a branch, so that works, but three things would have to change:
>>>>>
>>>>> 1. perf_entry_from_brbe_regset() goes through BRBE_REGN_SWITCH, a 32 case
>>>>>       switch, because the register number has to be an immediate. gcc emits a jump
>>>>>       table and the function has 52 branches in the object file. The read would
>>>>>       need full unrolling.
>>>>>
>>>>
>>>> Yes you would have to manually unroll it. I doubt the compiler would
>>>> emit a branch for BRBE_REGN_SWITCH() because your indexes are static if
>>>> it's unrolled. But if it does you can change it to a sequence of
>>>> read_sysreg_s()s.
>>>>
>>>> If you really want to be sure there are no branches, write it in a
>>>> single asm block.
>>>
>>> I will try that approach in the next version.
>>>
>>>>> 2. RPGDLX needs an ISB before the reads, and Table D19-10 makes it
>>>>>       IMPLEMENTATION DEFINED whether ISB itself generates a record. When we pause,
>>>>>       IZCHRF means the pausing ISB cannot pollute the buffer it is about to read.
>>>>>
>>>>
>>>> I assume one potential extra record from the isb() is acceptible seeing
>>>> as you already have two or more conditions plus a function call before
>>>> the pause? Is the problem that you don't know whether to filter it out
>>>> later because it's IMPDEF and isn't always there? You already don't know
>>>> exactly how many branches there will be before the pause beause it's
>>>> written in C. So I'm not sure what the exact issue here is.
>>>>
>>>>> 3. 64 record parts still need a bank switch, so BRBFCR_EL1 still has to be
>>>>>       written and restored.
>>>>>
>>>>
>>>> Yes that was included in my pseudo code example but it's still
>>>> branchless. I did miss that you might need an isb() after disabling
>>>> interrupts, but you added one for RPGDLX anyway.
>>>>
>>>>> Correctness would then depend on the read staying branchless, which is not
>>>>> checkable at build time and fails silently: a branch mid read shifts the buffer,
>>>>
>>>> Why would the compiler insert a branch between two read_sysreg_s()s,
>>>> which are asm volatile? Is that allowed?
>>>
>>> You are right, I just over complicated it!
>>>
>>>>> giving a duplicate and a gap. 64 * 24 bytes of records also wants a per-CPU
>>>>> scratch buffer rather than the stack.
>>>>>
>>>>
>>>> A per-CPU scratch buffer doesn't sound too bad. But aren't you in
>>>> control of how many entries are available to write to? You can reject
>>>> any calls that have fewer than 64 and always write directly to *entries.
>>>>
>>>> You could also compare with 'cnt' after reading each record and exit the
>>>> read section. Like you say below, branches not taken don't generate
>>>> records, and once the branch is taken you stop reading so after that
>>>> point generating records doesn't matter.
>>>>
>>>>> Happy to prototype it. What I would not do is pause without invalidating:
>>>>> records are from/to pairs, so a consumer walking across the hole reconstructs a
>>>>> call path that never happened. The invalidate was Mark's request after the RFC,
>>>>> "to maintain record contiguity for other consumers", so dropping the pause drops
>>>>> that too.
>>>>
>>>> Well the point was to not have to pause at all, so there's no need to
>>>> invalidate either. Even if you did add a pause, as long as there are no
>>>> branches between the pause and resume you don't need an invalidate
>>>> because you didn't miss any branches.
>>>>
>>>>>
>>>>> I was thinking of this for v6:
>>>>>
>>>>>            flags = raw_local_daif_save();
>>>>>
>>>>>            /* The BRBE sysregs below are UNDEFINED without this. */
>>>>>            if (!valid_brbe_version()) {
>>>>
>>>> You don't need to disable interrupts to call this, it's a constant. Or
>>>> is it to stop migration?
>>>
>>> It was to stop migration.
>>>
>>
>> Ah ok, so V5 wasn't correct then.
> 
> Yes, It was buggy! I missed that one CPU could implement BRBE while
> another doesn't
> 
>>
>> Separately to this, I'm also not sure how this BPF call is invoked. Is
>> it supposed to target a CPU, or an event or a process? How do you know
>> you are getting the branches from the CPU that you want?
> 
> So, A BPF program can attach to a function's entry through ftrace or
> kprobe and from there we call this helper to find out what branches
> were taken to reach that function.
> A BPF program runs on a CPU with migration always disabled, so it

In that case you can check for BRBE support before disabling interrupts.

So I think V5 wasn't buggy and you can carry on doing 
valid_brbe_version() at the same place in V6.

> knows which cpu it is getting the branches from. And It can also
> filter for a process as it knows which process is called the BPF
> program, let's say a process does a syscall and we attach a bpf
> program to it as the example I gave with the retsnoop tool in the
> cover letter's Usage model section. A BPF program can also attach to a
> tracepoint, or even to a perf event and this BPF helper can be called
> from any of those contexts, but the filtering based on cpu or pid or
> anything else is done by the BPF program itself, this helper should
> just return the raw branch records.
> 

Thanks for the explanation.

>>>>
>>>> V5 reads sysregs before disabling interrupts so I assume migration isn't
>>>> an issue here.
>>>>
>>>>>                    raw_local_daif_restore(flags);
>>>>>                    return 0;
>>>>>            }
>>>>>
>>>>>            brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>>>            brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>>>
>>>>>            write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>>>>            isb();
>>>>>
>>>>>            /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
>>>>>            if (!brbcr) {
>>>>>                    write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>>>>>                    isb();
>>>>>                    raw_local_daif_restore(flags);
>>>>>                    return 0;
>>>>>            }
>>>>>
>>>>>            trace_hardirqs_off();
>>>>>
>>>>>            ... read the records ...
>>>>>
>>>>>            if (!(brbfcr & BRBFCR_EL1_PAUSED) &&
>>>>>                !(read_pmovsclr() & (ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_F)))
>>>>>                    brbe_invalidate();
>>>>>            else
>>>>>                    brbfcr |= BRBFCR_EL1_PAUSED;
>>>>>
>>>>>            write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>>>>>            isb();
>>>>>            local_daif_restore(flags);
>>>>>
>>>>> Exceptions are masked before anything is sampled, BRBCR_EL1 is only read and
>>>>> never written, and BRBFCR_EL1 is written back from the value saved under the
>>>>> mask. cpu_has_brbe() is now valid_brbe_version().
>>>>>
>>>>> Neither conditional costs a record: valid_brbe_version() falls through when BRBE
>>>>> is present (RBBNSZ, only taken branches are recorded), and the BRBCR_EL1 test is
>>>>
>>>> Isn't the compiler free to invert it and make the happy path a taken
>>>> branch. I don't think any of that can be assumed without writing in
>>>> assembly.
>>>>
>>>>> after the pause. It cannot move later because BRBFCR_EL1 is UNDEFINED without
>>>>> FEAT_BRBE.
>>>>>
>>>>> PMOVSCLR_EL0 is masked because PMCCNTR_EL0 is bit 31 and PMCR_EL0.N is at most
>>>>> 31, so the cycle counter is outside every range RNXCWF, RGXGWY, RPKTXQ and
>>>>> RLDMVK name. Unmasked, a cycle counter overflow looked like a freeze.
>>>>
>>>> Sorry I didn't understand this bit. Can you elaborate?
>>>>
>>>>>
>>>>> Do you think this version works?
>>>>>
>>>>> Thanks,
>>>>> Puranjay
>>>>
>>>>
>>>>    From your previous reply:
>>>>
>>>>      "Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a
>>>>       freeze needs BRBE to not already be paused (RNXCWF). So once we have
>>>>       paused, nothing changes underneath us and the PMU does not need
>>>>       disabling."
>>>>
>>>> I'm still not 100% convinced this is correct. You read BRBFCR_EL1 and
>>>> write PAUSED to it in separate instructions. The PMU can overflow and
>>>> change the PAUSED state between those two instructions leading to
>>>> restoration of the wrong value.
>>>
>>> I was checking if the overflow happened and leaving it paused in that case.
>>>
>>
>> But couldn't it overflow after that check? I still think it's vulnerable
>> to the same issue unless you disable the PMU completely.
> 
> yeah you are right, I missed that it can overflow after the check.
> 
>>
>>>> Isn't this non pausing version way simpler to understand, and also has
>>>> the benefit of not invalidating someone elses BRBE buffers. The only
>>>> downside seems to be that it might have some assembly to make sure the
>>>> if statements are always not taken branches rather than inverted, but
>>>> personally I don't think that makes it any harder to understand than the
>>>> branchy pausing version in V5:
>>>>
>>>>      #define read_record(i)
>>>>        if (i >= cnt)                                       \
>>>>           goto out;                                        \
>>>>        isb(); /* Ensure our own exit branch isn't read? */ \
>>>>        entries[i].inf = read_brbe_inf(i)                   \
>>>>        if (!inf)                                           \
>>>>           goto out;                                        \
>>>>        entries[i].src = read_brb_src(i)                    \
>>>>        entries[i].dst = read_brb_dst(i)                    \
>>>>
>>>>      raw_local_daif_save();
>>>>
>>>>      /* disable counters to stop BRBFCR_EL1.PAUSE state changing */
>>>>      pmcr = armv8pmu_pmcr_read();
>>>>      armv8pmu_pmcr_write(pmcr & ~ARMV8_PMU_PMCR_E);
>>>>      isb();
>>>>
>>>>      brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>>      brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>>
>>>>      select_bank(0);
>>>>      read_record(0);
>>>>      read_record(1);
>>>>      ...
>>>>      select_bank(1);
>>>>      read_record(32);
>>>>      read_record(33);
>>>>      ...
>>>>
>>>> out:
>>>>      write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>>>>      isb();
>>>>      armv8pmu_pmcr_write(pmcr);
>>>>      raw_local_daif_restore();
>>>>
>>>>      /* Post process entries[n].inf etc into correct format */
>>>
>>> I will try out this approach and get back.
>>>
>>> Thanks,
>>> Puranjay
>>
>> Nice, hope it can work.
>>

