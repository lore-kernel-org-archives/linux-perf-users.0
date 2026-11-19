Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119237;
	b=IT6ZaOhPh0qzcGO5bWiVd+MYud2py/I9sLlC8Pm4oJ8q8Gd9LHHtsV96IvZ+hr8ypvY+
	 HaFOsA7az8uKWkd8kA0vZmKpQrIFiyiT+aHKQI39e4jqsE7FxGdLWJnKyhPtDgUpwfLKy
	 gS6wwie0HpYFBYF60m/bWTd249mDwtMaCpgFewiQmhUerSEJW2LsIPGemiJoSBVyY/Jl2
	 N2mcWgndB0YSDJXgNqURMIjNdgTa8kcEKPzTqG0LVlQKhiVN43bYuSluJh18lE6SffWeH
	 9VoCS7yvqdi8LesPYnIVk3gorEwq6D9o9soR1IHD+MN8w4kQdi9ab+dqVeWLVCq9uiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119237;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ohflwTIw+Y1tH/9jqyoPDqwznuFbRi/wcTKWRmCALvw=;
	b=k6M+FwkP9olRIe5YCbvlTgjK9OaT8VeEc4ybVJseqGzpwznuuQ5ztX7r7lGnZoCCn+tc
	 EvNhvlEwHltTIL9dPND3d3o5/wnW94OYzfsD3AWl103yRDjR7SwEPMC4UGyEEbZoHb7c2
	 MJ0DCcrRli/ljntzvQm7fVvulJe8H6IKfoQ9il7A6pfMpxPPcrjKN9Mtzq1ogQnsM5crG
	 0LSDAE81AL+zfBImiMtd0ZMDf2Tp43KYSsnajtHDfkwKQzN6QoVRvTDWYQaVJU9h/o3kp
	 TAKNjIz7pYeMKMlNEnuSSzE1V5f78X/1SfOwbNZurO/EoOXhyZpFwEDRpRLf9hVkPEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhzhEF87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183E606A320;
	Thu, 19 Nov 2026 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhzhEF87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8B41F000C0;
	Thu, 19 Nov 2026 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119237;
	bh=ohflwTIw+Y1tH/9jqyoPDqwznuFbRi/wcTKWRmCALvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dhzhEF87IGe3TrNLOmhv16gsGf5lfuG+STVwpK5CqftHhPorjQKUxxSHqAjtItPWB
	 0abKTfoUZqNz/Cwf0DdRveogQxxuB4RIkh/GSZQWOi93Z4ot/YmpbCvxO/esCJy8FI
	 b4hC+z09jr7OJdQm9Bez6HfjW75l3lYBnbLF23V4Q+XFWaAaow6X6Uq4T8qCCsenNc
	 kwSIHlAt+fwq3xeFZraigJmho4grycYNxl8SZSO7p4BosbIMy1aZ1ElSvNEkNjPfxM
	 3x0CRqORhKH9wNJ2MvEG8zfl2H/KaEiA5VRAkbTcomeOXZ7KLsdlY7RhHwva0VXqRd
	 aGtLxIrPMjMZw==
Date: Thu, 19 Nov 2026 14:13:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: perf: Describe the Broadcom BCM5301X
 AXI PMU
Message-ID: <179511923403.118198.12888677660376650016.robh@kernel.org>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
 <20261027175124.3518239-2-florian.fainelli@broadcom.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027175124.3518239-2-florian.fainelli@broadcom.com>


On Tue, 27 Oct 2026 10:51:22 -0700, Florian Fainelli wrote:
> Describe one APB register window per AXI Trace Module. The counters are
> have no overflow IRQ.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/perf/brcm,bcm5301x-axi-pmu.yaml  | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

