Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975051;
	b=wpwcVcIxRLu10r2/KDyNwLD0vBlNZJOBcMPgaZe5rcVHmzUmmvRmQDux6gDfTlzcIAzo
	 we7uccq0I/nPbhtcNqm2JOGiOn4jlhCc8An8m93OCGIW83uL8DbUe7iUJI01Y22DDlEWk
	 M3+AhoROIdbkT0z/aWs1via66uv3qHdi5e2zQgJQ73GUO3WgQFmSMkXlDu9EpEiRhGH39
	 Pp66mYcII3M1JVnKZ3vd64BcRFnzDToUQxlXj0SkvgidA5/cgzeUVJwwc4GB4VvoXFqu8
	 ZkwLc9fkRaL41AfSQ+kHEQ/fxsxpe/DbZNNlzhwyueOw6B+ArowAnU5+SuhZU+43Rpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975051;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JEujfxvJkgMbrRXFMud0HGv3eQRXzVxOwVMHMTGIZX0=;
	b=zUzy/vzAlzWVBq/ePP7oJ8k+HYk3nBH7vhFlk0GrpUbBFtpyp6ytXBeYHklKclbDJEKB
	 X6mSle55VXUK9CvLNoLaPYkq0JFlAXvJapzk8jfbClWfXRFt8Kb2RtVmOk0i9z5us6++E
	 ZZEM4nIpI/azX34eMbcHzHj7rnbe4St8uxBkIxNMMeDB147Ra26bYMzPIeDO6LF7FZL8S
	 Zg38j+DHaH46GwPLvGp0DpNpU5bWik3n2I4b1abOIN2V73nsHwh21CBsQA5KvbNQSYZPw
	 SXSPSs6qHHBEog25lmpH6II2tjkGTXnsaJvX6bZ0ybKJ60uPWJdHubfAJJkpsCf6UPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTrtQVQ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61547606A31C;
	Wed, 18 Nov 2026 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTrtQVQ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331CA1F000C4;
	Wed, 18 Nov 2026 04:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794975051;
	bh=JEujfxvJkgMbrRXFMud0HGv3eQRXzVxOwVMHMTGIZX0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gTrtQVQ5UJooWD04BnK57gFtLF5GpQ0Icn2pKvhBJSvQ8iZ2EYwdj89UlBq8my56b
	 ap7eIpafElKgt7ILgKxi9Pc8K40o9b1RQf3EWE7X1FptkellRy735AI0Tyj+yZ2Bio
	 VS07aaeuFDepsapW7q360+yVqJDB+cGVRw2bOTfjtjVF1rnwyBXcBrSDtgD6gG2Izi
	 nkDVwpK/ISjRdPTFZF31v39+Q9bcYfDArfLeBo4iqEW9kMkFfJ1n9DJY47btBFkYei
	 6QkhAnfhqac5+iwoc63rV647O6ZHPeCBFZ7YUFfKe68fcSW6t5B3uqf4DUtprbKwYK
	 MurKWaN/LewqQ==
Content-Type: multipart/mixed; boundary="===============4807986407573611338=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <913204cab6fa4a1068980a05e1f85a400d7cadc0d2f60a818cd61f227cdb2e15@mail.kernel.org>
In-Reply-To: <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v7 14/24] perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
From: bot+bpf-ci@kernel.org
To: dapeng1.mi@linux.intel.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,irogers@google.com,adrian.hunter@intel.com,alexander.shishkin@linux.intel.com,ak@linux.intel.com,eranian@google.com,sandipan.das@amd.com,andrii@kernel.org,song@kernel.org,ravi.bangoria@amd.com,ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,dapeng1.mi@intel.com,zide.chen@intel.com,thomas.falcon@intel.com,xudong.hao@intel.com,dapeng1.mi@linux.intel.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 04:10:48 +0000 (UTC)

--===============4807986407573611338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> perf/x86/intel: Account lbr_pebs_users for arch-PEBS events

TL;DR:
- On arch-PEBS, a non-PEBS branch-counter sibling event may report a stale
  branch stack with zero counters until a later patch fixes it; consider
  reordering
- Fixes tag may point to the wrong commit

>     perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
>
>     lbr_pebs_users tracks how many PEBS events are currently using LBR.
>     It is updated for legacy PEBS events, but arch-PEBS events were missing
>     from that accounting.
>
>     Add the missing lbr_pebs_users accounting for arch-PEBS as well.
>
>     Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
>     [ ... ]
>     Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

d243d0bb64af only parses the arch-PEBS CPUID leaves and adds the
enable/disable callbacks, it does not make arch-PEBS use LBR.  The
ARCH_PEBS_LBR handling and PERF_SAMPLE_BRANCH_STACK in large_pebs_flags
came with 52448a0a7390, which predates this series.

Should the tag point there instead:

  Fixes: 52448a0a7390 ("perf/x86/intel: Setup PEBS data configuration and enable legacy groups")

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -616,7 +616,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
>  	 * be 'new'. Conversely, a new event can get installed through the
>  	 * context switch path for the first time.
>  	 */
> -	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
> +	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
>  		cpuc->lbr_pebs_users++;
>  	perf_sched_cb_inc(event->pmu);
>  	if (!cpuc->lbr_users++ && !event->total_time_running)

Can this make a non-PEBS branch counter event report a stale branch stack
on arch-PEBS platforms?

With lbr_pebs_users now non-zero on arch-PEBS, the existing shortcut in
intel_pmu_handle_irq() is taken:

    if (cpuc->lbr_users != cpuc->lbr_pebs_users)
        intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);

That shortcut assumes every consumer of the LBR stack is counted in
lbr_users.  An event whose branch_sample_type is only
PERF_SAMPLE_BRANCH_COUNTERS plus PLM bits has
PERF_X86_EVENT_NEEDS_BRANCH_STACK cleared in intel_pmu_hw_config(), so
intel_pmu_add_event() never calls intel_pmu_lbr_add() for it and it is not
counted in lbr_users.  It still has has_branch_stack() set and samples
through the non-PEBS path in handle_pmi_common():

    if (has_branch_stack(event))
        intel_pmu_lbr_save_brstack(&data, cpuc, event);

Consider a group on an arch-PEBS CPU with ARCH_PEBS_LBR and PMU_FL_BR_CNTR,
with a precise leader using branch_type=any,counter and a non-precise
sampling sibling using only branch_type=counter.  After this patch
lbr_users == 1 and lbr_pebs_users == 1.  If only the sibling overflows,
intel_pmu_lbr_read() is skipped, and intel_pmu_lbr_save_brstack() ->
intel_pmu_lbr_counters_reorder() works on whatever cpu_lbr_stack(cpuc)
last held.  That is either nr == 0 after intel_pmu_lbr_reset(), or the
leader's last PEBS-record snapshot from intel_pmu_store_pebs_lbrs(),
whose raw counters in entries[i].reserved were already zeroed when the
leader's sample was saved.

So the sibling would report a stale branch stack with all branch counters
zero, where before this patch it got the live LBR state.  The same
problem already exists for legacy adaptive PEBS (pebs_baseline), and this
patch extends it to arch-PEBS.

This looks to be addressed later in the series by 0479605ddd39
("perf/x86/intel: Account LBR user counts for pure branch counter
events"), and 9edb70d448eb ("perf/x86/intel: Refresh LBR stack for
non-PEBS LBR events when needed") replaces the lbr_users != lbr_pebs_users
check at PMI entry with an on-demand re-read.  Would it make sense to
order 0479605ddd39 before this patch so the intermediate state does not
regress?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
--===============4807986407573611338==--
