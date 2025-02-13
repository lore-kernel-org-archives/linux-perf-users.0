Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A11FDA76;
	Thu, 13 Feb 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466204; cv=none; b=KQg+sDES5Rb3wVw9MQxa6Vrn4p+XGinlJryUIkAlezWKe9cODRmUUzWwUDUtHDOULDmx9VtWk63eelFpQwQXTPxk8pQhHDqiOSlgo/jNzwGhTvDHqXMGg+WyZVrtY1u1H9S2Ad36ygfAT43z8AFpzqzsarn6Eesa2kNw5hKJ1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466204; c=relaxed/simple;
	bh=vnxnylEp+XKENV3z/9ZNHoQdEM/a7qJdlV6rCttjW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OizJ+DpdztS1dHRZrZPbzdbUR8oExhiU0Cqa/9JiMvLclxFELz2nbHYJ59GDLn+GGik2CazbiSiBbTyDd9SKyBc9ujUGzw3uhVRKDlQ7f6HryzOwf0fcc8xkczxaOC99B6GPiUnMqzy36x0GvNEU+1RJuEayQvND1fF60kUEAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429B3113E;
	Thu, 13 Feb 2025 09:03:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C4D83F6A8;
	Thu, 13 Feb 2025 09:03:21 -0800 (PST)
Date: Thu, 13 Feb 2025 17:03:16 +0000
From: Leo Yan <leo.yan@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v19 10/11] KVM: arm64: nvhe: Disable branch generation in
 nVHE guests
Message-ID: <20250213170316.GG235556@e132581.arm.com>
References: <20250202-arm-brbe-v19-v19-0-1c1300802385@kernel.org>
 <20250202-arm-brbe-v19-v19-10-1c1300802385@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202-arm-brbe-v19-v19-10-1c1300802385@kernel.org>

On Sun, Feb 02, 2025 at 06:43:04PM -0600, Rob Herring (Arm) wrote:

[...]

> +static void __debug_save_brbe(u64 *brbcr_el1)
> +{
> +       *brbcr_el1 = 0;
> +
> +       /* Check if the BRBE is enabled */
> +       if (!(read_sysreg_el1(SYS_BRBCR) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
> +               return;
> +
> +       /*
> +        * Prohibit branch record generation while we are in guest.
> +        * Since access to BRBCR_EL1 is trapped, the guest can't
> +        * modify the filtering set by the host.
> +        */
> +       *brbcr_el1 = read_sysreg_el1(SYS_BRBCR);
> +       write_sysreg_el1(0, SYS_BRBCR);
> +}

Should flush branch record and use isb() before exit host kernel?

I see inconsistence between the function above and BRBE's disable
function. Here it clears E0BRE / ExBRE bits for disabling BRBE, but the
BRBE driver sets the PAUSED bit in BRBFCR_EL1 for disabling BRBE.

Thanks,
Leo
