Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B830C632;
	Tue,  5 May 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971030; cv=none; b=V3RvD5O1KYpNDnmhH/6CdFoHn+ldJy1lWmmx+VdfUNke085Yizv2pT+g/FBVmaL63NyJjOV0yZ73BlLRYo9VM0aQ9Jopk1AipdnPhrRYM/EQK05+ezH9SeFYJ06CLQFobtZh/Vjc6569M11U/0ukGi5Cpc1dw6avP8CAgKz5yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971030; c=relaxed/simple;
	bh=TSABjFUKhaSPriZfG4wryerz/Bt+NOXbdIcM8wPv6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EYMKKX3Q9ZNZxcTezYu4a9ZITvDEdroWRfLWOXo6RRy/SfVfF9E0UDGvFMdiYP8vH9uhR76pB1CvHr5ThJjKx2oPGxg/9dWONe+XtUJdvxAXsSSFDFqUqZbRJUDjEFlSEuqaHclTB2qnW6oJsp+WKS/mHGRfVBLvu1Y8ikZsHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM6xynsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM6xynsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A40C2BCB9;
	Tue,  5 May 2026 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777971030;
	bh=TSABjFUKhaSPriZfG4wryerz/Bt+NOXbdIcM8wPv6lQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BM6xynsQg5t4v96vNM57GMBYQb2A6y0jIBSCJ1tNnpZjwFujDCsmkMWtA5LeCurye
	 rSDsVZV524Bqe5cKvZf0/fWuFD4iw3O5IwiDCeezs9veuOkoYd5oQNj+DJM4co9XaQ
	 HC7ayxUWUyEpqVw6CjN7+SoUyybK9uRruBBAX77sZdK+3p58u5JhHEcGpHYZPWLZq+
	 v5oIrBujP0veRImQOI2qYUwlq1m9UnLvXXoRxWll3WrQhoFX6DgwlzK6nFaAFc/ATO
	 SBnBgqWZ85ho0kwHcU2HOMEfTTJw87fUPLeUGXMOzW1Na9UqExbYACZHoxKILym5lk
	 SXWmfmMEyuFEA==
Date: Tue, 5 May 2026 09:50:26 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Vastargazing <vebohr@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/5] perf: arm: pmu: fix reference leak on failed device
 registration
Message-ID: <20260505-bold-kind-herring-2c7eef@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>

On Mon, May 04, 2026 at 01:08:46PM +0300, Vastargazing wrote:
> When platform_device_register() fails in arm_acpi_register_pmu_device(),
> the embedded struct device has already been initialized by
> device_initialize() inside platform_device_register(). The error path
> unregisters the GSI interrupt but returns without dropping the device
> reference:
> 
>   arm_acpi_register_pmu_device()
>     -> platform_device_register(pdev)
>        -> device_initialize(&pdev->dev)   /* kref = 1 */
>        -> platform_device_add(pdev)       /* fails */
>     <- acpi_unregister_gsi() called, but kref still 1
> 
> Per platform_device_register() kernel-doc:
> 
>   NOTE: _Never_ directly free @pdev after calling this function, even if
>   it returned an error! Always use platform_device_put() to give up the
>   reference initialised in this function instead.
> 
> Fix this by calling platform_device_put() in the error branch before
> unregistering the GSI.
> 
> Fixes: d24a0c7099b3 ("arm_pmu: acpi: spe: Add initial MADT/SPE probing")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
> Signed-off-by: Vastargazing <vebohr@gmail.com>
> ---
>  drivers/perf/arm_pmu_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index e80f76d95e68..c2defbc32ad9 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>  
>  	pdev->resource[0].start = irq;
>  	ret = platform_device_register(pdev);
> -	if (ret)
> +	if (ret) {
> +		platform_device_put(pdev);

Both spe_dev and trbe_dev using this are statically allocated, what am I
missing here ? What will platform_device_put() do ?

-- 
Regards,
Sudeep
