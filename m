Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38024EA92
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101506; cv=none; b=CNu/G8Un/ftPF7zCEhV3H5d00RmIXmSDMuVEIRZejbVKo6MY9xeCuPITDBvkuKzuUjGINPCZn52vjsrYlG4Q95t/8XT+P1YR0pLVbUWNKPkPcbPDH8RQ7kx4XQWQtDV4wcaSecPsJrUt1sz6mBr710eGKBjhc54Fe+wgoGuTKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101506; c=relaxed/simple;
	bh=Nfbb4Q2xiDkH6WLiFI7e76Q6PwRDTA9H9+XvuWdYO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiBg8OJ5gYp1d+jg0GTAHW7uxMgkFUK79hdbZ9+fxsrqsPCoSQNq1P9HJjNqIv5ZLM7fo/jPobIjZK535A29ZYVbTXc94zkONwRF3rjll9dc+zYDSqns08k6s0XOcqFzNM7vHSskTTi1jX//Jjrfk0fKmXnnRs2f5wPHaHW5oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBIbM/7U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBIbM/7U"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22328dca22fso86932755ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741101504; x=1741706304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=gBIbM/7UCn3d+kG8XQQpXgjv6oo4359Az4NnhRvQG+OrZfNy37HWbUI6mXw5KqCHhH
         TN/VygfvNKNe497X57clJASH+VZQaIHPlbwaiW25ebDH9QtnXib+9HHy7Y7VFEiCJc+0
         U6ORj5nJcfQTJnuISlGSu2QKJys2DcjF9JWIjL2ZDYXn0GW5v+baNmvKmzUWgSviPKUa
         +pz2PZJPk1H6e0PFFtX+/9JS+ayLoZlPhgkvw7FqIaZ3vpHaioJX/BrbbMaNU3vxZUKi
         mA7vfCrejLi428a5pJ8iKs16cicAo9+tgbEkDiktMQHaJK8sJcird1xYiJfZFyBJh/HC
         0m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101504; x=1741706304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=f2B8sO7+kHv1w4xXxMA2Qn+JpRsva2N6tRgnYuD36hV3Sd2GQzn4IlnXgCS/0C+svI
         s7y+x132w+R60j8BxrckPP2MKO0CB4+0ZSCvlTe9TY6kRTGfVlXyPI/AIcTtIQxNB70/
         NnNPWn0EjC9N0ZNsiMJwrKREMtRZkt0LW2bxENmJh1DmE6RAU3QSyw0zSzwRsqKnM9/t
         id2Q1fwuRoLhGQrdfgyT639ABDWP00VF1O3ZjVHoBSyMnCH+R1N63la87DHecpUohX5a
         XU3PIMm5fbxvjeCVAY9/vxkjsS7qphn4hokDXyRrc44Jyz6m11CqV3Ib6gjHwwXFe8Fe
         e+mA==
X-Forwarded-Encrypted: i=1; AJvYcCWP0IRLhrTdcfBVwmK+HjIUX1S7w1LniK66++JCPp49e/WpyDKFhiMchnXiMa51mMJ/0WlcCaxjRN0fhYwqqlbV@vger.kernel.org
X-Gm-Message-State: AOJu0YxtElpu22oUsMtdwEbWLI3gphhrY9cQ2oFmsaLFW5AKZxLNcyq6
	zJjC7+BQYVqn6UK7a6JDjQHUNJaWGjZyo0ZIBbNnOI+BbR4q8AJoazt0Dhvxaw==
X-Gm-Gg: ASbGncvRrHBxiYl80Reo2J2Goq8GHdOGYuVv9RCHvRYlZSlUkFwWbQg9lbqGDE0fvg1
	Ptz1nOeHe45el/92R2SePJDDgzKzqowXHnwrAli9nzdTdy34iAkHsMtuDHlSWJ+MaW+tZ+Gk2mL
	4a0DTMX4wZDWBtpza/ZYjlBPvSgNXq6KfJhdZIIcl7RRRjLtkmW6h0aold6dVOEK55v9eBQM/gN
	k04EOAqzSLnw2M3zkQroaBk035489b6J9PT6dpWNZeDKRduRrRUWwreAgDMCRK5338t6f3se+yf
	mFx/CBLRqB2ogagm19rHhOujd08TyB3Y2pFR2Vyp2RT/8NsM0FcaQzs=
X-Google-Smtp-Source: AGHT+IE5m+vrO6nNhOZDvuax+Cu982tB5v2FtygKBkyOtqqZSXWNrXN1iB/dSPoQj7bI+IrEJ3ckng==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr234071745ad.3.1741101503081;
        Tue, 04 Mar 2025 07:18:23 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7a6sm95889145ad.160.2025.03.04.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:18:22 -0800 (PST)
Date: Tue, 4 Mar 2025 20:48:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Fan Ni <nifan.cxl@gmail.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304151814.6xu7cbpwpqrvcad5@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194647.GC1552306@rocinante>

+ Geert (who reported the regression in -next)

On Tue, Mar 04, 2025 at 04:46:47AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > +{
> > > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +	struct device *dev = pci->dev;
> > > +	struct debugfs_info *debugfs;
> > > +	struct dentry *dir;
> > > +	int ret;
> > > +
> > > +	/* Create main directory for each platform driver */
> > > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > +	dir = debugfs_create_dir(dirname, NULL);
> > > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +	if (!debugfs)
> > > +		return -ENOMEM;
> > > +
> > > +	debugfs->debug_dir = dir;
> > > +	pci->debugfs = debugfs;
> > > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +	if (ret)
> > > +		dev_dbg(dev, "RASDES debugfs init failed\n");
> > 
> > What will happen if ret != 0? still return 0? 
> 
> Given that callers of dwc_pcie_debugfs_init() check for errors,
> this probably should correctly bubble up any failure coming from
> dwc_pcie_rasdes_debugfs_init().
> 
> I made updates to the code directly on the current branch, have a look:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e
> 
> Let me know if this is OK with you.
> 

If the SoC has no RASDES capability, then this call is bound to fail (which will
break existing platforms). I'd propose to return 0 if
dw_pcie_find_rasdes_capability() fails in addition to this change:

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dca1e9999113..7277a21e30d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -471,7 +471,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
        ras_cap = dw_pcie_find_rasdes_capability(pci);
        if (!ras_cap) {
                dev_dbg(dev, "no RASDES capability available\n");
-               return -ENODEV;
+               return 0;
        }
 
        rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);

This will fix the regressions like the one reported by Geert:

https://lore.kernel.org/linux-pci/CAMuHMdWuCJAd-mCpCoseThureCKnnep4T-Z0h1_WJ1BOf2ZeDg@mail.gmail.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
