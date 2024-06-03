Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEC1272A7;
	Mon,  3 Jun 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407539; cv=none; b=W/DK/5bFKE6tJOVTJr5ErVbRW5frjQHao+gJ+lUySOcLyRMeIpJw8Laeuyn0J7kvZfOg81baiMgY0+qyk2eq0ZB1cXOoJTZ0hZM6LFE+igDx9bCEzXnRSDRt0rySzC3te+2dT5nuySCuwQ/UHgtFdSfG2BBNsKNxNgI8TBMU1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407539; c=relaxed/simple;
	bh=gEcQZBpRJHNIjOOJm8fOCp1xnDRgdhaQLEzUWoXDs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0r0hKlW7C95Y0C0+fScMjG60GuqLxg7Y8ishIgTHK8FAoxyYk4N9fwnc/1H3yK8B54AwzRP+0EBvfSEUzof2YCEown60ZasrjLIJqn4Iv3MD6jnmaY35Jw359LSDEI0i9/mhGzMowQ7EhgW4yPCXz0wxzeEDW3IvogNwvNINQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04ECD1042;
	Mon,  3 Jun 2024 02:39:22 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B29A3F762;
	Mon,  3 Jun 2024 02:38:55 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:38:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V17 4/9] arm64/boot: Enable EL2 requirements for BRBE
Message-ID: <Zl2PHX1OT3QQBlbS@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-5-anshuman.khandual@arm.com>
 <ZlcIvJUArqDYHVFm@J2N7QTR9R3>
 <7d765803-49ed-4847-a2d1-f0c3b3e2c79c@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d765803-49ed-4847-a2d1-f0c3b3e2c79c@arm.com>

On Mon, Jun 03, 2024 at 02:41:32PM +0530, Anshuman Khandual wrote:
> On 5/29/24 16:21, Mark Rutland wrote:
> > On Fri, Apr 05, 2024 at 08:16:34AM +0530, Anshuman Khandual wrote:

> >> +  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
> >> +
> >> +  - If the kernel is entered at EL2 and EL1 is present:
> >> +
> >> +    - BRBCR_EL1.CC (bit 3) must be initialised to 0b1.
> >> +    - BRBCR_EL1.MPRED (bit 4) must be initialised to 0b1.
> > 
> > IIUC this isn't necessary; if the kernel is entered at EL2, it's capable
> > of initializing the EL1 regs, and it doesn't look like this silently
> > affects something we'd need in the absence of a BRBE driver.
> 
> No, this does not affect anything other than the BRBE driver.

Ok.

> > AFAICT the __init_el2_brbe() code you add below handles this, so I think
> > this is redundant and can be deleted.
> 
> Did not understand the above. __init_el2_brbe() handles setting both BRBCR_EL2
> and BRBCR_EL1 for CC and MPRED config irrespective of whether the kernel enters
> EL2 directly or enters EL1 via EL2. But should not that be documented here for
> both those scenarios ? OR because once the kernel is in EL2, it can configure
> EL1 as required, so it is not a booting requirement anymore ?

The latter -- since the kernel can set this up, and only needs to do
that for the BRBE driver to work, this doesn't need to be a requiremnt
on FW/bootloader. So we can drop this when the kernel is booted at EL2.

Mark.
