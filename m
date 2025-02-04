Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D41A29A;
	Tue,  4 Feb 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672277; cv=none; b=TcCWsd2scMHopChIl5QTfDh9+WGJHaADfnu74z/wOaq6Skt9QxLYtqlccfVQA29SBYvgLsiqGH0RxV/zw7EzDouESwHsgxU/luErR1YuavMUtpguDppNWQjWj6XvDs0KnVdLmCaso4WLbbfOeh2AOpSIoJkFv2OkimtdZGlFvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672277; c=relaxed/simple;
	bh=HxAkbimq7JMlFE4Bz6VGGVMJ41FYZ/9aQ2pKvT02Esw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMO4W9BX+zuVyJO3bXMb86Ckn+5NaYobfZ+cp2994zkowZe9i9V/UgeTYD5SkeZk+8YItZ5/IvFwFmovkFnCjV1I/fJ50v7dSuM8xhHgDvz8iylhd2tFLoDfA9UvKRHD3tEA3Qyy1KsorItjITQ6LLY1vhFJBzkuO7nv7y1NGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1RMc+sA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1RMc+sA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E6C4CEDF;
	Tue,  4 Feb 2025 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738672277;
	bh=HxAkbimq7JMlFE4Bz6VGGVMJ41FYZ/9aQ2pKvT02Esw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1RMc+sAdgAMKIR1SHTTGIWoqhMNZCsiXW5nE8tAkK8Di6Cq5IdJH7/TspTlBcWGm
	 D3jUXaKZLiSmca8hxEFrh0eVKMKvHkaI3X+1/X0EkOzseoQ5DWai0zEQow2OyEL7x4
	 c0AhJOjFsFwBfzL3qulTMUWB+HehKAq4tBzlxt8Yy0bpP5/mFW7vBoCKSpSmZMW0v5
	 p5W8nYPz2Fj3Zp6vMHyQmEJ5PjLGFuOxn4b9BvABVXo326spebyZUOPO/mbhenYHTL
	 6IZMQYK/IiGK9HNZtfwHukB54iB/Xu5rYM4JC4LDvdKB/y4NBYYXmUu0KQRK9AZAQC
	 onNraGJMt8lkg==
Date: Tue, 4 Feb 2025 12:31:12 +0000
From: Will Deacon <will@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev
 devices
Message-ID: <20250204123111.GC1063@willie-the-truck>
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
 <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
 <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
 <CAEEQ3wm+f_SM7evwL=YrGy8gPLS5YdJm=qhJNT8bbMH7QBOzEA@mail.gmail.com>
 <20250124122952.GB23438@willie-the-truck>
 <CAEEQ3wnTMfWSZRhTax3N60W=m3a=zxnJF6dOfiGnqJzBQs8WEg@mail.gmail.com>
 <20250127165156.GE25757@willie-the-truck>
 <CAEEQ3wkj=6WPNFpet=A9JppiO52agw6HZArwhfWsWS9JOY6Dng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkj=6WPNFpet=A9JppiO52agw6HZArwhfWsWS9JOY6Dng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 01, 2025 at 05:51:21PM +0800, yunhui cui wrote:
> On Tue, Jan 28, 2025 at 12:52 AM Will Deacon <will@kernel.org> wrote:
> > On Sun, Jan 26, 2025 at 09:54:35AM +0800, yunhui cui wrote:
> > > On Fri, Jan 24, 2025 at 8:30 PM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 24, 2025 at 05:11:05PM +0800, yunhui cui wrote:
> > > > > > >>>        vsec = dwc_pcie_des_cap(pdev);
> > > > > > >>>        if (!vsec)
> > > > > > >>>                return -ENODEV;
> > > > > > >>>
> > > > > > >>>        sbdf = plat_dev->id;
> > > > > > >>> -     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> > > > > > >>> +     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);
> > > > > > >>
> > > > > > >> A new name will break previous user tools.
> > > > > > > This name isn't suitable. It can't clearly show which is the PMU
> > > > > > > device. Userspace tools don't have binding relationships, like perf.
> > > > > > > Tools must traverse PMU devices before use.
> > > > > >
> > > > > > The device is under /sys/bus/event_source/ which indates it is PMU device.
> > > > > > As far as I know, most of PMU devices do not endup with a '_pmu' prefix.
> > > > >
> > > > > The point is the name "dwc_rootport_" is misleading, suggesting an
> > > > > extra PCIE RP in the system. Best to change the name to intuitive
> > > > > "xx_pmu".
> > > >
> > > > As pointed out above, changing the name will break userspace. So it's
> > > > simply not an option, sorry.
> > >
> > > Could you specify what in the userspace is broken and give an example?
> >
> > Can't I just take the documented example from dwc_pcie_pmu.rst:
> >
> > $# perf stat -a -e dwc_rootport_13018/Rx_PCIe_TLP_Data_Payload/
> >
> > If I have a script that uses that command on a machine today, then
> > applying your kernel patch will break the script, no?
> 
> Well, this is just a usage guide for the PCIe PMU and has no binding
> with perf. In user space, the existing PCIe PMUs in the system should
> be traversed first, and then perf stat/record ... can be executed.

"should be". ha! You know we can't rely on userspace doing whatever we
think it "should" do.

> It's okay not to change the name, but it's better to change
> dwc_rootport_%x to dwc_rootport_%d to correspond with
> platform_device_register_data(NULL, "dwc_pcie_pmu", ...). It'll be
> more intuitive. What do you think?

No, as I said earlier, we cannot break userspace like this. Please stop
trying to rename things that cannot be changed.

Will
