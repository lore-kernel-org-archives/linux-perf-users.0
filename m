Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974093;
	b=D9aJ52EidY88V+omqPJY5cY3bpiPPGKAz1lYbecYAF+T5tF4HpT17XDsZZ8q0KisoXuh
	 JFC6kmxC2CI6N1SJn1oLnVrrO5eFtthmK/DjQ/FmT/XlRjtTkuKankeXO0h9ESss6guIg
	 06fXNgabDrmJse381DsUx/HukHYQlUhoeswKuI9ukhmkyiUCnWte/0jclObMDBshvA8Vs
	 DN7qtD0ehL4GG05SsQXAu6A0RvCd/YNtWTEO97E5UkAlTGby/Dz/3YtxkyNhiILfMxbfc
	 66fFaiGzOhHnEbfxYoDuiFcVW1QpGyg5Y51S/yXRTUkt+vCI/MNd9BG51n4L0hSbBkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974093;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6jXubmMW0WkKzVYsXG4XqabHpQVtQaMKrPNvSAB5T/o=;
	b=t3O1IxAVWeFDrkWLSqw2gqTeDlNqNsKGu74FtlUS6IBNK/FRfFRLSwKeEWPR6nx7ooqn
	 wpllN+kK3p3a+Ef7TCPvQzt9b1rrwp6nq4w45k+i9POmJTQy1WGx/+m94NTRF/uIkrrji
	 LLOZgCVRuWN5DnSv1MgbOpM2koDdoxjtXenTwEyysFiIdjs0fVwaTYNFYRqHJXbKOTKJD
	 KL7JIki6JWuL3y197I4QnGSU0cQMbUzhhk4+x4w8FPLOP5hbbpwHjgA2q+qO/0i2ySJYy
	 D8hB+qKF+Jpw8pm8YdNcprOUxRzuJcYV7q9Ey9Y53SUmHhR5fhhWTZQEvZOJzt8DpaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZINlYvaF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E4606A31C;
	Wed, 18 Nov 2026 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZINlYvaF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2031F000C4;
	Wed, 18 Nov 2026 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794974093;
	bh=6jXubmMW0WkKzVYsXG4XqabHpQVtQaMKrPNvSAB5T/o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZINlYvaF/2fXhkBXKpLC0M2cUT5FwI58umaaxuBvCKslVKKlIXczmHzjTvA52PtB2
	 TCgnFFA1lI98WWGC9gbf4tUKFMGkbIIyJj3Pdr3Xrfp3OeZnB0NgyOPXjTVk+/GMzh
	 vPUeC6s+7R5sPIEjOVWBHWYa6PoAw7mBQbyamHpNRsM3ORER51qfsT5/cSFNZgW9Q6
	 IYYXQ9viITLQeTsKh42uFqV5MJkaTIJ0cYMSj4eCErTUvbd9xME9/maL8NoXfZay42
	 Qw+eVPvnUuHfxFFTs1u+l0y2UIsYiBLRk8ji5EtmjMqXPaCsfXqekMlYnTyti46+3Z
	 tx8dvcR6mRw3g==
Content-Type: multipart/mixed; boundary="===============7242486858759126236=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cc3a05a38e308aa20c6b9886b4cd3e5f403287627b44f30ce07cb7607329ea13@mail.kernel.org>
In-Reply-To: <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v7 20/24] perf/x86/intel: Clear raw LBR counters in the LBR stack
From: bot+bpf-ci@kernel.org
To: dapeng1.mi@linux.intel.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,irogers@google.com,adrian.hunter@intel.com,alexander.shishkin@linux.intel.com,ak@linux.intel.com,eranian@google.com,sandipan.das@amd.com,andrii@kernel.org,song@kernel.org,ravi.bangoria@amd.com,ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,dapeng1.mi@intel.com,zide.chen@intel.com,thomas.falcon@intel.com,xudong.hao@intel.com,dapeng1.mi@linux.intel.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 03:54:50 +0000 (UTC)

--===============7242486858759126236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> perf/x86/intel: Clear raw LBR counters in the LBR stack

TL;DR: Clearing raw LBR counters in the shared stack may zero them before a
later branch-counter event in the same PMI reads them, giving all-zero counter
samples until a later commit fixes it.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -1001,6 +1013,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
>  		return;
>  	}
>
> +	intel_pmu_lbr_clear_raw_counters(cpu_lbr_stack(cpuc));
>  	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
>  }

Can this clear the counters before a later event in the same PMI has
consumed them?

handle_pmi_common() reads the LBR stack only once per PMI and reuses it for
every overflowing branch event:

    if (has_branch_stack(event)) {
        if (!cpuc->lbr_stack_live) {
            intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
            cpuc->lbr_stack_live = true;
        }
        intel_pmu_lbr_save_brstack(&data, cpuc, event);
    }

Suppose event A is an ordinary LBR event on counter 0 and event B is the
sampling event of a branch counters group on counter 1, and both overflow in
the same PMI.  A is handled first, and intel_pmu_lbr_save_brstack() calls
intel_pmu_lbr_clear_raw_counters(), which zeroes entries[i].reserved in the
shared cpu_lbr_stack().

When B is handled, lbr_stack_live is still true so the stack is not re-read,
and intel_pmu_lbr_counters_reorder() reads reserved == 0 for every entry.
B's sample then reports all-zero branch counters.

Before this patch the non-counters path left reserved alone, so B got the
correct counters in this ordering.

The later commit 57fc5222dbd3 ("perf/x86/intel: Refresh LBR stack for LBR
counter events in PMI handler") addresses this case by re-reading the LBR
stack before a branch counters group event once an earlier LBR event has
cleared it.  Until that commit, a bisect landing on this patch would see
wrong branch counter samples in this scenario.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
--===============7242486858759126236==--
