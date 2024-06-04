Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1044A11;
	Tue,  4 Jun 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527356; cv=none; b=lGlT25ZHHdMKfcuhvMDbp3BdyG+xluJ35UsqAUIo0yUzurtBo/k9SUQ19s2gNkX5GZEGQdlKqWivkxi5Vw8Aimae9FCDcVlfARaFSwm4xJlNDUfHAcc+oTXYKRv1yFK42Ki1P/zVBcibU3hwj4SufOXXe/Fb5Ke0vq0Q8HK9NWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527356; c=relaxed/simple;
	bh=1TWqoFGoKTn0dtjSPtBYckJ6bli5M+9XeQksJwerQ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQKIbqACerCgVKUKr+mm6mO1ZSOTVSBAnX3s3gvSSkp/AqKxrVVLiroHkBGmRDTCj1xFd3QiiXXYrf1BAp5xhJSqVsJUlIS0d5BFE6TIPXvLxSypRoe1AyqQrSk194592132R9R2oNuWCYISAsculjvundhDOp1KabgITBWMwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C75FEC;
	Tue,  4 Jun 2024 11:56:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF87E3F64C;
	Tue,  4 Jun 2024 11:55:50 -0700 (PDT)
Date: Tue, 4 Jun 2024 19:55:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
References: <Zl4MYzhP0NB-Z1DW@x1>
 <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com>

On Tue, Jun 04, 2024 at 06:14:22PM +0100, Leo Yan wrote:
> On 6/4/24 10:11, Mark Rutland wrote:
> > Hi Arnaldo,
> > 
> > On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > > To get the changes in:
> > > 
> > >    0ce85db6c2141b7f ("arm64: cputype: Add Neoverse-V3 definitions")
> > >    02a0a04676fa7796 ("arm64: cputype: Add Cortex-X4 definitions")
> > >    f4d9d9dcc70b96b5 ("arm64: Add Neoverse-V2 part")
> > 
> > As a heads-up, there are likely to be a couple more updates here
> > shortly:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20240603111812.1514101-1-mark.rutland@arm.com/
> > 
> > > That makes this perf source code to be rebuilt:
> > > 
> > >    CC      /tmp/build/perf-tools/util/arm-spe.o
> > > 
> > > The changes in the above patch add MIDR_NEOVERSE_V[23] and
> > > MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
> > > and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
> > > for later when this is all tested on those machines?
> > 
> > Hmm... looking at where that was added this is somewhat misnamed, this
> > is really saying that these cores use the same IMPLEMENTATION DEFINED
> > encoding of the source field. That's not really a property of Neoverse
> > specifically, and I'm not sure what Arm's policy is here going forwards.
> > 
> > We should probably rename that to something like
> > common_data_source_encoding, with a big comment about exactly what it
> > implies.
> 
> Agreed.
> 
> I went through Neoverse-V2/V3/V4, Cortex-X4, Cortex-X4, Cortex-A720, and
> Cortex-X925, all of them have the same definition for data source packet
> format. It makes sense to change name to Neoverse specific to a more general
> name.

Cool.

> > I would not touch this for now -- someone would have to go audit the
> > TRMs to check that those other cores have the same encoding, and I think
> > it'd be better to do that as a follow-up.
> 
> So far, it's fine to not change the file util/arm-spe.c.
> 
> Now more and more Arm CPUs support the data source in SPE and share the same
> data source format. It's not scalable for us to adding every CPU variant
> into the file util/arm-spe.c.
> 
> I would like to expose the PMSIDR_EL1.LDS bit (Data source indicator for
> sampled load instructions) via the 'cap' folder, and then we can save this
> info into the perf meta data during record phase.

I'd be happy to expose fields from PMSIDR_EL1.

> In the perf report, we can parse the meta data and if the
> PMSIDR_EL1.LDS bit is set, the tool will parse the data source packet
> based on the common format.

I don't believe that's right.

PMSIDR_EL1.LDS indicates that the loaded data source field is
implemented, but even when it is implemented, the format is
IMPLEMENTATION DEFINED.

Today, Arm Ltd implementations happen to share a format, but that isn't
implied by PMSIDR_EL1.LDS, and there's no guarantee that future CPUs
will all use the same format.

For the moment we'll have to keep adding to this list.

Mark.
