Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02D2DF142;
	Wed, 29 Jul 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314826; cv=none; b=QBZSCClY0XTVN3NzC3gKJCffM+Wsr/gaWVwNLD8FmKV2VJesr09xkwkpli/EA/ykoSXnL14J+0Th7B96svsq+fIf2sxxIy2raQAH01iNOIhKihHXjAS+0t4IKFtgO9n60GNLbYlO9ZiH3JFeahimV0hPOHNls271krjIaKhXSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314826; c=relaxed/simple;
	bh=hDt4g6wufmTGCeIWbKt1zmtfyCY6o1typYHKUE2h6EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJNDmT/rUktdNppXF6Dj11xCEagdOkf1sFfhsEzTprbIVEhc14Yd6pwy4/s2c/gmeEnDUCs1w3ckcuTrf8bPJ5c/pEuaoxFVjbKdseSTnngK0p+N+qXM4oID6KW6bfn0kSwSMwyokvK4CTMsAdIxXBfCg11m3pcFpdoqHngZx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O98AQmik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O98AQmik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFA71F000E9;
	Wed, 29 Jul 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314825;
	bh=JWdAI1NvPYdtxpdNDYy2eq7d4+X1bKpjAzLxCp6XRws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O98AQmik0gvB8yXO8+8UNiVZEKw7CpRGsyMeY84TO7cYjJEVEpCfHNa9DBiIVK9nv
	 YrUvT9wYqZB/NxxMoswZ4jX/XVb7YFBa6idysfl8BBNvfGnuc6VWcbrJgul4jVO5G+
	 sfdW+82KQxW+U9x19C2XrNtE56BvYhKDnNoNWxRuR/Sxw+KHEs9kejbZ+FlHDvbuGX
	 CYP6r8qiOAdWQr4A1psdQx5jbieO9JDgnG5eKGmIyLJwVKRyPvolAyoDjXz2DxnmDc
	 YOUFEQUfueF2mVvzqExnFdHRpXK2p5ZXlLXyfe8ZskjXrjGuswCsLUUEaS0SfN0ZAS
	 yQ9Bb/YgMjo+Q==
Date: Wed, 29 Jul 2026 10:47:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: perf: Add Arm Bus Monitor Unit
Message-ID: <20260729-glossy-strong-seahorse-81c9da@quoll>
References: <cover.1784214112.git.robin.murphy@arm.com>
 <1cc6acae06fb4910e27cc89e2270a52e80e310ef.1784214112.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cc6acae06fb4910e27cc89e2270a52e80e310ef.1784214112.git.robin.murphy@arm.com>

On Thu, Jul 16, 2026 at 04:12:40PM +0100, Robin Murphy wrote:
> Arm's Bus Monitor Unit is a low-level performance analysis tool for
> matching and counting transactions at interconnect interfaces. Typical
> platforms will have multiple BMUs each measuring multiple interfaces in
> various parts of the system, hence for the sake of usability we make it
> mandatory for the platform to label each instance such that the end user
> can correlate with platform documentation to know what's what.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> v2: Invent example

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

