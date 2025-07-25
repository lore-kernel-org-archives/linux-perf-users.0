Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD020127B;
	Fri, 25 Jul 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441155; cv=none; b=QofdrZ9c5gaU19z5zBOZNZY+fkYkpUXCU5i/b1UIObwEfRxe5v9gg9TcJAfcHsfSzI9WhwrUelfmKTRJjlja+WXhD846N9WJA+3Xs0th6R1+wRUHWOcfXtFQqT+nyV4IC6+HcxKPqGIuLax2hbXW+7Vm2iISeoFbQzvnVFfvLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441155; c=relaxed/simple;
	bh=BA/5YCPjkExRV5E2ItUn2bGOKsXbT1i4oIp65ZMJYQs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTVqGbW2F3JCls9af6+OLI7+xNU4xeiQBaWB770Y0hZ8hWKPOpAEEhsRGpT70TiFRjRNGgBMGN2K+g3tYrGKWlpMR3EeDlc6GCiMs13TriD4DdIUn+TE2jJ+gFgIAXKtYxtcxGiDv7dIhdg4JTAGIzffXcrdzT2khrSATxKoANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpPwC6pBLz6L56g;
	Fri, 25 Jul 2025 18:57:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3805F140159;
	Fri, 25 Jul 2025 18:59:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 12:59:10 +0200
Date: Fri, 25 Jul 2025 11:59:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Gatien Chevallier
	<gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, "Gabriel Fernandez"
	<gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk@kernel.org>, Le
 Goffic <legoffic.clement@gmail.com>, Julius Werner <jwerner@chromium.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 12/19] perf: stm32: introduce DDRPERFM driver
Message-ID: <20250725115908.000074d7@huawei.com>
In-Reply-To: <20250725115655.00002304@huawei.com>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
	<20250722-ddrperfm-upstream-v3-12-7b7a4f3dc8a0@foss.st.com>
	<20250725115655.00002304@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

> > +
> > +	platform_set_drvdata(pdev, pmu);
> > +	pmu->dev = &pdev->dev;
> > +
> > +	pmu->cfg = device_get_match_data(pmu->dev);
> > +
> > +	pmu->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +	if (IS_ERR(pmu->membase))
> > +		return PTR_ERR(pmu->membase);
> > +
> > +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
> > +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);  
> 
> Jiri is busy driving dev_fwnode() thorugh to get rid of all the directly references
> to of_node.  Probably better to use that here from the start.
> 
Need more coffee. Ignore this one, you still need an of_node here.

> 
> > +		if (ret)
> > +			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
> > +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
> > +		if (ret)
> > +			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
> > +	}
> > +
