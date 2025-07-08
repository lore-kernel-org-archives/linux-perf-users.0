Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B602E0915;
	Tue,  8 Jul 2025 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985620; cv=none; b=Bx+TPYOzShFcFIrIBdxjwnwiE+OJuWTBIRQbeke+OAmC22CIf9S6psLPuTIAAK7MY1+WJr/TQ6DtUfRm7AOhPVU/yZ0HtyJYWFkzNC/m4plkSPkPOgMUo9ddzkdnQGJUmNtcZOSbguOIg4ZBcKq/mmXFW/quvmVDsaAebJU+/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985620; c=relaxed/simple;
	bh=8Igoh3V3PfPDr1kU9omdjXEh0HyBrDWV6yhaeXoqTfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEUKmkDeF5Na71zWjqjN8NAwJOGoqabQqL0Z+NJA1DjWBcNURWr6RclmxNLpy9s3ANGcbENGKCXa8dzCDMNNQmnJIy7Zt14bBfZHf0RPup8/ZdR8+ZjxhBnfCt2knvUUv7lYuywUxmofp9j08197IyE9jBKTg9FH6T1kd+pf3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F2B153B;
	Tue,  8 Jul 2025 07:40:04 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20E23F694;
	Tue,  8 Jul 2025 07:40:14 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:40:04 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aG0tsz1EPbrDFTia@raptor>
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

Hi James,

On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
> buffer is enabled. Ensure that enabling the buffer comes after setting
> PMBPTR_EL1 by inserting an isb().
> 
> This only applies to guests for now, but in future versions of the
> architecture the PE will be allowed to behave in the same way.
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")

A note on why I think this is a fix.

The write to PMBLIMITR_EL1 serves two purposes: to enable the buffer and to set
the limit for the new buffer. The statistical profiling unit (I'm calling it
SPU) performs indirect reads of the registers. Without the ISB between the
buffer pointer write and the write that enables + sets limit for the buffer, I
think it's possible for the SPU to observe the PMBLIMITR_EL1 write before the
PMBPTR_EL1 write. During this time, from the point of view of the SPU, the
buffer is incorrectly programmed, and potentially the old PMBPTR_EL1.PTR > new
PMBLIMITR_EL1.Limit.

arm_spe_perf_aux_output_begin() can be called after sampling has been enabled
(PMSCR_EL1.E1SPE = 1).

Putting it all together, this means that we have all the conditions to break the
restrictions on the current write pointer and the behaviour is UNPREDICTABLE, as
per section D17.7.1, ARM DDI 0487L. I think it's worth pointing out that the SPU
can do any of the folling in this situation: writing to any writable virtual
address in the current owning translation regime (!), generate a profiling
management event, discard all data or don't enable profiling.

Thanks,
Alex

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
>  
>  out_write_limit:
>  	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> 
> -- 
> 2.34.1
> 
