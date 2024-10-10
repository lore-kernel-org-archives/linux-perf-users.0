Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183C28F1;
	Thu, 10 Oct 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519696; cv=none; b=pGXJq9ViniVVNIPfxA4e5K0GSxLx16bo+SQbJdtx96usAXL6pIYwpyWltFE0zv/LV/5Y1/QvXgvaoWihsguW7+mXJ7JFHIrdoho8xbsuG/+hcrQBwdWJ0UircCcaDRbtLmBauHbjcjPUKVID45AS5Xh0nHpT8e5dfP/rZ6MRtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519696; c=relaxed/simple;
	bh=B7hqZAaS2mOo9sVTu9vPgawB2ROJ3lP9/bA1L4lGT/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyh/uPcf874mYURbW6QBRHrEvL2eUSIhZXS+na9F7Z3wJ4S4L/YODFr0ITLtdf1NgVV2SDaRqm6x/Xy75XvRJRNa6i+Us049i9W8CRtIVvWaez63TbYAFxyZ4Udwjymu7g4lPgNH3E05GqH1ElfYhj9PjmdAaaQkS0UrMUJuCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM2Wlcn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM2Wlcn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2A8C4CEC3;
	Thu, 10 Oct 2024 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728519695;
	bh=B7hqZAaS2mOo9sVTu9vPgawB2ROJ3lP9/bA1L4lGT/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nM2Wlcn4xzfse8dAoKFug5dvbfO1zYtz6Fn6fmY7zCmRpg1UxQvN6i/0+U8QolGux
	 ba5ntYdisUgqfxN7lVYR8npzOjpUiY0YEUCXGucBGkLki8HSeubrwcOhjO75+ZDPI5
	 utJAlirwmgW/j8kp43PuH2rNTXkvRSJ7E1wr914Lp5VjfjmGLPNHXp6UjbPekVr8QC
	 btcBb5DteiDaHfiovEJYg0POireUdK9h/onxxS60LxKGQlz2Y03HZEm3PO2Lss4Wpc
	 VUWHJc/uO91fGjYPD7LHgd2nUplksd13XsiIOEGIN27gRCu6YGnkUWpsS1AwK9RBZW
	 RsG9//WpluFZg==
Date: Wed, 9 Oct 2024 17:21:33 -0700
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
Message-ID: <ZwceDV3xNXijFF_8@google.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
 <ZvsTJ47yHFUjo1uw@google.com>
 <20241008054935.zi2kqcaj4fwf2bda@hippo>
 <ZwYncyUlAtTAeOjo@google.com>
 <20241009093750.6mbq3zkmupahrzmm@hippo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009093750.6mbq3zkmupahrzmm@hippo>

On Wed, Oct 09, 2024 at 05:38:25PM +0800, Xu Yang wrote:
> On Tue, Oct 08, 2024 at 11:49:23PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 08, 2024 at 01:49:35PM +0800, Xu Yang wrote:
> > > Hi Namhyung,
> > > 
> > > On Mon, Sep 30, 2024 at 02:07:51PM -0700, Namhyung Kim wrote:
> > > > Hello,
> > > > 
> > > > On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> > > > > Add JSON metrics for i.MX91 DDR Performance Monitor.
> > > > > 
> > > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > > ---
> > > > >  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
> > > > >  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
> > > > >  2 files changed, 35 insertions(+)
> > > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> > > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> > > > 
> > > > How do you want to route this?  As it's mixed with kernel changes, I
> > > > would generally request to split but it's a change just to add new
> > > > files so it should be ok to go with other tree.  In that case,
> > > 
> > > Sorry for late.
> > > 
> > > How about you pick up this one to perf-tools tree and Will Deacon pick up
> > > the first 2 patches to his tree? I didn't see Will apply perf-tools patch
> > > before.
> > 
> > Did Will pick up the kernel patches already?
> 
> Not yet. I could ping you once it's done, is it ok?

Sure!

Thanks,
Namhyung

