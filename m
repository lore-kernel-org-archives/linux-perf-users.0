Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD360312815;
	Fri, 10 Apr 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801387; cv=none; b=ENmKMGJ61qIDzYeXSsljjZmNvJXHIQ7zMhxvVsn6DE6eU+oRw/D9TBR+Ypbf+iCDC1oBbYl818GughCyT8Rq9k2x8JWD4bxVPex0buAbKCMkTNQ94cS6/irfY13BVcHQQ4cMavcKIQ3hGqAw0UsRyN6fUBWpjwDrdejGhAO0TAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801387; c=relaxed/simple;
	bh=T5EvhFrIxER2QFYEsToO2rIyzFLR2rYS9S072vD0lHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TagLSHgeKdJNwAJfyURYKwIfkZFnW+EEj1cOM/F6yKUIuy4pyXvM+92ZxdcCq8hGgTHE/VxsGGh3BX8VmQySMQ6E0M/8l8/nzumpZEMasj8TJXpWIRgLcQjsLJb4LDctYUP6VZcJmXHBnKfFc4++bJGw8ncHjHLHycwfHKOhRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph2dbOqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph2dbOqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD9FC19421;
	Fri, 10 Apr 2026 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775801387;
	bh=T5EvhFrIxER2QFYEsToO2rIyzFLR2rYS9S072vD0lHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ph2dbOqU3FDowtMVikm8ZV+Ct7/KHyYCCQKCh6qWPuT9h8+7+eLW55WfbQDTdyWaw
	 7hDwJv220/NiR8RLgFJpBftAO7MJh6lYsSWxVEbXoITw1LeIqCHOh6ikw/uOCFB6HQ
	 V1DddC2fg0YMD/BcTEOk25oscV7YdXpKIYvNdda8zk9Z+bekJ9+HbBSMm8bU+OlPNj
	 lvhH9gVFpfF/WuV8yDl2W/IyAUUTDmKV9iq+R9VsASQysbdQtKtg2yaeVg9ELAFoEW
	 zleieLAEqBAvBgePupp7j0DZ/k6ZMtfkQ2kEGwJMjPBdWI5cw1RoTTdenWullfN8XG
	 w79ILjyrfKiNQ==
Date: Thu, 9 Apr 2026 23:09:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 08/16] perf annotate-arm64: Enable instruction
 tracking support
Message-ID: <adiUKB1CTkDAGrB_@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-9-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-9-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:52AM +0000, Tengda Wu wrote:
> Enable instruction tracking for the arm64 architecture in 'perf annotate'
> to support data type profiling.
> 
> Define ARM64_REG_SP as 31 to correctly identify the stack pointer
> register during type state initialization. Update
> arch_supports_insn_tracking() to include arm64, which allows
> find_data_type_block() to process the instruction scope for arm64.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/annotate-data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 1eff0a27237d..fd6416d43a2e 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -28,6 +28,7 @@
>  
>  /* register number of the stack pointer */
>  #define X86_REG_SP 7
> +#define ARM64_REG_SP 31
>  
>  static void delete_var_types(struct die_var_type *var_types);
>  
> @@ -177,7 +178,8 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
>  		state->regs[11].caller_saved = true;
>  		state->ret_reg = 0;
>  		state->stack_reg = X86_REG_SP;
> -	}
> +	} else if (arch__is_arm64(arch))
> +		state->stack_reg = ARM64_REG_SP;

Probably you want to setup caller-saved registers and the return
register as well.

Thanks,
Namhyung


>  }
>  
>  static void exit_type_state(struct type_state *state)
> @@ -1421,7 +1423,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
>  
>  static int arch_supports_insn_tracking(struct data_loc_info *dloc)
>  {
> -	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)))
> +	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)) ||
> +	    (arch__is_arm64(dloc->arch)))
>  		return 1;
>  	return 0;
>  }
> -- 
> 2.34.1
> 
