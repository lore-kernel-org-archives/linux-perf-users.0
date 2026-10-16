Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F352853FD;
	Fri, 16 Oct 2026 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120303; cv=none; b=M/t9/8No3GwJIVkqEYAiKoRnjH3HckgDqYDVz0zT1ZVNn24AGN91HRUX06EwJXicuapZrC8FpzUi8gS9hlGfCOryou2A+udHEnCPLqFCDHX7tOfAsUpgyd8F+xBo3uJWf1yGlPGtp9h2+Aaf8LJuTfUuFLN5268f/+mdxPzYkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120303; c=relaxed/simple;
	bh=sdnaONkbtC5AWH295B8Q1LbDEsh1f7mIxFFEsoKw9H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZgPoWwKeUfnSDRkW2XPaeUgZ2dtlUOWHYHdeQcxWzXlMjtg8x8D/144xTOUQ13sVRK4OMMX7Lt+9naJ9oh1Vrac1xMDlxeMfgDpc5EBCf1olyVlkFOmdn6MoQ6vH5lQAbMbDF+mkzo2mlyA6CLEOdIAZ0FmDFy7dUWT6Lvqnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLTtIAmx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLTtIAmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792120301; x=1823656301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sdnaONkbtC5AWH295B8Q1LbDEsh1f7mIxFFEsoKw9H0=;
  b=GLTtIAmxmxVTNmxVlp3kl6/2pLqidnIPORGEqNDfeweqpKQB6NcbSFIk
   pwiVw93/YNjaR3szpGVrNcvmknzUjAwZFnn9a/n6hqAi8FRrV6sHJlXkW
   a9t7vPbGNy93RthZdZUf+vDsZ71hJNMfdTqcoqB28aldX/RQbqQZNjNTL
   KmjKfYPlwFF+rEMi+aNDvC9jbHCN+uQug3aym91vXv32f8/jLGZSgZx1T
   raq6u07VQ3yMHocay3gtPgRzNukQGPyR5fA+X0OnYYnGTkrIJQ545gAum
   6NQJqKmpQcs4Kwa0ENihq/ZHBsXWdKXPJxjWSyfIlqWIZT8gKAGQUYjbB
   A==;
X-CSE-ConnectionGUID: pTEwuz3NT3Cgx8ipivUIpQ==
X-CSE-MsgGUID: jpEFTAkTQtOkJK9892qGKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="781821"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="781821"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 20:11:40 -0700
X-CSE-ConnectionGUID: 6ywES729QEm5/80oo1fpOw==
X-CSE-MsgGUID: fUNJ7nYDQaqEssfFFjYzhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1738755"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 20:11:33 -0700
Message-ID: <4ef25c08-ac66-4734-abd1-2d50bebcd94f@linux.intel.com>
Date: Fri, 16 Oct 2026 11:11:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
To: bot+bpf-ci@kernel.org, sandipan.das@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 andrii@kernel.org, song@kernel.org, ravi.bangoria@amd.com,
 ananth.narayan@amd.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
 <9ef8c1f496a9dca33792c7c3978e24208fe67d87688d5356b5e54e77eb009747@mail.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <9ef8c1f496a9dca33792c7c3978e24208fe67d87688d5356b5e54e77eb009747@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/16/2026 8:21 AM, bot+bpf-ci@kernel.org wrote:
>> perf/x86/intel/lbr: Limit branch snapshots to valid entries
> TL;DR: Resetting cpuc->lbr_stack.nr in intel_pmu_lbr_read() may clobber an
> in-flight adaptive PEBS sample if a BPF program calls
> bpf_get_branch_snapshot(), possibly yielding a PERF_RECORD_SAMPLE without
> branch records and with leftover bytes.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 22e2a06d5786..2fe858d99979 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>>  	 * but this simple approach seems to work for now.
>>  	 */
>>  	if (!cpuc->lbr_users || vlbr_exclude_host() ||
>> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
>> +	    cpuc->lbr_users == cpuc->lbr_pebs_users) {
>> +		cpuc->lbr_stack.nr = 0;
>                  ^^^^
> Can this clobber the branch stack of a PEBS sample that is still being
> built?
>
> Before this patch the early return had no side effects.  Now it writes to
> cpuc->lbr_stack, which is shared with the adaptive PEBS path.
>
> If every LBR user on the CPU is an adaptive PEBS event, then
> cpuc->lbr_users == cpuc->lbr_pebs_users, and the PEBS drain points the
> sample at the per-CPU stack:
>
> setup_pebs_adaptive_sample_data()
>     intel_pmu_store_pebs_lbrs(lbr);         /* cpuc->lbr_stack.nr = N */
>     intel_pmu_lbr_save_brstack(data, cpuc, event);
>         perf_sample_save_brstack(data, event, &cpuc->lbr_stack, ...);
>             data->br_stack = brs;           /* points at cpuc->lbr_stack */
>             data->dyn_size += ... + brs->nr * sizeof(struct perf_branch_entry);
>
> __intel_pmu_pebs_last_event() then calls perf_event_overflow(), and
> __perf_event_overflow() runs bpf_overflow_handler() before the sample is
> written.  A perf event BPF program attached to that event can call
> bpf_get_branch_snapshot(), which is in bpf_base_func_proto:

Yeah, it's a possible risk. After thinking twice about this issue, the
issue seems much more complex than I ever thought.

intel_pmu_lbr_read() could be called in two paths, one is from the perf PMI
handler, the other is from the bpf_get_branch_snapshot() bpf helper. Which
makes the thing more complicated is that bpf_get_branch_snapshot() helper
could be called in the PMI handler as well, where is just before the
default event overflow handler. In this case, intel_pmu_lbr_read() could be
called twice in PMI handler.

So there could be 3 scenarios for the intel_pmu_lbr_read() calling.

1. bpf_get_branch_snapshot() is not attached to any event, then
bpf_get_branch_snapshot() won't be called in anywhere, current LBR stack
update in PMI handler is good for both PEBS and non-PEBS events.

2. bpf_get_branch_snapshot() is attached to a software tracepoint, then
bpf_get_branch_snapshot() is called out of PMI handler,
the intel_pmu_lbr_read() is called to get the current LBR stack data in
bpf_get_branch_snapshot(), it's fine as well.

3. bpf_get_branch_snapshot() is attached to a perf hardware event, then
bpf_get_branch_snapshot() is called in the PMI handler, it leads to LBR
stack could be updated twice in the PMI handler. In this scenario, since
perf has already read the latest LBR stack data before calling
bpf_get_branch_snapshot() helper, bpf_get_branch_snapshot() is unnecessary
to read the LBR stack again, and worse it could overwrite the cache PEBS
LBR stack data if PMI is triggered by PEBS event.

Roughly we could need below changes to thoroughly fix this issue.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 442be0639414..d2cbb5ade003 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2869,8 +2869,8 @@ __intel_pmu_snapshot_branch_stack(struct
perf_branch_entry *entries,
 {
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

-       intel_pmu_lbr_read();
-       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+       intel_pmu_lbr_read(true);
+       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);

        memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry)
* cnt);
        intel_pmu_enable_all(0);
