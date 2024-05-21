Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DA7B3F3;
	Tue, 21 May 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297884; cv=none; b=d3k92dKAXhMVfPyuWg0eYmOg1Vt7iV2FPxIYJw3dFRNAfVQAqf9A/h52Rc97TC/Ke9TZQHJakRRKU0DcjHWBlaRxrssXkdecg3M1CSLSHuW5JvMRP8+pmt0M8Q4xzjbrw4oLV6t5Za+k1c4B/a2UhhdHlktFNyWNBvSpetbNXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297884; c=relaxed/simple;
	bh=wlbWCxHth2LRurdOjwxl58mGmXCms7NW7xTFGz6zfn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJjXeyi1uObBnffFVrbfMtegt2yYsBltvlTjtWQennap97kzhqPeYBq/YbEusXzdeWHOMPvDQ9zfm4ocIRbY+rBQ8nRmSty85Dd5RSGdzoyPaQvq9vaLaLmSL4CLrJJVUCk7EC8oMp7o3BdjlLiOy/KlRyjAHJlmzI+S39wtERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE7BDA7;
	Tue, 21 May 2024 06:25:05 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39373F641;
	Tue, 21 May 2024 06:24:38 -0700 (PDT)
Date: Tue, 21 May 2024 14:24:34 +0100
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V17 1/9] arm64/sysreg: Add BRBE registers and fields
Message-ID: <Zkygkt2a9HBHfmeu@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405024639.1179064-2-anshuman.khandual@arm.com>

On Fri, Apr 05, 2024 at 08:16:31AM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver, which is
> being added later on. While here, this drops redundant register definitions
> from the header i.e (arch/arm64/include/asm/sysreg.h).
> 
> BRBINFx_EL1_TYPE_IMPDEF_TRAP_EL3 register field value has been derived from
> latest ARM DDI 0601 ID121123, AKA 2023-12 instead of latest ARM ARM i.e ARM
> DDI 0487J.a. Please find the definition here.
> 
> https://developer.arm.com/documentation/ddi0601/2023-12/

The K.a release of the ARM ARM has now been published, and that includes
the "0b110000 IMPLEMENTATION DEFINED exception to EL3" value, so we can
point to that now.

With that in mind, for the commit message we can say:

| This patch adds definitions related to the Branch Record Buffer
| Extension (BRBE) as per ARM DDI 0487K.a. These will be used by KVM and
| a BRBE driver in subsequent patches.
|
| Some existing BRBE definitions in asm/sysreg.h are replaced with
| equivalent generated definitions.

Aside from a couple of minor issues below, this looks good to me. With
those fixed up (and the commit message above):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

[...]

> +Sysreg	BRBIDR0_EL1	2	1	9	2	0
> +Res0	63:16
> +Enum	15:12	CC
> +	0b101	20_BIT
> +EndEnum

Please pad this to the width of the field, i.e.

	0b0101	20_bit

> +Enum	11:8	FORMAT
> +	0b0	0
> +EndEnum

Likewise, this should be padded to the width of the field.

As with the BRBFCR_EL1.BANK definitions, I reckon it's worth givin the
enum value a prefix, so please make this:

	0b0000	FORMAT_0

Mark.
