Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F12285066;
	Tue,  5 May 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020511; cv=none; b=ZvEg0SheEQkN/So8iFYl3d5YpB46mQ17u5+RTvpKzzgNe1f3/a6R9zti6DVXg7l3hs4Cs2vCIOh7u6vg1VaLoVdUiNyAIRz0pRKSN6E6SW+wyolSnh403gNfv6BLxI/QymLjFqOothMauNGuXs6+beVxNfGS4eMV+SdjcQj+nC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020511; c=relaxed/simple;
	bh=w6OTTCfPyCZr+g37wh6OMJntQU+LnbrUZIbyk9kla1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHz2lUzaAMI5Dz02pW7AR8Cyh1FytMtAMqTVeXvId+V3OxO9npYwf+5/OYlV1bo81rQhbxRZ5YlNBW8IZWYoM1qgVgqA+nzShVpNWHAO2VPbnkR4f+hqFqG/UpRITST0qWQWOfQqKCG0iSvbfxJgRL9LKBtKLFwklZjzMEFlr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph0uz4Cp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph0uz4Cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA204C2BCB4;
	Tue,  5 May 2026 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778020510;
	bh=w6OTTCfPyCZr+g37wh6OMJntQU+LnbrUZIbyk9kla1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph0uz4CpWQ720yfvpqVRFD28JgjmpTRa1zS9AmMs+6WlcrFPfO4hs0p2MkGu89vW4
	 qdZPmCapJPO3RXfNoDV8U6GnEhQr0bqzYoj05ZkDu+lFpojXORUmCdHxNEpeltV/DD
	 n0/g83ToyZcKTNnbmQbgEDlWEVn70gsrSC7sJF7/BH/UVgSrvIC01iob1+3g754Bvw
	 rNr/VJfMg4K/s5iXxrFf1a4N1CufjQYujbTNdOEPOM2gHn/6BqEzPX5zZ9IMNHOMYJ
	 CkVMaF04SI2YRpSWqs/6BloC/ItubHEUNLgxWqq+a4JSWeRsyGZhrfZ7IE0qUSx7jh
	 oMGfNr+9QSv9w==
Date: Tue, 5 May 2026 15:35:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RESEND] perf/lock: Fix non-atomic max/time and min_time
 updates in contention_data
Message-ID: <afpwnf5VfjxBgIhS@google.com>
References: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
 <20260504172338.6FA50C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504172338.6FA50C2BCB8@smtp.kernel.org>

Hello,

On Mon, May 04, 2026 at 05:23:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The use of `__sync_val_compare_and_swap` introduces a compiler dependency on BPF ISA v3, breaking the `perf` tool build on older toolchains.
> --
> 
> commit 30820839a2cfcfa987fbc2e0f79fa0e2f2cf0dc3
> Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> perf/lock: Fix non-atomic max/time and min_time updates in contention_data
> 
> This commit replaces bare conditional assignments with a bpf_loop()-based CAS
> retry loop to fix non-atomic updates of max_time and min_time.
> 
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 96e7d853b9edf..5c8431be674ac 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> [ ... ]
> > @@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
> >  	return -1;
> >  }
> >  
> > +static long cas_min_max_cb(u64 idx, void *arg)
> > +{
> > +	struct cas_ctx *ctx = arg;
> > +
> > +	if (!ctx->max_done) {
> > +		u64 old_max = ctx->data->max_time;
> > +		if (old_max >= ctx->duration) {
> > +			ctx->max_done = 1;
> > +		} else {
> > +			u64 r = __sync_val_compare_and_swap(
> > +				&ctx->data->max_time, old_max, ctx->duration);
> 
> Does this cause build failures on older toolchains?
> 
> The built-in __sync_val_compare_and_swap lowers to the BPF_CMPXCHG
> instruction, which requires BPF CPU v3 (-mcpu=v3).

Hmm.. this looks like a real concern.  We could add -mcpu=v3 to the
compiler option, but then there would be compatibility issues with old
kernels.  It seems it's added in v5.1 kernel and the oldest longterm
support kernel version is 5.10.  So I think it's fine to add it.

Could you please update the build flag as well?  It can be a separate
commit.

Thanks,
Namhyung

> 
> The perf build system compiles BPF skeletons using the host compiler's default
> target features, without explicitly passing an -mcpu flag. On toolchains
> where the default BPF target is v1 or v2 (such as Clang < 18), the compiler
> may fail to generate the instruction and throw a fatal error (e.g.,
> 'hardware compare and swap not supported' or an unresolved libcall to
> __sync_val_compare_and_swap_8).
> 
> > +			if (r == old_max)
> > +				ctx->max_done = 1;
> > +		}
> > +	}
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260504135138.17050-1-suchitkarunakaran@gmail.com?part=1
