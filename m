Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2C25A34B;
	Mon, 14 Jul 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505916; cv=none; b=VZluvAA1RA9Keum7KFa+pq/Ou7FzSJ1MBSQmdYySYK0J+Z7ZXMRpRq3uImv9xc2JK2upvd0YElgkyqHUShnNvN1yfgQheJWQ/dNg61unN1xAbShs/vYJs/gQVnzLvw3PgHYQINBvfybzGQJcbOOG25idubqoMedPsQwFvo5s34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505916; c=relaxed/simple;
	bh=2Mp3An8Tm0oRvEmiusJdna3PrB49aRBXX+u9hCsh/yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtEvRcNPAFyXDvvyfcN3OkhY3xmMzbjb3Qxj4EwzO+vjr6UopdN6B65KqeSaez+G4t4kkfI+jmGZGK4wy9OFAh0eQyBdPEGvvpEEDhpm/mVJ6OPbyB8svMB2Lx7O088Oo9hdYPzkPRWmL98pxCJHWPKKmlbScskp/xfT4FoaZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyjXK2Li; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyjXK2Li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E81BC4CEED;
	Mon, 14 Jul 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505916;
	bh=2Mp3An8Tm0oRvEmiusJdna3PrB49aRBXX+u9hCsh/yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyjXK2LiLMSUKBgJhZgIyu2rg1Jg0v5V7r6Jjg7qz5Cvlj1ceo5oKWj7reiP5ZNu+
	 noQCSEp0i8lY0DoGEFMCW6Uy+xa5aICmCJ9uFNp1c3RQ7UCPiHbCA51SlyRQqj6V5m
	 IkcWCaAJTTvB+P/S7vVlq0JtqltbszZ+QHWqHNn+bWZwcyUVJJOVn+t1yfx67Ulxda
	 0r0kjx63a9rFhvP7lQ8OjVu/owlphxajgzXqtmAqEEuOPi0tSEn8MjJ7SXwUw4Aae+
	 hlCxD9EV83cmkYZkdg/JXH80pQgNRjPvmehJrVuHJMV5nlYfkrt/bMN6vjpFa41TFR
	 Eh1aZQozJf6Hg==
Date: Mon, 14 Jul 2025 16:11:50 +0100
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
Message-ID: <aHUeNpx6bsC5Gk3b@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <20250616-apple-cpmu-v7-2-df2778a44d5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-apple-cpmu-v7-2-df2778a44d5c@gmail.com>

On Mon, Jun 16, 2025 at 09:31:51AM +0800, Nick Chan wrote:
> Skip initialization of PMUv3 remap when EL2 is not available.
> Initialization is harmless in EL1 but it is still a weird thing to do.

Why is that weird?

Will
