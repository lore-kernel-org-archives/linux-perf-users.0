Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED53E3D98
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755229; cv=none; b=HGhlNdbGPFf0BTInwRkeont76Z125qSu5m6G7XYjYGi7h3vIvODk9tPSL/bAehe5LHpns9R0n5msI2vYXP+vtfopVg+T/45M/GPbMe92hw6ZIvtTufxSO2AuZviSyNVT6b7lU4xaAysY0O1W2ELWJuXLDyjmla7/9UYphsBtRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755229; c=relaxed/simple;
	bh=VBR60XG9y2Uk6RCxjNGiPAYXZH8PpzPBAAF3gDrOcTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8Op9c4YAj5DSxOKm9XEQrxRLut19Lcd+y5ZT29XC+4M+6y/op5LSMIUZBCrhpH6m/44ygB4nn/v52MZnkPYPdVxvwjqD8PWs7SD4y4VY4XvEFDIFNr5ZHS/K30i3pLGAKI+upDxzJWGNvyBUe2VlNATxf6jYl2uPqM44XCObSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC2Z7kv7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC2Z7kv7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f6de72faso13707015e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785755225; x=1786360025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSQmwTgmqqEI3Rld3bh1K2CmFtffeneeKX7l2+wWsvo=;
        b=yC2Z7kv76wwImAZjnRBOfwMNxmXiH1AoJioPafFIjVUqPIWoMWvQEwvbOvtBgf+COc
         hPRVg1eQiNA0EaNX5KKEFNloORTOQuxqy8+ql46WljgcKwdLbmWpkxp/7zgAxXnLxOH6
         IBcLiq9sCVBnszjZ4JpF2wO6epou6/DvgNNWX4GsLsL74kUVqNfSyqHB5BVRskqysmWb
         VT/+L/9RnxQCAPOhxA3IPDqfas6ghdqsoByvp2x8K0nQa+hqfiUSOvPQB1E9xP4QZUak
         fb9jySgDlUItQjT2XEBMIvb83fZ7hCQBSr9gkaMYLQ0uFfJsRqx5QwzsPmTqXsGEWemi
         vFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755225; x=1786360025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSQmwTgmqqEI3Rld3bh1K2CmFtffeneeKX7l2+wWsvo=;
        b=junfEDm0ZuKAA9PwdORdMMDGIW9xOX8fjOaNqc4Hq7txw7dz/gx4VVydL+bBwJ9Rxl
         6ggb4WjsKcSK4gMZ8Ne+QeHGIvyR47/MTRkFVj0vcFSrJrolp8fA7yDa7pNVphYAXpxs
         4LY+w4JwYn68BdQvT3GIuvesECOHHO2sxEzaYSb6d8wFDtcm3l2SSauq6C6q90JFRjRj
         0W9nmTai/kQbEJ1g9cwMFgwXZSjhzJpc8/oMLCFhEnDSEYwV5F+IPAij/bjkvx3+foxU
         3uSEZKqvzUgE1XsdfX5BCwNyvu740EY645+LontHg0E0UYU8JrcWLoILfiHRyAeP8n0t
         5nrA==
X-Forwarded-Encrypted: i=1; AHgh+Ro97QpZ7zaY7Quvgq1DEBKQgzMMWlyr0PZxSceNDML+iPyTQpmlz/xcxqvzgiSL+mCL+AgXGNJhD3J+FKmngTEF@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqMOG7J5m8MEhEp189DDbWyrkbC7FICh0b0bjSgyHL68rimUq
	BEnAC/mcT/eRlWzVF2pyvg+NEdAVPQNEMHYyPo/frdttfVCK6h1EVANlU6ylk4sMhyk=
X-Gm-Gg: AR+sD12NKMTF0C1gY/RUQK6rqLzcG3AzwsaFpCf7lXC22AGczbl+yi6huAt4Yb6bBDf
	q8JqlPIqLIlaC++wXmIsjpL2s/HXjwz2AW3JCU6iBZn6uY40csG2TbKUQp97/y89NFzAJPhf8cB
	x4fd/HD5h5AVIXayALtX9PXp6a8UxJCnIn95nifZCdqFqLEOXCaHemfXyqES7rGgDPXKYJ9N+pI
	Jl6GbYu0hlpy8dKOCv/SeTNHzXpjGBb+xA9VIqCKAafL56/ywyJC49e97I2ujtdSV4N5J5LpB/T
	cxDuZBqNitVfDwCc8J2k7+rdFwrOsJ/NX8dR8DGxHowjjbbByVOmd7wVL6avIkvB3QFr0Fr/5bc
	CKTZr6+5sBN4jFkxqxE1A2RaT5LdMH7prBVyDB83L1PxLa7QIbiNZBSwbK7AvOOi2pN5lMfw07I
	XarQDa/bIpxLub6AxD9zNTVVsdaEvpZkD1JjuatElARKAor/hOkMFWOPLR1+P9dQb9kNk=
