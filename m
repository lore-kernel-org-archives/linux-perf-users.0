Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599B33985;
	Wed, 19 Mar 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394398; cv=none; b=ujNdkuRTyQ+tarj7GZY6b4LHj1esgcSKHMdzyfKY9WpBJLBAPPfNU+nrtmFfd/rXdycDPQYR3q9r11R7Rsolc1U8GMBunCEQTDddkg3YWbnSelQ40sbJyBt3FDAxffiHEsH6Md0tWCcLEQqEP01gy2xflFc/39FPvUpWLRicp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394398; c=relaxed/simple;
	bh=6LaFCXWouUXetUyhtRcVc/74TIYXzXBLSNVMiDFBQcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l29t6KFVaXlY0G+4Px7Ck5GTjc4k3T3Fp2/FODG8hOUPqYLXDDjpwIL0cYBJ0YPuMhl1TIGPJY5EGj6BKYr85dNUzKA3IG9kXbsw61rZ7nqjiHWusmTViKssAbKyVx3eK8xbLqMi5mZSJRMYp6MTVwZdx40zs2mmdX6prXdIvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E07B0FEC;
	Wed, 19 Mar 2025 07:26:42 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0373F673;
	Wed, 19 Mar 2025 07:26:31 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:26:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64/gcs: task_gcs_el0_enable() should use passed
 task
Message-ID: <Z9rUEtZtNXhVnarO@J2N7QTR9R3>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-2-jeremy.linton@arm.com>

On Tue, Mar 18, 2025 at 03:48:35PM -0500, Jeremy Linton wrote:
> Mark Rutland noticed that the task parameter is ignored and
> 'current' is being used instead. Since this is usually
> what its passed, it hasn't yet been causing problems but likely
> will as the code gets more testing.

Are we sure nothing is relying upon the bug?

For example, in copy_thread_gcs():

copy_thread_gcs(p, ...) {
	...
	gcs = gcs_alloc_thread_stack(p, ...) {
		...
		if (!task_gcs_el0_enabled(p))
			return 0;
		...
		< actually allocate here >
	}
	...
	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
	...
}

Either that later assignment is redundant, or copy_thread_gcs() was
accidentally relying upon task_gcs_el0_enabled() reading from 'current'
rather than 'p', and this change opens up another bug...

Mark.

> 
> Fixes: fc84bc5378a8 ("arm64/gcs: Context switch GCS state for EL0")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/gcs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
> index f50660603ecf..5bc432234d3a 100644
> --- a/arch/arm64/include/asm/gcs.h
> +++ b/arch/arm64/include/asm/gcs.h
> @@ -58,7 +58,7 @@ static inline u64 gcsss2(void)
>  
>  static inline bool task_gcs_el0_enabled(struct task_struct *task)
>  {
> -	return current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
> +	return task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
>  }
>  
>  void gcs_set_el0_mode(struct task_struct *task);
> -- 
> 2.48.1
> 
