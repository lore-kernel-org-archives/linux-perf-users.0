Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C42E266A;
	Thu, 18 Sep 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225240; cv=none; b=HQ70d8lrFCDtaedV3RKJ/9I92n2GRpHveCcMvbVFcN94FgpQO5LKg2mfxVlVoZZ1lXZKPpPLWJdEmmvkonDImMECAd6IN/mM0PvIZ3hmaQDSROpX+YOHOZwmkX6Wm51ldsfgKLykb2rP67q2u7eE2zkNJ0A8cLTLGm5Ce6seVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225240; c=relaxed/simple;
	bh=XPINndy9CqjB8RtVY9lpJ7pMHtnLQVCK9BiVb/6M/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovMS6Puhz0G0clgFyXB038ATV1vEOVClNFy5sEk3SRzsxrhsH9z2C9m1h8MW3tna9nIao5cwFOZwUf6eesOUxtG8Z+1E+e9kFcgMwiy47T8RhQ3NKUISH8jnKFx1NRFekF4MPvUbg/SzjV68X71WMDqpZQnrNVYOo9hsHbLadjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLErXogf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLErXogf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C61DC4CEE7;
	Thu, 18 Sep 2025 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225239;
	bh=XPINndy9CqjB8RtVY9lpJ7pMHtnLQVCK9BiVb/6M/Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLErXogfkcD7ZzKJgdDVzD4vRiwcx3YcxGVc2TWPITUnV9Hy9Xhse1y/HqN/FX9YX
	 pjCf75S8I1ffvj7pk6POyioN6P4FxxiJOdhCTSEVR/lCrh3UehhAKMxY/kdMpa2jMo
	 AsBKJTZAvCddMtAFgaA+5vrH71sf0v98OPn/tjbFckBpxniaUyhzt48BFDWoDPN+lN
	 x50K7sD32TX7kQEhMcoTmpdHZg1iPacrdHGUS1+yI7vUS/ADHBJIwBZO/khOSBMZmN
	 BEUMqJnfCCEGR4huLxKTgnKVmAAYymykUzWXO43lmDR7QFEC7ehwUkkpqr2Twq053m
	 VFdyuicyKHxWw==
Date: Thu, 18 Sep 2025 14:53:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: Add Arm C1 cores and PMUs
Message-ID: <175822522990.2521066.13725879500851779588.robh@kernel.org>
References: <20250915140508.2806590-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915140508.2806590-1-robh@kernel.org>


On Mon, 15 Sep 2025 09:05:07 -0500, Rob Herring (Arm) wrote:
> Add the newly introduced Arm C1-Nano/Pro/Premium/Ultra core and PMU
> compatible strings. These cores are part of the Lumex CSS. The new names
> are replacing the long lived Cortex-A/X branding going forward.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 4 ++++
>  Documentation/devicetree/bindings/arm/pmu.yaml  | 4 ++++
>  2 files changed, 8 insertions(+)
> 

Applied, thanks!

