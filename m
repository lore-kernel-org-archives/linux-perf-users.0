Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393F1A3BD8
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896269; cv=none; b=IxFfkOm6SOIbF6qIH28h003V1ou5W2V/Ho/h768Wd4oZ6XJj+OorYlG5vLlc0dKHAgsSuD+qvirlyxUNs2oLUDSKWisB9y+REKzrd2Dx9WpmiWj6oRxlqJEUi2suE6NOE8hxPmUCU9xtcetkCG2XvVZ9INM6U3ihCfgONsaf6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896269; c=relaxed/simple;
	bh=AgSMuhax1w6whyYc2kxg5rDY9Pznuy/Epu/NPsXVlq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBnc3lgcgz9XXQSD2XzqNHE2iJVF4yEONNlY0Ppm37TFaOMIIOf1VaftF/POi7x6Z2FV9PKDEriM28PGWYYR4FtbbSCNKo9Krc3RbuPZv4+qCloeAyDc3MgnUNQYn6BND/Ak68clB2x6qipNyQc6vFFAiHo98pvWJE9e232vRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XayWf85V; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XayWf85V"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622940ef7so2347106e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739896266; x=1740501066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btU0w+uNVFHY2e6nf/JYninIaoVDv7TVqnoTKzlZWZc=;
        b=XayWf85Vz30Wf06EYnqPteeypPfCzj3OhFe08je6wBhg7knDlV4bCwce/Bv6a8UpXe
         LI3X4ZkPExChYNt+xNzKDnsZUoqEljioqVW4XS3tenah0iur8zqss//My1EepQbcjlFk
         fISPxalOeJB0GzH+iS2ghg0SSFcykabQ1KRMjwfON+8UhguSCbt6pO7pbPPuBxNSIUnB
         rHlpB47+BMfJPkzLP6wxMqhsUxs3oXH86CsXp8gJo+riXVfVP2UTBuL+ZJ5EoGWVH3Ry
         Mz+gMrdSjrXfTSz1Gy0/5SMYVQejOaPvOu9SK5Daq5WH2iCOcFyd2CHYRbiPdq6HjVOI
         z+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896266; x=1740501066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btU0w+uNVFHY2e6nf/JYninIaoVDv7TVqnoTKzlZWZc=;
        b=F1ANZWpQFQtZquXGWcX21NE4aNPizphXZF82L2vLRYcAdmv37XCKknx84jMuWtDhMS
         JCDHK5MkciCnuxPYrTm0z+N+3wrsMkI8ipZros9YLB+ApqjreTfbvMh/MaL7veUY3oKo
         cLrLRnrfBzHDs7X3ylH1VlLsgqmthSO873jlhsMHePgAM+qNx7GCE6i3n5EkF+SItO8S
         nOz0uSHe1stpjAqLRNrgqMIuaL8A4C77ntNyxARt3zhBMtOYqON3B9b0gPKkSXzi9gC4
         KgmS+d+5nESesf+t5KQxCLPX/4WQU8D57TNBXINIDjn+fqvhPvB242XvZXMt1IIc+RoS
         w0vw==
X-Forwarded-Encrypted: i=1; AJvYcCW2B2Z63WNBaYWZco1rEqtQ7uyKn4dfL1HYa64lf6gPd7gor66Xn3Mig6WZF/9+5nTaOrCfWuobsDk/Gzz/+ey0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JDNz1iE49fK2WOVORk/gviRUEPUtV2R1KO2WOdA2ZzrHqGX7
	EinwHx7rj9jFmjxLBri1Mk6fFs2eGC3J1N7LEykIorTLpkRH9h5Yn0YpKZeQhEs=
X-Gm-Gg: ASbGncvWD/vN7y2wwNUqU/I+p3s0oLMJX9UQcLHlndhjLIvHBbCLuMLw5n0U2XT+LuV
	madx2r4KPlex47AfPhUg+KAvnaa5tNW0/OMWjEJWok/fIcSVmSv7uQOTfZjVdYOpphC6WcmTp3V
	8UNyNTVKI5vqOElhIdkek4JBtlJXCafos4vqoD1X3voxKIOxY2e9p5ZfIvoEVjQLZ9pB358BTiR
	4qjtWKYfCiH8uFvJx0incRYU8wF1SW3WpbiqxhpQlu3f245TLB8AubTvAXUfIRa1OKBSWNh3Ilr
	qMztV9r6c+YPSlW7gSjVt76bhW7WhLDC/RUBW8LqZ/8WQ6vR4GgPaQylpZZB2tGPppWPJn0=
X-Google-Smtp-Source: AGHT+IEtC0aFiCVfXRyL9SzdaH9Q4MvJkCVZReT3BK5AY1Ni+JC9UVla9+Vl5hHTO/rCaSOKR4FQqA==
X-Received: by 2002:a05:6512:130b:b0:545:e19:ba12 with SMTP id 2adb3069b0e04-5462ef20f0dmr90751e87.51.1739896265862;
        Tue, 18 Feb 2025 08:31:05 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452fa00e6esm1360335e87.162.2025.02.18.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:31:04 -0800 (PST)
Date: Tue, 18 Feb 2025 18:31:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: manivannan.sadhasivam@linaro.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to
 'pcie-dwc.h'
Message-ID: <4nnikepf7ay4ml3audn34gmq5jttjcfz3syfnxeowmjb4no2cj@lyawl4saa3sa>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>

On Tue, Feb 18, 2025 at 08:06:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Since these are common to all Desginware PCIe IPs, move them to a new
> header, 'pcie-dwc.h' so that other drivers could make use of them.

Which drivers are going to use it? Please provide an explanation.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS                 |  1 +
>  drivers/perf/dwc_pcie_pmu.c | 23 ++---------------------
>  include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..b4d09d52a750 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18123,6 +18123,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>  F:	drivers/pci/controller/dwc/*designware*
> +F:	include/linux/pcie-dwc.h
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..05b37ea7cf16 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/pcie-dwc.h>
>  #include <linux/perf_event.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
>  	struct list_head dev_node;
>  };
>  
> -struct dwc_pcie_pmu_vsec_id {
> -	u16 vendor_id;
> -	u16 vsec_id;
> -	u8 vsec_rev;
> -};
> -
> -/*
> - * VSEC IDs are allocated by the vendor, so a given ID may mean different
> - * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> - */
> -static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> -	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{} /* terminator */
> -};
> -
>  static ssize_t cpumask_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -529,7 +510,7 @@ static void dwc_pcie_unregister_pmu(void *data)
>  
>  static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>  {
> -	const struct dwc_pcie_pmu_vsec_id *vid;
> +	const struct dwc_pcie_vsec_id *vid;
>  	u16 vsec;
>  	u32 val;
>  
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> new file mode 100644
> index 000000000000..261ae11d75a4
> --- /dev/null
> +++ b/include/linux/pcie-dwc.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + *
> + * Copyright 2025 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#ifndef LINUX_PCIE_DWC_H
> +#define LINUX_PCIE_DWC_H
> +
> +#include <linux/pci_ids.h>
> +
> +struct dwc_pcie_vsec_id {
> +	u16 vendor_id;
> +	u16 vsec_id;
> +	u8 vsec_rev;
> +};
> +
> +/*
> + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> + */
> +static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {

Having it in the header means that there are going to be several
copies of this data. Is that expected?

> +	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{} /* terminator */
> +};
> +
> +#endif /* LINUX_PCIE_DWC_H */
> 
> -- 
> 2.25.1
> 
> 

-- 
With best wishes
Dmitry
