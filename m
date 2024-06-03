Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BC82487;
	Mon,  3 Jun 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407576; cv=none; b=CVCvYaT3h9DIcKGDLaxxDxAz6zXYVaBZhE1uOazcpI/ep0KzQLwIGlYWRHCNI3PU6nNdZt6i9FACzdf6vvuAPk1/mHPaQeDNw3Bkegv9TDK4Wxi0/bktLin90Xkf0PYwwhbLWvcB4RNgW0PJXGR5iQtoT13xR1scqsAWIXaoTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407576; c=relaxed/simple;
	bh=qMkXAFv9lGGixL1rgvPjKdZzgR+KXcK9HaCAo6EOfrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXlHCK9QAi74ctmQBKO+MYI4BudjIfZ8cO0axZMnhukxJ1wW0ahUjZ2n1N2KL6AoPH1pPfdi9uV69uS+ddi4iGx1pFbRuDcoVeKJV0fnox5nfs16zeMBIiJHHp7KwoQoBW742c1KxGI2UddDVtI6QVtfqBHqz3mY3HkVwajn9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7C0D1042;
	Mon,  3 Jun 2024 02:39:58 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD153F762;
	Mon,  3 Jun 2024 02:39:32 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:39:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
Message-ID: <Zl2PUoGb3lFBRSqo@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <5f8fdfd2-a4f9-4fde-ad24-3b76231e61c8@arm.com>
 <eab504ab-1563-4235-aef0-62525b2813eb@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab504ab-1563-4235-aef0-62525b2813eb@arm.com>

On Mon, Jun 03, 2024 at 02:48:58PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/30/24 15:33, James Clark wrote:
> > 
> > 
> > On 05/04/2024 03:46, Anshuman Khandual wrote:
> >> This series enables perf branch stack sampling support on arm64 platform
> >> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> >> the relevant register definitions could be accessed here.
> >>
> >> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> >>
> >> This series applies on 6.9-rc2.
> >>
> >> Also this series is being hosted below for quick access, review and test.
> >>
> >> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
> >>
> >> There are still some open questions regarding handling multiple perf events
> >> with different privilege branch filters getting on the same PMU, supporting
> >> guest branch stack tracing from the host etc. Finally also looking for some
> >> suggestions regarding supporting BRBE inside the guest. The series has been
> >> re-organized completely as suggested earlier.
> > 
> > For guest support I'm still of this opinion:
> > 
> >   * No support for the host looking into guests (the addresses don't
> >     make sense anyway without also running Perf record in the guest)
> >   * Save and restore the host buffer and registers on guest switch (if
> >     it was ever used by either host or guest)
> >   * Let the guest do whatever it wants with BRBE without any
> >     virtualisation
> > 
> > Merging this with the current PMU virtualistion stuff seems like a lot
> > of work for no use case (host looking into guests). Having said that, it
> > might not even be worth discussing on this patchset apart from "no guest
> > support", and we can do it later to avoid confusion that it's being
> > proposed for this version.
> 
> Agreed, let's just have "no guest support" for now in this proposed series
> without any more additional changes to keep things simpler and separated.
> I will also update the cover letter next time around making this clear.

FWIW, that sounds good to me.

Mark.
