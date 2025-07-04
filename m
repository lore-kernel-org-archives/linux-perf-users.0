Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4982D839B
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Jul 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651090; cv=none; b=TyBEq7W8BEXE8PYCrzq5j0tBXvVi6D8PEBMtQxgC8rpoSAGChwKSHmdNgQW5QZu8ihWIosaiyB2lhs3vqyadKwOHmM9f2ECYnrewW9wKkffGDtgnvDAMWjGPK/k5cHsE955Y++zImlWuhdo7HLNaAT1HPieb68+NeCT5Zcrx3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651090; c=relaxed/simple;
	bh=esn9s6EqpaSnRfbcaIGb2L569+x/GbsPLSuq7sW2VI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyK3SYgkBa6tSWqGeh37q155buSXXlwC9ZLpL/cazhW2n8o47VuF83ZlsAaqdRp6WB8+tjDJx2n++DxMidQZlEj7MVL07pXbzkMcWiUIBpToA/ALM/1prm3SZWm3aBojUJotrFkvKLMQorc7zDKPvP59EnAgDTXp7dDvAb+H2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS/ElbMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS/ElbMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED223C4CEEF;
	Fri,  4 Jul 2025 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651090;
	bh=esn9s6EqpaSnRfbcaIGb2L569+x/GbsPLSuq7sW2VI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZS/ElbMZ1mq02XaEzcr/NsY/cYdXVJTbh1B9XGFhXGfvp4xs1q9OPuYzOXOMfCJ0b
	 PGQwRSAtd2W0wmVECLYe6vlvFU7DHeidbRpuz3H3HzIJIidyuvLsddRfk6+6lPCPCv
	 jNVvFb4jYhH67llkIfTCaKlEcbfccczSCxhQ0y4rgT2D2OBxvTa5zto6FLQOjZB4zy
	 ApYR1y9XU5hoQCNQPf72y6Fj9S+edg2/0TCAjjBb69ykBfULqxXfEFaYCsQcENvBNv
	 8o4qUU1EsPepz8CJAVYLZSaDd6+929IZEFbjYbPxoDmA8Pn1jWtaeAWeceyHtG3cW+
	 c0fRs59GcbXIg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm: Add missing .suppress_bind_attrs
Date: Fri,  4 Jul 2025 18:44:18 +0100
Message-Id: <175164884772.4004499.6828118473358601895.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <acd48c341b33b96804a3969ee00b355d40c546e2.1751465293.git.robin.murphy@arm.com>
References: <acd48c341b33b96804a3969ee00b355d40c546e2.1751465293.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Jul 2025 15:08:13 +0100, Robin Murphy wrote:
> PMU drivers should set .suppress_bind_attrs so that userspace is denied
> the opportunity to pull the driver out from underneath an in-use PMU
> (with predictably unpleasant consequences). Somehow both the CMN and NI
> drivers have managed to miss this; put that right.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm: Add missing .suppress_bind_attrs
      https://git.kernel.org/will/c/860a831de138

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
