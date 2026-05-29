Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332A2E8B67;
	Fri, 29 May 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066444; cv=none; b=bu6/KN1bRDuiVBoDMPPaWBfGXZFPZBib6oD6y+tBmaC08ipzqY/0SPW4X1nc6k9yDZOxSiuHrLQo9VQw/G8NDCuO29zFkyCwKhubUtC87A9mCh+ayj99Ogtyg+X3wCdWRBLELODkKu40972IqC/ltKDZyhxQIa7jiUo/zs5S46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066444; c=relaxed/simple;
	bh=gZdh1w8vRYOuFtaxDYEbXNNnQrE9nz4aFDDjcyod/yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZCOIrJVpeQr6sd1Nh548UbEWtf3a5ndOwGMJRYBSzJBaK1KeDXNmSK13/HADyukov68PH2hDuiOWnRdPVFD6cxQwG9SWvDxIJO88f7eK1jqqGgl+VXaqraKw2/L9j+p3OmvRdPZahrUmxJ0moslUJR7xZJ0mrOwRKRsomwUv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btigZHr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btigZHr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADDF1F00893;
	Fri, 29 May 2026 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066443;
	bh=aeelb+SxVvWZH/Lny1Z/xaobYN8qV++QCgA8BW3g8rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=btigZHr6ceEB8i2nQXFz9UnBi4GN5ysMJzsAvsBa/b8RDtQe4dDZu2SKAjg9tz1IH
	 kA3njYoCJ6YwvL/NHLD2Rq+cmPoL38pP7srU5dchpJcOQBejoaHYMP6pPwnQCUgmtY
	 nQR2ttvfFZjmqth/a+pjwrwQoerMiJJnVyLKBhvtveBX5TbCbhFLw6e0Fb/umydsoE
	 BkKS82gPL3L318UY6HxFF7SMew1C7iD8IwTCmyHldFJ/cDGbmqDgooA/IAJ8a5BPJ/
	 SvARwc84o/1tB2WocLKPsjXC2DmLpsUBCqrBNFPHWresKz67G1OQjotOBQoYiM795v
	 fdJpKGY4WiX9w==
Date: Fri, 29 May 2026 15:53:58 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pratyush Anand <panand@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	clm@meta.com, leo.bras@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] arm64/hw_breakpoint: reject unaligned watchpoints that
 would truncate BAS
Message-ID: <ahmohv6vQGxY-asL@willie-the-truck>
References: <20260430-arm64_bas-v1-1-c6ab2b15aec0@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-arm64_bas-v1-1-c6ab2b15aec0@debian.org>

Hi Breno,

Thanks for sending this out.

On Thu, Apr 30, 2026 at 02:40:10AM -0700, Breno Leitao wrote:
> hw_breakpoint_arch_parse() positions the BAS bit pattern in
> hw->ctrl.len with
> 
> 	offset = hw->address & alignment_mask;	/* 0..7 */
> 	hw->ctrl.len <<= offset;
> 
> ctrl.len is an 8-bit bitfield (struct arch_hw_breakpoint_ctrl::len is
> u32 :8), so the shift silently drops any bits past bit 7.  For
> non-compat AArch64 watchpoints the offset is unbounded relative to
> ctrl.len: a perf_event_open(PERF_TYPE_BREAKPOINT) caller asking for
> HW_BREAKPOINT_W with bp_addr=page+1 and bp_len=HW_BREAKPOINT_LEN_8
> ends up with 0xff << 1 = 0x1fe, stored as 0xfe.  The kernel programs
> WCR.BAS=0xfe and the hardware watches bytes [1..7] instead of the
> requested [1..8] -- the eighth byte is silently dropped.  The
> syscall still returns success, leaving userspace to discover the
> gap by empirical probing.
> 
> The same class affects HW_BREAKPOINT_LEN_{2,4} when offset pushes the
> high BAS bit past bit 7 (e.g. LEN_4 with offset=5 yields 0xe0
> instead of 0x1e0).  No memory-safety impact -- the value is masked
> into 8 bits before encoding -- but debuggers and perf users observe
> missed events on bytes they thought they were watching.
> 
> The AArch32 branch immediately above already rejects unrepresentable
> (offset, len) combinations via an explicit switch.  Mirror that for
> the non-compat branch by checking that the shifted pattern fits in
> the BAS field, returning -EINVAL when it does not.
> 
> Reproducer:
> 
>   struct perf_event_attr a = {
>       .type = PERF_TYPE_BREAKPOINT, .size = sizeof(a),
>       .bp_type = HW_BREAKPOINT_W,
>       .bp_addr = (uintptr_t)(buf + 1),
>       .bp_len = HW_BREAKPOINT_LEN_8,
>       .exclude_kernel = 1, .exclude_hv = 1,
>   };
>   int fd = perf_event_open(&a, 0, -1, -1, 0);
>   /* before this fix: succeeds, watches 7 bytes (buf+1..buf+7)   */
>   /* after  this fix: fails with EINVAL                          */
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: b08fb180bb88 ("arm64: Allow hw watchpoint at varied offset from base address")

Oh man, this has been broken for nearly a decade :/

I think we probably should've stuck with the old behaviour of rejecting
unaligned base addresses, but it's too late now. Damn.

>  arch/arm64/kernel/hw_breakpoint.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index ab76b36dce820..b8a1402119f3a 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -559,6 +559,15 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  		else
>  			alignment_mask = 0x7;
>  		offset = hw->address & alignment_mask;
> +
> +		/*
> +		 * BAS is an 8-bit field in WCR/BCR; the shift below would
> +		 * silently drop the high bits of ctrl.len when offset + len
> +		 * exceeds 8, programming hardware to watch fewer bytes than
> +		 * the user requested.
> +		 */
> +		if (((u32)hw->ctrl.len << offset) > 0xff)

nit: Use ARM_BREAKPOINT_LEN_8 instead of 0xff

> +			return -EINVAL;
>  	}

I must confess, I'm very nervous about breaking userspace here. If GDB
is triggering this path, then this patch will change an unreliable
watchpoint into a hard error (which probably means GDB exits). Have you
looked to see what GDB and/or any other debuggers do?

I had a quick peek and found the bugzilla entry which motivated the
buggy change in the first place:

https://sourceware.org/bugzilla/show_bug.cgi?id=20207

and it looks like the aarch64_align_watchpoint() function does try to
spill into multiple watchpoints, so perhaps your patch is ok. I'd
appreciate your opinion, though.

Will
