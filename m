Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7328C5DC;
	Wed, 23 Jul 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265393; cv=none; b=V1+8Dd4Y/Bm0t2V2BuB2b5xNybZt4+1eH8nCeBAomlhMFzKpv/SXZ6VtXtRd1ubu1xllvUM2aHnvV5KV8osQPYz3nIwZ0N71zxoSqSJG4SxXpbx8wxZ8p7DYcWMv2cbn/4Pc2+ZraZKohFBFOmRuLoxc7rnxUwiDYS4w4vrz0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265393; c=relaxed/simple;
	bh=DBJLrajVhFT/tWzROxvnSHc6ojd9hjEDROhPbVmn0fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix52nshxw5qYZu5ABMA0JEs5J9DcRLp2cPYVt+GHtJIqBkIdYrqlzBKTMGbJEz1bSCEMguju56AemAmQMRJxg3JCUtUgpXIMSOCSyJP/8aIStw4GdnunTcwzxolUftlOjkmWx+w5OWDOT8HPyu4MVWLtRIlJqzxJu8ox03njypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D78C4CEE7;
	Wed, 23 Jul 2025 10:09:48 +0000 (UTC)
Date: Wed, 23 Jul 2025 11:09:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: uprobes: Add GCS support to uretprobes
Message-ID: <aIC06oEF5FV99ukl@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-7-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-7-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:38PM -0500, Jeremy Linton wrote:
> @@ -159,11 +160,41 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  				  struct pt_regs *regs)
>  {
>  	unsigned long orig_ret_vaddr;
> +	unsigned long gcs_ret_vaddr;
> +	int err = 0;
> +	u64 gcspr;
>  
>  	orig_ret_vaddr = procedure_link_pointer(regs);
> +
> +	if (task_gcs_el0_enabled(current)) {
> +		gcspr = read_sysreg_s(SYS_GCSPR_EL0);
> +		gcs_ret_vaddr = load_user_gcs((unsigned long __user *)gcspr, &err);
> +		if (err) {
> +			force_sig(SIGSEGV);
> +			goto out;
> +		}

Nit: add an empty line here, I find it easier to read.

> +		/*
> +		 * If the LR and GCS entry don't match, then some kind of PAC/control
> +		 * flow happened. Likely because the user is attempting to retprobe

I don't full get the first sentence.

> +		 * on something that isn't a function boundary or inside a leaf
> +		 * function. Explicitly abort this retprobe because it will generate
> +		 * a GCS exception.
> +		 */
> +		if (gcs_ret_vaddr != orig_ret_vaddr)	{
> +			orig_ret_vaddr = -1;
> +			goto out;
> +		}

Nit: another empty line here.

> +		put_user_gcs(trampoline_vaddr, (unsigned long __user *) gcspr, &err);

Nit: (... *)gcspr (no space after cast).

> +		if (err) {
> +			force_sig(SIGSEGV);
> +			goto out;
> +		}
> +	}
> +
>  	/* Replace the return addr with trampoline addr */
>  	procedure_link_pointer_set(regs, trampoline_vaddr);
>  
> +out:
>  	return orig_ret_vaddr;
>  }

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
