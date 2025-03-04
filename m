Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F892780F4
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102339; cv=none; b=ZKs0T9Hh74sOwsfVpPfctK/luD2bRNmpWG2RkFYx0seeloyKnCQGzgWGZpVVxs5lQ11Iym5q6Z5ibIh+Q9u6H3OsRWhuM6fbzVCWRGfZIuxlFftQUh5JZzVOzMdo6UUOn8NPG60enacrmuyyVVkQ8QLmxVV8B2sLehewKjHL/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102339; c=relaxed/simple;
	bh=jHsoS/QfB3OLT+xMvFjIYwKmEM5bHtcU7LWt7y8mak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERKXbUH+eAO9/Ap88Ehe0nx7DLQWxe0cs+mUgyfiJTl8YEDy+ygOoMIgKIijREtk7tSoLZ8EpJmwC8/6PS1yZxQ8nM70fxy2TrFIHho+nVz8HgHLbIFD20v67wpAzOu5FVllFSbejNDy1ELGPuHDITHuJ8BWygqS7mv0f01QKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcHRxeoJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcHRxeoJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso9872432a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741102337; x=1741707137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9J55i6SaAxXDmk71XUiDvvdHDUMorv5pKHh75B2QGvY=;
        b=PcHRxeoJRnnQsqqnpmTbzdbJFuUoQ6wslJvBQ1oXtZ6vlbZ6aI4+N14wW2b8UzUPxD
         /4WdAv8otbQKOIfVurvDb67QKRHwWuADKVpEFmvbBEUzy09otdz6SB+Q1FmmKFWYnL0G
         +Wo4JsWoPhupopYXMMzgma901JP6G5E+WHm6rQSkBFtNlhdszAnhDHFC6wxrvzEhVZDQ
         he/qzQQIGyRHK7n+/AyUYR1/y5AZqocZfAkyin6P3kLx5K8EbTbcwJBstocmJR1tErbA
         VrEL+Y+s0hn++WB4IUEuYsutvL+TzXzLRd1AO/UwNM6YVPJ0+vBpn7cbl0eud2eIm3XS
         /elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102337; x=1741707137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J55i6SaAxXDmk71XUiDvvdHDUMorv5pKHh75B2QGvY=;
        b=JM/0L6MQLJy+tlZXT6wxr2sZSdexigQ4lkjmGraCyqqDcoER1xpTT8Ee/vB6FCU7go
         s/GSwJbkpjVa2oJPC26m9IRd2QIHaSjW1b1EldJdwHbd9ZqqF3o42ocnBEzH4HUmDFLr
         lsu7fxDpEnWqtFgdr5Ljt2oqYLahUYexZvJwRRdX1Rud7uk4YWdubbHScDUehXLZDSyl
         h60kQP1brj/VwfZV0EDZxvOsuo3t9WKB02MtAz8KHA6Mkhsur3T8B3q22CLPa4PIz7tq
         BvoeMf9/0noP5hb+pSNaD/rAoWj0qfrcubFsY3grsN91hIzAeyEVYo7jKQcFnOiuHv4m
         uO0w==
X-Forwarded-Encrypted: i=1; AJvYcCXBXgUL1WjWHRnE3M4PxCB9BYhNq/Fe28TtZeEiYifmpXYjpRVzHoByeBFGCDbCvxCOyGlFFOX6W0V5gFKWKgQ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFsWtWbiBB4tmmAGAn2YqF1AYbNpiCn/DaTXQTwoNzfiBB2lJ
	6lBDLJU9IjtTNty7t1VQk2it9weYFbsw0zxqajU0I0v5oGCnyVM6K2qxlHiBRw==
X-Gm-Gg: ASbGncsIpJDZDSKLPT84NWDs8zCPgai0Zpd0R2TgxivsB+v62HVHrP8zE6RbI3xOSTY
	1+i9YdloiTy+gvAsmqjuyTIncZhBZKt8gEETMsr7PVjMuN+hB5B6eh3+Nx9HH27b6G4FmhmA/1q
	D2q6edFOqStv2nr2iJ/TYl58GLf83F5TVU3C+T6GbvJICepIUq4kVJrAwYyo20FcpDEBNakV0CS
	AIrc45iNpdM1hYNJC/Zo/e+ig5BFPidD0F4t5fUooEwLDBrS0J3/k1uwTF4RBt3cXa64qXTeEsu
	0jp7FFq85/5YymUTlZg1qGjTC7NsPf/RSHzE0LvJsZNnK3yeGigvuw4=
X-Google-Smtp-Source: AGHT+IGGf95zBxRvPRSEYDsTC4/BBUP78sumCmzYhxc9letUVVeTQ59a5edLgdJXdoWT1eIqtoqw6w==
X-Received: by 2002:a17:90b:2888:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-2febab5e112mr30851643a91.14.1741102336858;
        Tue, 04 Mar 2025 07:32:16 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f076sm13309640a91.42.2025.03.04.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:32:16 -0800 (PST)
Date: Tue, 4 Mar 2025 21:02:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <20250304153206.gr7footrqrpc5uxf@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
 <Z8XuuNb6TRevUlHH@debian>
 <20250303194228.GB1552306@rocinante>
 <Z8YZEALV71PUkXpF@debian>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8YZEALV71PUkXpF@debian>

On Mon, Mar 03, 2025 at 01:03:12PM -0800, Fan Ni wrote:
> On Tue, Mar 04, 2025 at 04:42:28AM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > [...]
> > > > +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > > > +{
> > > > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > > > +	struct dw_pcie *pci = pdata->pci;
> > > > +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > > > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > > > +	ssize_t pos;
> > > > +	u32 val;
> > > > +
> > > > +	mutex_lock(&rinfo->reg_event_lock);
> > > > +	set_event_number(pdata, pci, rinfo);
> > > > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > > > +	mutex_unlock(&rinfo->reg_event_lock);
> > > > +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> > > > +
> > > > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> > > > +}
> > > 
> > > Do we need to check whether the counter is enabled or not for the event
> > > before retrieving the counter value?
> > 
> > I believe, we have a patch that aims to address, have a look at:
> > 
> >   https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org
> 
> Maybe I missed something, that seems to fix counter_enable_read(), but
> here is to retrieve counter value. 
> How dw_pcie_readl_dbi() can return something like "Counter Disabled"? 
> 

Only way to know if a counter is enabled by reading back the status. And that is
what the patch is doing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
