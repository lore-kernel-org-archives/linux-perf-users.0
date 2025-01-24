Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AA2B9BC;
	Fri, 24 Jan 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721798; cv=none; b=V/74tQbGff1AZOTUd5kMd0by+vumAMiCZ414glrZZxo676isbe3XIF4XmxBzCOjN21EscrWC1o6mcvYDBI8x3nD1Q6XIWBGUGFEw53XBZlFXj0hOg84HOW2xCPPOe35nCTmeIf0063wNO784RDT1yybCE/fWsWXPdF3pwETc9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721798; c=relaxed/simple;
	bh=JwX8musVq+spcpO8VEXeNqq9bKiTj5rJbdsNNvyFCe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNrPQWPHk9+Lz2HwBc2sUCqcW6lJbxB1GAtieQLKE4IyNtZIjg3w5I2nFvrqBLGw4RVG6UwgMeEQzn1aGnOiBYwhHZ13FdY6y+mCNEKRGoEj+b3WELjvFxfovHM2wqsIps7fAP3tesc54xWyCKXkLimoChVc9O3h1yid2pNNw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPk6UeVA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPk6UeVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9E7C4CEDD;
	Fri, 24 Jan 2025 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737721798;
	bh=JwX8musVq+spcpO8VEXeNqq9bKiTj5rJbdsNNvyFCe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPk6UeVAOQKa1tW5jlmsBHMAt3+ItJAXlrnRL1MiTQ3pif3Umq9lNV7NaUyMR6ULD
	 pdX9+U9vARyY7/FoIUj+wtcNKU5mMDwwtGgq0B7tkk//7mEWTt0fEg7GdnQLo/jkx8
	 vZvD3VETn337V8QK1vqeHcWIHTYvJGPDqjG2Gku5o6DxBOe9NA9ebCpaX4YFVXYYQ+
	 mTM49i0A+GlsQV7CtpAVcq/fit7WH44CunvhJflOz5xm7KlDaJHOxJAqld3/DMzwkK
	 GPj37EI1pb7NF+4y/+XI4pKqFfR6WsLwrNuOgr8hfXjyROzoAl6SdlDhMK2dQNCevx
	 IFUcaaPKwz3Qg==
Date: Fri, 24 Jan 2025 12:29:53 +0000
From: Will Deacon <will@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev
 devices
Message-ID: <20250124122952.GB23438@willie-the-truck>
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
 <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
 <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > >>>        vsec = dwc_pcie_des_cap(pdev);
> > >>>        if (!vsec)
> > >>>                return -ENODEV;
> > >>>
> > >>>        sbdf = plat_dev->id;
> > >>> -     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> > >>> +     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);
> > >>
> > >> A new name will break previous user tools.
> > > This name isn't suitable. It can't clearly show which is the PMU
> > > device. Userspace tools don't have binding relationships, like perf.
> > > Tools must traverse PMU devices before use.
> >
> > The device is under /sys/bus/event_source/ which indates it is PMU device.
> > As far as I know, most of PMU devices do not endup with a '_pmu' prefix.
> 
> The point is the name "dwc_rootport_" is misleading, suggesting an
> extra PCIE RP in the system. Best to change the name to intuitive
> "xx_pmu".

As pointed out above, changing the name will break userspace. So it's
simply not an option, sorry.

Will
