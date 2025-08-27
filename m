Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C489342CA3;
	Wed, 27 Aug 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287405; cv=none; b=MEkGvirusOutJvuoyofIBYJn9F68H5AIDrDPwflygyRt61yRQgBPDV323IhcnwqfIoAe9O9Y5uu4yv/Y4Nyq4UEba2/mUg/4kQ2/i83Aj5GhHI1SdJSea3xxgIF/SkTZA2odAWjNdxHsGWEGJIKtJNaYn/K9nBm1j2/swbd2Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287405; c=relaxed/simple;
	bh=iSUf8Gw5Sp+DAbiZyhAnBJ3UUczThdhyX3g627Tzm5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b45QVUwUAya/ce+WdSwIKxn1rq+KDZobXYEW4Q5fsQA/zlU3oFNpkklsB8WJ7GBC+KA4HkD/AKIiMrpwKI6nip1PzhltFadafMA9sILyUS1VlCE6gqAeFEG4OFTsxatSaJ55pamxWSZsDFwGYDl62yBlp0j7m8ZPVzBV/pRPbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F3D15A1;
	Wed, 27 Aug 2025 02:36:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 466153F738;
	Wed, 27 Aug 2025 02:36:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:36:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers: perf: use us_to_ktime() where appropriate
Message-ID: <aK7RkB5p6L17Ffuw@J2N7QTR9R3>
References: <20250813083257.504573-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813083257.504573-1-zhao.xichao@vivo.com>

[adding Robin and LAKML]

On Wed, Aug 13, 2025 at 04:32:57PM +0800, Xichao Zhao wrote:
> The arm_ccn_pmu_poll_period_us are more suitable for using
> the us_to_ktime(). This can make the code more concise and
> enhance readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Superficially this looks fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, I assume that (if no-one complains) you'll pick this up when
queueing PMU patches.

Mark.

> ---
>  drivers/perf/arm-ccn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 1a0d0e1a2263..8af3563fdf60 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -565,7 +565,7 @@ module_param_named(pmu_poll_period_us, arm_ccn_pmu_poll_period_us, uint,
>  
>  static ktime_t arm_ccn_pmu_timer_period(void)
>  {
> -	return ns_to_ktime((u64)arm_ccn_pmu_poll_period_us * 1000);
> +	return us_to_ktime((u64)arm_ccn_pmu_poll_period_us);
>  }
>  
>  
> -- 
> 2.34.1
> 
