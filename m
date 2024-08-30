Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F41152170;
	Fri, 30 Aug 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023377; cv=none; b=Pe/RJGYs4ccVKpIx2tGkvWLxYVYFE6sGDWY33nuYRyKyTwN80la66xBDUh2a467CBK5QW1j0zYVL5DABfE4jC0YYcCmUf1huKiZCewqRTgEDh4Xc7z5YDuxH3Kr7oaFENd3Cc8RPMyqez0pyTugGfE/NquG4XnTjGeuHkLj3z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023377; c=relaxed/simple;
	bh=QvPrz8rzklG+KeLU/RJsKgy+ZZCTvBZD+d/rparHM2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqyXnxU0noGnYd4DTnJOn1s+lazLynWevNM441DVK7FosOdb7sKtxBLBNtGdEUVWxK5z7BZhai9xJbKl+wJA30Uy7fL0pea0H+bHqMr7JKIeOsZrs2U4MiaXDYWzFJlaymd510xoQF95PWpbTaxwaAWINkQ3p0mMNZ2KWKKVTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbK6IHQ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbK6IHQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166BC4CEC2;
	Fri, 30 Aug 2024 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023377;
	bh=QvPrz8rzklG+KeLU/RJsKgy+ZZCTvBZD+d/rparHM2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbK6IHQ8FV7g+D3kbufxEFgeCXJtCjK4OWJSAOaNNWDl00LvQjd2zwU/I2gBLsEXX
	 YT/N5LrTGs7RTcr106/1li0Fw8K1xc6ncVfrExN4YOmjfNbTMdPQSAl4V921RZwByU
	 uC5tpD4CibZA0uiz9/Dv5rVyk3v0EZkWdu4HRxLefg4bjma8mzJkuE6dUNjvFEhis6
	 pBMmntwjnqGBrvRN3NdaR5hvx/ShtoE0Grybi7YT34+ePlwgbaeirMAuFHpKNU/UT7
	 T9oTXErrAMdjmSnlubARe+9YGWl2/XDpmRZ+07Wnr1pBFQptRSrUY0Dvc+6/VJWJVF
	 oR3Ff1NQyH2UQ==
Date: Fri, 30 Aug 2024 14:09:31 +0100
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
Message-ID: <20240830130930.GA8615@willie-the-truck>
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-2-leo.yan@arm.com>
 <20240830103834.GA8000@willie-the-truck>
 <655edf2e-8e0d-4c00-91a1-1af58593f597@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655edf2e-8e0d-4c00-91a1-1af58593f597@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 30, 2024 at 01:12:33PM +0100, Leo Yan wrote:
> On 8/30/24 11:38, Will Deacon wrote:
> > On Tue, Aug 27, 2024 at 05:44:09PM +0100, Leo Yan wrote:
> > > This commit adds a new entry 'lds' in the capacity folder. 'lds' stands
> > > for "loaded data source". When its value is 1, it indicates the data
> > > source implemented, and data source packets will be recorded in the
> > > trace data.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >   drivers/perf/arm_spe_pmu.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > > index 9100d82bfabc..81c1e7627721 100644
> > > --- a/drivers/perf/arm_spe_pmu.c
> > > +++ b/drivers/perf/arm_spe_pmu.c
> > > @@ -110,6 +110,7 @@ enum arm_spe_pmu_buf_fault_action {
> > >   /* This sysfs gunk was really good fun to write. */
> > >   enum arm_spe_pmu_capabilities {
> > >        SPE_PMU_CAP_ARCH_INST = 0,
> > > +     SPE_PMU_CAP_LDS,
> > >        SPE_PMU_CAP_ERND,
> > >        SPE_PMU_CAP_FEAT_MAX,
> > >        SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
> > > @@ -118,6 +119,7 @@ enum arm_spe_pmu_capabilities {
> > > 
> > >   static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
> > >        [SPE_PMU_CAP_ARCH_INST] = SPE_PMU_FEAT_ARCH_INST,
> > > +     [SPE_PMU_CAP_LDS]       = SPE_PMU_FEAT_LDS,
> > >        [SPE_PMU_CAP_ERND]      = SPE_PMU_FEAT_ERND,
> > >   };
> > > 
> > > @@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
> > > 
> > >   static struct attribute *arm_spe_pmu_cap_attr[] = {
> > >        SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
> > > +     SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
> > >        SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
> > >        SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
> > >        SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> > 
> > What will userspace do with this? I don't think you can turn LDS on/off,
> > so either you'll get the data source packet or you won't.
> 
> Yes, LDS bit does not work as a switch.
> 
> The tool in the userspace will record the LDS bit into the metadata. During
> decoding phase, it reads out the LDS from metadata. Based on it, the perf
> tool can know if the data source is supported or not, if yes then decode the
> data source packet.

Why not just decode a data source packet when you see it? i.e. assume LDS
is always set.

> Another point is how to decide the data source packet format. Now we maintain
> a CPU list for tracking CPU variants which support data source trace. For long
> term, I would like the tool can based on hardware feature (e.g. a ID register
> in Arm SPE) to decide the data source format, so far it is absent. This is why
> LDS bit + CPU list is a more reliable way. See some discussion [1].

Huh. Why would you have a CPU in the list if it _doesn't_ have LDS? If
we have to resort to per-CPU decoding, then that's even more of a reason
not to have the LDS cap imo.

Will
