Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89B30AAD5
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Jul 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468049; cv=none; b=pdZlK/hpw6hh01hJhTzOt5BpaCplbShl7QxPgpOpbS6GOmrXMZB/zRm3ZN3olC7DRLF11ul2Iyh9EdZT1Sho6WkjNkjXDBovjiQHOqXdgVulhyUTkj9ePz58dZlaqQG4LhB+LHV7JFdcvpUYMRwQOyIVRFlFV5FwCSUv3ADQIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468049; c=relaxed/simple;
	bh=LKiAkwIlkhGKHxSQo+67Kv6s4ANIA/quEcyhEv0mrrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXXPpuHMQEdCQGHH6iVtYHVvbZEeiZfeKnLNHvlzJkAr+mCyN/GjPEQbP6S6ef54w7YhoCsv6Mb0t9ndi3N6za6PVKJqWcYQaT6Xq6KVhu6Gm/iBDhx44+zk7c0EqN5JOcJ453qQBIJlDdWcutxypdn8DRbmobBacJ82Zl6pcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA2522C7;
	Wed,  2 Jul 2025 07:53:52 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2C73F6A8;
	Wed,  2 Jul 2025 07:54:06 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:54:04 +0100
From: Leo Yan <leo.yan@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm: Add missing .suppress_bind_attrs
Message-ID: <20250702145404.GZ794930@e132581.arm.com>
References: <acd48c341b33b96804a3969ee00b355d40c546e2.1751465293.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd48c341b33b96804a3969ee00b355d40c546e2.1751465293.git.robin.murphy@arm.com>

On Wed, Jul 02, 2025 at 03:08:13PM +0100, Robin Murphy wrote:
> PMU drivers should set .suppress_bind_attrs so that userspace is denied
> the opportunity to pull the driver out from underneath an in-use PMU
> (with predictably unpleasant consequences). Somehow both the CMN and NI
> drivers have managed to miss this; put that right.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/perf/arm-cmn.c | 1 +
>  drivers/perf/arm-ni.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 031d45d0fe3d..d1df2f3adbc5 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2655,6 +2655,7 @@ static struct platform_driver arm_cmn_driver = {
>  		.name = "arm-cmn",
>  		.of_match_table = of_match_ptr(arm_cmn_of_match),
>  		.acpi_match_table = ACPI_PTR(arm_cmn_acpi_match),
> +		.suppress_bind_attrs = true,
>  	},
>  	.probe = arm_cmn_probe,
>  	.remove = arm_cmn_remove,
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index de7b6cce4d68..5f20baf59024 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -707,6 +707,7 @@ static struct platform_driver arm_ni_driver = {
>  		.name = "arm-ni",
>  		.of_match_table = of_match_ptr(arm_ni_of_match),
>  		.acpi_match_table = ACPI_PTR(arm_ni_acpi_match),
> +		.suppress_bind_attrs = true,
>  	},
>  	.probe = arm_ni_probe,
>  	.remove = arm_ni_remove,
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
> 
