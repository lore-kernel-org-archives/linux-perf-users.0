Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0A46C833;
	Wed, 29 Jul 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353322; cv=none; b=sOXwECBFzvKjEYOUWUvq13GotB21BTDdJZY2+/3VAYNcBcOAehLSWEp6eMEvcMOI0pz+LML2+BGo1HpoNRUdOPIpjSr2zCInVX3kauCuUmcwRMBjxxzjjU2q52WmiawDiz+uaT8n9+A5R5sf44HsEl1V2UAB6jiamdB0ZBsI66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353322; c=relaxed/simple;
	bh=HDupeP+/VU2Czyp6G9QUOgHjT9Sa68UJUFWBpM5oBvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8luNpiF8tIppspae75AZ7dKa5YMXElqfEdo+xnlkbe/Pqmf9cf99WwU4Q9EW2BZqEFwdzIfMeh8hqGPao728tvXWb4uYN8ZQrQcRk/0VuSopP7+5FSS79Fd+Q6mRjbAp3jTy1xKqkF3L6R9eRsrATrQc4H49RUtOH7zJcVU7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4glAfKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4glAfKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD911F000E9;
	Wed, 29 Jul 2026 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353312;
	bh=Qftu12ZXhaE+oi4prIE03G+6pqgNMX5iRk3LbukTmu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J4glAfKfs585lMEt1V2Cxy7PprkIrrXS4v58TIlWdqx4w5QHPJYyJ6VdSpOrFRXbe
	 KTvVrqecgssodMKX0eedNjb12O3AjuFtDDy7hhNHoI/9p1pLr/I4z0tIkKYbShPwc1
	 hKrAspm6RFLm4JkBtkSXnkQ4bj5lPmfP3oyadGm3FTMf8GUFQnYM1pkRGfmOPGa3rK
	 c/7/kvcgUR8fgMJNAjaEJcMUSjFx8VMX59KOoTY0G7GqSspAO+1L/tdRLWn0ORY2TK
	 VV0zJ73nzARACXCBs5Nm13Q2zB+iFx2xfb+j9/J8r+9/8WdVRrbBx/GFSOZezrdFNL
	 u/jamppGwerCw==
Date: Wed, 29 Jul 2026 20:28:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Message-ID: <20260729202827.5f2e9d4c@jic23-huawei>
In-Reply-To: <20260729145555.3919550-5-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:50 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
> info->irq holds the MSI/MSI-X message number the device signals overflow
> on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
> interrupt support". Message number 0 is valid and pci_irq_vector() takes
> a 0-based index, so a compliant device signalling on the first vector is
> wrongly refused and fails to probe.
> 
> Reject only the no-interrupt case (info->irq < 0), matching the sibling
> CXL mailbox and event IRQ handling.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Anyone who puts the PMU on vector 0 is presumably sharing one vector
for everything - which to me sounds unwise.  Still indeed a bug.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 956da8202551..d1e810601e36 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
>  		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>  	};
>  
> -	if (info->irq <= 0)
> +	if (info->irq < 0)
>  		return -EINVAL;
>  
>  	rc = pci_irq_vector(pdev, info->irq);

