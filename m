Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CDD433CB;
	Mon, 27 Jan 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996722; cv=none; b=Nfml8L/70/ZM28S0ojsoIWh3OICZYcQvzIih7ReEYkvf3/l7H79aoDwkMG7V6UrHmMUGUxbgLEebcL2eiJuzlFZk6xJ/GTBbOzEaOlCAc5Y4HGOv4XWKtXRhCL0ML/GNhEQgAHGxrCIoR41DnejZ5I30m37jKCQY21lv6xKG1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996722; c=relaxed/simple;
	bh=edqYJfrVotNUf8DCzv4lTc39ww3u3IUd6Qrm7OINrvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kor/V+fetqatMJdK0mPyUGJ/QLi6Vo+9mo6ZNMohlFvsRFq1CFzQ9gAXQz/i2iRSWNpa/2GVMPeW4Pu+qIvf/Pma8s3aDrNKEg02MCXYvNtaaDCkWx/rg2D77TOC2kV/y06ZaJR//oS5VhEfwlrgcnfjjGGCLwQOKCF6nC1K1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpXN14xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpXN14xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BAFC4CEE0;
	Mon, 27 Jan 2025 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737996721;
	bh=edqYJfrVotNUf8DCzv4lTc39ww3u3IUd6Qrm7OINrvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpXN14xdKnrob1tV4xs/up/06b6D1Gir3JJdEkZqbhw5yakHbwF59EYIeh6MSyT1M
	 O9CaQQAkHl2P3lK6H96A4tVqAv77nJKi2yTclbyKai4zZV0ucvPJOgSCC6ucK6bk+Q
	 d2HTIDiNPBZoJjfMtxUEMymrRpKe+Dy58Q8uyVq8Tef7/ONlipLVYar2QuOSBbHNdL
	 v+8g4IKbSgqBTWDe4lZIYGP3oM/fRY18CcU0ryGHskIRh9raB5RP8qjudJU3tesa7p
	 qC2QIQ9CO1Q9WhrYFa6Q3TrIoARftIJ04oq52hAtWkdOrPCfWGX/7BedufvBc883wG
	 vuKnYEGoSTdMg==
Date: Mon, 27 Jan 2025 16:51:57 +0000
From: Will Deacon <will@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev
 devices
Message-ID: <20250127165156.GE25757@willie-the-truck>
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
 <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
 <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
 <20250124122952.GB23438@willie-the-truck>
 <CAEEQ3wnTMfWSZRhTax3N60W=m3a=zxnJF6dOfiGnqJzBQs8WEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnTMfWSZRhTax3N60W=m3a=zxnJF6dOfiGnqJzBQs8WEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jan 26, 2025 at 09:54:35AM +0800, yunhui cui wrote:
> Hi Will,
> 
> On Fri, Jan 24, 2025 at 8:30 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > > > >>>        vsec = dwc_pcie_des_cap(pdev);
> > > > >>>        if (!vsec)
> > > > >>>                return -ENODEV;
> > > > >>>
> > > > >>>        sbdf = plat_dev->id;
> > > > >>> -     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> > > > >>> +     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);
> > > > >>
> > > > >> A new name will break previous user tools.
> > > > > This name isn't suitable. It can't clearly show which is the PMU
> > > > > device. Userspace tools don't have binding relationships, like perf.
> > > > > Tools must traverse PMU devices before use.
> > > >
> > > > The device is under /sys/bus/event_source/ which indates it is PMU device.
> > > > As far as I know, most of PMU devices do not endup with a '_pmu' prefix.
> > >
> > > The point is the name "dwc_rootport_" is misleading, suggesting an
> > > extra PCIE RP in the system. Best to change the name to intuitive
> > > "xx_pmu".
> >
> > As pointed out above, changing the name will break userspace. So it's
> > simply not an option, sorry.
> 
> Could you specify what in the userspace is broken and give an example?

Can't I just take the documented example from dwc_pcie_pmu.rst:

$# perf stat -a -e dwc_rootport_13018/Rx_PCIe_TLP_Data_Payload/

If I have a script that uses that command on a machine today, then
applying your kernel patch will break the script, no?

Will
