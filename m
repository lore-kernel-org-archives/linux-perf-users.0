Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1D1D5165;
	Thu, 24 Oct 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772822; cv=none; b=dkmTjnprkJxy3W4XBhToI5vXwbn8qY6+Fhe5Dl6HHeo2fSvrnDDQclLj1PzCmrpRmYPMVHzH0SphE4FQiZY1G8j5HM8LaqzjPNbZMNpDNMjSFkmVdXD1y7mXQwkJHGu4THEgC2A9KDCZdNnWUR2GzfVUX4WE5EoFuEJFqzHgyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772822; c=relaxed/simple;
	bh=lw6sXiQ6wtFxX+kp2lb3mbfcoAhgOy+cKDBtWDndOkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLjakN5En/48fg9Nn69VBLasnAKV4MTqFK/uxKbrB3JuqD4ja5tj+UB7a8K2XdsbNMyHRS5p+fk1QxlQmcIdy8x7VnHrAQK5KP3maagv8BukguoHx4CCM+MB0wSLy8m6UcAW54Qkag6qM+C2LVav4MWWowo+//5jgHnMwHGLWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAY2d50D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAY2d50D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EAC4CEC7;
	Thu, 24 Oct 2024 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772821;
	bh=lw6sXiQ6wtFxX+kp2lb3mbfcoAhgOy+cKDBtWDndOkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAY2d50D8Q7Wngqp0j8nZOH+BiwQOIsrnP+QRDrthfgGBvPGB9yfX9p0zHpriPPkK
	 x8vR4T3QMoIoWPHiPF/dvosNZaUypb+QsESwMxmIostN6Vtso5Wtvw44heyRhCBWqy
	 diff+uzfBTVyunZmp3KJ2kSJxnhzoj0WgfnTMiCch6SWcOqZnVyHr6S10+KlmNyf+F
	 kJbKak7k3cEqMbYPIgXMTzTNn8yHhulHP8ORYa+Dfb0FgUAT0BtG1XdUuqDYJ0nZOE
	 TOnDSplIg0k8dxGKQGQ3UimuK4ZkLTCeqQ/1CdbpRH/mKXopcb00jZ94r3kzsXSeCk
	 hxVeyh2if7Y6g==
Date: Thu, 24 Oct 2024 13:26:54 +0100
From: Will Deacon <will@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, Frank.li@nxp.com, mark.rutland@arm.com,
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
Message-ID: <20241024122651.GA30704@willie-the-truck>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
 <ZvsTJ47yHFUjo1uw@google.com>
 <20241008054935.zi2kqcaj4fwf2bda@hippo>
 <ZwYncyUlAtTAeOjo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwYncyUlAtTAeOjo@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 08, 2024 at 11:49:23PM -0700, Namhyung Kim wrote:
> On Tue, Oct 08, 2024 at 01:49:35PM +0800, Xu Yang wrote:
> > Hi Namhyung,
> > 
> > On Mon, Sep 30, 2024 at 02:07:51PM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> > > > Add JSON metrics for i.MX91 DDR Performance Monitor.
> > > > 
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > ---
> > > >  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
> > > >  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
> > > >  2 files changed, 35 insertions(+)
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> > > 
> > > How do you want to route this?  As it's mixed with kernel changes, I
> > > would generally request to split but it's a change just to add new
> > > files so it should be ok to go with other tree.  In that case,
> > 
> > Sorry for late.
> > 
> > How about you pick up this one to perf-tools tree and Will Deacon pick up
> > the first 2 patches to his tree? I didn't see Will apply perf-tools patch
> > before.
> 
> Did Will pick up the kernel patches already?

I have done now, sorry for the delay.

Will
