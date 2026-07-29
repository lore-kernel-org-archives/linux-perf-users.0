Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D13B8128;
	Wed, 29 Jul 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352867; cv=none; b=iUNoKYPqQXY1hwGeg4k4o2H6GPa1iAC+YkRaFBo+ava4kBoao1P5eUOjjKYOOVAwpbXbG50X/JdgRNrZ5WOCx+Kq9w9FVIaXNka8yN11UZYkpqc+wQHCQvhXAD3dbVzJSA82XCAwDG9/4GsTXt98xK00At8DN5TeWELi45mHDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352867; c=relaxed/simple;
	bh=8BqyJMEU3Q1Rl/Fd9zJYrqkl8T3kYYUWlIVOTHz56D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kq0SCa/kNo/o1+akCUmIb0sTE+TBbMGb8NclcNH5d7jwgB10zgr+Qssom+MrD/juztR/Vw6T1kJECntBjMk19duaDvFzzpLwd7dbFLo8wacziJDSBek9n1KQxfHXQvIfrH0f44W0CoT6igOdmMrwa0EY5co8g7EZADsdWPCgrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSrKBArN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSrKBArN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96131F000E9;
	Wed, 29 Jul 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352865;
	bh=r+XwtW/b/HxFe1EIARgOQETUrX9kwgIw0hy26Fm2rPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iSrKBArNhdjcqwSkuwkbt1bdgpavqDcDYrSaJ59AUqwZHUeWO71pSwVdtfuadYpVJ
	 g8p5Q6JtWqqKpyW/EK20JNTOrtAnHSOC5WBKhoyjALasBmmRXPR4diBuHUCjyWd3SL
	 BsPnwiianGpgMU8U8nLIOCj/2d44BJNwgeFQ6WG0SH4uz8sR2fEB1HaLF4oB7OlVxE
	 8FOUpaEISwe5/2b61bn1rRg2uMoUdCY6OEdQUvYW7pjAz4UFt1crCnDTjN1C21ekf9
	 Un2VrtMmUjnnpB4ZV0UkY7JFU1VF4z6ZfQCNW8RCcjmkP/oXAVVw+yQYa1gl0ecjup
	 5O+zl4tjmld4w==
Date: Wed, 29 Jul 2026 20:21:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] perf/cxl: Validate the hardware-reported counter
 width
Message-ID: <20260729202101.6406ee6d@jic23-huawei>
In-Reply-To: <20260729145555.3919550-8-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:53 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_parse_caps() takes the Counter Width straight from the CPMU
> Capability register with no bounds check. The Counter Data register is
> 64 bits, so a device reporting width 0 (or > 64) is invalid, and the
> read path's GENMASK_ULL(counter_width - 1, 0) would shift out of range
> (undefined behavior, e.g. a UBSAN splat) on a value of 0.
> 
> Reject a counter width outside 1..64 at probe.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")

I don't mind hardening this but there has been a lot of push back on
'bugs' that are dependent on broken hardware (part of the AI discussions
on the ksummit list).  

Anyhow it is easy protection so fair enough - I'm just not sure it is
worth the pain of chasing down more complex hardware did the wrong thing
'bugs'

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>



> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/perf/cxl_pmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 52e78a6e0960..2e817a52ff1e 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -139,6 +139,15 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
>  
>  	info->num_counters = FIELD_GET(CXL_PMU_CAP_NUM_COUNTERS_MSK, val) + 1;
>  	info->counter_width = FIELD_GET(CXL_PMU_CAP_COUNTER_WIDTH_MSK, val);
> +	/*
> +	 * The Counter Data register is 64 bits wide, so a Counter Width of 0 or
> +	 * >64 is invalid. Reject it rather than let GENMASK_ULL(width - 1, 0) in
> +	 * the read path shift out of range.
> +	 */
> +	if (info->counter_width == 0 || info->counter_width > 64) {
> +		dev_err(dev, "Invalid counter width %d\n", info->counter_width);
> +		return -ENODEV;
> +	}
>  	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
>  
>  	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;