X-Received: by 2002:a05:600c:5249:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4980eb9b2eemr139526335e9.5.1785755224975;
        Mon, 03 Aug 2026 04:07:04 -0700 (PDT)
Received: from [192.168.1.183] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm375587785e9.12.2026.08.03.04.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:07:04 -0700 (PDT)
Message-ID: <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org>
Date: Mon, 3 Aug 2026 12:07:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260616155716.2631508-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2026 16:57, Puranjay Mohan wrote:
> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> perf_snapshot_branch_stack static call for BRBE.
> 
> BRBE is paused before masking exceptions to avoid branch buffer
> pollution from trace_hardirqs_off(). Exceptions are then masked with
> local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
> If an overflow between pause and DAIF save re-enables BRBE, the snapshot
> detects this via BRBFCR_EL1.PAUSED and bails out.
> 
> Branch records are read using perf_entry_from_brbe_regset() with a NULL
> event pointer to bypass event-specific filtering. The buffer is
> invalidated after reading.
> 
> Introduce a for_each_brbe_entry() iterator to deduplicate bank
> iteration between brbe_read_filtered_entries() and the snapshot.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++-------
>   drivers/perf/arm_brbe.h  |   9 +++
>   drivers/perf/arm_pmuv3.c |   5 +-
>   3 files changed, 120 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index effbdeacfcbb..a141ad7abcf2 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -9,6 +9,7 @@
>   #include <linux/types.h>
>   #include <linux/bitmap.h>
>   #include <linux/perf/arm_pmu.h>
> +#include <asm/daifflags.h>
>   #include "arm_brbe.h"
>   
>   #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
>   	       brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
>   }
>   
> +static __always_inline bool cpu_has_brbe(void)

This should be more like cpu_valid_brbe_version(). has_brbe() only 
implies that the CPU has BRBE, not that it's a version that the driver 
supports. And it's actually just a wrapper around valid_brbe_version() 
that accesses the ID reg on that CPU, not a functionally different check.

But it also looks like valid_brbe_version() isn't called from anywhere 
else, so why not delete that function and use its name for the new one?

