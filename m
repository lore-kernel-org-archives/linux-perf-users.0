Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975056;
	b=MGCzNeURbnCHx16QVKAYoX8TTxH6fS+lqMKEkCS55eRmcGPNG2tFRV08AKEW0nbdyGQU
	 29DNvrXdKYz5hBO82QLMoWwFys//SIFFjo+oKki7p5nYqquDRvFq1g/XEzgsm/NFeafXW
	 7VMDl88kqf1p2RtyVXU2j7C5il0Ltqoe3ehEdk99+Q9Pzcai6fdD9ga/GVfgay0xBKkY7
	 EvgIWo5Rjf7mPYgJAd35lI9zUnW/nR4uMYnMrJ9M0fPvJUs24BFwDoaH5GSvuAUDqHYnA
	 x6ISGGhFTrg01jb2a33JeeRrBBbx7iFDdjjYw3UYSf68Hq6L4S6S3H8jjZXV/ZYzAaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975056;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=h3qA4QlsVDH5xdgBYsuDi3c1zf0fz2YKqCzY/AfDqKw=;
	b=DmnTrsspdPtbeQMamPcN8hOgMcHJy9P31ob20vPcrpPCuMgCug7FaNxcgqIWe5C7PjRo
	 hIGEm4dyzpPyqwCbBqtrsfs/pZKDnHw1F/JL1laMZIuw4gZkDG9nfEIMXPjMEEmMjTMm7
	 Axnc5GdJDaPl0r5DqWAIWgf564d7f5ODwjx03mMXFjxGOYpbc5OXmtmGjkzAPdVwRXNsS
	 c0MbuI6/yvs6QITA3tgdL7td845NoryngJHzHGlHVsppAhszpgy5hoZBeEj7M0zdc/MPZ
	 xXXzVWi4kJybLX8s6cnSjdqU6xVKVfmRX/h63PIG0/4aHLDmzN6IQlSwUPcHotEqNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aj23ateH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E393606A332;
	Wed, 18 Nov 2026 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aj23ateH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E291F000C4;
	Wed, 18 Nov 2026 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794975055;
	bh=h3qA4QlsVDH5xdgBYsuDi3c1zf0fz2YKqCzY/AfDqKw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aj23ateHmO9Smp7R79jBViBScdqnAoymGWoAdhtMHs3lxneWGKXLMmtYAlT09KPsR
	 ezPed/+0h9CJtmLum74vdgaVeCml80Wb2epts35prlLnLpmbuZzNzw73+aX9CFC4Cg
	 eTBJgLp0CE2bq+9e3Hn0E/6gImicqzWDySFBe8DBJRgBk773Fdf0ckRLj69J9BRXWI
	 wKVK/R/zwATldEk5BnrXZ6CuPUbKJyM/GfTgeREuj8eHk7pWKhRsMd/NkKeQpYfx3l
	 mLMmPTSXWbtFI0ihQ34jqbLUWtO9OuW4TFLemNTOUqKJmrhoxaeZDlOwRLkGubNwh3
	 2TIg4Sj1aPAow==
Content-Type: multipart/mixed; boundary="===============2643490914929125600=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <61848b4bb02d2dcb5f78b813f31a4f395805c864c1152c52374abc2ca1a1ff51@mail.kernel.org>
In-Reply-To: <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v7 04/24] perf/x86/intel: Limit branch snapshots to valid entries
From: bot+bpf-ci@kernel.org
To: dapeng1.mi@linux.intel.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,irogers@google.com,adrian.hunter@intel.com,alexander.shishkin@linux.intel.com,ak@linux.intel.com,eranian@google.com,sandipan.das@amd.com,andrii@kernel.org,song@kernel.org,ravi.bangoria@amd.com,ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,dapeng1.mi@intel.com,zide.chen@intel.com,thomas.falcon@intel.com,xudong.hao@intel.com,dapeng1.mi@linux.intel.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 04:10:53 +0000 (UTC)

--===============2643490914929125600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> perf/x86/intel: Limit branch snapshots to valid entries

TL;DR: Resetting the shared lbr_stack.nr in intel_pmu_lbr_read() may corrupt
an in-flight host adaptive-PEBS branch-stack sample when KVM vLBR is active
and a BPF program calls bpf_get_branch_snapshot(); a later patch fixes it.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -1026,14 +1026,19 @@ void intel_pmu_lbr_read(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> +	if (!cpuc->lbr_users || vlbr_exclude_host()) {
> +		/* Reset lbr_stack.nr to prevent stale data leakage. */
> +		cpuc->lbr_stack.nr = 0;
> +		return;
> +	}
> +

Can this reset of cpuc->lbr_stack.nr corrupt a host adaptive-PEBS sample
that is still in flight?

Before this patch the vlbr_exclude_host() case returned without writing
anything.  Now the BPF snapshot path writes to the same per-CPU struct
that a PMI-time sample may still point at:

intel_pmu_handle_irq()
  handle_pmi_common() -> x86_pmu_drain_pebs
    __intel_pmu_pebs_last_event()
      setup_pebs_adaptive_sample_data()
        intel_pmu_store_pebs_lbrs(lbr)   /* cpuc->lbr_stack.nr = N */
        intel_pmu_lbr_save_brstack()
          perf_sample_save_brstack()     /* data->dyn_size += N entries */
                                         /* data->br_stack = &cpuc->lbr_stack */
      perf_event_overflow()
        __perf_event_overflow()
          bpf_overflow_handler()
            BPF prog -> bpf_get_branch_snapshot()
              __intel_pmu_snapshot_branch_stack()
                intel_pmu_lbr_read()     /* vlbr_exclude_host(): nr = 0 */
          overflow_handler() -> perf_output_sample()
            perf_output_put(handle, data->br_stack->nr);       /* now 0 */
            perf_output_copy(handle, data->br_stack->entries, ...);

The record header was sized for N branch entries, but nr is now 0 and no
entries are written, so the PEBS LBR data for that sample is lost and the
tail of the record is never written.

This looks reachable when KVM's vLBR event is active (it sets
INTEL_PMC_IDX_FIXED_VLBR in intel_ctrl_exclude_host_mask) alongside a host
PEBS event using PERF_SAMPLE_BRANCH_STACK, with a perf_event BPF program
calling bpf_get_branch_snapshot().  Before this patch the same sequence
produced a consistent sample.

The !cpuc->lbr_users half of the condition does not look affected, since
any event whose sample references cpuc->lbr_stack is counted in lbr_users.

The series appears to fix this later in 61909a79de63 ("perf/x86/intel:
Use a dedicated LBR stack for BPF snapshotting"), where
intel_pmu_lbr_read() takes the stack to fill as a parameter.  Is it worth
avoiding the shared-stack write in this patch, so that the intermediate
commit does not have this window?

>  	/*
>  	 * Don't read when all LBRs users are using adaptive PEBS.
>  	 *

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
--===============2643490914929125600==--
