Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878F1E5215;
	Thu, 17 Jul 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765398; cv=none; b=F/5mOcDSBPXR/E6sZUkqP/cVfCBR8i/iOt6iEbQyQT7ClmxOUypaE7fJ0VJQV5IIJyqL6TpKA7wfKTDW8s0WjAn8TxN/rwdNg6IXh/93LFcSw90ZXFZdWSEf0EsFgykoMUhNTk5cILN0tvkcSEZWrqYU7EfqlHE/Rzr4VvnJmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765398; c=relaxed/simple;
	bh=6a7Fa9ac/MNL7U3l/5o7kETAQQpJBjKaoVUI/yFXSJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWBKGpKG9NONe2tP2yRbSTWPw2/5nUzhxKqy1jMbO8TKx0Pv01Iw861dZKvBT3yBQ/VhFxuWUNfdrU2FzwmI0I8JP9AduL1HNk62ZnOoj2yWa2gD9kc2CezUjv3ayCJGpzTysgkFYuF1NMG4vN3wyeZKcuyrJBH+l2WYiA1t5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWPV/Vo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWPV/Vo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF53C4CEE3;
	Thu, 17 Jul 2025 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752765397;
	bh=6a7Fa9ac/MNL7U3l/5o7kETAQQpJBjKaoVUI/yFXSJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWPV/Vo4X3GFFJlDb2e0Bn+OqCAvCXROXBZotPrKoJ09FOkNOjQclgVohXCsaOpWb
	 QzJrey8/fBo928yTMa9jnKFk4WFPa9GFEibFb6QdqKiEtFmDkdi2GrtZQexUzLfAJv
	 +JPxhLuuPGLE83AQggp0eSt+tb0fcV4gahOgqi1NmtctMb1hxlzXazxlHmcBrGlvF5
	 N7a+An/SmwuN9KBVGd37UTtAW4GdAOtSyPKr2pv7FzFM2Tl2AjsyMPWjhUc3xySmRs
	 OWpvgL6j0dspW6wXJG+jo+984m1SfuDWFlL+nUcTm/kkiPLQrv7nCqCY9ze6AoSvCB
	 /kBMrLVZLoj8g==
Date: Thu, 17 Jul 2025 16:16:32 +0100
From: Will Deacon <will@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 02/21] drivers/perf: apple_m1: Only init PMUv3
 remap when EL2 is available
Message-ID: <aHkT0BIyuUVvI4Ht@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <20250616-apple-cpmu-v7-2-df2778a44d5c@gmail.com>
 <aHUeNpx6bsC5Gk3b@willie-the-truck>
 <81addd64-6ba6-465e-901e-05f9cb29185b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81addd64-6ba6-465e-901e-05f9cb29185b@gmail.com>

On Mon, Jul 14, 2025 at 11:37:46PM +0800, Nick Chan wrote:
> 
> Will Deacon 於 2025/7/14 夜晚11:11 寫道:
> > On Mon, Jun 16, 2025 at 09:31:51AM +0800, Nick Chan wrote:
> >> Skip initialization of PMUv3 remap when EL2 is not available.
> >> Initialization is harmless in EL1 but it is still a weird thing to do.
> > Why is that weird?
> 
> Maybe I could use better wording but if the check is not here, then for Apple A7 which has very
> different event mappings, it either has to use the mappings for M1 which is wrong on the hardware,
> or declare an a7_pmu_pmceid_map, which would just be dead code since A7's CPU does not
> support EL2. Not initializing the mapping in EL1 avoid these problems.

That's definitely more motivating than what you have :)

Will