@@ -4090,7 +4090,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)

        loops = 0;
 again:
-       intel_pmu_lbr_read();
+       intel_pmu_lbr_read(false);
        intel_pmu_ack_status(status);
        if (++loops > 100) {
                static bool warned;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 2218469be644..c651b94a893f 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1008,18 +1008,31 @@ static void intel_pmu_arch_lbr_read_xsave(struct
cpu_hw_events *cpuc)
        intel_pmu_store_lbr(cpuc, xsave->state.lbr.entries);
 }

-void intel_pmu_lbr_read(void)
+void intel_pmu_lbr_read(bool from_bpf)
 {
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

+       if (!cpuc->lbr_users || vlbr_exclude_host()) {
+               /* Reset lbr_stack.nr to prevent stale data leakage. */
+               cpuc->lbr_stack.nr = 0;
+               return;
+       }
+
        /*
         * Don't read when all LBRs users are using adaptive PEBS.
         *
         * This could be smarter and actually check the event,
         * but this simple approach seems to work for now.
         */
-       if (!cpuc->lbr_users || vlbr_exclude_host() ||
-           cpuc->lbr_users == cpuc->lbr_pebs_users)
+       if (cpuc->lbr_users == cpuc->lbr_pebs_users)
+               return;
+
+       /*
+        * Don't read LBRs from BPF context if we're in an PMI handler
+        * since the LBR stack has been updated previously and new LBR
+        * stack update could overwrite the cached PEBS LBR stack.
+        */
+       if (from_bpf && in_nmi())
                return;

        x86_pmu.lbr_read(cpuc);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 60038d329518..4738b40288a4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -2006,7 +2006,7 @@ void intel_pmu_lbr_enable_all(bool pmi);

 void intel_pmu_lbr_disable_all(void);

-void intel_pmu_lbr_read(void);
+void intel_pmu_lbr_read(bool from_bpf);

 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);

Sandipan, would you mind I take this series? I need to do fully validation
for the Intel side changes. Once the validation passes, I would send a new
patch series to fix the issue for both AMD and Intel side. Thanks.


>
> intel_pmu_snapshot_branch_stack()
>     __intel_pmu_snapshot_branch_stack()
>         intel_pmu_lbr_read()
>             /* lbr_users == lbr_pebs_users, early return taken */
>             cpuc->lbr_stack.nr = 0;
>
> When the program returns, data->br_stack still points at cpuc->lbr_stack,
> but nr is now 0.  A later bpf_read_branch_records() in the same program
> reads ctx->data->br_stack->nr and returns 0 bytes.
>
> perf_output_sample() then writes nr = 0 and no entries, while header.size was
> already computed by perf_prepare_header() from data->dyn_size, which counted
> N entries.  Doesn't that leave the PERF_RECORD_SAMPLE without its branch
> records and followed by N * sizeof(struct perf_branch_entry) bytes of
> leftover ring buffer content?
>
> Before the patch, the early return left cpuc->lbr_stack untouched and this
> sample came out intact.
>
> Would it be better to leave cpuc->lbr_stack alone in the snapshot path, for
> example by checking the skip condition in __intel_pmu_snapshot_branch_stack()
> and returning 0 there, instead of resetting the shared nr inside
> intel_pmu_lbr_read() for every caller?
>
>>  		return;
>> +	}
>>
>>  	x86_pmu.lbr_read(cpuc);
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38827450009
