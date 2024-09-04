Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE0185935;
	Wed,  4 Sep 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453354; cv=none; b=mC3Ra4oZbDkgJkpC5eGCDQJiq1PwVuGVxEzVxXp+1gJ6sEu3iq4iohkazZnM9lROTaPIg5oD2A4DkBIg6n9PJjoRLHh76gfVPinSRl0DKmP6a/a/EXGlS52IQbNc0ENEoovdQ8QZ1TOiJKfH8G1UZIgqq2uRRmTvHP+nGcAfM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453354; c=relaxed/simple;
	bh=fjWW4m3Ll2ydWjHg6gzxX2V7+q9bKZYwiViXSnn/3Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1rqh/BTsrGlD8gZv83AFUzmDcgjOpzKP74bL9FiZrdEPUmzmpCXOyzjUFMKJDvuL6GpYz5cH3ihqL3npGJdeNY0gTuBts6i922E2nkiIwHLY0/xyrqcRA3YP0MRWjlVTyxHqJscj0j6IYDhj5Y8NVDz6XUGxJin18l6HOF+K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpkgEkRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpkgEkRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0932C4CEC6;
	Wed,  4 Sep 2024 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453353;
	bh=fjWW4m3Ll2ydWjHg6gzxX2V7+q9bKZYwiViXSnn/3Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpkgEkRc+CChmGCkYFkh1y56Dld92UgaWYbJ00E28R0XnsGC6NyORq5U+a7/eMjQe
	 3K3r28UGRqlCK+gz2JyR3QPSRmtP8NpcRxUfI84sRUXtaqvoxniVdZmaC22ovYWAGv
	 qWWTvYs2OF8nb+CuvzKIo4ZR+oVeMrukJ3vffBJT9VCCtbqkpngIu7OfEy/tmJa8sc
	 WiccfciL75imt4RyDkcMJnOt0Pfns6YQP0+p6KWydop0JcmqnydRz4zyrNXlvohDY4
	 Foge2izuF1WNAy4zGcOURTQXJvWxTYTZvTJWaq8Qqo0NYtvxL9lJkbEZsBq6O1CzEq
	 u6WrZ6mafocOQ==
Date: Wed, 4 Sep 2024 13:35:47 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/9] perf: arm_spe: Introduce 'lds' capacity
Message-ID: <20240904123544.GG13550@willie-the-truck>
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-2-leo.yan@arm.com>
 <20240830103834.GA8000@willie-the-truck>
 <655edf2e-8e0d-4c00-91a1-1af58593f597@arm.com>
 <20240830130930.GA8615@willie-the-truck>
 <0c6d3625-228a-4cb0-b75f-57f1d4069ced@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6d3625-228a-4cb0-b75f-57f1d4069ced@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 31, 2024 at 12:37:29PM +0100, Leo Yan wrote:
> On 8/30/2024 2:09 PM, Will Deacon wrote:
> 
> [...]
> 
> >>>> @@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
> >>>>
> >>>>   static struct attribute *arm_spe_pmu_cap_attr[] = {
> >>>>        SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
> >>>> +     SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
> >>>>        SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
> >>>>        SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
> >>>>        SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> >>>
> >>> What will userspace do with this? I don't think you can turn LDS on/off,
> >>> so either you'll get the data source packet or you won't.
> >>
> >> Yes, LDS bit does not work as a switch.
> >>
> >> The tool in the userspace will record the LDS bit into the metadata. During
> >> decoding phase, it reads out the LDS from metadata. Based on it, the perf
> >> tool can know if the data source is supported or not, if yes then decode the
> >> data source packet.
> > 
> > Why not just decode a data source packet when you see it? i.e. assume LDS
> > is always set.
> 
> The current tool works this way to directly decode a data source packet.
> 
> However, as Arm ARM section D17.2.4 "Data Source packet" describes, the loaded
> data source is implementation dependent, the data source payload format also
> is implementation defined.
> 
> We are halfway here in using the LDS bit to determine if the data source is
> implemented. However, we lack information on the data source format
> implementation. As a first step, we can use the LDS bit for sanity checking in
> the tool to detect any potential silicon implementation issues. Once we have
> an architectural definition for the data source format, we can extend the tool
> accordingly.

I don't think we shyould expose UAPI from the driver to detect potential
hardware bugs. Let's add it when we know it's useful for something instead.

> 
> >> Another point is how to decide the data source packet format. Now we maintain
> >> a CPU list for tracking CPU variants which support data source trace. For long
> >> term, I would like the tool can based on hardware feature (e.g. a ID register
> >> in Arm SPE) to decide the data source format, so far it is absent. This is why
> >> LDS bit + CPU list is a more reliable way. See some discussion [1].
> > 
> > Huh. Why would you have a CPU in the list if it _doesn't_ have LDS?
> 
> Yeah, this is what we don't expect - we can verify the implementation based on
> LDS bit.
> 
> E.g. if users ask data source related questions, we can use LDS bit (saved in
> the perf metadata) to confirm the feature has been implemented in a silicon.

What exactly do you mean by this?

As far as I can tell:

  - Data source packets are either present or absent depending on LDS
  - You need CPU-specific information to decode them it they are present

So it's neither necessary nor sufficient to expose the LDS bit to
userspace.

Will
