Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F01E48A;
	Wed,  9 Oct 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456566; cv=none; b=FVjnyZDuVV0KdljXejIYyEoxDSm6aN3999DmOJpPeP1y/aCmHAaOrx7GYXDC7dDumJrzkLHCrkaGaDrgzcTX1KgNhTFKSD8Giq2LNg1vejYYKz80NYTtJV7QzvORa8O4mK/Chuxcf0EZoqUSJ52sWBywg9gOI0S5LG59owdFjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456566; c=relaxed/simple;
	bh=K0wTO0P+SD9WkcMo9G1S7p8QWIzc7QXT/iG62OpJhNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/lKu0M3e/Y5uHAnTOHht97Bp6OsRpmY11MBhu1ovd7FUg/GQ+Div621tF4S0idev3RrVgIdvVMhh29upnwcRT+bN8IQUsnowCTwSqUYacd3hP5ykIIorN7QyOlq/krkiSl7kLxM0Uj/dgS97k2lQI188IXUn5BEqpaGC5Ba5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzRSu0vE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzRSu0vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E334AC4CEC5;
	Wed,  9 Oct 2024 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728456565;
	bh=K0wTO0P+SD9WkcMo9G1S7p8QWIzc7QXT/iG62OpJhNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzRSu0vEscb8ZJFUNuun1/g+fZpuervnioQ8kBCYnbCnuVaiC5lMSz5ZZ405dKTzL
	 2anW7T22mpiv2LgKxO2h87p7mQ4k9+l3bW4Brr3n1+ILh/r1TVy5wnrJNNsCL1kC6W
	 L3ESbwswHBdmfukSuOdubveoypWt6SEafr0bNJV1rNj37ADP/MJ8fjxtLMigyfvt3r
	 oPY7X+KKCAUe0f1TvAg0eTgvju3cW0390HE+BxNXD+UwGDJOaTFukxoi6j4IwHUdPp
	 S8FfU3H85hlZjbfs2eh3n4byYXllLXGc/1S4ZKFItFF2MAbKEvIFvyFFyzCi22H5bT
	 UX/hl4CYcs82g==
Date: Tue, 8 Oct 2024 23:49:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf vendor events arm64: Add i.MX91 DDR Performance
 Monitor metrics
Message-ID: <ZwYncyUlAtTAeOjo@google.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
 <ZvsTJ47yHFUjo1uw@google.com>
 <20241008054935.zi2kqcaj4fwf2bda@hippo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008054935.zi2kqcaj4fwf2bda@hippo>

On Tue, Oct 08, 2024 at 01:49:35PM +0800, Xu Yang wrote:
> Hi Namhyung,
> 
> On Mon, Sep 30, 2024 at 02:07:51PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> > > Add JSON metrics for i.MX91 DDR Performance Monitor.
> > > 
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > ---
> > >  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
> > >  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> > 
> > How do you want to route this?  As it's mixed with kernel changes, I
> > would generally request to split but it's a change just to add new
> > files so it should be ok to go with other tree.  In that case,
> 
> Sorry for late.
> 
> How about you pick up this one to perf-tools tree and Will Deacon pick up
> the first 2 patches to his tree? I didn't see Will apply perf-tools patch
> before.

Did Will pick up the kernel patches already?

Thanks,
Namhyung

