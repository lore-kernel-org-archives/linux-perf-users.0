Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68F2D837C
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Jul 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651093; cv=none; b=Y7zfAxDz9o4cWEyNg5NzHzYSJfyA9tWZDShfO036aB+Ck465MQNtzTODPanUeDnYmn0ZKlsOP1Acs6NmhE4+dFQErdXCOUME2mRhX+bmJQuMlE7mF+tXYrajWS5TghWJJUp/xkoPLoaJZQhHqTbER506fFxyulsHilcZXSwfVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651093; c=relaxed/simple;
	bh=RCqv3apiRAvADrsUAeAhC/3SwamOTFDAyQI+WX1ky1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAgJILhiaS64iBMSe1QMcqG5Rc2NhRh3xJux5KbSBc8MB9L6dS+bsiU7MZwAfiP7aP23CnXIe89D+6E8pNaNq5FRHAJ7r8uFcrwF6+mbN0ocrvnhHBUKbsW8vmHEphQJ06fGCD6UraoVK55nnfPzAjat6FmvXUoPHOAATarJPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXQampag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXQampag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AFBC4CEE3;
	Fri,  4 Jul 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651092;
	bh=RCqv3apiRAvADrsUAeAhC/3SwamOTFDAyQI+WX1ky1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXQampagQ81AV6XCk+tbU0dYcvaI4k/MH0kZqgbomKxodofh3H+eCxJOGexWHMIvm
	 CPl1bbb+qMNZa1+jYKcvJ79soojk3Q6sySUxt1s+kgeygQZCL5LllTeWA8Dy30sM+M
	 WnsMtG05bz6G5xVJde/SanPyKaKyxXHJcGCVgyNXeKvvN8QO2L1XxTKahH6WHCFND9
	 b//KgZ9Uajndlx5wXgFslexbwrjRaMuxKx/rn/MyD4S2Y7NxNld7U8J0+AfYWs50j8
	 yD2IpE+1n0vOe4mauFzHLYEuaGGWCG43G+NEBP2ZlJtzQlI+HVthXKyODQ0zLyB6Jl
	 oz0ofdwMqvteg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] perf/arm-cmn: Reduce stack usage during discovery
Date: Fri,  4 Jul 2025 18:44:19 +0100
Message-Id: <175164881621.4004183.13139163312474667678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com>
References: <e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 27 Jun 2025 18:42:39 +0100, Robin Murphy wrote:
> Arnd reports that Clang's aggressive inlining of arm_cmn_discover() can
> lead to stack frame size warnings, and while we could simply prevent
> such inlining to hide the issue, it seems more productive to actually
> heed the warning and do something about the overall stack footprint.
> The xp_region array is already rather large, and CMN_MAX_XPS might only
> grow larger in future, however it only serves as a convenience to save
> repeating the first level's worth of register reads in the second pass
> of discovery. There's no performance concern here, and it only takes a
> small tweak to the flow to re-extract the offsets instead of stashing
> them, so let's just do that and save several hundred bytes of stack.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Reduce stack usage during discovery
      https://git.kernel.org/will/c/a7bfae21457c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
