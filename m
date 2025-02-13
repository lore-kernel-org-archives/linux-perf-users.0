Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB01EF08E;
	Thu, 13 Feb 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435818; cv=none; b=FWEqJ+GnPeB8qQ/eFU/TYkPVpT+PvsLIYsMVzDIjjgEQr4Jf8LbBk7vtfxaeaDYyPd2B9HMpOxiA1o1ynwqvMUmDqKxoIBugqqPSnQl6BZF0pabGtgAqndtxUrXITbkYsg1XnstScJORaRMyw2G2gH6U6J6pvOCnDj96t6MKgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435818; c=relaxed/simple;
	bh=JVjamHUOMR+z4fstZ7q+wxFcrko27vWOwkE+Hpff8QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJmGsVRJuKyMnoL5xOhViXZQYi8MRtBzi/Efg4l4xkFmvCc62qPVadae0VkD+VvGioal5pCRffTWTsbZ0RzLdsi32s46wKySfDnhLRFqFGBwbvP9iiFiuzUwj+vL4ok8UHB/d128HgWKc1ptacWx/LiiBGznl+Ua0++H+U82z5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhhCQOg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhhCQOg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72666C4CEE6;
	Thu, 13 Feb 2025 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739435818;
	bh=JVjamHUOMR+z4fstZ7q+wxFcrko27vWOwkE+Hpff8QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhhCQOg4+qgB6D+JCwx3cFfcXDYidpmtX/QIO34q5fdPwiElEh6EO7dpi4Ro0qbxT
	 ufIBwk7g5Pa5Nl4ifL5RPDUDAxIOhOBsKd49LI9ILyVMRnuxfry++9IzDxg7aD/+sZ
	 +JyeXyuJEAV/LIOcfFmm2Ku4xAUqyYv1C53jBmg2wofcNQKm0qvY2WGaLLFnAH0t2a
	 dtG1kUClU9vnzA8ThAYy4AjUvYy+U17CLICxbeZgeUKqDJVJi5rNJ3UMDGJygjUHAJ
	 gWIfT3TTsiiysm8dfakQuMqoKGX00SeOIAfHoPlvpHedMShnXkQnv1AgqFmFqcrFeH
	 Fk9m3Rw6cgwUg==
Date: Thu, 13 Feb 2025 09:36:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Message-ID: <20250213-ruddy-pumpkin-lynx-d6ea1e@krzk-bin>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
 <20250213-apple-cpmu-v2-1-87b361932e88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213-apple-cpmu-v2-1-87b361932e88@gmail.com>

On Thu, Feb 13, 2025 at 01:22:24AM +0800, Nick Chan wrote:
> Document the compatibles for Apple A7-A11 SoC CPU PMU.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

