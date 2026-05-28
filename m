Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB0D3438AF;
	Thu, 28 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954578; cv=none; b=acOST65v98nrQ9Tk1foNp+ntdFvmZVewjsoM2Qf6t7LMcH4gMZqaN9fN19FU321cj8bOhGbX1epXs/fL0zlTbAZ+rj8q5Hd+Z31K2Y7KtpJ800Ai0oUBjOqNjunsSrd3Cdsy4ABMj0CJSZEYd9x3rwGx/zaZTVVxTX4KAjxfpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954578; c=relaxed/simple;
	bh=pjdhvqSiNhvy7Qy/b6UmRx9J1B580W+nvc/BWlCeJFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awtLP1k/tmjmAAP9t5XKVhhnkHDTQfQ93ejvde8mOn1UWpJd/F9kSZmBFG0nsyLDZYIZ1yVt1YO7qHdndViVW3MNqESApiHMyAVSnOraUnsxoZ5hGXc0Ns9ycvGsAvS2+oB8ufyoQ18TSawzXTT/psEQDdawhatpo/gMKFzhfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn8fajq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn8fajq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE6B1F000E9;
	Thu, 28 May 2026 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779954577;
	bh=ku00qaicxZefmnje9SkxWtMUgvb2Vl4elij8jTv31fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vn8fajq4rrGBfOzzXS5P/YIxcunbyso+GFTWEKmLWETN8PyBnTHwan0mddYSQ3vF1
	 AsV9kTuCnQy7WiEkNQ5saEonR1XA7o73d8l2fcu9o/g79jQTqWrtjGnqfe8a9IkmYu
	 MPIKJ18GoYi3Whdx0Uiy/aMseZREwOniS9L92lUjySUa079yDBArUB/ILacxT3yMzD
	 p4byqhqBh40HOci4WLzCFYIXw98geeizc7r2OyH3CxGyEV79/usXq7B4I2dG3e6/8b
	 Jmxq8Qckf3J39Pvtovam7jbd7YGhkGzSFsS2phg7x3wgS3eLhiGy1QlJ06kIdKRDhc
	 4Ay/Y8/EEGdZA==
Date: Thu, 28 May 2026 09:49:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, 
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Message-ID: <20260528-unbiased-affable-bobcat-0adec6@quoll>
References: <20260527154118.12884-1-gakula@marvell.com>
 <20260527154118.12884-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527154118.12884-2-gakula@marvell.com>

On Wed, May 27, 2026 at 09:11:17PM +0530, Geetha sowjanya wrote:
> Marvell CN20K SoCs integrate a DDR Performance Monitoring Unit (PMU)
> associated with the DDR controller. The block provides hardware counters
> to monitor DDR traffic and performance events and is accessed via a
> dedicated MMIO region.
> 
> The CN20K DDR PMU is functionally equivalent to the CN10K DDR PMU, with
> minor register offset differences.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

