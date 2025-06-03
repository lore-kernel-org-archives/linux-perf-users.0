Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682002AE8D;
	Tue,  3 Jun 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959248; cv=none; b=rxSJBnEKulggEVPUcvCkR7OJ5lPkectxabqYv2yASVr5iYzT9q2rZ5Skb0DMyOGGMvoU7T0Ryccbgw2gNTG3jdqWR5d67bUQZU+8xN/8ytUcV+O+ezvVaz+vIQ54/Gr/8BXL6YgeIx/qfkKzmZgMab726yuy0ThwhTc9CioCrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959248; c=relaxed/simple;
	bh=LfQhyG+gAeQ7nIAhOL9ZjWWzy98MrKRoup70yuP6NiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqvVWvM9twwjcMGUqenUoEDsQlKNZK1Sv+dr/6u3+hIrNFsoecQSPEqKKlbFJIol9pdDTOIARBCddT2VQ0f7lUPpbwHReJA4bu0YDFn5jzd5MBW2nV1U+1yCGVs/h9YECOX9gel2xYKGbdRbSIBvaOqZMInabgoCWVZF18io2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D88012FC;
	Tue,  3 Jun 2025 07:00:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7D73F5A1;
	Tue,  3 Jun 2025 07:00:44 -0700 (PDT)
Date: Tue, 3 Jun 2025 15:00:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250603140040.GB8020@e132581.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602184049.4010919-1-yeoreum.yun@arm.com>

Hi Levi,

On Mon, Jun 02, 2025 at 07:40:49PM +0100, Yeoreum Yun wrote:
> commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> changes the event->state update before list_del_event().
> This change prevents calling perf_cgroup_event_disable() as a result,
> cpuctx->cgrp can't be cleared properly and point to dangling point of cgroup.
> 
> Because of this problem, some machin meets the below panic[0]:
> 
> 863.881960] sysved_call_function_sing le+0x4c/0xc0
> 863.881301] asm_sysvec_call_function_single+0x16/0x20
> 869.881344] RIP: 0633:0x7f9alcea3367
> 663.681373] Code: 00 66 99 b8 ff ff ff ff c3 66 ....
> 863.881524] RSP: 002b:00007fffa526fcf8 EFLAGS: 00000246
> 869.881567] RAX: 0000562060c962d0 RBX: 0000000000000002 RCX: 00007f9a1cff1c60
> 863.881625] RDX: 00007f9a0c000030 RSI: 00007f9alcff1c60 RDI: 00007f9a1ca91c20
> 863.081682] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007f9a1d6217a0
> 869.881740] R10: 00007f9alca91c10 R11: 0000000000000246 R12: 00007f9a1d70c020
> 869.881798] R13: 00007fffa5270030 R14: 00007fffa526fd00 R15: 0000000000000000
> 863.881860] </TASK>
> 863.881876) Modules linked in: snd_seq_dummy (E) snd_hrtimer (E)...
> ...
> 863.887142] button (E)
> 863.912127] CR2: ffffe4afcc079650
> 863.914593] --- [ end trace 0000000000000000 1--
> 864.042750] RIP: 0010:ctx_sched_out+0x1ce/0x210
> 864.045214] Code: 89 c6 4c 8b b9 de 00 00 00 48 ...
> 864.050343] RSP: 0000:ffffaa4ec0f3fe60 EFLAGS: 00010086
> 864.052929] RAX: 0000000000000002 RBX: ffff8e8eeed2a580 RCX: ffff8e8bded9bf00
> 864.055518] RDX: 000000c92340b051 RSI: 000000c92340b051 RDI: ffff
> 864.058093] RBP: 0000000000000000 R08: 0000000000000002 R09: 00
> 864.060654] R10: 0000000000000000 R11: 0000000000000000 R12: 000
> 864.063183] R13: ffff8e8eeed2a580 R14: 0000000000000007 R15: ffffe4afcc079650
> 864.065729] FS: 00007f9a1ca91940 (0000) GS:ffff8e8f6b1c3000(0000) knIGS:0000000000000000
> 864.068312] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
> 864.070898] CR2: ffffe4afcc079650 CR3: 00000001136d8000 CR4: 0000000000350ef0
> 864.673523] Kernel panic - not syncing: Fatal exception in interrupt
> 864.076410] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xff
> 864.205401] --- [ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> To address this call the perf_cgroup_event_disable() properly before
> list_del_event() in __perf_remove_from_context().
> 
> Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/ [0]
> Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Tested-by: David Wang <00107082@163.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..909b9d5a65c1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2498,6 +2498,10 @@ __perf_remove_from_context(struct perf_event *event,
>  		state = PERF_EVENT_STATE_DEAD;
>  	}
>  	event_sched_out(event, ctx);
> +
> +	if (event->state > PERF_EVENT_STATE_OFF)
> +		perf_cgroup_event_disable(event, ctx);
> +

As we discussed, seems to me, the issue is caused by an ambigous state
machine transition:

When a PMU event state is PERF_EVENT_STATE_EXIT, the current code does
not transite the state to PERF_EVENT_STATE_OFF. As a result, the
list_del_event() function skips to clean up cgroup pointer for non OFF
states. This is different from the code prior to the commit a3c3c6667,
which transits states EXIT -> INACTIVE -> OFF.

My suggestion is not reliable. Roughly read code, except for the
PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
up the cgroup pointer.  The reason is I don't see other places to
clean up the cgroup pointer for these error cases:

  PERF_EVENT_STATE_REVOKED
  PERF_EVENT_STATE_DEAD

Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
cgroup as this has already been handled in merge_sched_in().

So a correct condition would be:

    if (event->state > PERF_EVENT_STATE_OFF ||
        event->state <= PERF_EVENT_STATE_EXIT)
        perf_cgroup_event_disable(event, ctx);

And we need to remove the perf_cgroup_event_disable() from
list_del_event() to avoid duplicate code.

Perhaps a better approach for code consolidation would be to modify
the conditions in list_del_event() to ensure the cgroup pointer is
cleaned up in error cases. However, I'm not confident that this is the
correct direction, so I would wait for suggestions from the maintainers.

Thanks,
Leo
