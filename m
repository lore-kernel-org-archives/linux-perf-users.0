Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8122D8394
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Jul 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651088; cv=none; b=SZl/T9RTUXt/c37Br8fanuWewKXyHF0C+9eH+Dfwr1lS4SbcLitlS9XXL9GPRcZTWkNNOAO45/zK7jjGtWTNL+gghJ2oyLeKbPbQm4/6XNQAgGVLQmr/LX0RH2Si6tyr1sPVTHAIHIaHoZBfnH2ogG6i7CvYNvSmi9ArSPXLLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651088; c=relaxed/simple;
	bh=vlBQ29Znbri6/+ISyC5uRMdnOm8l/jH6wA+Yrqz9eo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja+ez1oSwnicht7nDbdTerYovGav7lAWdOtQvFJ/b05LasKJXB4Z+0DsvCxLEI2S2Q+iPOexuYGLlB/EznJBoqv1zeF57+3SJ/9gN1KqrhJD0rt0u3OqL4qG9glxx8WPNCOvp6NHyJFbleaeHfgC3lAMJnjKaQEfRHGy9Zm46B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XslOOkQT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XslOOkQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D658C4CEED;
	Fri,  4 Jul 2025 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651088;
	bh=vlBQ29Znbri6/+ISyC5uRMdnOm8l/jH6wA+Yrqz9eo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XslOOkQTZVhEqv5uRhzJybA1lEz4/NwDjjhofrO/2jnL/IezHmrAGgPHbl39tayRL
	 UFcK/fUuacr2YL9MrVKwN7m1D9vBcQ4xylQYchoNkku+Xeh2+6isELk0hfmQIDof/K
	 uyEmZzkzDlW1yDF4vhG9z+Zs4jYGgzYD4gjKdlX54gLkL/VRJQ3gHAq7QjxiYz6tvX
	 t1aCFw698Xtr3LhbNksUkOMskpEGihUjAQcv0BWXjrbcCTi8U812OCqXhoaxZoELkW
	 +A5vI486Hn7pdrpgLASdFsDFoHT2Y184xXek1L+iLJC0ErcBOZ510KX54l6PBj17uR
	 d8UxmHW7F8trg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: Re: [PATCH 0/3] perf/arm-ni: IRQ improvements
Date: Fri,  4 Jul 2025 18:44:17 +0100
Message-Id: <175164863700.4002753.2959016964413719180.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1747149165.git.robin.murphy@arm.com>
References: <cover.1747149165.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 16:38:57 +0100, Robin Murphy wrote:
> While the previous attempt[1] was missing some important aspects, it's
> a valid problem to solve, so I figured I'd take a look myself. This
> ended up turning into a slightly wider cleanup, but I think the end
> result is nice enough.
> 
> As usual I don't have anything to test this on, so if there are any
> silly mistakes left that the compiler couldn't catch please do let me
> know.
> 
> [...]

Applied first patch to will (for-next/perf), thanks!

[1/3] perf/arm-ni: Set initial IRQ affinity
      https://git.kernel.org/will/c/c872d7c83738

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
