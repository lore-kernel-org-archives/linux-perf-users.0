Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE172DE71C;
	Mon,  8 Sep 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338905; cv=none; b=kOG/aD1lYv3n2vgLVqN52Jg9l9dFKdD54DFJqaZg7Mq/18st9463c3YwcbBg9UEFXuWepgQQUJCmKyl+XDHGZlWrRH6dxW36/22+1RdfjqMqfqH+WJPTk6H1U8hwZKZrR95qBWAyOSDjSsGogtUt2mBKN/nQHmlcA2PS/SQfmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338905; c=relaxed/simple;
	bh=5Y6zB1qVaCtl+YF3/faf9NgPIS00Q6EHARjCuoSy/qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrtoVXPGVWNftcZgsD9bsE8q+AIYJMpa0mcqMZsKJvXgaKSoojkfJEVIyPSuN/uSaJMlTljGb1CNJXo54J+2ukaiLrO5QmI1YBI1dRT2zYqER6TVGT1Q9H6DyIAyCMABZyahfM6IVt25i+CuGuxQZmIDcXPMYazz+dAxC5SQaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8W7qxmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8W7qxmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26BEC4CEF1;
	Mon,  8 Sep 2025 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338905;
	bh=5Y6zB1qVaCtl+YF3/faf9NgPIS00Q6EHARjCuoSy/qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8W7qxmNLbGkQ93uu6yJqdVytHhALtWK7oEdZdybtGb4lyHpDwzbTzGFutE6320Z0
	 uumIRcToNZEJbKatO6LOzxCeaPS/L60s58s6t67vmdbvGSYSuCp7BrnP5cTtJrnwzV
	 /xPXoGkO0aW1r7cQpTodWapvivb0hotP+djAvzMkoIww8LvoLUmzAW9464/cZMdacJ
	 h5xXvc2C8EgwubOSbcJ7TgfWWoTARDTCcbkSaW48oR78SSd9CPfGB9jcYp3ttdZcNh
	 hQJ8VUxcMQMHHZTHRdlqwQJAw2MVhIBzjJsozWnqxNmHahiC+VeCK5wDR/Gp7fTNv8
	 /GjE+8diBybBQ==
Date: Mon, 8 Sep 2025 14:41:40 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aL7dFIzEgiEETcIb@willie-the-truck>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>

On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
> buffer is enabled. Ensure that enabling the buffer comes after setting
> PMBPTR_EL1 by inserting an isb().
> 
> This only applies to guests for now, but in future versions of the
> architecture the PE will be allowed to behave in the same way.
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4e..6235ca7ecd48 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  	limit += (u64)buf->base;
>  	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>  	write_sysreg_s(base, SYS_PMBPTR_EL1);
> +	isb();


Hmm.

arm_spe_perf_aux_output_begin() is only called in two places:

1. From arm_spe_pmu_start()
2. From arm_spe_pmu_irq_handler()

For (1), we know that profiling is disabled by PMSCR_EL1.ExSPE.
For (2), we know that profiling is disabled by PMBSR_EL1.S.

In both cases, we already have an isb() before enabling profiling again
so I don't understand what this additional isb() is achieving.

Will
