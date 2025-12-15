Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978531576C;
	Mon, 15 Dec 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810755; cv=none; b=bOBh80nJE3wVudVONmw6nmE7LnjtfUO0achBSfqpa6mlLuP3Tj30cLvy6oaSylRKNJOIF/aIGUrk0m+Ofk1NHlcHAW2h+McLLAIjwCjRFuiA43eGTxCJKSJWGZ4H3x4VkaU/NXIZ0WgyfXUXtpX1Kh9DuocIQ5VpmjwFxxpoGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810755; c=relaxed/simple;
	bh=5Uj3g6oOcW7p1t8bUjqJr8Ix32MQCWcpCoGJTzhY6XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7vVtAlpnt9K9O23neXPHV+WXs4ge56WDBATgMknvpaAPzaoaWTAqYNLbD1NeN4BymBnF68IssUk4N7G0ry9wBIJFyK4daYoUH3P54VKPrNK2aKY0o4ZXzq07zKDoUsTJPeKmJ/g6w7BzTZqi84MZre9COfb2aSIjg6UD+tUvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230CC497;
	Mon, 15 Dec 2025 06:59:04 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC3C3F73B;
	Mon, 15 Dec 2025 06:59:10 -0800 (PST)
Date: Mon, 15 Dec 2025 14:59:09 +0000
From: Leo Yan <leo.yan@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: hw_breakpoint: warn on invalid breakpoint
 length
Message-ID: <20251215145909.GC681384@e132581.arm.com>
References: <20251213112336.26503-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213112336.26503-1-osama.abdelkader@gmail.com>

Hi,

On Sat, Dec 13, 2025 at 12:23:35PM +0100, Osama Abdelkader wrote:
> Some tools (e.g. perf) incorrectly assume that breakpoints should be
> sizeof(long), but this is wrong for AArch64 where breakpoints must be
> 4 bytes. Add a warning when we silently fix up the parameter so tool
> developers can get notified.

To be clear, the perf tool has fixed the issue since:

  fa6cc3f93258 ("perf parse-events: Vary default_breakpoint_len on i386 and arm64")

The latest perf can pass the correct length (4) for instruction
breakpoint.

> This addresses the FIXME comment by adding diagnostic output rather
> than breaking existing tools by returning -EINVAL.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2: fix warning messageline splitting
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index ab76b36dce82..cce306145d78 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -475,11 +475,13 @@ static int arch_build_bp_info(struct perf_event *bp,
>  				return -EINVAL;
>  		} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
>  			/*
> -			 * FIXME: Some tools (I'm looking at you perf) assume
> -			 *	  that breakpoints should be sizeof(long). This
> -			 *	  is nonsense. For now, we fix up the parameter
> -			 *	  but we should probably return -EINVAL instead.

This FIXME is still valid for me.  IMO, if really want to remove the
comment, a reasonable solution is:

  1) Backport two patches (fa6cc3f93258 and 70b27c756f9) onto the
     stable kernel code base for fixing perf tool.

  2) Based on perf tool has fixed the issue on the mainline kernel and
     stable kernels, we can change to return -EINVAL instead.

> +			 * Some tools (e.g. perf) incorrectly assume that
> +			 * breakpoints should be sizeof(long). This is wrong
> +			 * for AArch64 where breakpoints must be 4 bytes.
> +			 * Warn the user and fix up the parameter.
>  			 */
> +			pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d, fixing to 4 bytes\n",
> +				     hw->ctrl.len);

AFAIK, since I started to use Armv5 CPUs, Arm instructions (not Thumb
ones) are always 4-byte length. Not sure if the log is useful or not,
I would leave this to maintainers.

Thanks,
Leo

>  			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
>  		}
>  	}
> -- 
> 2.43.0
> 
> 
