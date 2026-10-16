Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74E25B0BD;
	Fri, 16 Oct 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110081; cv=none; b=Eheu1l6mfHlLgtvg8UQpuG/BC/v6ieWgDJrUGMcqwMPYhDWXtb7148NPGCEzkaE82iRUzXnN6prf7B58aisRr9SttVDQrf+oE7M8AABEtTm4ruTnxLvq6cpKWC56y97Jdb6jae04ondhguxNORj4cPglu5yHoXo0Kmzyjg21c6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110081; c=relaxed/simple;
	bh=0N7/MGPm/18++p920/0/dH+k0mxW5aoBjt1LcCYGDhs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Nz8s7Z5Omejt9oQ31GqYoSxlkvSGfI2U85gKp7iVafAwn7L0bfixSzhdVIR68QJuwEtKNzy5HRf3Tss4xcs4obGZHUTUzet+U1AtThD7nZQuf4h/T3YfWJfVhAdZ1iRRKKgjpw0pHgiJJUI1TebM8JltMCWrKtLzlyxjVn5LdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJk+V2GR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJk+V2GR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E621F000C4;
	Fri, 16 Oct 2026 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110079;
	bh=XeyTc9n/9HfHLJ3yCVcyJ8dfyeOw0NBSEeSIkVV0MyM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JJk+V2GR2y9HWcercu95PciZJHqFaDUCh/wNqcROeKls+DBSpLV5gSiwMTZmPDyAC
	 uv+R1IHvxd7lQtv2/BPSAybUXr4XiBrEKgmGb8Jlu33wTUUFd2WcAXknG2g6dgZOx9
	 AftMVC0bwVp/p9Vx/iAcW0JS9VvR2AmJnH52wB3uVEdLltRFrabFVcBN0WthrvugJE
	 Uizqz11W+CiTTTkmhYoyvUUm2zdABjhE8EYUu567Fc6W3+QZjmxyibusAxQ2xYBXY7
	 foHIqPT8P0cosHZZuUz9YWC//8FC5uMqyOlaj42LMufigp80czSQV56329h2NhRtGN
	 mMuDRlH1AmUNg==
Content-Type: multipart/mixed; boundary="===============2096954798088473371=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ef8c1f496a9dca33792c7c3978e24208fe67d87688d5356b5e54e77eb009747@mail.kernel.org>
In-Reply-To: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
References: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
Subject: Re: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to valid entries
From: bot+bpf-ci@kernel.org
To: sandipan.das@amd.com,linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org
Cc: peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,dapeng1.mi@linux.intel.com,andrii@kernel.org,song@kernel.org,ravi.bangoria@amd.com,ananth.narayan@amd.com,sandipan.das@amd.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:21:17 +0000 (UTC)

--===============2096954798088473371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> perf/x86/intel/lbr: Limit branch snapshots to valid entries

TL;DR: Resetting cpuc->lbr_stack.nr in intel_pmu_lbr_read() may clobber an
in-flight adaptive PEBS sample if a BPF program calls
bpf_get_branch_snapshot(), possibly yielding a PERF_RECORD_SAMPLE without
branch records and with leftover bytes.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 22e2a06d5786..2fe858d99979 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>  	 * but this simple approach seems to work for now.
>  	 */
>  	if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
> +	    cpuc->lbr_users == cpuc->lbr_pebs_users) {
> +		cpuc->lbr_stack.nr = 0;
                 ^^^^
Can this clobber the branch stack of a PEBS sample that is still being
built?

Before this patch the early return had no side effects.  Now it writes to
cpuc->lbr_stack, which is shared with the adaptive PEBS path.

If every LBR user on the CPU is an adaptive PEBS event, then
cpuc->lbr_users == cpuc->lbr_pebs_users, and the PEBS drain points the
sample at the per-CPU stack:

setup_pebs_adaptive_sample_data()
    intel_pmu_store_pebs_lbrs(lbr);         /* cpuc->lbr_stack.nr = N */
    intel_pmu_lbr_save_brstack(data, cpuc, event);
        perf_sample_save_brstack(data, event, &cpuc->lbr_stack, ...);
            data->br_stack = brs;           /* points at cpuc->lbr_stack */
            data->dyn_size += ... + brs->nr * sizeof(struct perf_branch_entry);

__intel_pmu_pebs_last_event() then calls perf_event_overflow(), and
__perf_event_overflow() runs bpf_overflow_handler() before the sample is
written.  A perf event BPF program attached to that event can call
bpf_get_branch_snapshot(), which is in bpf_base_func_proto:

intel_pmu_snapshot_branch_stack()
    __intel_pmu_snapshot_branch_stack()
        intel_pmu_lbr_read()
            /* lbr_users == lbr_pebs_users, early return taken */
            cpuc->lbr_stack.nr = 0;

When the program returns, data->br_stack still points at cpuc->lbr_stack,
but nr is now 0.  A later bpf_read_branch_records() in the same program
reads ctx->data->br_stack->nr and returns 0 bytes.

perf_output_sample() then writes nr = 0 and no entries, while header.size was
already computed by perf_prepare_header() from data->dyn_size, which counted
N entries.  Doesn't that leave the PERF_RECORD_SAMPLE without its branch
records and followed by N * sizeof(struct perf_branch_entry) bytes of
leftover ring buffer content?

Before the patch, the early return left cpuc->lbr_stack untouched and this
sample came out intact.

Would it be better to leave cpuc->lbr_stack alone in the snapshot path, for
example by checking the skip condition in __intel_pmu_snapshot_branch_stack()
and returning 0 there, instead of resetting the shared nr inside
intel_pmu_lbr_read() for every caller?

>  		return;
> +	}
>
>  	x86_pmu.lbr_read(cpuc);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38827450009
--===============2096954798088473371==--
