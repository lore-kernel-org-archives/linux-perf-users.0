Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741F2F7478;
	Mon,  2 Feb 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059647; cv=none; b=EbClnwnNDTSFc+2B+N1kMy+uLHOuMlwQkEPFhuNP5ZuuScLpIV/xXDVTFQ+eFzRIET8bnJdxMSu9SvTqGyfmHU1tqEJDJD2RtHmprpYvagQP8JMAlgk2Gto9HSzu+yYZds/+9aO4rv0BeH4tNKnGosfb2cQSOTYYv0VYg4Li+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059647; c=relaxed/simple;
	bh=mT6qNQUHmBfM0LETkPTDCUqw5si+arIq2TELq59b/YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1Yc0FH0gnhB6XFC9nLKN+7gv48KRecJmn4TG4nNWv9QeI17HNUNW27x0YueiMw+iBNoEhxGCsBtKYBX0yiAqXI/H4Pp4YMHG+CFXN6RBKRcMeTv/oxT2yb0clQuZeuBqVR0OboUeoKZ3CltrTgGezXWpR2egQ4D6EQozIc4Y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 972C5339;
	Mon,  2 Feb 2026 11:13:58 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BFBC3F740;
	Mon,  2 Feb 2026 11:14:04 -0800 (PST)
Date: Mon, 2 Feb 2026 19:14:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <20260202191402.GD3481290@e132581.arm.com>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <20260130202437.GB3481290@e132581.arm.com>
 <aYDWpc8Jh4SqMcD5@willie-the-truck>
 <20260202184234.GC3481290@e132581.arm.com>
 <aYDzh1B9Cnr_expJ@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYDzh1B9Cnr_expJ@willie-the-truck>

On Mon, Feb 02, 2026 at 06:57:11PM +0000, Will Deacon wrote:

[...]


> > > I'm not sure I follow your logic as to why both ISBs are required, but
> > > I'd have thought that if perf_aux_output_begin() fails when called from
> > > arm_spe_perf_aux_output_begin() in the irqhandler, we need the ISB
> > > because we're going to clear pmblimitr_el1 to 0 and that surely has
> > > to be ordered before clearing pmbsr?
> > 
> > I think the ISB after arm_spe_perf_aux_output_begin() in the irq
> > handler is required for both the failure and success cases.
> > 
> > For a normal maintenance interrupt, an ISB is inserted between writing
> > PMBLIMITR_EL1 and PMBSR_EL1 to ensure that a valid limit write is
> > visible before tracing restarts.  This ensures that the following
> > conditions are safely met:
> > 
> >   "While the Proﬁling Buﬀer is enabled, proﬁling is not stopped, and
> >    Discard mode is not enabled, all of the following must be true:
> > 
> >    The current write pointer must be at least one sample record below
> >    the write limit pointer.
> > 
> >    PMBPTR_EL1.PTR[63:56] must equal PMBLIMITR_EL1.LIMIT[63:56],
> >    regardless of the value of the applicable TBI bit."
> 
> Hmm, so let's say we've executed the first ISB. At that point, the
> Profiling Buffer is disabled (PMBLIMITR_EL1.E = 0) and profiling is
> stopped (PMBSR_EL1.S = 1).

This is not true.  PMBLIMITR_EL1.E is always 1 during interrupt
handling.

> If we *don't* have the second ISB then either
> PMBLIMITR_EL1 is written first or PMBSR_EL1 is written first. But the
> text you quoted will only come into effect once they've both happened,
> right? In which case, why does the order matter for the success case?

Yes, both PMBLIMITR_EL1.E == 1 and PMBSR_EL1.S == 0 must be true to
enable tracing.

However, the tricky part is that PMBLIMITR_EL1.E remains 1 throughout
the sequence.  Writing PMBLIMITR_EL1 effectively only sets the limit,
while clearing PMBSR_EL1 is the distinct step that enables tracing.

Thanks,
Leo
