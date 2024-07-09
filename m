Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E512CDB6;
	Tue,  9 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519522; cv=none; b=j8rxPEeEuYC6Fwjde1mGqJB3mIZxUa5NAsnmvKpZzGnb0ZsicpMgqnIGHjiCnxAd203ge7mbBQMCGKjjc5mVWpdpgL+Nk0dnHTlu7zAKpj8d6Y+1Z19880QNl0CFMSrX6nb/e249A4jOx2CeIg/7KQjWN6Bgb5V8n5Ys4O4+sTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519522; c=relaxed/simple;
	bh=adwdFXqIUIzPu8uQo4yWNR59n+TVdE5/QzTHYlgT4Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deLKiopoQFLaVqTmFIzFofGYIqV97NE8ys/BKMJCE2mPDQg3VxYN84EieboHE0PZwYRWOfwSzfBAitlHQbwMaD8FFGNaA/jV+H4SwSRehFj8fEa/Uct6rSGzYXFCWxhJqRX0jP5EkIl0+Racb3fUyjcZgUlDqt8Pl0zvv8EF2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axsmg7yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axsmg7yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60963C3277B;
	Tue,  9 Jul 2024 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720519521;
	bh=adwdFXqIUIzPu8uQo4yWNR59n+TVdE5/QzTHYlgT4Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axsmg7yf+1yjLnsJh8Jj6P1cLgosBDQI5K0LjNBSjXcZXDhgpoaBRBAFzByzXJjgU
	 wPV75u4MMWyGxzd9MIHgjZQJcttfLicyP8qNwh8FTMFPhOJYpuRXwJh4Af0n4j71kX
	 FhxBzEFxZYP2fWAJwkMEcOulo4aONV6c2O3nFzZgJoiQ9VnHxdKg5OW+tq9AH2JHOW
	 jiY3f3jf3D0rYlsK+hvL/L4+dkOrS5EwsbxZAP9oDyC0J5bAZtltH7BafOEPV2CC8g
	 uga47XTb1fB+U+N6IzpG6nR8VMDBIFWECs+URBBkurw/c6vLLpN47GOP/huLpRlBbP
	 OPwoMK4ZqvyVw==
Date: Tue, 9 Jul 2024 11:05:16 +0100
From: Will Deacon <will@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: hw_breakpoint: Save privilege of access
 control via ptrace
Message-ID: <20240709100515.GB12978@willie-the-truck>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
 <20240709095506.9691-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709095506.9691-4-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 09, 2024 at 05:55:06PM +0800, Tiezhu Yang wrote:
> In the current code, decode_ctrl_reg() saves the privilege of access
> control passed by the ptrace user data, but it is not used anymore,
> arch_build_bp_info() checks whether bp virtual address is in kernel
> space to construct hw->ctrl.privilege, it seems not reasonable.
> 
> The value of ctrl->privilege saved in decode_ctrl_reg() can be used
> in arch_build_bp_info(), there is no need to check bp virtual address
> to assign value for hw->ctrl.privilege, just make use of "bp_priv" in
> the struct perf_event_attr to save the privilege of access control via
> ptrace for hardware breakpoint.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
>  arch/arm64/kernel/ptrace.c        |  2 ++
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 722ac45f9f7b..06e34bcdcf92 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -486,15 +486,8 @@ static int arch_build_bp_info(struct perf_event *bp,
>  	/* Address */
>  	hw->address = attr->bp_addr;
>  
> -	/*
> -	 * Privilege
> -	 * Note that we disallow combined EL0/EL1 breakpoints because
> -	 * that would complicate the stepping code.
> -	 */

Just because you remove the comment doesn't mean that constraint no
longer applies.

> -	if (arch_check_bp_in_kernelspace(hw))
> -		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
> -	else
> -		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
> +	/* Privilege */
> +	hw->ctrl.privilege = attr->bp_priv;
>  
>  	/* Enabled? */
>  	hw->ctrl.enabled = !attr->disabled;
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 0d022599eb61..3b37c4a2e0d4 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -309,6 +309,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
>  	attr.bp_addr	= 0;
>  	attr.bp_len	= HW_BREAKPOINT_LEN_4;
>  	attr.bp_type	= type;
> +	attr.bp_priv	= AARCH64_BREAKPOINT_EL0;
>  	attr.disabled	= 1;
>  
>  	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
> @@ -352,6 +353,7 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>  	attr->bp_len	= len;
>  	attr->bp_type	= type;
>  	attr->bp_addr	+= offset;
> +	attr->bp_priv	= ctrl.privilege;

Wait, so ptrace can now set breakpoints with arbitrary privileges?

Will
