Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFA3546C6;
	Mon, 13 Jul 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927622; cv=none; b=c1QeNZ3e9jnAybEPCUa4BDbaYyv+iv35XvcfOzQQ8Jw60sRElt7UN/k6EgstMZEkDPJAMeoVTdcQD+ZXe1o1tqZvpbGg1bN82lp1q5wBVcv9DRxWLlKTdOpBe9fKpq8ufxZbC72bLXXO3nF5wegnF3JGRVWBneWRqTKeMlEzJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927622; c=relaxed/simple;
	bh=uSZcqEKbqPyot+IKzNnU7hzmxT0JoaBbII4zxAy3kFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMkR1XuuR4BgVlrm0KnpNT+0HrG4dVM5eDIoebfg43Lacj3Pd1M7TunGRpQMxeUbcwA9xuiYNuhFy46NTLZcOc5wI8oTDhEGXnjCXsoKqRlTL1mbKmFivaqZDJSW47DvZfsnt3IOGtjJIQRqLvjsb/LxOfZmbRSeYa6ZRbGuq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3ton2aG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3ton2aG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87721F000E9;
	Mon, 13 Jul 2026 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927621;
	bh=E372M33xfbBlxY96rpMILM58r6QIxHS+6Mzjsgps5Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3ton2aGo8UP6tslQcS7Wf1uzCZLPkA0gMMsOPLTIrantiXEqm7TMCVKLhylRDPlF
	 XJfjADxNpgBP3y0bRogsdCoS1aoD9VBOtm0zg8lVtmLpv/vH9q59VDNz4hR99HyQMe
	 JViYlBji3/YRYS5N/J97KblnwHUoOYTwt3x9Qv00UjNBCUzj4kMBJdLQ2ER8PEmGps
	 bYZq53qWEY2SCfh59r91BH3bhYBys53GqJ5pEj1eVK6cx7GlfxYe2d1OctOxygo7py
	 2KGWTCPkHGfB0PZCaGaTCLyt/z8kNT3BT4rpFs9KxOjP/Oz60lP7gAIcssJkd3kycD
	 OCCy4Om8Thsxw==
Date: Mon, 13 Jul 2026 09:26:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: perf: Add Arm Bus Monitor Unit
Message-ID: <20260713-noble-jade-wapiti-20ba9d@quoll>
References: <cover.1783439341.git.robin.murphy@arm.com>
 <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>

On Thu, Jul 09, 2026 at 08:22:07PM +0100, Robin Murphy wrote:
> +required:
> +  - compatible
> +  - reg
> +  - label
> +
> +additionalProperties: false

You need an example DTS, unless this is a subdevice and part of other device as
subschema.

Best regards,
Krzysztof