> +{
> +	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> +	int brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
> +
> +	return valid_brbe_version(brbe);
> +}
> +
>   static void select_brbe_bank(int bank)
>   {
>   	u64 brbfcr;
> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
>   	isb();
>   }
>   
> +static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
> +{
> +	if (++(*idx) >= BRBE_BANK_MAX_ENTRIES &&
> +	    *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> +		*idx = 0;
> +		select_brbe_bank(++(*bank));
> +	}
> +}
> +
> +#define for_each_brbe_entry(idx, nr_hw)					\
> +	for (int __bank = (select_brbe_bank(0), 0), idx = 0;		\
> +	     __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);		\
> +	     __brbe_advance(&__bank, &idx, (nr_hw)))
> +
>   static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
>   {
>   	entry->brbinf = get_brbinf_reg(idx);
> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
>   
>   void brbe_probe(struct arm_pmu *armpmu)
>   {
> -	u64 brbidr, aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> -	u32 brbe;
> +	u64 brbidr;
>   
> -	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
> -	if (!valid_brbe_version(brbe))
> +	if (!cpu_has_brbe())
>   		return;
>   
>   	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
>   
>   	brbe_set_perf_entry_type(entry, brbinf);
>   
> -	if (!branch_sample_no_cycles(event))
> +	if (!event || !branch_sample_no_cycles(event))
>   		entry->cycles = brbinf_get_cycles(brbinf);
>   
> -	if (!branch_sample_no_flags(event)) {
> +	if (!event || !branch_sample_no_flags(event)) {
>   		/* Mispredict info is available for source only and complete branch records. */
>   		if (!brbe_record_is_target_only(brbinf)) {
>   			entry->mispred = brbinf_get_mispredict(brbinf);
> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>   {
>   	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>   	int nr_hw = brbe_num_branch_records(cpu_pmu);
> -	int nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
>   	int nr_filtered = 0;
>   	u64 branch_sample_type = event->attr.branch_sample_type;
>   	DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
>   
>   	prepare_event_branch_type_mask(branch_sample_type, event_type_mask);
>   
> -	for (int bank = 0; bank < nr_banks; bank++) {
> -		int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
> -		int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
> +	for_each_brbe_entry(i, nr_hw) {
> +		struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
>   
> -		select_brbe_bank(bank);
> +		if (!perf_entry_from_brbe_regset(i, pbe, event))
> +			break;
>   
> -		for (int i = 0; i < nr_this_bank; i++) {
> -			struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
> +		if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
> +			continue;
>   
> -			if (!perf_entry_from_brbe_regset(i, pbe, event))
> -				goto done;
> +		nr_filtered++;
> +	}
>   
> -			if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
> -				continue;
> +	branch_stack->nr = nr_filtered;
> +}
>   
> -			nr_filtered++;
> -		}
> +/*
> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> + * self-recording and return 0 if the snapshot state appears disturbed.
> + */
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int nr_hw, nr_copied = 0;
> +	u64 brbfcr, brbcr;
> +
> +	if (!cnt)
> +		return 0;

If you're trying to avoid branches before pausing BRBE, can't you check 
this after the pause?

> +
> +	/* Guard against running on a CPU without BRBE (e.g. big.LITTLE). */
> +	if (!cpu_has_brbe())
> +		return 0;
> +
> +	/*
> +	 * Pause BRBE first to avoid recording our own branches. The
> +	 * sysreg read/write and ISB are branchless, so pausing before
> +	 * checking BRBCR avoids polluting the buffer with our own
> +	 * conditional branches.
> +	 */
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);

Can this work without first disabling interrupts? Sashiko pointed it 
out, but I think it's correct. If you read an active state into brbfcr, 
then the PMU event fires and disables BRBE, then you disable interrupts, 
then you would restore an active state when it should be inactive. 
Surely the only way to do it properly is to disable interrupts before 
touching anything at all, if the PMU handler is also touching the same 
registers?

If you want to avoid trace_hardirqs_off() can you make a new 
raw_local_daif_save() that disables interrupts and then call 
trace_hardirqs_off() yourself after pausing BRBE? Or not call 
trace_hardirqs_off() at all? There is a comment mentioning something 
like that in arch/arm64/kernel/suspend.c.

Also, disabling interrupts doesn't stop the PMU event from overflowing 
and changing the state of PAUSED either. I think this is another path 
that leads to you restoring the wrong state, so don't you also need to 
disable the PMU?

> +	isb();
> +
> +	/* Bail out if BRBE is not enabled (BRBCR_EL1 == 0). */
> +	if (!brbcr) {
> +		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +		isb();
> +		return 0;
>   	}
>   
> -done:
> -	branch_stack->nr = nr_filtered;
> +	/* Block local exception delivery while reading the buffer. */
> +	flags = local_daif_save();
> +
> +	/*
> +	 * A PMU overflow before local_daif_save() could have re-enabled
> +	 * BRBE, clearing the PAUSED bit. The overflow handler already
> +	 * restored BRBE to its correct state, so just bail out.
> +	 */
> +	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
> +		local_daif_restore(flags);
> +		return 0;
> +	}
> +
> +	nr_hw = FIELD_GET(BRBIDR0_EL1_NUMREC_MASK,
> +			  read_sysreg_s(SYS_BRBIDR0_EL1));
> +
> +	for_each_brbe_entry(i, nr_hw) {
> +		if (nr_copied >= cnt)
> +			break;
> +
> +		if (!perf_entry_from_brbe_regset(i, &entries[nr_copied], NULL))
> +			break;
> +
> +		nr_copied++;
> +	}
> +
> +	brbe_invalidate();
> +
> +	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +	isb();
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +	/* Ensure BRBE is unpaused before returning to the caller. */
> +	isb();
> +	local_daif_restore(flags);
> +
> +	return nr_copied;
>   }
> diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
> index b7c7d8796c86..c2a1824437fb 100644
> --- a/drivers/perf/arm_brbe.h
> +++ b/drivers/perf/arm_brbe.h
> @@ -10,6 +10,7 @@
>   struct arm_pmu;
>   struct perf_branch_stack;
>   struct perf_event;
> +struct perf_branch_entry;
>   
>   #ifdef CONFIG_ARM64_BRBE
>   void brbe_probe(struct arm_pmu *arm_pmu);
> @@ -22,6 +23,8 @@ void brbe_disable(void);
>   bool brbe_branch_attr_valid(struct perf_event *event);
>   void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>   				const struct perf_event *event);
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
> +				   unsigned int cnt);
>   #else
>   static inline void brbe_probe(struct arm_pmu *arm_pmu) { }
>   static inline unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
> @@ -44,4 +47,10 @@ static void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>   				       const struct perf_event *event)
>   {
>   }
> +
> +static inline int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
> +						 unsigned int cnt)
> +{
> +	return 0;
> +}
>   #endif
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8014ff766cff..1a9f129a0f94 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1449,8 +1449,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>   	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
>   
>   	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
> -	if (brbe_num_branch_records(cpu_pmu))
> +	if (brbe_num_branch_records(cpu_pmu)) {
>   		cpu_pmu->pmu.sched_task		= armv8pmu_sched_task;
> +		static_call_update(perf_snapshot_branch_stack,
> +				   arm_brbe_snapshot_branch_stack);
> +	}
>   
>   	cpu_pmu->name			= name;
>   	cpu_pmu->map_event		= map_event;

