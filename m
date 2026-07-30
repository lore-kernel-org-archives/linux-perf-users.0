Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA83AAF4E;
	Thu, 30 Jul 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437834; cv=none; b=bkopPq3iEl3qc3O8lSdjwEp1a16dXo2eAvSKRxf8d71SVlp4P4EXPNGLVNzPY3M0pJEYcoahgaQCRswNKroVPMjr3ov6pkkKv38gUk+s1czycRSbi/O50KUlgEYYgcZiECA3sfnYdjNvULsojyzQN3g3Wh7V6xtySc56VQ+cA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437834; c=relaxed/simple;
	bh=3lALbVcoXwUYwK2rN+fiVHU1cDDDp3wn9GF9+iB5mnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+Y1OiEe3aboH8TStfyauYNTeYh8dRHabjZ6+GRgDMQlIQ7CbYPMlIzC92Q2cUi10fmkzILNwog0QPeotk7SWcmPH0CuQIH5hR2oi7djK31tFwu3aVxWJi6pkIr2IIXe/QPf05kiqQnVBWdolEkEWCAPouNdk/oIlm8ulxhLIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpeHwMCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpeHwMCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229FF1F000E9;
	Thu, 30 Jul 2026 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437832;
	bh=HaaHnBcoQ5raku0Wf4/lOex2nP2d7Nu6HLjan5qfweM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RpeHwMCU0y6k58mGdwOcKpd0NZlBy2tk8qC0HGcitu7M9Yt9PiAY6c5TednOY+ZKz
	 PoZWr//wQepg/uNVdSxRwNEHYaKaB/tJiVU//VEeQtbyt+tfUiWloa5ltBM9yw/0Ar
	 YrlfbgcBD3Rvw6U/PkawOQXNYVRA7QcJlrXFmDWgm7xqzQ7sV9UsoTns9czEa6EeQT
	 XLiuTE9yEAR8JuTlBAvPbR7ZjymWj+eEDlIHIRy4tnFLlmACX0Xx0E2ZHxrSXko+7k
	 USpjAZlucYCPMzqU9J/gR97cVdUQnNW/Soko6BtvdoRpfElZhmhMdLXewoY2cM06Tc
	 6whqN0XBGh7rg==
Date: Thu, 30 Jul 2026 19:57:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Message-ID: <20260730195707.553670cd@jic23-huawei>
In-Reply-To: <5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-5-dave.jiang@intel.com>
	<5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 13:18:42 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 29/07/2026 3:55 pm, Dave Jiang wrote:
> > cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
> > info->irq holds the MSI/MSI-X message number the device signals overflow
> > on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
> > interrupt support". Message number 0 is valid and pci_irq_vector() takes
> > a 0-based index, so a compliant device signalling on the first vector is
> > wrongly refused and fails to probe.  
> 
> If info->irq is a PCI MSI vector index, not the Linux vIRQ number, then 
> surely that means the irq_set_affinity() calls are wrong as well?

yup.  I really messed this driver up :(

should rename this one and then have irq mean irq.


> 
> Thanks,
> Robin.
> 
> > Reject only the no-interrupt case (info->irq < 0), matching the sibling
> > CXL mailbox and event IRQ handling.
> > 
> > Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >   drivers/perf/cxl_pmu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 956da8202551..d1e810601e36 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
> >   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> >   	};
> >   
> > -	if (info->irq <= 0)
> > +	if (info->irq < 0)
> >   		return -EINVAL;
> >   
> >   	rc = pci_irq_vector(pdev, info->irq);  
> 

