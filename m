Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEB12E78;
	Fri, 26 Jul 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005379; cv=none; b=uEW4rhNwLChla7VKNHsYq5OeQPnnWg3fXrt98HNIzsLV18Le48EPrBYlWKGJVNfEAR0eAD0nG2D/BujS9txaAJtHgnWzKLGuq5G3kDEeYrFGXT25dcqLXqlg5ZqtjIfPiIGTAKk4RifAu9wuM6hXhxy8+ijfszyVUQWS+UgjRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005379; c=relaxed/simple;
	bh=Z4Unxh9riY/mmX1bd2RGjAQIZdTsnqCI5uhuBf/P4P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb9nSzpbAnXuAn389b+hThvH2c28CcadHU2JW1SI/LuR/itPrW30wOU/up4w1EUFWtchTtlMDddkRXVVaOb64E9Vy2rpBf3A1CTL9D6l4zCk4vEBdZkr9ibdhxR2nLZmWHVE2nKi67ZP0EmurVHoiED5yjRY3bCGz39hzt9h9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bchnRRVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bchnRRVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4802EC32786;
	Fri, 26 Jul 2024 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722005378;
	bh=Z4Unxh9riY/mmX1bd2RGjAQIZdTsnqCI5uhuBf/P4P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bchnRRVbFfL8YH5kYPOkkcygJF1sKD2938nLGWR8H/ylXlIiwl5IzgWeNRo75Pm5p
	 xFTvalx10ML0C0+ewkhOdevwfnyHOgSau8XUD+1mpe3ZdAYVmzZRd17Wb/aVba62LF
	 UbSuSNBOR6usrIcfDC2PZwHts8Mheh/WTx0O11Vi6wA4t36Is97KZAO4q/ZLYcNya8
	 a1xQQh5y9NSJInzlfAuw9X5pyYjdUJB2/bNTdBNX0xslb4zIVvz9bJEjcTYFFD8WtV
	 2tGS5ex9ATccqf7P5u48DzVvqA+5zIiYc87DnePNPb2RHrmngDEr9OTgfYuGR4/ryc
	 P16f2h1rxbX8Q==
Date: Fri, 26 Jul 2024 11:49:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
	leo.yan@linux.dev, anshuman.khandual@arm.com,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Message-ID: <ZqO3gPcCCVh1r5WM@x1>
References: <20240722101202.26915-1-james.clark@linaro.org>
 <ZqOwGWcYosGe9ru4@x1>
 <6476a228-847b-4804-9229-c11a881663c7@arm.com>
 <ZqOzio8Oco9ZFsDm@x1>
 <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>

On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
> On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
> > > On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
> > > > > This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> > > > > as long as there are fewer than that many ETMs connected to each sink.
> > > > 
> > > > Hey, may I take the tools part, i.e. patches 0-7 and someone on the ARM
> > > > kernel team pick the driver bits?

> > > I plan to pick the kernel driver bits for v6.12

> > Perhaps it is better for me to wait for that?

> Yes, please.

Please let me know when you do so so that I can merge the tooling bits.

Thanks,

- Arnaldo
